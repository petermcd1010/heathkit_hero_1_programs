* Sonar Detection Program from Heathkit ET/ETW-18 Hero Robot Product Guide, p.53
*
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET/ETW-18 Hero Robot Product Guide, p.53

sonar   equ     $11             ; Address of current sonar reading
iensnr  equ     $45             ; Interpreter: Enable sonar
ispkwait equ    $72             ; SPKWAIT address.
iexit   equ     $83             ; Interpreter: Exit interpreter mode
redis   equ     $f64e           ; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

	org     $0400

	fcb	iensnr		; Turns on the Robot's sonar and stores its reading in special memory location 0011.
	fcb	iexit       	; Goes to the Machine Language Mode which is faster than the Robot Language Mode.
top:
	jsr	redis       	; Goes to the "clear the display" routine... located at address F64E.
	ldaa	sonar         	; Loads the contents into the computer of... special memory address 0011.
	jsr	outbyt      	; Goes to the "show on display" routine... located at F7AD.
	cmpa	#$20		; Compare the distance reading... to 20.
	bhi	skip		; If the reading is higher than 20... go ahead to 0412. 
	swi			; If the reading is less than 20 go to the Robot Language Mode.
	fcb     ispkwait	; Enters the speak mode for the...
	fdb     $fb7b		; vocal response at FB7B. "There is something in my way."
skip:
	fcb     iexit		; Goes to the Machine Language Mode.
	ldx     #$1000		; Loads into the computer... the hexadecimal number 1000.
loop:
	dex			; Subtracts 1 from the preceding number.
	bne	loop        	; If the number is not zero... it goes back to 0416.
	bra     top		; If the number is equal to zero... it goes to the beginning of the program at 0400.

