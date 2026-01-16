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
	mov dl, byte [rsi] ; dl = *rsi
	mov byte [rdi], dl ; *rdi = dl
	test dl, dl ; if (dl != 0)
	jnz .loop ; goto .loop

.end:
	ret ; return rax
