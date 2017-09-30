;;; test program for binSearch()
;;; D. Thiebaut
;;; main program that will call the recursive binSearch
;;; function 4 times, on 2 different arrays, with 2 different
;;; keys.
;;; To assembly, link and run:
;;; nasm -f elf main.asm
;;; nasm -f elf binSearch.asm
;;; nasm -f elf 231Lib.asm
;;; ld -melf_i386 -o main main.o binSearch.o 231Lib.o
;;; ./main
;;; 28
;;; -1
;;; 2
;;; -1
;;;     
        section .data
table1  dd      1,3,5,10,11,20,21,22,23,34
        dd      40,41,42,43,45,48,50,51,100
        dd      102,103,200,255,256,1000,1001
        dd      1020,2000,3000,4000,4001,5000
TABLE1LEN equ   ($-table1)/4

table2  dd      10,20,30,40,41,50,60,80,90,100
TABLE2LEN equ   ($-table2)/4


        section .text
        
        extern  _printInt
        extern  _println
        extern  binSearch
        


;;; -------------------------------------------------------------
;;;                        MAIN PROGRAM
;;; calls binSearch on two different arrays, each time for 2
;;; different keys.  The values printed should be:
;;; 
;;;     28
;;;     -1
;;;     2
;;;     -1
;;; 
;;; -------------------------------------------------------------
        global  _start
        
_start: 

 
        mov     eax, table1
        push    eax
        mov     eax, 43          ; search for 2 in table1.
        push    eax             ; 
        mov     eax, 0
        push    eax
        mov     eax, TABLE1LEN-1
        push    eax
        call    binSearch
	call    _printInt
        call    _println        

        ;; binSearch( table2, 30, 0, TABLE2LEN-1 )
        ;; returned value should be 2
        
        
        
;;; exit
        mov     ebx, 0
        mov     eax, 1
        int     0x80
