TITLE   MINIMAL DEMO PROGAM CALC2                           
        PAGE      ,132
;---------------------------------------------------------;
; Author: B.D. Purcell                                       ;
; Date: 10/29/2014                                         ;
; Purpose: To demonstrate the simplest program structure  ;
;          and write a program to add and subtract two 32-;
;          bit numbers.                                   ;
;**********************************************************
STACK   SEGMENT   PARA STACK 'STACK'
        DB 64 DUP('STACK')
STACK   ENDS
;**********************************************************
DSEG    SEGMENT   PARA PUBLIC 'DATA'
DATA1L   DW   0ABCDH
DATA1H   DW   0FFFFH
DATA2L   DW   0ABCDH
DATA2H   DW   0FFFFH
SUM1L    DW   ?
SUM1H    DW   ?
DIFF1L   DW   ?
DIFF1H   DW   ?
DSEG    ENDS
SUBTTL  Here is the main program
;*********************************************************
SUBTTL  The main program starts here
;---------------------------------------------------------
CSEG     SEGMENT   PARA PUBLIC 'CODE'
OUR_PROG PROC  FAR
         ASSUME CS:CSEG, DS:DSEG, SS:STACK
;  Set up the stack to contain the proper values 
;  so this program can return to debug.
;  
         PUSH DS           ; Put return seg. addr on stack
         MOV AX,0          ; Clear a register AX
         PUSH AX           ; Put zero return address on stack

;  Initialize the data segment address
         MOV AX,DSEG      ;Initialize DS
         MOV DS,AX
;  -------------------------------------------------------------
;  Perform the addition
;
         MOV AX,DATA1L     ; Load LOW PART OF first word to reg AX
         MOV BX,DATA1H     ; Load HIGH PART OF first word to reg BX
         MOV CX,DATA2L     ; Load LOW PART OF second word to reg CX
         MOV DX,DATA2H     ; Load HIGH PART OF second word to reg DX
         ADD AX,CX         ; Add data at mem loc AX and CX
         ADD BX,DX         ; Add data at mem loc BX and DX
;  Store the sum in memory
;
         MOV SUM1L,AX       ; Store the LOW PART of the result at SUM
         MOV SUM1H,BX       ; Store the HIGH PART of the result at SUM
;  -------------------------------------------------------------
;  Perform the subtraction
         MOV AX,DATA1L     ; Load LOW PART of first word to reg AX
         MOV BX,DATA1H     ; Load HIGH PART of first word to reg BX
         MOV CX,DATA2L     ; Load LOW PART of first word to reg CX
         MOV DX,DATA2H     ; Load HIGH PART of first word to reg DX
;        XCHG AX,CX        ; Move large number to AX
         SUB AX,CX         ; Subtract CX from AX
         SBB BX,DX         ; Subtract DX from BX
;  Store the difference in memory
;        
         MOV DIFF1L,AX      ; Store the LOW PART of the result at DIFF
         MOV DIFF1H,BX      ; Store the HIGH PART of the result at DIFF
;  -------------------------------------------------------------
         RET              ; Retrurn to DEBUG
OUR_PROG ENDP
CSEG     ENDS
         END OUR_PROG
;**********************************************************
