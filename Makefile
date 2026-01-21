NAME = libasm.a

INC_DIR = include
OBJ_DIR = .obj
SRC_DIR = src
TEST_DIR = test

SRCS = \
	ft_atoi_base_bonus.s \
	ft_list_push_front_bonus.s \
	ft_list_size_bonus.s \
	ft_read.s \
	ft_strcmp.s \
	ft_strcpy.s \
	ft_strdup.s \
	ft_strlen.s \
	ft_write.s

OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.s=.o))

AR = ar
ARFLAGS = -c -r -s
ASMC = nasm
ASMCFLAGS = -f elf64 -g -F dwarf
RM = rm -rf
MKDIR = mkdir -p

all bonus: $(NAME) test

run:
	$(MAKE) -C $(TEST_DIR) $@

test:
	$(MAKE) -C $(TEST_DIR)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_DIR):
	$(MKDIR) $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(ASMC) $(ASMCFLAGS) -o $@ $<

clean:
	$(MAKE) -C $(TEST_DIR) $@
	$(RM) $(OBJ_DIR)

fclean:
	$(MAKE) -C $(TEST_DIR) $@
	$(RM) $(OBJ_DIR) $(NAME)

re: fclean all

.PHONY: all bonus test clean fclean re
