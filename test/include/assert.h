#ifndef _ASSERT_H_
# define _ASSERT_H_

# define _GNU_SOURCE

# include "color.h"
# include <signal.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <sys/wait.h>
# include <unistd.h>

# define print_success() printf(BBLK GRNB "Test passed!" RESET "\n")
# define print_failure() printf(BBLK REDB "Test failed!" RESET "\n")

# define assert(expr) \
	if (expr) \
		print_success(); \
	else \
		print_failure();

# define get_signal(expr) \
retsig = 0; \
{ \
	pid_t pid = fork(); \
	if (pid == 0) { \
		expr; \
		exit(0); \
	} \
	int status; \
	waitpid(pid, &status, 0); \
	if (WIFSIGNALED(status)) \
		retsig = WTERMSIG(status); \
}

#endif /* _ASSERT_H_ */
