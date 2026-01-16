section .text
	global ft_strlen

; size_t ft_strlen(const char *s);
ft_strlen:
	; (const char *s)rdi

	mov rax, rdi ; rax = rdi
	jmp .start_loop ; goto .start_loop

.loop:
	inc rax ; rax++
.start_loop:
	cmp byte [rax], 0 ; if (*rax != 0)
	jne .loop ; goto .loop

	sub rax, rdi ; rax -= rdi
	ret ; return rax
