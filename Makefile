CC = clang++
CFLAGS = -Wall -Wextra -std=c++20 -O2 `sdl2-config --cflags`
LDFLAGS = `sdl2-config --libs`
SRC_DIR = src
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
OUTPUT = $(BUILD_DIR)/xui

SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRCS))

$(OUTPUT): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(OBJS) -o $(OUTPUT) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)

run: $(OUTPUT)
	./$(OUTPUT) 800 600

.PHONY: clean run
