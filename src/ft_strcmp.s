section .text
	global ft_strcmp

; int strcmp(const char *s1, const char *s2);
ft_strcmp:
	; (const char *s1)rdi
	; (const char *s1)rsi

	xor rax, rax ; rax = 0
	jmp .start_loop ; goto .start_loop

.loop:
	inc rdi ; rdi++
	inc rsi ; rsi++
.start_loop:
	mov al, byte [rsi] ; al = *rsi
	sub al, byte [rdi] ; al -= *rdi
	neg rax ; rax *= -1
	test al, al
	jnz .end ; if (bl != 0) goto .end

	cmp byte [rdi], 0
	je .loop ; if (*rdi == 0) goto .loop

.end:
	ret
