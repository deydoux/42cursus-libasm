#include "assert.h"
#include "libasm.h"

void test_strdup(const char *s)
{
	char *ret = strdup(s);
	printf("\n   strdup(\"%s\") = \"%s\"\n", s, ret);

	char* ft_ret = ft_strdup(s);
	printf("ft_strdup(\"%s\") = \"%s\"\n", s, ft_ret);

	assert(strcmp(ret, ft_ret) == 0);

	free(ret);
	free(ft_ret);
}

void test_strdup_signal(const char *s, const char *name)
{
	int retsig;

	get_signal(strdup(s));
	int sig = retsig;
	printf("\n   strdup(%s) -> SIG%s\n", name, sigabbrev_np(sig));

	get_signal(ft_strdup(s));
	int ft_sig = retsig;
	printf("ft_strdup(%s) -> SIG%s\n", name, sigabbrev_np(ft_sig));

	assert(sig == ft_sig);
}

int main(int argc, char **argv)
{
	printf(BBLK BLKB "=== Testing ft_strdup ===" RESET "\n");

	if (argc > 1)
	{
		for (int i = 1; i < argc; i++)
			test_strdup(argv[i]);
		return (0);
	}

	test_strdup("Hello, World!");
	test_strdup("");
	test_strdup("42");
	test_strdup("This is a longer string to test the strdup function.");
	test_strdup_signal(NULL, "NULL");
}
