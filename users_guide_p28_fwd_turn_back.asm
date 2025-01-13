* Forward-turn-back program from Heathkit ET-18 Robot User's Guide, p.28
* 
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET-18 Robot User's Guide.
 
irte	equ	$3a             ; Interpreter: Return to EXEC
iexit   equ     $83             ; Interpreter: Exit interpreter mode
imvrelw	equ	$d3		; Interpreter: Move relative, wait, immediate mode #(motor, speed, displacement)

        org     $0100

	fcb	imvrelw		; Instruction to drive a motor.
	fcb	$10		; The motor is the drive motor, run it forward.
	fcb	$10		; Go 10 units.
	jsr	wait		; Jump to the subroutine at the address given. Address is (0119).
	fcb	imvrelw		; Upon return from subroutine, drive a motor.
	fcb	$d0		; The head motor, to the right.
	fcb	$60		; Go 60 units.
	jsr	wait		; Jump to subroutine again. Subroutine address is 0119.
	fcb	imvrelw		; Upon return drive a motor.
	fcb	$14		; The drive motor, backwards.
	fcb	$10		; Go 10 units.
	jsr 	wait		; Jump to subroutine again. At this address (0119).
	fcb	imvrelw		; Upon return, drive a motor.
	fcb	$d4		; The head motor, to the left.
	fcb	$60		; Go 60 units
	jsr	wait		; Jump to subroutine again. At this address (0119).
	fcb	irte		; Return to executive mode when you get here.

wait
	ldx	#$100		; Put the following number into the Index Register. The number is 0100.
waitloop
	dex			; Subtract 1 from the Index Register.
	bne	waitloop	; Check if Index Register is zero. If not, go back to "subtract 1" command.
	rts			; When you get here go back to the next step of the main program.

