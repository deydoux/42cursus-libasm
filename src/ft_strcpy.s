section .text
	global ft_strcpy

; char *ft_strcpy(char *dest, const char *src);
ft_strcpy:
	; (const char *dest)rdi
	; (const char *src)rsi

	mov rax, rdi ; rax = rdi
	jmp .init_loop ; goto .init_loop

.loop:
	inc rdi ; rdi++
	inc rsi ; rsi++
.init_loop:
	mov dl, byte [rsi] ; dl = *rsi
	mov byte [rdi], dl ; *rdi = dl
	test dl, dl
	jnz .loop ; if (dl != 0) goto .loop

	ret ; return rax
