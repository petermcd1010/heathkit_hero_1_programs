* Motion detection program from Heathkit ET-18 Robot User's Guide, p.422
* 
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0650' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET-18 Robot User's Guide.

usrmdt  equ	$27		; Interrupt "vector" for motion detector (location of jmp instruction)
usrmdt1 equ	$28		; Interrupt "vector" for motion detector (address to jmp to)
ienmotion equ	$4b             ; Interpreter: Enable motion detector
iexit   equ     $83             ; Interpreter: Exit interpreter mode
mode    equ     $0EE1           ; Interpreter/machine language mode status
redis   equ     $f64e		; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

        org     $0650
begin
	ldaa	mode		; Read the number... which is found at 0EE1. (0 = Repeat Mode).
	cmpa    #$FF 		; Compare that number... to FF.
	bne	top		; If not equal, go ahead to 0658.
	fcb	iexit		; Otherwise change from Repeat Mode to Program Mode.
top
	cli			; Clear interrupt mask.
	clr	$0040		; Clear (empty) the contents of... memory address 0040.
	ldaa	#$7e		; Load into the computer the command 7E (a jump command).
	staa	usrmdt		; Store the command... at this address (0027)
* Load the following number in the computer... The number is 066A (hexadecimal), and the address of the interrupt routine.
	ldx	#isr_top		
	stx	usrmdt1		; Store this number at... memory address 0028 and 0029.
	swi			; Change to Robot Language.
        fcb     ienmotion	; Turn on the motion detector.
        fcb     iexit		; Change back to Machine Language.
wait_here
	bra	wait_here	; Every time you reach here, go... to memory address 0668 ("wait here").

*** INTERRUPT ROUTINE ***
isr_top				
	ldaa	$40		; Load into the computer the contents of... memory address 0040 (total of times that motion has been detected).
	inca			; Add 1 to the total...
	staa	$40		; Store the resutls at... memory address 0040.
	jsr	redis		; Jump to "select where to show digit" subroutine... (which is at address f64e).
	jsr	outbyt		; Jump to "print on display" subroutine... (which is at address F7AD).
	rts			; End of subroutine
