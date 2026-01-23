section .text
	global ft_strcmp

; int strcmp(const char *s1, const char *s2);
ft_strcmp:
	; (const char *s1)rdi
	; (const char *s2)rsi

	jmp .init_loop ; goto .init_loop

.loop:
	inc rdi ; rdi++
	inc rsi ; rsi++
.init_loop:
	mov al, byte [rdi] ; al = *rdi
	mov bl, byte [rsi] ; bl = *rsi
	sub al, bl ; al -= bl

	test al, al
	jnz .end ; if (al != 0) goto .end

	cmp byte [rdi], 0
	jne .loop ; if (*rdi != 0) goto .loop

.end:
	movsx eax, al ; eax = (int)al
	ret ; return eax
