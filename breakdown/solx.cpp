// RUNTIME
0x608060405234601057600336116026575b5f5ffd5b50602060043603126010576004355f55005b5f3560e01c633fb5c1cb811460145763f2c9ecd8036010575f5460805260206080f3fea2646970667358221220b730297347459487fcdd0694695686527eba39499727afbb09ccfeabc7abbae564736f6c637821736f6c783a302e312e333b736f6c633a302e382e33333b6c6c766d3a312e302e320052

// CREATION CODE
[00]	CALLVALUE	     // [msg.value]
[01]	PUSH1	15       // [15, msg.value]
[03]	JUMPI	
[04]	PUSH4	0000009e // [0x0000009e]
[09]	DUP1	         // [0x0000009e, 0x0000009e]
[0a]	PUSH4	0000001a // [0x0000001a, 0x0000009e, 0x0000009e]
[0f]	PUSH1	80       // [0x80, 0x0000001a, 0x0000009e, 0x0000009e] // long code is 0x92 or 158 bytes
[11]	CODECOPY	
[12]	PUSH1	80       // [0x80, 0x0000009e]
[14]	RETURN	         // [] CRUCIAL: return runtime bytecode, and evm will mark this to stick to the code of this addr, btw addr count via (sender_addr, sender_nonce)[12:]

// IF HAS msg.value will REVERT
[15]	JUMPDEST	     // @> [03]
[16]	PUSH0	
[17]	PUSH0	
[18]	REVERT	
[19]	INVALID	


// RUNTIME CODE
[1a]	PUSH1	80       // FPM
[1c]	PUSH1	40
[1e]	MSTORE	         // [] Mem: [..., 0x40: 0x40]
[1f]	CALLVALUE        // [msg.value]	
[20]	PUSH1	10       // [0x10, msg.value]
[22]	JUMPI	         // -> revert

[23]	PUSH1	03       // [0x03]
[25]	CALLDATASIZE	 // [0x03, calldata]
[26]	GT	             // [0x03 > calldata] // valid calldata always false
[27]	PUSH1	26
[29]	JUMPI	


[2a]	JUMPDEST         // @> from [22, 39] called if has msg.value > 0
[2b]	PUSH0	
[2c]	PUSH0	
[2d]	REVERT	


// SET NUMBER FUNCTION
R - [14] [2e]	JUMPDEST // @> from [4d]
[2f]	POP	             // []
[30]	PUSH1	20       // [0x20]
[32]	PUSH1	04       // [0x04, 0x20]

// 0x00000001 => 0x04 size
// 0xabababababababababab => 0x0a size
[34]	CALLDATASIZE	 // [calldata_byte_size, 0x04, 0x20]
[35]	SUB	             // [calldata_byte_size - 4, 0x20] => [... > 0x20]
// i think since the max calldata in our solidity is uint256 in 1 param only so it check max size of calldata is 32 bytes + 4 bytes (selector)
[36]	SLT	             // [calldata_byte_size - 4 > 0x20] // check if calldata size in bytes minus selector is greater 32 bytes long
[37]	PUSH1	10
[39]	JUMPI	         // [] JUMP 10 => revert // jump if calldata is exceed 32 bytes (uint256 in set numebr param + 4 bytes selector)

[3a]	PUSH1	04       // [0x04]
[3c]	CALLDATALOAD	 // [calldata - selector (uint256 value)]
[3d]	PUSH0	         // [0x00, calldata - selector]
[3e]	SSTORE	         // [] Storage: [0x00: calldata - selector]
[3f]	STOP	


R - [26] [40]	JUMPDEST // @> from [27]
[41]	PUSH0	         // [0x00]
[42]	CALLDATALOAD	 // [calldata 32 bytes forst]
[43]	PUSH1	e0       
[45]	SHR	
[46]	PUSH4	3fb5c1cb // [set_num_sel, shr_res]
[4b]	DUP2	         // [shr_res, set_num_sel, shr_res]
[4c]	EQ	             // [shr_res == set_num_sel, shr_res]
[4d]	PUSH1	14       
[4f]	JUMPI	


[50]	PUSH4	f2c9ecd8 // [get_num_sel, shr_sel]
[55]	SUB	             // []
[56]	PUSH1	10
[58]	JUMPI	         // [] JUMP is shr_sel bigger then get sel func


[59]	PUSH0	
[5a]	SLOAD	
[5b]	PUSH1	80       // FMP
[5d]	MSTORE	
[5e]	PUSH1	20
[60]	PUSH1	80
[62]	RETURN	
[63]	INVALID	


[64]	LOG2	
[65]	PUSH5	6970667358
[6b]	INVALID	


[6c]	SLT	
[6d]	KECCAK256	
[6e]	INVALID	


[6f]	ADDRESS	
[70]	INVALID	


[71]	PUSH20	47459487fcdd0694695686527eba39499727afbb
[86]	MULMOD	
[87]	INVALID	
[88]	INVALID	
[89]	INVALID	
[8a]	INVALID	
[8b]	INVALID	
[8c]	INVALID	
[8d]	INVALID	
[8e]	PUSH5	736f6c6378
[94]	INVALID	
[95]	PUSH20	6f6c783a302e312e333b736f6c633a302e382e33
[aa]	CALLER	
[ab]	EXTCODESIZE	
[ac]	PUSH13	6c766d3a312e302e320052