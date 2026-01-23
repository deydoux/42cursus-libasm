<div align="center">
	<img height="64" src="https://github.com/user-attachments/assets/4c2a75de-4325-48a6-bf35-9f393a43e4c0"/>
	<h1>libasm</h1>
	<p>The aim of this project is to become familiar with assembly language.</p>
</div>

## About the project
This project introduces x86-64 assembly language programming by reimplementing standard C library functions. It requires writing assembly code using the Intel syntax and compiling with NASM.

### Key Requirements
- Write assembly code in 64-bit architecture
- Use Intel syntax
- Compile with NASM
- [Implementation](#implementation) of standard C library functions

### Skills Learned
- Understanding of low-level programming and CPU architecture
- Register management and calling conventions (System V AMD64 ABI)
- System calls in Linux
- Memory manipulation at assembly level
- Error handling with errno

## Implementation
### Mandatory functions

#### ft_strlen · *[man](https://man7.org/linux/man-pages/man3/strlen.3.html)*
Returns the **length** of the string `s`.
```c
size_t ft_strlen(const char *s);
```

#### ft_strcpy · *[man](https://man7.org/linux/man-pages/man3/strcpy.3.html)*
**Copies** the string from `src` to `dst`. Returns a pointer to `dst`.
```c
char *ft_strcpy(char *dst, const char *src);
```

#### ft_strcmp · *[man](https://man7.org/linux/man-pages/man3/strcmp.3.html)*
**Compares** two strings `s1` and `s2`.
```c
int ft_strcmp(const char *s1, const char *s2);
```

#### ft_write · *[man](https://man7.org/linux/man-pages/man2/write.2.html)*
**Writes** `count` bytes from the buffer `buf` to the file descriptor `fd`. On error, sets `errno` appropriately.
```c
ssize_t ft_write(int fd, const void *buf, size_t count);
```

#### ft_read · *[man](https://man7.org/linux/man-pages/man2/read.2.html)*
**Reads** `count` bytes from the file descriptor `fd` into the buffer `buf`. On error, sets `errno` appropriately.
```c
ssize_t ft_read(int fd, void *buf, size_t count);
```

#### ft_strdup · *[man](https://man7.org/linux/man-pages/man3/strdup.3.html)*
**Duplicates** the string `s` by allocating memory using `malloc`. Returns a pointer to the duplicated string.
```c
char *ft_strdup(const char *s);
```

### Bonus functions
The linked list functions will use the following structure:
```c
typedef struct s_list {
	void *data;
	struct s_list *next;
} t_list;
```

#### ft_atoi_base
**Converts** a string `str` to an integer using the specified `base`. Handles leading whitespace, optional sign, and validates the base format.
```c
int ft_atoi_base(const char *str, const char *base);
```

#### ft_list_push_front
**Push** a new element at the beginning of the list.
```c
void ft_list_push_front(t_list **begin_list, void *data);
```

#### ft_list_size
Returns the **size** of the list.
```c
int ft_list_size(t_list *begin_list);
```

#### ft_list_sort
**Sorts** the list in ascending order using the provided comparison function.
```c
void ft_list_sort(t_list **begin_list, int (*cmp)());
```

#### ft_list_remove_if
**Removes** elements from the list that match the reference data using the provided comparison function.
```c
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
```

## References
- [Let's Learn x86-64 Assembly! Part 0 - Setup and First Steps](https://gpfault.net/posts/asm-tut-0.txt.html)
- [Langage de programmation - Assembleur 80x86 - 8086/8088](https://www.gladir.com/CODER/ASM8086/8086-8088.htm)
- [Linux System Call Table for x86 64 · Ryan A. Chapman](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [GDB Cheat Sheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
- [System V AMD64 ABI](https://en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI)
