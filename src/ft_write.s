extern __errno_location

section .text
	global ft_write

; ssize_t ft_write(int fd, const void *buf, size_t count);
ft_write:
	; (int fd)edi
	; (const void *buf)rsi
	; (size_t count)rdx

	mov eax, 1 ; eax = 1 // write system call number
	syscall ; write(edi, rsi, rdx)

	cmp rax, 0
	jge .end ; if (rax >= 0) goto .end

	mov ebx, eax ; ebx = eax
	neg ebx ; ebx *= -1
	call __errno_location
	mov [rax], ebx ; *rax = ebx
	mov rax, -1 ; rax = -1

.end:
	ret ; return rax
