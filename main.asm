bits 16

org 0x7C00

start:
	mov ax, 0x0003
	int 0x10

	mov bx, 0x1000
	mov dh, 2
	mov dl, 0x80
	call read_sectors

	jmp 0x1000:0000

read_sectors:
	push ax
	push bx
	push cx
	push dx
	push es
	push di

	mov ah, 0x02
	mov al, dh
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov dl, 0x80
	int 0x13

	pop di
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	ret

times 510 - ($ - $$) db 0

dw 0AA55h