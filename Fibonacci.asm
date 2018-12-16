; Fibonacci sequence

	JMP main

; Variables for DoubleDabble
ones:
	DB 0
tens:
	DB 0
hundreds:
	DB 0
input:
	DB 0

; Variables for Fibonacci sequence
first:
	DB 1
second:
	DB 0

print:		; printing to console
	MOV D, [hundreds]	; hundreds place
	SHR D, 4	; shift to ones place
	ADD D, 48	; change to ascii
	MOV [232], D

	MOV D, [tens]	; tens place
	SHR D, 4	; shift to ones place
	ADD D, 48	; change to ascii
	MOV [233], D

	MOV D, [ones]	; ones place
	SHR D, 4	; shift to ones place
	ADD D, 48	; change to ascii
	MOV [234], D
	RET

shift:
	MOV A, [hundreds]	;shift nibble
	SHL A, 1
	MOV [hundreds], A
shtens:
	MOV A, [tens]		;shift nibble
	SHL A, 1
	MOV [tens], A

	JNC shones	;carry bit
	MOV A, 16
	ADD A, [hundreds]
	MOV [hundreds], A

shones:
	MOV A, [ones]		;shift nibble
	SHL A, 1
	MOV [ones], A

	JNC shinput	;carry bit
	MOV A, 16
	ADD A, [tens]
	MOV [tens], A

shinput:
	MOV A, [input]		;shift byte
	SHL A, 1
	MOV [input], A

	JNC shend	;carry bit
	MOV A, 16
	ADD A, [ones]
	MOV [ones], A
shend:
	RET

dabble:
	MOV B, ones
.dabbleloop:
	MOV A, [B]
	SUB A, 0x40	;if(nibble > 4) add 3
	JNA incb
	MOV A, [B]
	ADD A, 0x30
	MOV [B], A
incb:		
	INC B
	CMP B, 5
	JNZ .dabbleloop
	RET

doubledabble:
	MOV C, 0
	MOV [ones], 0
	MOV [tens], 0
	MOV [hundreds], 0
.doubledabbleloop:
	CALL dabble	;Double dabble algorithm
	CALL shift
	INC C
	CMP C, 8
	JNZ .doubledabbleloop
	RET

main:
	MOV A, [second]		; Print second
	MOV [input], A
	CALL doubledabble
	CALL print
.mainloop:
	MOV A, [first]		; print first
	MOV [input], A
	CALL doubledabble
	CALL print

	MOV A, [first]
	MOV B, [second]
	MOV [second], A		; move first to second
	ADD A, B		; add old numbers
	MOV [first], A		; put result in first

	JNC .mainloop
	HLT
