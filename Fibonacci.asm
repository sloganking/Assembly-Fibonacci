; Fibonacci sequence

	JMP main
first:
	DB 0
second:
	DB 1
swap:
	DB 0

main:
	; Print second
.loop:
	; print first

	MOV A, [first]	
	ADD A, [second]
	MOV B, [second]
	MOV [first], B
	MOV [second], A

	JNC .loop
	HLT
