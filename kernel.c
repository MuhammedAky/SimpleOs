#define VIDEO_MEMORY 0xB8000
#define WHITE_ON_BLACK 0x0F

void print_string(char *str) {
    unsigned short *vide_memory = (unsigned short *)VIDEO_MEMORY;
    int i = 0;
    while (str[i] != '\0') {
        vide_memory[i] = (vide_memory[i] & 0xFF00) | str[i];
        i++;
    }
}

void draw_square() {
    unsigned short* vide_memory = (unsigned short *)VIDEO_MEMORY;
    int x, y;
    for (y = 10; y < 20; y++) {
        for (x = 30; x < 50; x++) {
            vide_memory[y * 80 + x] = (vide_memory[y * 80 + x] & 0x00FF) | (0x9F << 8);
        }
    }
}

void kernel_main() {
    print_string("Merhaba Dunya!");
    draw_square();
    while (1) {}
}