SUBDIRS := $(wildcard */.)
ELF_FILES := $(shell find . -type f -name "*.elf")
S_FILES := $(ELF_FILES:.elf=.s)

BIN_FILE := $(word 2, $(MAKECMDGOALS))

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	@for dir in $(SUBDIRS); do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C "$$dir" clean; \
		fi \
	done

clean-all:
	@for dir in $(SUBDIRS); do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C "$$dir" clean-all; \
		fi \
	done

# %.s: %.elf
# 	@echo "disassemble $< to $@"
# 	riscv64-unknown-elf-objdump --disassemble-all  "$<" > "$@"

# disassemble: $(S_FILES)
disassemble:
	@for dir in $(SUBDIRS); do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C "$$dir" disassemble; \
		fi \
	done

# ignore args
%:
	@:

.PHONY: all $(SUBDIRS) disassemble clean clean-all
