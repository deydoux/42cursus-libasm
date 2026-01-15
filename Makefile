NAME = libasm.a

SRC_DIR = src
INC_DIR = include
OBJ_DIR = .obj

SRCS = \
	ft_strlen.s

OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.s=.o))

AR = ar
ARFLAGS = -c -r -s
ASMC = nasm
ASMCFLAGS = -f elf64
RM = rm -rf
MKDIR = mkdir -p

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_DIR):
	$(MKDIR) $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(ASMC) $(ASMCFLAGS) -o $@ $<

clean:
	$(RM) $(OBJ_DIR)

fclean:
	$(RM) $(OBJ_DIR) $(NAME)

re: fclean all

.PHONY: all clean fclean re
