;;; Silvana Saca
;;; binSearch.asm
;;;
;;; Computes a binary search on a sorted array
;;;
;;; Instructions to link in main program
;;;
	global binSearch

	extern	_printRegs
	extern	_println

;;; binSearch(table, key, ilow, ihigh)
binSearch:
	
	push    ebp
	mov     ebp, esp 		; Initialize stack frame
	%define ilow    dword[ebp+12] 	; define low
	%define ihigh   dword[ebp+8]  	; define high

	mov	eax, ilow	
	cmp     eax, ihigh

	jl      .computeMid 		; if less<high, compute mid
	je	.foundSol		; If they are equal, check if you found the sol
	jg	.notFound		; if less>high, not found
.notFound:	
	mov     eax, -1 		; otherwise, return -1
	pop     ebp
	ret     16


;;; ; ; ; CALCULATE MID
.computeMid:
	push    ebx
	push    ecx
	push    edx
	push    esi
	push    edi

;;; ; ;  mid = (left+right/2)
	mov     eax, ilow
	add     eax, ihigh 		; eax <-mid index
	mov     ecx, 2  		; move 2 into ecx
	div     ecx     		; divide eax by 2
	mov     ecx, 0  		; clean ecx
	mov     edx, 0  		; clean edx

	mov     esi, dword[ebp+20] 	; esi <- array address
	mov     ecx, dword[ebp+16] 	; ecx <- key

	mov     ebx, dword[esi+eax*4] 	; ebx <- table[mid]
	mov     edi, eax	      	; edi <- mid
;;; ; ;  ---- STOP CONDITION 2 ----
;;; ; ;   IF table[mid] == key, return mid
	cmp     ecx, ebx 		; compare key to item at index
	jl      .recurseDecHigh
	jg      .recurseIncLow

	pop     edi
	pop     esi
	pop     edx
	pop     ecx
	pop     ebx
	pop     ebp     		; return mid, currently in eax
	ret     16

;;; ; ;  binSearch(table, key, ilow, mid-1)
	
.recurseDecHigh:

	mov     eax, dword[ebp+20] 	; push table to stack
	push    eax
	mov     eax, dword[ebp+16] 	; push key to stack
	push    eax
	mov     eax, dword[ebp+12] 	; push ilow to stack
	push    eax
	mov     eax, edi 		; push mid-1
	dec     eax			; mid-1
	push    eax

	mov     ecx, 0
	mov     edx, 0
	call    binSearch		; RECURSE

	pop     edi
	pop     esi
	pop     edx
	pop     ecx
	pop     ebx
	pop     ebp 			; return mid, currently in eax
	ret     16

;;; ; ;    binSearch(table, key, mid+1, ihigh)

.recurseIncLow:

	mov     eax, dword[ebp+20] ; push table to stack
	push    eax
	mov     eax, dword[ebp+16] ; push key to stack
	push    eax
	mov     eax, edi
	inc     eax     	; push mid+1
	push    eax
	mov     eax, dword[ebp+8] ; push ihigh
	push    eax

	mov     ecx, 0
	mov     edx, 0
	call    binSearch

	pop     edi
	pop     esi
	pop     edx
	pop     ecx
	pop     ebx
	pop     ebp     	; return mid, currently in eax
	ret     16

;;;  if ilow==ihigh && key == table[ilow], found solution, 
.foundSol:
	mov	esi, dword[ebp+20] 	; move array to esi
	mov	ebx, dword[ebp+16] 	; ebx<-key
	mov	ecx, dword[esi+eax*4] 	; ecx<-esi[ilow] 
	cmp	ecx, ebx		
	jne	.notFound		; if not equal, we didn't find a solution 
	mov	eax, ilow		; if equal, return sol
	pop     ebp			
	ret     16
	
	
