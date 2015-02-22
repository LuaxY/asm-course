org 0x0100 ; header .COM

; -- READ AND PRINT KEY --

mov si, message
mov ah, 0x03
int 0x10
mov cx, 1
wait_keyboard:
mov ah, 0x01 ; get keystroke status
int 0x16
jz wait_keyboard
mov ah, 0x00 ; get pressed key
int 0x16
mov [si], al ; store char
inc si ; increment si
cmp al, 13
je end_wait_keyboard
mov ah, 0x0A ; print char
int 0x10
inc dl ; increment cursor pos
mov ah, 0x02 ; set new cursor pos
int 0x10
jmp wait_keyboard
end_wait_keyboard:
inc dh ; increment line pos
xor dl, dl ; set cursor pos to 0
mov byte [si], 0 ; add end of string char
mov si, message ; get new string
call print_string
ret

; FUNCTION BEGIN
print_string:
push ax
push bx
push cx
push dx
xor bh, bh ; reset display page
mov ah, 0x03 ; get cursor pos
int 0x10
mov cx, 1 ; print char only 1 time
print_next_char:
mov al, [si] ; get char
or al, al ; is end of string ?
jz end_of_string
cmp al, 13 ; is new line ?
je new_line
mov ah, 0x0A ; print char
int 0x10
set_new_cursor_pos:
inc dl ; increment cursor pos
inc si ; increment to next char
mov ah, 0x02 ; set new cursor pos
int 0x10
jmp print_next_char
end_of_string:
pop dx
pop cx
pop bx
pop ax
ret
new_line:
inc dh
xor dl, dl
mov ah, 0x02
int 0x10
jmp set_new_cursor_pos
; FUNCTION END

message: db 'Hello World!', 0
