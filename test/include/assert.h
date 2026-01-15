#ifndef _ASSERT_H_
# define _ASSERT_H_

# include "color.h"
# include <stdio.h>

# define assert(expr) \
	if (expr) \
		printf(BBLK GRNB "Test passed!" RESET "\n"); \
	else \
		printf(BBLK REDB "Test failed!" RESET "\n");

#endif /* _ASSERT_H_ */
