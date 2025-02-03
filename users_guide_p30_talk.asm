* Making the robot talk program from Heathkit ET-18 Robot User's Guide, p.30
* 
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0090' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET-18 Robot User's Guide.

ispkwait equ	$72		; SPKWAIT address. 

        org     $0090
	
	fcb	ispkwait	; Speak the phonemes
	fdb	$0095		; that start at... 0095 in memory.
wait:
	bra	wait		; This command and the next one tell the CPU to wait here when done speaking.

* "HELLO"
	fcb	$1b		; This is the first phoneme (H)
	fcb	$3b		; Phoneme (E).
	fcb	$18		; Phoneme (L).
	fcb	$35		; Phoneme (O).
	fcb	$37		; Phoneme (U).
	fcb	$3f		; The "stop" phoneme (needed at the end).
	fcb	$ff		; This indicates the end of the phonemes.

