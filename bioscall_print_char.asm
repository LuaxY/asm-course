org 0x0100 ; header .COM

; -- SHOW CHAR ON SCREEN --
mov ah, 0x0A ; number of function
mov al, 'B' ; char to print on screen
xor bx, bx ; display page (mov bx, 0)
mov cx, 1 ; repetition
int 0x10 ; call BIOS interruption
ret ; end of program
