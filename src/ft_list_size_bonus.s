section .text
	global ft_list_size

; int ft_list_size(t_list *begin_list);
ft_list_size:
	; (t_list *begin_list)rdi

	mov rdx, rdi ; rdx = rdi
	xor eax, eax ; eax = 0
	jmp .init_loop ; goto .init_loop

.loop:
	mov rdx, [rdx + 8] ; rdx = rdx->next
	inc eax ; eax++
.init_loop:
	test rdx, rdx
	jnz .loop ; if (rdx != 0) goto .loop

	ret ; return eax
