#include "assert.h"
#include "libasm.h"

int print_atoi_base(char *str, char *base)
{
	int ret = ft_atoi_base(str, base);
	printf("\nft_atoi_base(\"%s\", \"%s\") = %d\n", str, base, ret);

	return ret;
}

void test_atoi_base(char *str, char *base, int expected)
{
	assert(print_atoi_base(str, base) == expected);
}

int main(int argc, char **argv)
{
	printf(BBLK BLKB "=== Testing ft_atoi_base ===" RESET "\n");

	if (argc == 3)
	{
		print_atoi_base(argv[1], argv[2]);
		return 0;
	}

	test_atoi_base("42", "", 0);
	test_atoi_base("42", "0", 0);
	test_atoi_base("42", "0123456789+", 0);
	test_atoi_base("42", "0123456789-", 0);
	test_atoi_base("42", "0123456789 ", 0);
	test_atoi_base("42", "01234+56789", 0);
	test_atoi_base("42", "01234-56789", 0);
	test_atoi_base("42", "01234 56789", 0);

	test_atoi_base("+ 42", "0123456789", 0);
	test_atoi_base("- 42", "0123456789", 0);
	test_atoi_base("++42", "0123456789", 0);
	test_atoi_base("--42", "0123456789", 0);
	test_atoi_base("-+42", "0123456789", 0);
	test_atoi_base("+-42", "0123456789", 0);
	test_atoi_base("+-+42", "0123456789", 0);
	test_atoi_base("-+-42", "0123456789", 0);

	test_atoi_base("101010", "01", 42);
	test_atoi_base("+101010", "01", 42);
	test_atoi_base("-101010", "01", -42);
	test_atoi_base("42", "0123456789", 42);
	test_atoi_base("+42", "0123456789", 42);
	test_atoi_base("-42", "0123456789", -42);
	test_atoi_base("2A", "0123456789ABCDEF", 0x2A);
	test_atoi_base("+2A", "0123456789ABCDEF", 0x2A);
	test_atoi_base("-2A", "0123456789ABCDEF", -0x2A);
	test_atoi_base("   1111", "01", 15);
	{
		int ret = ft_atoi_base("\t\n\v\f\r 100000", "01");
		printf("\nft_atoi_base(\"\\t\\n\\v\\f\\r 100000\", \"01\") = %d\n", ret);
		assert(ret == 32);
	}
	test_atoi_base("   -7B", "0123456789ABCDEF", -0x7B);
	test_atoi_base("7FFFFFFF", "0123456789ABCDEF", 0x7FFFFFFF);
	test_atoi_base("-80000000", "0123456789ABCDEF", -0x80000000);
	test_atoi_base("1234567890ABCDEF", "0123456789ABCDEF", (int)0x1234567890ABCDEF);
	test_atoi_base("-1234567890ABCDEF", "0123456789ABCDEF", (int)-0x1234567890ABCDEF);

	test_atoi_base("1234567890ABCDEF1234567890ABCDEF", "0123456789ABCDEF", -1);
	test_atoi_base("-1234567890ABCDEF1234567890ABCDEF", "0123456789ABCDEF", 0);
}
