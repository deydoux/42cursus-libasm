extern free

section .text
	global ft_list_remove_if

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
ft_list_remove_if:
	; (t_list **begin_list)rdi
	; (void *data_ref)rsi
	; (int (*cmp)())rdx
	; (void (*free_fct)(void *))rcx

	mov rbx, rdi ; rbx = rdi // t_list **begin_list
	mov r8, [rbx] ; r8 = *rbx // t_list *current
	mov qword [rbx], 0 ; *rbx = 0
	jmp .head_init_loop ; goto .head_init_loop

.head_loop:
	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data // stack align
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call rcx ; free_fct(rdi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data // stack align
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

	mov rdi, r8 ; rdi = r8
	mov r8, [r8 + 8] ; r8 = r8->next

	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data // stack align
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call free ; free(rdi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data // stack align
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

.head_init_loop:
	test r8, r8
	jz .end ; if (r8 == 0) goto .end

	mov rdi, [r8] ; rdi = r8->data

	test rdx, rdx
	jz .head_loop ; if (rdx == 0) goto .head_loop

	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call rdx ; eax = cmp(rdi, rsi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

	test eax, eax
	jnz .head_loop ; if (eax != 0) goto .head_loop

	mov [rbx], r8 ; *rbx = r8
	mov rbx, [rbx] ; rbx = *rbx // t_list *previous
	jmp .init_loop ; goto .init_loop

.loop:
	mov rbx, r8 ; rbx = r8
.init_loop:
	mov r8, [rbx + 8] ; r8 = rbx->next
	test r8, r8
	jz .end ; if (r8 == 0) goto .end

	mov rdi, [r8] ; rdi = r8->data

	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call rdx ; eax = cmp(rdi, rsi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

	test eax, eax
	jz .loop ; if (eax == 0) goto .loop

	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data // stack align
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call rcx ; free_fct(rdi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data // stack align
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

	mov rdi, r8 ; rdi = r8
	mov rax, [r8 + 8] ; rax = r8->next
	mov [rbx + 8], rax ; rbx->next = rax
	mov rbx, rax ; rbx = rax

	push rbx ; t_list **begin_list
	push rcx ; void (*free_fct)(void *)
	push rdx ; int (*cmp)()
	push rdi ; void *data // stack align
	push rsi ; void *data_ref
	push r8 ; t_list *current
	call free ; free(rdi)
	pop r8 ; t_list *current
	pop rsi ; void *data_ref
	pop rdi ; void *data // stack align
	pop rdx ; int (*cmp)()
	pop rcx ; void (*free_fct)(void *)
	pop rbx ; t_list **begin_list

	test rbx, rbx
	jnz .init_loop ; if (rbx != 0) goto .init_loop

.end:
	ret ; return
