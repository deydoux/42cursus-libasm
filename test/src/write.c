#include "assert.h"
#include "libasm.h"
#include <errno.h>
#include <fcntl.h>
#include <signal.h>

typedef ssize_t (*write_fn_t)(int, const void *, size_t);
typedef ssize_t (*test_write_fn_t)(write_fn_t);

char buf[65536];

ssize_t get_eagain(write_fn_t write_fn)
{
	int pipefd[2];
	pipe(pipefd);
	fcntl(pipefd[1], F_SETFL, O_NONBLOCK);

	ssize_t ret;
	do {
		ret = write_fn(pipefd[1], buf, sizeof(buf));
	} while (ret >= 0);

	close(pipefd[0]);
	close(pipefd[1]);
	return ret;
}

ssize_t get_ebadf(write_fn_t write_fn)
{
	return write_fn(-1, buf, sizeof(buf));
}

ssize_t get_efault(write_fn_t write_fn)
{
	return write_fn(1, NULL, 1);
}

void sig_handler(int signum)
{
	return ;
	(void)signum;
}

ssize_t get_eintr(write_fn_t write_fn)
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

	ssize_t ret;
	do {
		ret = write_fn(pipefd[1], buf, sizeof(buf));
	} while (ret >= 0);

	close(pipefd[0]);
	close(pipefd[1]);
	sigaction(SIGUSR1, &old_act, NULL);
	return ret;
}

ssize_t get_enospc(write_fn_t write_fn)
{
	int fd = open("/dev/full", O_WRONLY);
	ssize_t ret = write_fn(fd, buf, sizeof(buf));

	close(fd);
	return ret;
}

ssize_t get_epipe(write_fn_t write_fn)
{
	struct sigaction act = {
		.sa_handler = SIG_IGN
	};
	struct sigaction old_act;
	sigaction(SIGPIPE, &act, &old_act);

	int pipefd[2];
	pipe(pipefd);
	close(pipefd[0]);

	ssize_t ret = write_fn(pipefd[1], buf, sizeof(buf));

	close(pipefd[1]);
	sigaction(SIGPIPE, &old_act, NULL);
	return ret;
}

void test_write_errno(test_write_fn_t test_write_fn, const char *name)
{
	printf(BBLK "\n--- Check %s ---" RESET "\n", name);

	errno = 0;
	ssize_t ret = test_write_fn(write);
	int err = errno;
	printf("   write(...) = %zd -> %s\n", ret, strerrorname_np(err));

	errno = 0;
	ssize_t ft_ret = test_write_fn(ft_write);
	int ft_err = errno;
	printf("ft_write(...) = %zd -> %s\n", ft_ret, strerrorname_np(ft_err));

	assert(ret == ft_ret && err == ft_err);
}

int main(void)
{
	memset(buf, 'A', sizeof(buf));

	printf(BBLK BLKB "=== Testing ft_write ===" RESET "\n");

	ssize_t bytes = ft_write(1, "Hello, World!\n", 14);
	printf("ft_write(1, \"Hello, World!\\n\", 14) = %zd\n", bytes);

	test_write_errno(get_eagain, "EAGAIN");
	test_write_errno(get_ebadf, "EBADF");
	test_write_errno(get_efault, "EFAULT");
	test_write_errno(get_eintr, "EINTR");
	test_write_errno(get_enospc, "ENOSPC");
	test_write_errno(get_epipe, "EPIPE");
}
