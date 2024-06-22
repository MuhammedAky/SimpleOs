# Makefile for OS development

NASM = nasm
GCC = gcc
LD = ld

NASM_FLAGS = -f elf32
GCC_FLAGS = -m32 -c
LD_FLAGS = -m elf_i386 -T linker.ld

BOOTLOADER_SRC = bootloader.asm
KERNEL_SRC = kernel.c
LINKER_SCRIPT = linker.ld

OBJ = bootloader.o kernel.o

all: kernel.bin

kernel.bin: $(OBJ)
    $(LD) $(LD_FLAGS) -o $@ $(OBJ)

bootloader.o: $(BOOTLOADER_SRC)
    $(NASM) $(NASM_FLAGS) $< -o $@

kernel.o: $(KERNEL_SRC)
    $(GCC) $(GCC_FLAGS) $< -o $@

clean:
    rm -f $(OBJ) kernel.bin

iso: kernel.bin
    mkdir -p isofiles/boot/grub
    cp kernel.bin isofiles/boot/kernel.bin
    echo 'set timeout=0' > isofiles/boot/grub/grub.cfg
    echo 'set default=0' >> isofiles/boot/grub/grub.cfg
    echo 'menuentry "Custom OS" {' >> isofiles/boot/grub/grub.cfg
    echo '  multiboot /boot/kernel.bin' >> isofiles/boot/grub/grub.cfg
    echo '  boot' >> isofiles/boot/grub/grub.cfg
    echo '}' >> isofiles/boot/grub/grub.cfg
    grub-mkrescue -o os.iso isofiles

.PHONY: all clean iso
