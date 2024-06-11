# Variables
ASM = nasm
ASM_FLAGS = -f bin
OUTPUT = sector
EMU = qemu-system-x86_64

# Default target
all: run

# Assemble the boot sector
$(OUTPUT): main.asm
	$(ASM) $(ASM_FLAGS) -o $(OUTPUT) main.asm

# Run the boot sector using QEMU
run: $(OUTPUT)
	$(EMU) $(OUTPUT)

# Clean the output file
clean:
	rm -f $(OUTPUT)

.PHONY: all run clean
