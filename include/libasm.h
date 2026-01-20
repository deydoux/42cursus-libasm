#ifndef _LIBASM_H_
#define _LIBASM_H_

# include <unistd.h>

char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *s1, const char *s2);
size_t ft_strlen(const char *s);
ssize_t ft_read(int fd, void *buf, size_t count);
ssize_t ft_write(int fd, const void *buf, size_t count);

#endif /* _LIBASM_H_ */
