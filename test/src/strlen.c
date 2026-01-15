#include "assert.h"
#include "libasm.h"
#include <string.h>

void test_strlen(const char *s)
{
	printf("\n");
	size_t len = strlen(s);
	printf("   strlen(\"%s\") = %zu\n", s, len);

	size_t ft_len = ft_strlen(s);
	printf("ft_strlen(\"%s\") = %zu\n", s, ft_len);

	assert(len == ft_len);
}

int main(int argc, char **argv)
{
	if (argc > 1) {
		for (int i = 1; i < argc; i++)
			test_strlen(argv[i]);

		return 0;
	}

	test_strlen("Hello, World!");
	test_strlen("42");
	test_strlen("");
	test_strlen("This is a longer string to test the strlen function.");
}
