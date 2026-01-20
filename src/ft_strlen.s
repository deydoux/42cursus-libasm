section .text
	global ft_strlen

; size_t ft_strlen(const char *s);
ft_strlen:
	; (const char *s)rdi

	mov rax, rdi ; rax = rdi
	jmp .init_loop ; goto .init_loop

.loop:
	inc rax ; rax++
.init_loop:
	cmp byte [rax], 0
	jne .loop ; if (*rax != 0) goto .loop

	sub rax, rdi ; rax -= rdi
	ret ; return rax
