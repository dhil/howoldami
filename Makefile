#
# Makefile
#

# Project root and build directory
ROOT:=$(shell dirname $(firstword $(MAKEFILE_LIST)))
BUILD_DIR:=$(ROOT)/_build

# The build command and some standard build system flags
BUILD=dune build
DEV_FLAGS=--profile=dev
REL_FLAGS=--profile=release

# Build rules.

# The default is to build everything in development mode.
.DEFAULT_GOAL:= all
.PHONY: all
all: dune dune-project
	$(BUILD) $(REL_FLAGS) @install
	ln -fs $(BUILD_DIR)/default/howoldami.exe howoldami


# Cleans the project directory.
.PHONY: clean
clean:
	dune clean
	rm -rf *.install
	rm -rf howoldami
	rm -rf doc/_build
