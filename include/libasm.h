#ifndef _LIBASM_H_
#define _LIBASM_H_

# include <unistd.h>

typedef struct s_list {
	void *data;
	struct s_list *next;
} t_list;

char *ft_strcpy(char *dest, const char *src);
char *ft_strdup(const char *s);
int ft_atoi_base(char *str, char *base);
int ft_strcmp(const char *s1, const char *s2);
size_t ft_strlen(const char *s);
ssize_t ft_read(int fd, void *buf, size_t count);
ssize_t ft_write(int fd, const void *buf, size_t count);
void ft_list_push_front(t_list **begin_list, void *data);

#endif /* _LIBASM_H_ */
