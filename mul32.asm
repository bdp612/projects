;*****************************************************************************
TITLE         MAIN PROGRAM MUL32(UNSIGNED)
              PAGE           57,80
;-----------------------------------------------------------------------------
; Author: B. Purcell
; Revised: Nov. 29, 2014
;-----------------------------------------------------------------------------
;*****************************************************************************

SSEG          SEGMENT        PARA STACK  'STACK' ; Start of Stack Segment
              DB             64 DUP('STACK')     ; Reserve 64 bytes
SSEG          ENDS                               ; End of Stack Segment

;*****************************************************************************

DSEG          SEGMENT        PARA PUBLIC 'DATA'  ; Start of data segment
;             Enter here the data words
MPLIERL         DW             00001H              ; Store low multiplier
MPLIERH         DW             00000H              ; Store high multiplier
MPLICANDL       DW             00000H              ; Store low multiplicand
MPLICANDH       DW             00000H              ; Store high multiplicand
;             Reserve two words for the product
PROD1         DW              ?                  ; Low byte of Product 
PROD2         DW              ?                  ; Next lowest
PROD3         DW              ?                  ; Next lowest
PROD4         DW              ?                  ; High byte of Product
;       
DSEG          ENDS                               ; End of data segment
               
;*****************************************************************************

CSEG          SEGMENT        PARA PUBLIC 'CODE'  ; Start of Code Segment
              ASSUME         CS:CSEG, DS:DSEG, SS:SSEG

MUL32          PROC           FAR
;             Set up the Stack  with proper values to return to DOS or DEBUG

              PUSH           DS                  ; Save DS on the stack
              SUB            AX,AX               ; Load 0 into AX
              PUSH           AX                  ; Save 0 on the stack

;             Initialize the Data Segment registers

              MOV            AX,DSEG             ; Store Address DSEG in AX
              MOV            DS,AX               ; Transfer AX to Data Seg Reg

;----------------------------------------------------------------------------
;             Programming task starts here
START:        SUB       AX,AX               ; Store 0 in AX and clear CF
              SUB       BX,BX               ; Store 0 in BX
              MOV       DI,MPLIERL          ; Move to D1
              MOV       SI,MPLIERH          ; Move to S1
              MOV       BP,MPLICANDL        ; Move to BP
              MOV       DX,MPLICANDH        ; Move to DX
              MOV       CX,10H              ; Move 10H to CX
              RCR       SI, 1               ; Right shift of S1
              RCR       DI, 1               ; Right shift of D1
              
NEXT:
              JNC       SHIFT               ; If CF=1, skip the adding
              ADD       BX,BP               ; Add multipicand to BX
              ADD       AX,DX               ; Add DX to AX
SHIFT:                                      ; Perform right shift of product 
              RCR       AX,1                ; Right shift of AX thru CF
              RCR       BX,1                ; Right shift CF into BX
              RCR       SI,1                ; For S1
              RCR       DI,1                ; For D1
              DEC       CX                  ; Decrease bit count by 1
              JCXZ      DONE                ; Done if bit count is 0
              JMP       NEXT                ; Otherwise loop for next bit
DONE:                                       ; Multiplication is finished
              MOV       PROD1,SI            ; Store lowest word at PROD1
              MOV       PROD2,BX            ; Store next lowest
              MOV       PROD3,DI            ; Store next lowest
              MOV       PROD4,AX            ; Store highest word at PROD4
              RET                           ; return to debug
MUL32         ENDP
CSEG          ENDS
              END            MUL32
