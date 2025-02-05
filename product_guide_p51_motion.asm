* Motion Sensor Program from Heathkit ET/ETW-18 Hero Robot Product Guide, p.51
*
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET/ETW-18 Hero Robot Product Guide, p.51

imvwait	equ 	$c3		; MVWAIT #(motor,speed,distance)
idssnr	equ	$5b		; Interpreter: Disable sonar
ispkwait equ    $72             ; SPKWAIT address.
iexit   equ     $83             ; Interpreter: Exit interpreter mode
ienmotion equ	$4b             ; Interpreter: Enable motion detector

	org 	$0100

start:
	fcb	ienmotion 	; Turns on the Robot's motion detector.
	fcb	iexit		; Goes to the Machine Language Mode which is faster than operating in the Robot Language Mode.
	cli			; Clears all interrupt lines to the computer.
	ldaa 	#$7e		; Loads into the computer the command ... 7E which is a Jump command.
	staa 	$27		; Store this command ... at this address (0027).
	ldx	#ready		; Loads the following number into the computer ... $010e (hexadecimal).
	stx 	$28		; Stores number 010e at memory address 0028 and 0029.
loop:
	bra	loop		; Every time you reach here ... go back to 010C (This is a waiting period for the motion detector to be activated).
ready:
	swi					; Returns to the Robot Language Mode.
	fcb	idssnr		; Turns off the motion detector.
	fcb	ispkwait	; Commands the Robot to speak ...
	fdb	$fa64		; the response located at address FA64. "Hello. I am Hero, the Heath Educational Robot."
	fcb	ispkwait	; Commands the Robot to speak ...
	fdb	$fbc1		; the response located at FBC1.
* "I have a brain, just like you do. But my brain is a computer. My owner programs my computer for me and I always do as I am programmed."
	fcb	ispkwait 	; Commands the Robot to speak ...
	fdb	$fa93		; the response located at FA93. "I can talk like this."
	fcb	ispkwait	; Commands the Robot to speak ...
	fdb	$fada		; the response located at FADA. "I can turn my head."
	fcb	imvwait		; Commands the Robot to move ...
	fcb 	$d8		; the head motor to ...
	fcb	$48		; the absolute position, 48.
	fcb	imvwait		; Commands the Robot to move ...
	fcb	$d8		; the head motor ...
	fcb	$62		; back to its starting absolute position, 62.
	fcb	ispkwait	; Commands the Robot to speak ...
	fdb	$faaa		; the response at address FAAA. "I can move my arm."
	fcb	imvwait		; Moves the ...
	fcb	$3c		; arm extend motor ...
	fcb	$50		; out 50 steps.
	fcb	imvwait		; Moves the ...
	fcb	$3c		; arm extend motor ...
	fcb	$00		; back to its starting position.
	fcb	imvwait		; Commands the ...
	fcb	$55		; shoulder motor ...
	fcb	$50		; to move ahead 50 steps.
	fcb	imvwait		; Moves the ...
	fcb	$3c		; shoulder motor ...
	fcb	$00		; back to its starting position.
	fcb	ispkwait	; Commands the Robot to speak ...
	fdb	$fac0		; the response at FACO. "I can use my gripper."
	fcb	imvwait		; Moves the ...
	fcb	$bc		; gripper motor ...
	fcb	$50		; to open the Robot's gripper.
	fcb	imvwait		; Commands the Robot's ...
	fcb	$bc		; gripper motor ...
	fcb	$00		; to close the gripper.

	fcb	ispkwait	; Commands the Robot to speak..
	fdb	$0158		; the response at address 0158. "I can move my wrist."
	fcb	imvwait		; Moves the...
	fcb	$90		; Robot's wrist pivot motor...
	fcb	$50		; around 50 steps.
	fcb	imvwait		; Moves the Robot's...
	fcb	$90		; wrist pivot motor...
	fcb	$00		; back to its starting position.
	fcb	imvwait		; Moves the...
	fcb	$75		; wrist rotate motor...
	fcb	$50		; around 50 steps.
	fcb	imvwait		; Moves the...
	fcb	$75		; wrist rotate motor...
	fcb	$00		; back to its starting position.
	fcb	ispkwait	; Commands the Robot to speak...
	fdb	$faf1		; the response at address FAF1. "And I can move about."
	fcb	imvwait		; Moves the...
	fcb	$10		; drive motor...
	fcb	$10		; ahead 10 steps.
	fcb	imvwait		; Moves the...
	fcb	$14		; drive motor...
	fcb	$20		; back to its starting position.
	fcb	ispkwait	; Commands the Robot to speak...
	fdb	$fdba		; the response at address FDBA. "I think I make an excellent pet. I'm even house trained."
	jmp	start		; Jumps from here to the beginning of the program.

	fcb	$15		; Phoneme code for AH1. This is the beginning of the response "I can move my wrist."
	fcb	$00		; Phoneme code for EH3.
	fcb	$09		; Phoneme code for I3.
	fcb	$29		; Phoneme code for Y. These four phonemes make up the word for "I".
	fcb	$19		; Phoneme code for K.
	fcb	$2f		; Phoneme code for AE1.
	fcb	$00		; Phoneme code for EH3.
	fcb	$0d		; Phoneme code for N. These four phonemes make up the word "can".
	fcb	$0c		; Phoneme code for M.
	fcb	$37		; Phoneme code for U1.
	fcb	$37		; Again the phoneme code for U1.
	fcb	$0f		; Phoneme code for V. These four phonemes make up the word "move".
	fcb	$0c		; Phoneme code for M.
	fcb	$15		; Phoneme code for AH1.
	fcb	$00		; Phoneme code for EH3.
	fcb	$09		; Phoneme code for I3.
	fcb	$29		; Phoneme code for Y. These five phonemes make up the word "my"
	fcb	$ad		; Phoneme code for W.
	fcb	$2b		; Phoneme code for R.
	fcb	$0a		; Phoneme code for I.
	fcb	$1f		; Phoneme code for S.
	fcb	$2a		; Phoneme code for T. These five phonemes make up the word "wrist".
	fcb	$3f		; Commands the robot to stop speaking.
	fcb	$ff		; This is the end of the program.
