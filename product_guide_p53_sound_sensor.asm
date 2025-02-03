* Sound Sensor Program from Heathkit ET/ETW-18 Hero Robot Product Guide, p.53
*
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET/ETW-18 Hero Robot Product Guide, p.53

iensound equ    $42             ; Interpreter: Enable sound
ispkwait equ    $72             ; SPKWAIT address.
iexit   equ     $83             ; Interpreter: Exit interpreter mode
mode    equ     $0EE1           ; Interpreter/machine language mode status
sensport equ    $c240           ; Sense (eye/ear) port
redis   equ     $f64e           ; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

	org	$0300

	fcb	iensound	; Turns on the Robot's sound sensor.
	fcb	iexit    	; Goes to the Machine Language Code which is faster than the Robot Language Mode.
top:
	jsr	redis		; Goes to the "clear the display" routine... located at address F64E.
	ldaa	sensport	; Read the sound sensor information... located at address C240.
	jsr	outbyt		; Goes to the "show on display" routine... located at address F7AD.
	ldaa	sensport	; Read the sound sensor information again... at address C240.
	cmpa	#$e0		; Compare this sensor information to... level E0.
	bls	wait     	; If the sensor level is equal to or less than E0... go to 0316.
	swi			; If the sensor level is greater than E0, enter the Robot Language Mode.
	fcb	ispkwait	; Commands the Robot to speak the response at...
	fdb	$fd91   	; address FD91. "Please be quiet, I'm trying to sleep."
	fcb	iexit		; Goes to the Machine Language Mode,
wait:
	ldx	#$1000		; Loads into the index register... the hexadecimal number 1000.
loop:
	dex			; Subtracts 1 from the above number.
	bne	loop		; If the result is not equal to 0 (zero)... it goes back to 031A. This acts as a delay between sensor readings.
	bra	top		; If the result is 0... it goes back to the beginning of the program at 0300.
