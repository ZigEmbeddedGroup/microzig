SUBDIRS := $(wildcard */.)
ELF_FILES := $(shell find . -type f -name "*.elf")
S_FILES := $(ELF_FILES:.elf=.s)

BIN_FILE := $(word 2, $(MAKECMDGOALS))

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

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

wch-isp:
	@if [ "$(suffix $(BIN_FILE))" = ".bin" ]; then \
		echo "write $(BIN_FILE) by wch-isp"; \
		wch-isp -pr flash $(BIN_FILE); \
	else \
		echo "Error: $(BIN_FILE) is not a .bin file"; \
		exit 1; \
	fi

# ignore args
%:
	@:

.PHONY: all $(SUBDIRS) disassemble wch-isp
