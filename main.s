.equ DATA, 0x10001000				

.global _start
_start:

	call MENU
WHILE:
	movia r8, DATA
	mov r9, ra
	call POLLING_LEITURA1
	mov ra, r9
	
	br WHILE

LETRA:
	movia r10, DATA
	addi r13,r10, 4 
	
POLLING1:
	ldwio r12, 0(r13)                 
	andhi r12, r10, 0xFFFF           
	beq r12, r0, POLLING1
	stwio r8, 0(r10)
	ret

MENU:
	mov r9,ra
	movia r8,'E'                  
	call LETRA
	movia r8,'n'                  
	call LETRA
	movia r8,'t'                  
	call LETRA
	movia r8,'r'                  
	call LETRA
	movia r8,'e'                  
	call LETRA
	movia r8,' '                  
	call LETRA
	movia r8,'c'                  
	call LETRA
	movia r8,'o'                  
	call LETRA
	movia r8,'m'                  
	call LETRA
	movia r8,' '
	call LETRA
	movia r8,'o'                  
	call LETRA
	movia r8,' '                  
	call LETRA
	movia r8,'c'                  
	call LETRA
	movia r8,'o'                  
	call LETRA
	movia r8,'m'                  
	call LETRA
	movia r8,'a'                  
	call LETRA
	movia r8,'n'                  
	call LETRA
	movia r8,'d'                 
	call LETRA
	movia r8,'o'                  
	call LETRA
	movia r8,':'	
	call LETRA
	movia ra, 0x4
	/*mudar 0x4 para r9*/
	ret
		
	movia r8, DATA
POLLING_LEITURA1:
    ldwio r12, (r8)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA1
	
POLLING_ESCRITA1:
    ldwio r9, 4(r8)
    srli r9,r9,16
    beq r0,r9, POLLING_ESCRITA1
    stw r12, (r8)

	andi r12, r12, 0xFF
	movia r11, 0x30
	beq r12, r11, TRATALED
	movia r11, 0x31
	beq r12, r11, TRATATRIANGULAR
	movia r11, 0x32
	beq r12, r11, TRATAROTACAO
	/*trata erro*/

TRATALED:
	call LED
	call MENU
	ret
	
TRATATRIANGULAR:
	call TRIANGULAR

TRATAROTACAO:
/*	call ROTACAO*/
	
	ret

LOOP:
	br LOOP
