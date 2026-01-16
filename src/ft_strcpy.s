section .text
	global ft_strcpy

; char *ft_strcpy(char *dest, const char *src);
ft_strcpy:
	; (const char *dest)rdi
	; (const char *dest)rsi

	mov rax, rdi ; rax = rdi

	dec rdi ; rdi--
	dec rsi ; rsi--

.loop:
	inc rdi ; rdi++
	inc rsi ; rsi++
	mov al, byte [rsi] ; al = *rsi
	mov byte [rdi], al ; *rdi = al
	test al, al ; if (al != 0)
	jnz .loop ; goto .loop

.end:
	ret ; return rax
