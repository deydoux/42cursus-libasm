#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include "assert.h"
#include "libasm.h"

typedef ssize_t (*read_fn_t)(int, void *, size_t);
typedef ssize_t (*test_read_fn_t)(read_fn_t);

char buf[65536];

ssize_t get_eagain(read_fn_t read_fn)
{
	int pipefd[2];
	pipe(pipefd);
	fcntl(pipefd[0], F_SETFL, O_NONBLOCK);

	ssize_t ret = read_fn(pipefd[0], buf, sizeof(buf));

	close(pipefd[0]);
	close(pipefd[1]);
	return ret;
}

ssize_t get_ebadf(read_fn_t read_fn)
{
	return read_fn(-1, buf, sizeof(buf));
}

ssize_t get_efault(read_fn_t read_fn)
{
	int pipefd[2];
	pipe(pipefd);

	write(pipefd[1], "42", 2);
	ssize_t ret = read_fn(pipefd[0], NULL, 2);

	close(pipefd[0]);
	close(pipefd[1]);
	return ret;
}

void sig_handler(int signum)
{
	return ;
	(void)signum;
}

ssize_t get_eintr(read_fn_t read_fn)
{
	struct sigaction act = {
		.sa_handler = sig_handler,
		.sa_flags = SA_INTERRUPT
	};
	struct sigaction old_act;
	sigaction(SIGUSR1, &act, &old_act);

	int pipefd[2];
	pipe(pipefd);

	if (fork() == 0) {
		kill(getppid(), SIGUSR1);
		exit(0);
	}

	ssize_t ret = read_fn(pipefd[0], buf, sizeof(buf));

	close(pipefd[0]);
	close(pipefd[1]);
	sigaction(SIGUSR1, &old_act, NULL);
	return ret;
}

ssize_t get_eisdir(read_fn_t read_fn)
{
	int fd = open(".", O_RDONLY);
	ssize_t ret = read_fn(fd, buf, sizeof(buf));

	close(fd);
	return ret;
}

void test_read_errno(test_read_fn_t test_read_fn, const char *name)
{
	printf(BBLK "\n--- Check %s ---" RESET "\n", name);

	errno = 0;
	ssize_t ret = test_read_fn(read);
	int err = errno;
	printf("   read(...) = %zd -> %s\n", ret, strerrorname_np(err));

	errno = 0;
	ssize_t ft_ret = test_read_fn(ft_read);
	int ft_err = errno;
	printf("ft_read(...) = %zd -> %s\n", ft_ret, strerrorname_np(ft_err));

	assert(ret == ft_ret && err == ft_err);
}

int main(void)
{
	printf(BBLK BLKB "=== Testing ft_read ===" RESET "\n");

	int pipefd[2];
	pipe(pipefd);

	ssize_t ret = write(pipefd[1], "Hello, World!", 14);
	printf("write(pipefd[1], \"Hello, World!\", 14) = %zd\n", ret);

	ret = ft_read(pipefd[0], buf, sizeof(buf));
	printf("read(pipefd[0], buf, %zu) = %zd\n", sizeof(buf), ret);
	printf("buf = \"%.*s\"\n", (int)ret, buf);

	close(pipefd[0]);
	close(pipefd[1]);

	test_read_errno(get_eagain, "EAGAIN");
	test_read_errno(get_ebadf, "EBADF");
	test_read_errno(get_efault, "EFAULT");
	test_read_errno(get_eintr, "EINTR");
	test_read_errno(get_eisdir, "EISDIR");
}
