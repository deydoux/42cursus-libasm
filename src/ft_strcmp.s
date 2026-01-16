section .text
	global ft_strcmp

; int strcmp(const char *s1, const char *s2);
ft_strcmp:
	; (const char *s1)rdi
	; (const char *s1)rsi

	xor rax, rax ; rax = 0
	xor rbx, rbx ; rbx = 0
	jmp .start_loop ; goto .start_loop

.loop:
	inc rdi ; rdi++
	inc rsi ; rsi++
.start_loop:
	mov al, byte [rdi] ; al = *rdi
	mov bl, byte [rsi] ; bl = *rsi
	sub rax, rbx ; al -= *rsi

	test al, al
	jnz .end ; if (al != 0) goto .end

	cmp byte [rdi], 0
	je .loop ; if (*rdi == 0) goto .loop

.end:
	ret
