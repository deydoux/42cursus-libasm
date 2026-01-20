extern ft_strcpy
extern ft_strlen
extern malloc

section .text
	global ft_strdup

; char *ft_strdup(const char *s);
ft_strdup:
	; (const char *s)rdi

	push rdi ; (const char *s)
	call ft_strlen ; rax = ft_strlen(rdi)

	mov rdi, rax ; rdi = rax
	inc rdi ; rdi++
	call malloc ; rax = malloc(rdi)
	test rax, rax
	jz .end ; if (rax == 0) goto .end

	pop rsi ; (const char *s)
	mov rdi, rax ; rdi = rax
	call ft_strcpy ; rax = ft_strcpy(rdi, rsi)

.end:
	ret
