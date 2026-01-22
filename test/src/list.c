#include "assert.h"
#include "libasm.h"

void print_list(t_list *list)
{
	printf(BBLK "list = " RESET);
	for (t_list *current = list; current != NULL; current = current->next)
		printf("\"%s\" -> ", (char *)current->data);
	printf("NULL\n");
}

void test_list_size(t_list *list, int expected)
{
	int size = ft_list_size(list);
	printf("ft_list_size(list) = %d\n", size);

	assert(size == expected);
}

void print_list_push_front(t_list **list, char *data)
{
	ft_list_push_front(list, data);
	printf("ft_list_push_front(list, \"%s\")\n", data);
}

int is_even(const char *s1)
{
	return s1[0] % 2 == 0;
}

int ret_one(void)
{
	return 1;
}

int main(void)
{
	t_list *list = NULL;
	print_list(list);

	putchar('\n');
	test_list_size(list, 0);

	putchar('\n');
	print_list_push_front(&list, strdup("world"));
	print_list(list);
	test_list_size(list, 1);
	assert(strcmp(list->data, "world") == 0);
	assert(list->next == NULL);
	assert(ft_list_size(list) == 1);

	putchar('\n');
	print_list_push_front(&list, strdup("hello"));
	print_list(list);
	test_list_size(list, 2);
	assert(strcmp(list->data, "hello") == 0);
	assert(strcmp(list->next->data, "world") == 0);
	assert(list->next->next == NULL);

	putchar('\n');
	print_list_push_front(&list, strdup("0"));
	print_list_push_front(&list, strdup("2"));
	print_list_push_front(&list, strdup("4"));
	print_list_push_front(&list, strdup("6"));
	print_list_push_front(&list, strdup("8"));
	print_list_push_front(&list, strdup("9"));
	print_list_push_front(&list, strdup("7"));
	print_list_push_front(&list, strdup("5"));
	print_list_push_front(&list, strdup("3"));
	print_list_push_front(&list, strdup("1"));
	print_list(list);
	test_list_size(list, 12);

	putchar('\n');
	printf("ft_list_sort(&list, ft_strcmp)\n");
	ft_list_sort(&list, ft_strcmp);
	print_list(list);

	putchar('\n');
	printf("ft_list_remove_if(&list, NULL, is_even, free)\n");
	ft_list_remove_if(&list, NULL, is_even, free);
	print_list(list);

	putchar('\n');
	printf("ft_list_remove_if(&list, NULL, ret_one, free)\n");
	ft_list_remove_if(&list, NULL, ret_one, free);
	print_list(list);
}
