.equ DATA, 0x10001000				

.global TRIANGULAR

TRIANGULAR:
	movia r16, DATA
	mov r9, ra
	call POLLING_LEITURA2
	mov ra,r9
	ret
	
POLLING_LEITURA2:
    ldwio r12, (r16)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA2
	
POLLING_ESCRITA2:
    ldwio r9, 4(r16)
    srli r9, r9, 16
    beq r0, r9, POLLING_ESCRITA2
    stw r12, (r8)

	andi r12, r12, 0xFF
	movia r11, 0x30
	beq r12, r11, TRATA_TRIANGULAR
	/*trata erro*/

TRATA_TRIANGULAR:

POLLING_LEITURA3:
    ldwio r12, (r16)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA3

POLLING_ESCRITA3:
    ldwio r9, 4(r16)
    srli r9, r9, 16
    beq r0, r9, POLLING_ESCRITA3
    stw r12, (r16)
	
	andi r12, r12, 0xFF
	subi r14, r12, 0x30
	slli r15, r14, 3
	slli r14, r14, 1
	add r14, r14, r15
	
POLLING_LEITURA4:
    ldwio r12, (r16)
    slli r13, r12, 16
    srli r13, r13, 31
    beq r0, r13, POLLING_LEITURA4

POLLING_ESCRITA4:
    ldwio r9, 4(r16)
    srli r9, r9, 16
    beq r0, r9, POLLING_ESCRITA4
    stw r12, (r16)
	
	andi r12, r12, 0xFF
	add r14, r14, r12
	subi r14, r14, 0x30
	
CALCULA_TRIANGULAR:
	mov r8, r14
	mov r17, r14
	
MULTIPLICA:
	subi r8, r8, 1
	add r14, r14, r17
	bne r8, r0, MULTIPLICA
	srli r14, r14, 1
	
	add r8, r0, r0
	mov r10, r14
	mov r17, r0
	
VERIFICA_DECIMAIS:
	andi r18, r10, 0b1111111111110111
	subi r18, r18, 1
	subi r18, r18, 1		/*divide por 10*/
	
	sub r10, r10, r18
	bgt r10, r0, TEM_DIGITO
	br CONTINUA
	
TEM_DIGITO:
	addi r8, r8, 1
	
CONTINUA:
	subi r8, r8, 1
	beq r8, r0, PRIMEIRO_DIGITO
	subi r8, r8, 1
	beq r8, r0, SEGUNDO_DIGITO
	subi r8, r8, 1
	beq r8, r0, TERCEIRO_DIGITO
	subi r8, r8, 1
	beq r8, r0, QUARTO_DIGITO
	
PRIMEIRO_DIGITO:
	addi r8, r8, 1
	movia r16, 0x10000020
    ldwio r19,0(r16)
	mov r9, ra
	call INSERE_DIGITO
	mov ra, r9
	add r17, r17, r18
	bgt r10, r0, VERIFICA_DECIMAIS
	
SEGUNDO_DIGITO:
	addi r8, r8, 1
	mov r9, ra
	call INSERE_DIGITO
	mov ra, r9
	slli r18, r18, 1
	add r17, r17, r18
	bgt r10, r0, VERIFICA_DECIMAIS
	
TERCEIRO_DIGITO:
	addi r8, r8, 1
	mov r9, ra
	call INSERE_DIGITO
	mov ra, r9
	slli r18, r18, 2
	add r17, r17, r18
	bgt r10, r0, VERIFICA_DECIMAIS
	
QUARTO_DIGITO:
	addi r8, r8, 1
    stwio r17,0(r16)
    ret

	
INSERE_DIGITO:
	beq r18, r0, DIGITO_0
	subi r18, r18, 1
	beq r18, r0, DIGITO_1
	subi r18, r18, 1
	beq r18, r0, DIGITO_2
	subi r18, r18, 1
	beq r18, r0, DIGITO_3
	subi r18, r18, 1
	beq r18, r0, DIGITO_4
	subi r18, r18, 1
	beq r18, r0, DIGITO_5
	subi r18, r18, 1
	beq r18, r0, DIGITO_6
	subi r18, r18, 1
	beq r18, r0, DIGITO_7
	subi r18, r18, 1
	beq r18, r0, DIGITO_8
	subi r18, r18, 1
	beq r18, r0, DIGITO_9
	
DIGITO_0:
	addi r18, r0, 0b0111111
	ret

DIGITO_1:
	addi r18, r0, 0b0000011
	ret
	
DIGITO_2:
	addi r18, r0, 0b1011011
	ret
	
DIGITO_3:
	addi r18, r0, 0b1001111
	ret
	
DIGITO_4:
	addi r18, r0, 0b1100110
	ret
	
DIGITO_5:
	addi r18, r0, 0b1101101
	ret
	
DIGITO_6:
	addi r18, r0, 0b1111101
	ret
	
DIGITO_7:
	addi r18, r0, 0b0000111
	ret
	
DIGITO_8:
	addi r18, r0, 0b1111111
	ret
	
DIGITO_9:
	addi r18, r0, 0b1101111
	ret

/*
    movia r16, 0x10000000
    ldwio r19,0(r16)
    movia r17,0x1
    rol r17,r17,r14
    or r17,r17,r19
    stwio r17,0(r16)
    ret
*/
	/*Juntar Acende e Apaga led nos polling de escrita(OK)*/
	/*mudar registradores r9 e r12*/

	
	