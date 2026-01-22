extern malloc

section .text
	global ft_list_push_front

; void ft_list_push_front(t_list **begin_list, void *data);
ft_list_push_front:
	; (t_list **begin_list)rdi
	; (void *data)rsi

	push rdi ; t_list **begin_list
	push rsi ; void *data

	mov rdi, 16 ; rdi = sizeof(t_list)
	call malloc ; rax = malloc(rdi)
	test rax, rax
	jz .end ; if (rax == 0) goto .end

	pop rsi ; void *data
	pop rdi ; t_list **begin_list

	mov [rax], rsi ; rax->data = rsi
	mov rbx, [rdi] ; rbx = *rdi
	mov [rax + 8], rbx ; rax->next = rdi
	mov [rdi], rax ; *rdi = rax

.end:
	ret ; return
