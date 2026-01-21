#include "assert.h"
#include "libasm.h"

int main(void)
{
	t_list *list = NULL;

	ft_list_push_front(&list, strdup("world"));
	assert(strcmp(list->data, "world") == 0);
	assert(list->next == NULL);

	ft_list_push_front(&list, strdup("hello"));
	assert(strcmp(list->data, "hello") == 0);
	assert(strcmp(list->next->data, "world") == 0);
	assert(list->next->next == NULL);

	return (0);
}
