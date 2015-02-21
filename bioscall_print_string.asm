org 0x0100 ; header .COM

; -- SHOW STRING ON SCREEN --
mov si, hello ; store address of hello string in SI register
xor bh, bh ; reset BH register, who stock  display page
mov ah, 0x03 ; ??
int 0x10 ; call BIOS interruption for displaying char on screen
mov cx, 1 ; char repetition

display_next:
mov al, [si] ; stock next char to display in AL register
or al, al ; compare current char to 0 (EOL)
jz end_display_next ; if AL == O jump to end
cmp al, 13 ; compare current char to 13 (new line)
je  new_line ; jump to new line
print_char:
mov ah, 0x02 ; set cursor position
int 0x10 ; call BIOS interruption
mov ah, 0x0A ; display current char CX time
int 0x10 ; call BIOS interruption
inc si ; increment to next char
inc dl ; increment to next cursor position
jmp display_next ; jump to next char

end_display_next:
ret ; end en program

new_line:
inc dh ; go to next line
xor dl, dl ; set to first column
jmp print_char

hello: db 'Hello World!', 13, 0
