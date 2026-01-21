extern __errno_location

section .text
	global ft_read

; ssize_t ft_read(int fd, void *buf, size_t count);
ft_read:
	; (int fd)edi
	; (void *buf)rsi
	; (size_t count)rdx

	mov eax, 0 ; eax = 0 // read system call number
	syscall ; read(edi, rsi, rdx)

	cmp rax, 0
	jge .end ; if (rax >= 0) goto .end

	mov ebx, eax ; ebx = eax
	neg ebx ; ebx *= -1
	call __errno_location
	mov [rax], ebx ; *rax = ebx
	mov rax, -1 ; rax = -1

.end:
	ret ; return rax
