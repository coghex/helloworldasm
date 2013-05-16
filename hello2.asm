BITS 32

; custom ELF takes the program header and overlaps it with
; the elf header, this makes the program 97 bytes long.

          org     0x00200000                      ;   forces the e_phentsize and
                                                  ;   p_vaddr fields to match
                                                  ;   up.

          db      0x7F, "ELF", 1, 1, 1, 0         ;   e_ident
  times 8 db      0
          dw      2                               ;   e_type
          dw      3                               ;   e_machine
          dd      1                               ;   e_version
          dd      _start                          ;   e_entry
          dd      phdr - $$                       ;   e_phoff
  phdr:   dd      1                               ;   e_shoff / p_type
          dd      0                               ;   e_flags / p_offset
          dd      $$                              ;   e_ehsize / p_vaddr /
                                                  ;   e_phentsize
          dw      1                               ;   e_phnum / p_paddr
          dw      0                               ;   e_shentsize
          dd      filesize                        ;   e_shnum / p_filesz /
                                                  ;   e_shstrndx
          dd      filesize                        ;   p_memsz
          dd      5                               ;   p_flags
          dd      0x1000                          ;   p_align

  section .data

  msg:
    db "Hello World!",0x0A ; 0x0A = ascii newline

  section .text
  global _start

  _start:
    mov al, 4    ; 4 = sys_write
    xor ebx, ebx   
    inc ebx      ; 1 = STDOUT
    mov ecx, msg ; pointer to msg
    mov dl, 13   ; size of msg
    int 80h      ; syscall interrupt

    xor eax, eax   
    inc eax      ; 1 = sys_exit
    int 80h

  filesize      equ     $ - $$
