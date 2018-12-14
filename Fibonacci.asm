; Fibonacci sequence

	JMP main
a:
	DB 0 ; 
b:
	DB 1

main:
	MOV A, [a]	
	ADD A, [b]
	MOV [a], A
	
	; print A

	MOV B, [b]
	ADD B, [a]
	MOV [b], B
	
	; print B

	SUB 
