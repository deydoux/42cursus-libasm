section .text
	global ft_strlen

; size_t ft_strlen(const char *s);
ft_strlen:
	; (const char *s)rdi

	mov rax, rdi ; rax = rdi
	dec rax ; rax--

.loop:
	inc rax ; rax++
	cmp byte [rax], 0 ; *rax != 0
	jne .loop

	sub rax, rdi ; rax -= rdi
	ret ; return rax
