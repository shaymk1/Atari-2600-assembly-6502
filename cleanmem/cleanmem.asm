     processor 6502

     seg code
     org $F000 ;define the code origin at $F000

;housekeeping/resetting with start
Start:
     SEI       ;disable interrupts
     CLD       ; disable BCD decimal math mode
     LDX #$FF  ; load the X register with #$FF
     TXS       ; transfer the X register to the (s)tack   pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Clear The Page Zero Region ($00 - $FF);;;;
;;The entire RAM  AND also the entire TIA registers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     LDA #0    ; A=0
     LDX #$FF  ; X = #$FF 
MemLoop:
     STA $0,X  ;store the value of A inside the momory address $0 + whatever is inside X
     DEX       ; X--
     BNE MemLoop    ;loop until x ==0 or until z-flag is set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Fill the ROM size to exactly 4KB;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     org $FFFC      ; jump to this position $FFFC
     .word Start    ; add 2 bytes at address of start and reset vector at #FFFC (where the programme starts)
     .word Start    ; interrupt vector at $FFFE(unused in the vcs)
     
     
     
     
