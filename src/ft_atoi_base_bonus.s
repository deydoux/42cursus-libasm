section .text
	global ft_atoi_base

; int isspace(int c)
isspace:
	; (int c)rdi

	xor eax, eax ; eax = 0

	cmp rdi, 9
	jl .end ; if (rdi < '\t') goto .end

	cmp rdi, 13
	jle .end_true ; if (rdi <= '\r') goto .end_true

	cmp rdi, 32
	jne .end ; if (rdi != ' ') goto .end

.end_true:
	inc eax ; eax++
.end:
	ret ; return eax


; int invalid_base(int c)
invalid_base:
	; (int c)rdi

	call isspace
	test al, al
	jnz .end ; if (al != 0) goto .end

	cmp rdi, 43
	je .end_true ; if (rdi == '+') goto .end_true

	cmp rdi, 45
	jne .end ; if (rdi == '-') goto .end

.end_true:
	inc eax ; eax++
.end:
	ret ; return eax


; ssize_t find(char v, const char *s)
find:
	; (char v)dil
	; (const char *s)rsi

	mov rax, rsi ; rax = rsi
	jmp .init_loop ; goto .init_loop

.loop:
	inc rax ; rax++
.init_loop:
	cmp byte [rax], 0
	je .error ; if (*rax == 0) goto .error

	cmp byte [rax], dil
	jne .loop ; if (*rax != dil) goto .loop

	sub rax, rsi ; rax -= rsi
	ret ; return rax

.error:
	mov rax, -1 ; rax = -1
	ret ; return rax


; int ft_atoi_base(char *str, char *base);
ft_atoi_base:
	; (char *str)rdi
	; (char *base)rsi

	mov r8, rdi ; r8 = rdi
	mov rbx, rsi ; rbx = rsi
	jmp .check_base_init_loop ; goto .check_base_loop

.check_base_loop:
	inc rsi ; rsi++
	call find ; rax = find(dil, rsi)
	cmp rax, -1
	jne .base_error ; if (rax != -1) goto .base_error

.check_base_init_loop:
	movsx rdi, byte [rsi] ; rdi = *rsi
	call invalid_base ; al = invalid_base(rdi)
	test al, al
	jnz .base_error ; if (al != 0) goto .base_error

	test rdi, rdi
	jnz .check_base_loop ; if (rdi != 0) goto .check_base_loop

	sub rsi, rbx ; rsi -= rdi
	cmp rsi, 2
	jl .base_error ; if (rsi < 2) goto .base_error

	mov rcx, rsi ; rcx = rsi // base length
	mov rsi, rbx ; rsi = rbx
	jmp .skip_space_init_loop ; goto .skip_space_init_loop

.skip_space_loop:
	inc r8 ; r8++
.skip_space_init_loop:
	movsx rdi, byte [r8] ; rdi = *r8
	call isspace ; al = isspace(rdi)
	test al, al
	jnz .skip_space_loop ; if (al != 0) goto .skip_space_loop

	xor r9, r9 ; r9 = 0 // n
	mov r11, 1 ; r11 = 1 // sign

; .check_sign:
	cmp byte [r8], 43
	je .loop ; if (*r8 == '+') goto .loop

	cmp byte [r8], 45
	jne .init_loop ; if (*r8 != '-') goto .init_loop

	mov r11, -1 ; r11 = -1

.loop:
	inc r8 ; r8++
.init_loop:
	mov dil, byte [r8] ; dil = *r8
	test dil, dil
	jz .end ; if (dil == 0) goto .end

	call find ; rax = find(dil, rsi)
	cmp rax, -1
	je .end ; if (rax == -1) goto .end

	mov r10, rax ; r10 = rax // save index in base
	mov rax, r9 ; rax = r9 // copy n to multiply in rax
	mul rcx ; rax *= rcx // multiply with base length
	add rax, r10 ; rax += r10 // add base index
	cmp rax, r9
	jle .error ; if (rax <= r9) goto .error // check long overflow

	mov r9, rax ; r9 = rax ; restore n to r9
	jmp .loop ; goto .loop

.end:
	mov eax, r9d ; eax = r9d
	mul r11 ; eax *= r11
	ret ; return eax

.error:
	xor eax, eax ; eax = 0
	cmp r11, 1
	sete al ; al = r11 == 1
	neg eax ; eax *= -1
	ret ; return eax

.base_error:
	xor eax, eax ; eax = 0
	ret ; return eax
