#include "assert.h"
#include "libasm.h"
#include <string.h>

static void test_strcpy(const char *dest, const char *src)
{
	char *dest_cpy = strdup(dest);
	char *ft_dest = strdup(dest);

	char *ret = strcpy(dest_cpy, src);
	printf("\n   strcpy(\"%s\", \"%s\") = \"%s\"\n", dest, src, ret);

	char *ft_ret = ft_strcpy(ft_dest, src);
	printf("ft_strcpy(\"%s\", \"%s\") = \"%s\"\n", dest, src, ft_ret);

	assert(ret == dest_cpy && ft_ret == ft_dest && strcmp(dest_cpy, ft_dest) == 0);

	free(dest_cpy);
	free(ft_dest);
}

static void test_strcpy_signal(char *dest, const char *src, const char *dest_name, const char *src_name)
{
	int retsig;

	get_signal(strcpy(dest, src));
	int sig = retsig;
	printf("\n   strcpy(%s, %s) -> SIG%s\n", dest_name, src_name, sigabbrev_np(sig));

	get_signal(ft_strcpy(dest, src));
	int ft_sig = retsig;
	printf("ft_strcpy(%s, %s) -> SIG%s\n", dest_name, src_name, sigabbrev_np(ft_sig));

	assert(sig == ft_sig);
}

int main(void)
{
	printf(BBLK BLKB "=== Testing ft_strcpy ===" RESET "\n");

	test_strcpy("Hello, World!", "Goodbye!");
	test_strcpy("The Answer", "42");
	test_strcpy("Non-empty", "");
	{
		char *dest = "";
		char *src = "Non-empty";
		test_strcpy_signal(dest, src, "\"\"", "\"Non-empty\"");
	}
	{
		char *dest = NULL;
		char *src = "Non-empty";
		test_strcpy_signal(dest, src, "NULL", "\"Non-empty\"");
	}
	{
		char *dest = "Non-empty";
		char *src = NULL;
		test_strcpy_signal(dest, src, "\"Non-empty\"", "NULL");
	}
	{
		char *dest = NULL;
		char *src = NULL;
		test_strcpy_signal(dest, src, "NULL", "NULL");
	}
}
