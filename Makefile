CC=gcc

SRC_DIR=src
TEST_DIR=tests
BUILD_DIR=build
DBG_DIR=debug

EXEC=$(BUILD_DIR)/weakcrypt
DBG_EXEC=$(DBG_DIR)/weakcrypt
TEST_RUNNER=$(DBG_DIR)/testrunner

CFLAGS=-Wall -Wextra -Werror -pedantic-errors -MMD -O3 -march=native -std=c99
DBG_CFLAGS=$(CFLAGS) -g -O0 -D_DEBUG
TEST_CFLAGS=$(DBG_CFLAGS) -Isrc
OBJ_FILES=$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(wildcard $(SRC_DIR)/*.c))
DBG_OBJ_FILES=$(patsubst $(SRC_DIR)/%.c, $(DBG_DIR)/%.o, $(wildcard $(SRC_DIR)/*.c))
TEST_OBJ_FILES=$(patsubst $(TEST_DIR)/%.c, $(DBG_DIR)/%.o, $(wildcard $(TEST_DIR)/*.c))
DEP_FILES=$(wildcard $(BUILD_DIR)/*.d)
DBG_DEP_FILES=$(wildcard $(DBG_DIR)/*.d) # Will also include the test*.d files

.PHONY: all clean test debug

all: $(EXEC)
debug: $(DBG_EXEC)

test: $(TEST_RUNNER)
	./$(TEST_RUNNER)

include $(DEP_FILES)
include $(DBG_DEP_FILES)

$(EXEC): $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $@ $^

$(DBG_EXEC): $(DBG_OBJ_FILES)
	$(CC) $(DBG_CFLAGS) -o $@ $^

$(TEST_RUNNER): $(filter-out $(DBG_DIR)/main.o, $(DBG_OBJ_FILES)) $(TEST_OBJ_FILES)
	$(CC) $(TEST_CFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ -c $<

$(DBG_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(DBG_DIR)
	$(CC) $(DBG_CFLAGS) -o $@ -c $<

$(DBG_DIR)/%.o: $(TEST_DIR)/%.c
	@mkdir -p $(DBG_DIR)
	$(CC) $(TEST_CFLAGS) -o $@ -c $<

clean:
	rm -rf $(BUILD_DIR) $(DBG_DIR)
