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
	mov bl, byte [rsi] ; bl = *rsi
	cmp byte [rdi], bl
	je .check_end ; if (*rdi == bl) goto .check_end
	; Characters differ
	mov rax, 1 ; al = 1
	jg .end ; if (*rdi > bl) goto .end
	; else
	neg rax ; rax *= -1
	jmp .end ; goto .end

; Check if '\0' reached
.check_end:
	test bl, bl
	jnz .loop ; if (bl != 0) goto .loop

.end:
	ret
