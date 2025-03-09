CC = clang++
CFLAGS = -Wall -Wextra -std=c++20 -O2 `sdl2-config --cflags`
LDFLAGS = `sdl2-config --libs`
SRC_DIR = src
BUILD_DIR = build
OUTPUT = build/xui

SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

$(OUTPUT): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(OBJS) -o $(OUTPUT) $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	@mkdir -p $@

clean:
	rm -rf $(BUILD_DIR) $(OUTPUT)

.PHONY: clean
