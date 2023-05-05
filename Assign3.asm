; Assignment 3     (Assignment3.asm)

; Author(s): Sean Harrington
; CS_271 / Project ID                 Date: 2/3/2023

; Description: 
; Write a program to convert miles to kilometers and Fahrenheit to Celcious. 
; Display the program title and programmer’s name. Then get the user’s name and greet the user. 
; Prompt the user to enter the distance in miles that they want to convert and then prompt them to 
; enter the temperature that they want to convert in Fahrenheit.
; Convert and display the user values and the converted values.
; Display a parting message that includes the user’s name and terminate the program. 


INCLUDE Irvine32.inc

; (insert constant definitions here)
.386
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

.data
	intro1					BYTE				"Assignment 3: Distance &",0				;Display Assignment name
	intro2					BYTE				" Temperature Conversion ",0
	intro3					BYTE				"by: Sean Harrington ",0					;Display creators name
	promptN					BYTE				"What is your name: ",0						;Prompt for users input
	uName					BYTE				79 DUP(?)
	max = 80				
	promptA2				BYTE				"Greetings, ",0								;Cont.
	inst1					BYTE				"Enter the distance in miles that ",0
	inst2					BYTE				"you want to convert in kilometers: ",0

	uMile					REAL8				?
	inst3					BYTE				"Now enter the temperature in Fahrenheit ",0
	inst4					BYTE				"that you want to convert in Celsius: ",0
	uFahr					REAL8				?

	mKilo					BYTE				"The conversion from miles to kilometers is: ",0
	resultK					REAL8				?

	mCels					BYTE				"The conversion from degrees Fahrenheit to Celsius is: ",0
	resultC					REAL8				?

	bye1					BYTE				"GoodBye, ",0								;Exit message and users name 

	mToKilo					REAL8				1.60934										;kilometers
	var1					REAL8				5.0
	var2					REAL8				9.0
	var3					REAL8				32.0

; (insert variable definitions here)

.code
main PROC
		FINIT

; Introduction give assignment and name 
	Introduction:
		mov EDX, OFFSET intro1																;Move copy of into1 to a known address
		call WriteString																	;call write command
		
		mov EDX, OFFSET intro2																;Move copy of into1 to a known address
		call WriteString																	;call write command
		call Crlf

		mov EDX, OFFSET intro3																;Move copy of into1 to a known address
		call WriteString																	;call write command
		call Crlf																			;End of line sequence

		mov EDX, OFFSET promptN																;Output Name Instructions
		call WriteString

		mov EDX, OFFSET uName
		mov ECX, MAX
		call ReadString																		;Take in Users name and save to uName
		call Crlf

		mov EDX, OFFSET promptA2															;Output Name and message
		call WriteString

		mov EDX, OFFSET uName
		call WriteString
		call Crlf

; Outputs prompt for User to begin program 
	GetUserData:
		mov EDX, OFFSET inst1																;Ask for Miles value from user
		call WriteString																	;call write command

		mov EDX, OFFSET inst2																;Ask for Miles value from user p2
		call WriteString																	;call write command
		call ReadFloat																		;Puts input in ST(0)
		FSTP uMile
		call Crlf

		mov EDX, OFFSET inst3																;Ask for Fahrenheit value from user
		call WriteString																	;call write command

		mov EDX, OFFSET inst4																;Ask for Fahrenheit value from user p2
		call WriteString																	;call write command
		call Crlf																			;End of line sequence

		call ReadFloat																		;Puts input in ST(0)
		FSTP uFahr
		call Crlf
		


;For the conversions assume that 1 mile = 1.60934 kilometers, and the formula to convert the 
;temperature from Fahrenheit to celsius is C = 5/9 x (F-32)

	ConvertToKM:
		FINIT
		FLD uMile
		FLD mToKilo
		FMUL
		FSTP  resultK																	; result = mToKilo * uMile

	ConvertToCelsius:
		FINIT
        FLD var1
        FLD var2
        FDIV
        FLD uFahr
        FLD var3
        FSUB
        FMUL
        FSTP resultC																	; result = varZ * vary + varX


	DisplayConvertedData:
		mov EDX, OFFSET mKilo
		call WriteString

        FLD	resultK
		Call WriteFloat
		Call Crlf

		mov EDX, OFFSET mCels
		call WriteString

        FLD resultC
		Call WriteFloat
		Call Crlf

	

; Display exit message to screen
	Farewell:																				;goodbye message
		Call Crlf
		mov	EDX, OFFSET bye1				
		call WriteString
		mov	EDX, OFFSET uName
		call WriteString
		call Crlf


; (insert executable instructions here)

	
	invoke ExitProcess,0
	exit	; exit to operating system
main ENDP


; (insert additional procedures here)

END main
