section .text
	global ft_atoi_base

; int isspace(int c)
isspace:
	; (int c)rdi

	xor rax, rax ; rax = 0

	cmp rdi, 9
	jl .end ; if (rdi < '\t') goto .end

	cmp rdi, 13
	jle .end_true ; if (rdi <= '\r') goto .end_true

	cmp rdi, 32
	jne .end ; if (rdi != ' ') goto .end

.end_true:
	inc rax ; rax++
.end:
	ret


; int invalid_base(int c)
invalid_base:
	; (int c)rdi

	call isspace
	test rax, rax
	jnz .end ; if (rax != 0) goto .end

	cmp rdi, 43
	je .end_true ; if (rdi == '+') goto .end_true

	cmp rdi, 45
	jne .end ; if (rdi == '-') goto .end

.end_true:
	mov rax, 1
.end:
	ret


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

	mov rdx, rdi ; rdx = rdi
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
	inc rdx ; rdx++
.skip_space_init_loop:
	movsx rdi, byte [rdx] ; rdi = *rdx
	call isspace ; al = isspace(rdi)
	test al, al
	jnz .skip_space_loop ; if (al != 0) goto .skip_space_loop

	xor r8, r8 ; r8 = 0 // n
	mov r10b, 1 ; r10b = 1 // sign

	cmp byte [rdx], 43
	je .loop ; if (*rdx == '+') goto .loop

	cmp byte [rdx], 45
	jne .init_loop ; if (*rdx != '-') goto .init_loop

	mov r10b, -1 ; r10b = -1

.loop:
	inc rdx ; rdx++
.init_loop:
	mov dil, byte [rdx] ; dil = *rdx
	test dil, dil
	jz .end ; if (dil == 0) goto .end

	call find ; rax = find(dil, rsi)
	cmp rax, -1
	je .end ; if (rax == -1) goto .end

	mov r9, rax ; r9 = rax
	mov rax, r8 ; rax = r8
	push rdx
	mul rcx ; rax *= rcx
	pop rdx
	add rax, r9 ; rax += r9
	cmp rax, r8
	jle .error ; if (rax <= r8) goto .error

	mov r8, rax ; r8 = rax
	jmp .loop ; goto .loop

.end:
	mov eax, r8d ; eax = r8d
	mul r10b ; eax *= r10b
	ret ; return eax

.error:
	xor eax, eax ; eax = 0
	cmp r10b, 1
	sete al ; al = r10b == 1
	neg eax ; eax *= -1
	ret ; return eax

.base_error:
	xor eax, eax ; eax = 0
	ret ; return eax
