ELF_FILES := $(shell find . -type f -name "*.elf")
S_FILES := $(ELF_FILES:.elf=.s)

BIN_FILE := $(word 2, $(MAKECMDGOALS))

all:
	zig build -Doptimize=ReleaseSmall

%.s: %.elf
	@echo "disassemble $< to $@"
	riscv64-unknown-elf-objdump --disassemble-all  "$<" > "$@"

clean:
	rm -rf zig-out

clean-all:
	rm -rf zig-out .zig-cache

disassemble: $(S_FILES)

flash:
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

.PHONY: all disassemble flash clean clean-all
