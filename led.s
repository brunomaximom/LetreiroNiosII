.equ DATA, 0x10001000				

.global LED

LED:
	movia r8, DATA
	mov r9, ra
	call POLLING_LEITURA2
	mov ra,r9
	ret
	
POLLING_LEITURA2:
    ldwio r12, (r8)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA2
	
POLLING_ESCRITA2:
    ldwio r9, 4(r8)
    srli r9,r9,16
    beq r0,r9, POLLING_ESCRITA2
    stw r12, (r8)

	andi r12, r12, 0xFF
	movia r11, 0x30
	beq r12, r11, TRATA_ACENDE_LED
	movia r11, 0x31
	beq r12, r11, TRATA_APAGA_LED
	/*trata erro*/

TRATA_ACENDE_LED:
	movia r11, 0
	br POLLING_LEITURA3
	
TRATA_APAGA_LED:
	movia r11, 1

POLLING_LEITURA3:
    ldwio r12, (r8)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA3

POLLING_ESCRITA3:
    ldwio r9, 4(r8)
    srli r9,r9,16
    beq r0,r9, POLLING_ESCRITA3
    stw r12, (r8)
	
	andi r12, r12, 0xFF
	subi r14, r12, 0x30
	slli r15, r14, 3
	slli r14, r14, 1
	add r14, r14, r15
	
POLLING_LEITURA4:
    ldwio r12, (r8)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA4

POLLING_ESCRITA4:
    ldwio r9, 4(r8)
    srli r9,r9,16
    beq r0,r9, POLLING_ESCRITA4
    stw r12, (r8)
	
	andi r12, r12, 0xFF
	add r14, r14, r12
	subi r14, r14, 0x30
	
	bne r11, r0, APAGA_LED
	
ACENDE_LED:
    movia r16, 0x10000000
    ldwio r19,0(r16)
    movia r17,0x1
    rol r17,r17,r14
    or r17,r17,r19
    stwio r17,0(r16)
    ret

APAGA_LED:
    movia r16, 0x10000000
    ldwio r19,0(r16)
    movia r17,0x1
    rol r17,r17,r14
   
    movia r20,0xfffff
    xor r17,r17,r20
    and r17,r19,r17   
    stwio r17,0(r16)
	ret
	
	/*Juntar Acende e Apaga led nos polling de escrita(OK)*/
	/*mudar registradores r9 e r12*/

	
	