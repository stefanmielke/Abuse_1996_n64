V=1
SOURCE_DIR=src
BUILD_DIR=build_n64
N64_DFS_OFFSET=2M
include $(N64_INST)/include/n64.mk
include libs/sdl_n64/SDL2/Makefile_sdl2.mk

abuse_VERSION=0.9
abuse_VERSION_MAJOR=0
abuse_VERSION_MINOR=9
abuse_VERSION_PATCH=0
abuse_VERSION_TWEAK=0

N64_CXXFLAGS += -I$(SOURCE_DIR) -I$(SOURCE_DIR)/imlib -I$(SOURCE_DIR)/lisp -DPACKAGE_NAME="abuse" -DPACKAGE_VERSION="${abuse_VERSION}" -DHAVE_UNISTD_H -DASSETDIR='"rom:/"' -DN64
N64_CXXFLAGS += -Wno-error=class-conversion -Wno-error=misleading-indentation -Wno-error=unused-function -Wno-error=maybe-uninitialized -Wno-error=format-overflow=
N64_CXXFLAGS += -Wno-error=unused-but-set-variable -Wno-error=unused-variable -Wno-error=format-truncation= -Wno-error=delete-non-virtual-dtor -Wno-error=stringop-truncation
N64_CXXFLAGS += -Wno-error=alloc-size-larger-than= -Wno-error=narrowing -Wno-error=nonnull-compare

N64_ROM_TITLE = "Abuse 64"
N64_ROM_SAVETYPE = none
N64_ROM_REGIONFREE = true
N64_ROM_RTC = false

CPP_FILES := $(wildcard ${SOURCE_DIR}/*.cpp) $(wildcard ${SOURCE_DIR}/lol/*.cpp) $(wildcard ${SOURCE_DIR}/imlib/*.cpp) $(wildcard ${SOURCE_DIR}/sdlport/*.cpp)
CPP_FILES += $(wildcard ${SOURCE_DIR}/lisp/*.cpp) $(wildcard ${SOURCE_DIR}/ui/*.cpp) $(wildcard ${SOURCE_DIR}/net/*.cpp)

SRC_C = $(C_SDL_FILES)
SRC_CPP = $(CPP_FILES)
OBJS = $(SRC_C:%.c=%.o) $(SRC_CPP:%.cpp=%.o)
DEPS = $(SRC_C:%.c=%.d) $(SRC_CPP:%.cpp=%.d)

all: abuse.z64
abuse.z64: $(BUILD_DIR)/abuse.dfs

$(BUILD_DIR)/abuse.dfs: $(wildcard data/*)
	$(N64_MKDFS) $@ data

$(BUILD_DIR)/abuse.elf: $(OBJS)

clean:
	find . -name '*.v64' -delete
	find . -name '*.z64' -delete
	find . -name '*.elf' -delete
	find . -name '*.o' -delete
	find . -name '*.d' -delete
	find . -name '*.bin' -delete
	find . -name '*.plan_bak*' -delete
	find . -name '*.dfs' -delete
	find . -name '*.raw' -delete
	find . -name '*.z64' -delete
	find . -name '*.n64' -delete

-include $(DEPS)

.PHONY: all clean