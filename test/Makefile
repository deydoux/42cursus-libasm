LIBASM = asm
LIBASM_DIR = ..
LIBASM_FILE = lib$(LIBASM).a
LIBASM_PATH = $(LIBASM_DIR)/$(LIBASM_FILE)

INC_DIRS = include $(LIBASM_DIR)/include
OBJ_DIR = .obj
SRC_DIR = src

TEST_NAMES = \
	strlen

TESTS = $(addprefix test_,$(TEST_NAMES))
DEPS = $(addprefix $(OBJ_DIR)/,$(addsuffix .d,$(TEST_NAMES)))

CC = cc
CFLAGS = $(addprefix -I,$(INC_DIRS)) -Wall -Wextra -Werror -g -MD -MF $(OBJ_DIR)/$*.d
LFLAGS = -L$(LIBASM_DIR) -l$(LIBASM)
MKDIR = mkdir -p
RM = rm -rf

all: $(TESTS)

-include $(DEPS)

run: $(addprefix run_,$(TEST_NAMES))

run_%: test_%
	./$<

test_%: $(SRC_DIR)/%.c $(LIBASM_PATH) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -o $@ $< $(LFLAGS)

$(LIBASM_PATH): FORCE
	$(MAKE) -C $(LIBASM_DIR) $(LIBASM_FILE)

$(OBJ_DIR):
	$(MKDIR) $@

clean:
	$(RM) $(OBJ_DIR)

fclean:
	$(RM) $(OBJ_DIR) $(TESTS)

re: fclean all

FORCE:

.PHONY: all run clean fclean re FORCE
