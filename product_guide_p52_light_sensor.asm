* Light Sensor Program from Heathkit ET/ETW-18 Hero Robot Product Guide, p.52
*
* Run make to generate .s19 file
* Power on robot
* Enter '3A' on robot keypad to enter serial download mode
* Send .s19 contents over serial port to robot, when complete, robot will say 'Ready'
* Enter 'AD0100' on robot keypad to jump to start address
* Press <RESET> on robot keypad to exit the program
*
* Comments are verbatim from the Heathkit ET/ETW-18 Hero Robot Product Guide, p.52

ispkwait equ    $72             ; SPKWAIT address.
ienlight equ    $41             ; Interpreter: Enable light
iexit   equ     $83             ; Interpreter: Exit interpreter mode
sensport equ    $c240           ; Sense (eye/ear) port
redis   equ     $f64e           ; Reset display
outbyt  equ     $f7ad           ; Outbyt: Output two hex digits

	org 	$0200

        fcb     ienlight        ; Turns on the light sensor.
        fcb     iexit           ; Goes to the Machine Language Mode which is faster than operating in the Robot Language Mode.
loop:
        jsr     redis           ; Goes to the "clear the display" routine at address F64E.
        ldaa    sensport        ; Reads the light sensor information at address C240.
        jsr     outbyt          ; Goes to the "show on display" routine located at address F7AD.
        ldaa    sensport        ; Reads the information again at address C240.
        bne     wait		; If the the number at C240 is not equal to zero... go ahead to 0214.
        swi                     ; If the number is equal to zero, go to the Robot Language Mode.
        fcb     ispkwait        ; Commands the Robot to speak...
        fdb     $021D           ; the response located at address 021D.
wait:
        fcb     iexit           ; Goes back to the Machine Language Mode.
        ldx     #$1000          ; Loads the following number into the index register ... 1000.
waitloop:
        dex                     ; Subtracts 1 from 1000.
	bne	waitloop	; If the subtraction does not equal zero... it goes back to 0218. This acts as a delay between light sensor readings.
	bra	loop		; If the subtraction does equal zero.... the program goes back to the beginning at 0200.

        fcb     $A5             ; Phoneme code for P. This is the start of the vocal response for the above program at 0212.
        fcb     $98             ; Phoneme code for L.
        fcb     $7C             ; Phoneme code for E1.
        fcb     $7C             ; Phoneme code for E1.
        fcb     $52             ; Phoneme code for Z. These five phonemes make up the word "please".
        fcb     $2A             ; Phoneme code for T.
        fcb     $06             ; Phoneme code for A1.
        fcb     $21             ; Phoneme code for AY.
        fcb     $29             ; Phoneme code for Y.
        fcb     $19             ; Phoneme code for K. These five phonemes make up the word "take".
        fcb     $69             ; Phoneme code for Y.
        fcb     $66             ; Phoneme code for 0.
        fcb     $6B             ; Phoneme code for R. These three phonemes make up the word "your".
        fcb     $9B             ; Phoneme code for H.
        fcb     $AF             ; Phoneme code for AE1.
        fcb     $40             ; Phoneme code for EH3.
        fcb     $4D             ; Phoneme code for N.
        fcb     $5E             ; Phoneme code for D. These five phonemes make up the word "hand".
        fcb     $71             ; Phoneme code for UH2.
        fcb     $AD             ; Phoneme code for W.
        fcb     $46             ; Phoneme code for A1.
        fcb     $61             ; Phoneme code for AY.
        fcb     $61             ; Phoneme code for AY. These five phonemes make up the word "away".
        fcb     $DD             ; Phoneme code for F.
        fcb     $6B             ; Phoneme code for R.
        fcb     $72             ; Phoneme code for UH1.
        fcb     $4C             ; Phoneme code for M. These four phonemes make up the word "from".
        fcb     $0C             ; Phoneme code for M.
        fcb     $15             ; Phoneme code for AH1.
        fcb     $00             ; Phoneme code for EH3.
        fcb     $29             ; Phoneme code for Y.
        fcb     $29             ; Phoneme code for Y. These four phonemes make up the word "my".
        fcb     $55             ; Phoneme code for AH1.
        fcb     $40             ; Phoneme code for EH3.
        fcb     $7C             ; Phoneme code for E1. These three phonemes make up the word "eye".
        fcb     $3F             ; The response "Please take your hand away from my eye" stops here.
        fcb     $FF             ; This is the end of the program.
