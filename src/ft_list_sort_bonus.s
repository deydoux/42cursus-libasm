section .text
	global ft_list_sort

; void ft_list_sort(t_list **begin_list, int (*cmp)());
ft_list_sort:
	; (t_list **begin_list)rdi
	; (int (*cmp)())rsi

	mov rcx, rsi ; rcx = rsi
	mov rdx, [rdi] ; rdx = *rdi
	jmp .init_loop ; goto .init_loop

.loop:
	mov rdx, [rdx + 8] ; rdx = rdx->next
.init_loop:
	test rdx, rdx
	jz .end ; if (rdx == 0) goto .end

	mov rdi, [rdx] ; rdi = rdx->data
	mov rbx, rdx ; rbx = rdx

.sort_loop:
	mov rbx, [rbx + 8] ; rbx = rbx->next
	test rbx, rbx
	jz .loop ; if (rbx == 0) goto .loop

	mov rsi, [rbx] ; rsi = rbx->data

	push rdi ; (void *)data
	push rsi ; (void *)data
	push rax ; stack align
	push rbx ; (t_list *current)
	push rcx ; (int (*cmp)())
	push rdx ; (t_list *begin_list)
	call rcx ; eax = cmp(rdi, rsi)
	mov r8d, eax ; r8d = eax
	pop rdx ; (t_list *begin_list)
	pop rcx ; (int (*cmp)())
	pop rbx ; (t_list *current)
	pop rax ; stack align
	pop rsi ; (void *)data
	pop rdi ; (void *)data

	cmp r8d, 0
	jle .sort_loop ; if (r8d <= 0) goto .sort_loop

.swap:
	mov [rdx], rsi ; rdx->data = rsi
	mov [rbx], rdi ; rbx->data = rdi
	mov rdi, rsi ; rdi = rsi
	jmp .sort_loop ; goto .sort_loop

.end:
	ret ; return
