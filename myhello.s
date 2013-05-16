; Hello World
section .data

msg:
  db "Hello World!",0x0A ; 0x0A = ascii newline

section .text
global _start

_start:
  mov eax, 4    ; 4 = sys_write 
  mov ebx, 1    ; 1 = STDOUT
  mov ecx, msg ; pointer to msg
  mov edx, 13  ; size of msg
  int 80h      ; syscall interrupt

  mov eax, 1   ; 1 = sys_exit
  int 80h
