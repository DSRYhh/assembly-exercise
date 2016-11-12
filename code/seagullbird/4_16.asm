DATA SEGMENT
	BUFF DW 0, 1, -1, 197 DUP (0)
	N1 DB ?
	N2 DB ?
	N3 DB ?
DATA ENDS

CODE SEGMENT
	ASSUME DS:DATA, CS:CODE
START:
	MOV AX, DATA
	MOV DS, AX

	MOV BX, -2
	MOV AX, 0
	MOV DL, 0

	FOR:
		ADD BX, 2
		CMP BX, 402
		JZ FINAL
		MOV SI, [BX]
		CMP SI, WORD PTR 0
		JZ ADD_N2
		SHL SI, 1
		JC ADD_N3
		JNC ADD_N1

	ADD_N3:
		ADD DL, 1
		JMP FOR
	ADD_N2:
		ADD AH, 1
		JMP FOR
	ADD_N1:
		ADD AL, 1
		JMP FOR


	FINAL:
		MOV AL, N1 	;>0 1
		MOV AH, N2 	;=0 198 C6H
		MOV DL, N3 	;<0 1

	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START
