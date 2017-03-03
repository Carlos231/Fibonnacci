TITLE Fibonacci Numbers     (Fib.asm)

; Author: Carlos Lopez-Molina
; Course / Project ID : CS 271                Date: 01/29/2017
; Description: Program that calculates the fibonnacci numbers. Will greet user and ask for an input between 1 and 46, validate it and then display the Fibonacci numbers.

INCLUDE Irvine32.inc

UPPER = 46	;Highest number for fib
LOWER = 1	;Lowest number for fib

.data

; (constant definitions here)
intro_1		BYTE	"Fibonacci Numbers      Programmed by Carlos Lopez-Molina ", 0
extra		BYTE	"**EC: Displays the numbers in aligned columns",0
Hello		BYTE	"Hello, ",0
intro_3		BYTE	"Enter the number of Fibinnacci terms to be displayed (must be between 1-46).",0
error		BYTE	"Out of range! Enter a number betweem 1 and 46: ",0
prompt_1	BYTE	"How many Fibonacci terms do you want? ",0
prompt_2	BYTE	"Whats your name? ",0
result		BYTE	"Results certified by Carlos Lopez.",0
goodbye		BYTE	"Goodbye, ",0
space		BYTE	"     ",0
aName		BYTE	51 DUP (?)
nameSize	dd		?
number		DWORD	?	
curr		DWORD	?			
prev		DWORD	0			
next		DWORD	1			
col			DWORD	0

.code
main PROC
	call	ClrScr

;intro name
	mov		edx, OFFSET intro_1			
	call	WriteString
	call	CrLf
	call	CrLf

;get name
	mov		edx, OFFSET prompt_2			
	call	WriteString	
	;input for name
	mov		edx, OFFSET aName	
	mov		ecx, SIZEOF aName				
	call	ReadString
	mov		nameSize, eax		
		
;hello - name				
	mov		edx, OFFSET Hello			
	call	WriteString
	mov		edx, OFFSET aName			
	call	WriteString
	call	CrLf
	call	CrLf

;intro for fib
	mov		edx, OFFSET intro_3			
	call	WriteString
	call	CrLf

;prompt for number
	mov		edx, OFFSET prompt_1 
	call	WriteString 
	call	ReadInt 
	mov		number,eax

;error checking - loop until number entered fits criteria
	.while ((number < LOWER) || (number > UPPER)) ;if number is less than or greater than 1 or 46, keep asking for new number.
		mov		edx, OFFSET error		
		call	WriteString
		call	ReadInt					
		mov		number,eax
		call	CrLf
	.endw

	call	CrLf
;fibonnacci sequence:
	mov		ecx, number
	mov		eax, prev	
	mov		ebx, next
fib:
	cmp		ecx, 0
	JE		_end

	mov		edx, eax
	;curr = prev + next
	add		edx, ebx
	dec		ecx
	
	mov		curr, eax
	mov		next, edx
	
	call	WriteDec		
	mov		edx, OFFSET space			
	call	WriteString
	
	mov		eax, curr
	mov		edx, next

	;prev = next
	mov		eax, ebx
	;next = curr
	mov		ebx, edx
	
	;columns
	inc		col
	cmp		col, 5
	JE		_column
	
	jnz		fib
_column:
	mov		col, 0
	Call	CrLf
	jmp		fib

_end:
;Goodbye
	Call	CrLf
	Call	CrLf
	mov		edx, OFFSET result			
	call	WriteString
	call	CrLf

	mov		edx, OFFSET Goodbye			
	call	WriteString
	mov		edx, OFFSET aName			
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main