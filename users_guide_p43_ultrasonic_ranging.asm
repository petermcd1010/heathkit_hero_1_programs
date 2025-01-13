* Ultrasonic Ranging (sonar) program from Heathkit ET-18 Robot User's Guide, p.43
* 
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET-18 Robot User's Guide.
 
sonar   equ     $11             ; Address of current sonar reading
iensnr  equ     $45             ; Interpreter: Enable sonar
iexit   equ     $83             ; Interpreter: Exit interpreter mode
mode    equ     $0EE1           ; Interpreter/machine language mode status
redis   equ     $f64e		; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

        org     $05f8

begin
        ldaa    mode            ; Read the number... which is found at 0EE1.
        cmpa    #$0             ; Compare that number... to zero.
        bne     interp          ; If not equal, go ahead to 0600.
        swi                     ; Otherwise change from Program Mode to Repeat Mode.
interp
        fcb     iensnr		; Turn on, and begin sampling, sonar. Store reading at special place (0010) in memory.
        fcb     iexit		; Go to Machine Language Mode, which is much faster than operating in the Robot Language.
loop
	jsr     redis		; Jump to "clear display" subroutine... at the address F64E.
	ldaa    sonar		; Load into the computer the contents of... special address (0011) (sonar reading).
	jsr	outbyt		; Jump to "print on display" subroutine... (which is F7AD).

	ldx     #$1000		; Load the following number in register. The number is 1000 (hexadecimal).
waitloop
        dex			; Subtract one from the number.
        bne     waitloop	; If the number is not yet zero go... back to 060D.
        bra     loop		; Everytime you reach here, go... back to memory 0602.
