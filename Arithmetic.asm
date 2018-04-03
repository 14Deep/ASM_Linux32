; Name: Arithmetic.asm

; Function: Allow the observation of basic arithmetic when the program is run.
; Notes: This is heavily commented to be used as a reference point and easy to use for learning purposes.
; Compiling: This needs to be assembled and linked using nasm and ld:
; 	- nasm -f elf32 -o Arithmetic.o Arithmetic.asm
;	  - ld -o Arithmetic Arithmetic.o
; Notes: This is written for a Linkux 32 bit system. 
; When debugging in GDB to see the flow of the program and the 
; arithmetic being applied,it is recommended to define hook-stop.
; In this instance (more/less parameters can be added as required):
;
; define hook-stop
; print/x $eax
; x/xb &var1
; x/xh &var2
; print $eflags
; disassemble $eip,+10
; end


global _start

section .text
_start:

	; Register arithmetic

	mov eax, 0 ; Making eax 0.
	add al, 0x1 ; Adding 1 to al, the lower 8 bits of eax(ax).
	add ah, 0x2 ; Adding 2 to ah, the higher 8 bits of eax(ax).
	add ax, 0x11 ; Adding 17 to ax, the lower 16 bits of eax. 

	sub ax, 0x11 ; Subtracting 17 from ax, the lower 16 bits of eax.
	sub ah, 0x2 ; Subtracting 2 from ah, the higher 8 bits of eax(ax).

	; When debugging here, look for the carry flag to be set. 
	mov eax, 0xffffffff ; Moving the maximum value inside the register
	add eax, 0x10 ; Adding more to the already full register. 



	; Memory based arithmetic
	; addition can happen for a byte, word or double word. 

	mov eax, 0
	
	; Adding data to the defined variables from the .data section.
	add byte [var1], 0x1
	add byte [var1], 0x2

	add word [var2], 0x1122
	add word [var2], 0x3344



	; set/clear/complement carry flag

	clc ; Clearing the carry flag.
	stc ; Setting the carry flag.
	cmc ; Complement the carry flag.



	; Add with carry

	mov eax, 0
	stc
	adc al, 0x22
	stc
	adc al, 0x11

	mov ax, 0x1122
	stc
	adc eax, 0x10 ; Add with carry (takes the carry flag into account). 

	; Subtract

	mov eax, 10
	sub eax, 5
	stc
	sbb eax, 4 ; Subtract with borrow (takes the carry flag into account).


	; Increment and Decrement

	inc eax ; Increment eax
	dec eax ; Decrement eax




	; Exit program 
	
	mov eax, 1
	mov ebx, 10
	int 0x80





section .data
	
	; Defining var1 and var2 which are used above. 
	var1	db	0x00
	var2	dw	0x0000
