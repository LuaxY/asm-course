org 0x0100 ; header .COM

; -- HELLO WORD WITH SYSTEM INT --
mov dx, hello ; store hello string in DX register
mov ah, 0x9 ; params for SYS call for displaying string
int 0x21 ; call SYS interruption to display string
ret ; end of program

hello: db 'Hello World!$'
