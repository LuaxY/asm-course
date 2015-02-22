org 0x0100 ; header .COM

; -- GET AND SHOW MEMORY --
int 0x11
and ax, 0b1100
shr ax, 2
inc ax
shl ax, 4
mov si, buffer
call to_ascii
mov si, buffer
call print_string
mov si, memory
call print_string
ret

; FUNCTION BEGIN
to_ascii:
push bx
push cx
push dx
mov bl, 10
mov cx, 1
store_digit:
div bl
mov dl, ah
push dx
inc cx
xor ah, ah
or al, al
jne store_digit
loop_digit:
loop display_digit
mov byte [si], 0
pop dx
pop cx
pop bx
ret
display_digit:
pop ax
add ax, '0'
mov [si], al
inc si
jmp loop_digit
; FUNCTION END

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

buffer: db '0000000000000000', 0
memory: db ' Ko', 13, 0
