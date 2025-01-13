* Light detection program from Heathkit ET-18 Robot User's Guide, p.40
* 
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0615' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET-18 Robot User's Guide.
 
ienlight equ	$41             ; Interpreter: Enable light
iexit   equ     $83             ; Interpreter: Exit interpreter mode
mode    equ     $0EE1           ; Interpreter/machine language mode status
sensport equ	$c240		; Sense (eye/ear) port
redis   equ     $f64e		; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

        org     $0615
begin
	ldaa	mode		; Read the number... which is found at 0EE1.
	cmpa    #$0		; Compare that number... to zero.
	bne	interp		; If not equal, go ahead to 061D.
	swi			; Otherwise change from Program Mode to Repeat Mode.
interp
        fcb     ienlight	; Turn on the light sensor.
        fcb     iexit		; Go to the machine language mode, which is faster than Robot language.
loop
	jsr     redis		; Go to the "clear the display" subroutine...
	ldaa    sensport	; Read the information (light sensor)... which is found at C240.
	jsr	outbyt		; Go to the "show on display" subroutine... which is stored at F7AD.

	ldx     #$1000		; Load the following number into register. The number is 1000 (hexadecimal).
waitloop
        dex			; Subtract 1 from the register.
        bne     waitloop	; If the register is not zero, go... back to 062B.
        bra     loop		; Everytime you reach here, go back to memory location 061F.
