#include "assert.h"
#include "libasm.h"
#include <string.h>

static void test_strlen(const char *s)
{
	size_t len = strlen(s);
	printf("\n   strlen(\"%s\") = %zu\n", s, len);

	size_t ft_len = ft_strlen(s);
	printf("ft_strlen(\"%s\") = %zu\n", s, ft_len);

	assert(len == ft_len);
}

static void test_strlen_signal(const char *s, const char *name)
{
	int retsig;

	size_t len;
	get_signal(len = strlen(s));
	int sig = retsig;
	printf("\n   strlen(%s) -> SIG%s\n", name, sigabbrev_np(sig));

	size_t ft_len;
	get_signal(ft_len = ft_strlen(s));
	int ft_sig = retsig;
	printf("ft_strlen(%s) -> SIG%s\n", name, sigabbrev_np(ft_sig));

	assert(sig == ft_sig);
}

int main(int argc, char **argv)
{
	printf(BBLK BLKB "=== Testing ft_strlen ===" RESET "\n");

	if (argc > 1) {
		for (int i = 1; i < argc; i++)
			test_strlen(argv[i]);

		return 0;
	}

	test_strlen("Hello, World!");
	test_strlen("42");
	test_strlen("");
	test_strlen("This is a longer string to test the strlen function.");
	test_strlen_signal(NULL, "NULL");
	test_strlen_signal((const char *)0x1, "0x1");
}
