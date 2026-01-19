#include "assert.h"
#include "libasm.h"
#include <string.h>

static void test_strcmp(const char *s1, const char *s2)
{
	int ret = strcmp(s1, s2);
	printf("\n   strcmp(\"%s\", \"%s\") = %d\n", s1, s2, ret);

	int ft_ret = ft_strcmp(s1, s2);
	printf("ft_strcmp(\"%s\", \"%s\") = %d\n", s1, s2, ft_ret);

	int ret_rev = strcmp(s2, s1);
	printf("   strcmp(\"%s\", \"%s\") = %d\n", s2, s1, ret_rev);

	int ft_ret_rev = ft_strcmp(s2, s1);
	printf("ft_strcmp(\"%s\", \"%s\") = %d\n", s2, s1, ft_ret_rev);

	assert(ret == ft_ret && ret_rev == ft_ret_rev);
}

static void test_strcmp_signal(const char *s1, const char *s2, const char *s1_name, const char *s2_name)
{
	int ret;
	int retsig;

	get_signal(ret = strcmp(s1, s2));
	int sig = retsig;
	printf("\n   strcmp(%s, %s) -> SIG%s\n", s1_name, s2_name, sigabbrev_np(sig));

	get_signal(ret = ft_strcmp(s1, s2));
	int ft_sig = retsig;
	printf("ft_strcmp(%s, %s) -> SIG%s\n", s1_name, s2_name, sigabbrev_np(ft_sig));

	get_signal(ret = strcmp(s2, s1));
	int rev_sig = retsig;
	printf("   strcmp(%s, %s) -> SIG%s\n", s2_name, s1_name, sigabbrev_np(rev_sig));

	get_signal(ret = ft_strcmp(s2, s1));
	int ft_rev_sig = retsig;
	printf("ft_strcmp(%s, %s) -> SIG%s\n", s2_name, s1_name, sigabbrev_np(ft_rev_sig));

	assert(sig == ft_sig && rev_sig == ft_rev_sig);
}

int main(int argc, char **argv)
{
	printf(BBLK BLKB "=== Testing ft_strcmp ===" RESET "\n");

	if (argc > 2) {
		for (int i = 1; i + 1 < argc; i++)
			test_strcmp(argv[i], argv[i + 1]);

		return 0;
	}

	test_strcmp("Hello, World!", "Hello, World!");
	test_strcmp("Hello World!", "Hello, World?");
	test_strcmp("The Answer", "42");
	test_strcmp("Non-empty", "");
	{
		const char s1[] = {-1, -2, -3, 0};
		const char s2[] = {-1, -2, -3, 0};
		test_strcmp(s1, s2);
	}
	{
		const char s1[] = {-1, -3, -2, 0};
		const char s2[] = {-1, -2, -3, 0};
		test_strcmp(s1, s2);
	}
	{
		char *dest = NULL;
		char *src = "Non-NULL";
		test_strcmp_signal(dest, src, "NULL", "\"Non-NULL\"");
	}
	{
		char *dest = NULL;
		char *src = NULL;
		test_strcmp_signal(dest, src, "NULL", "NULL");
	}
}
