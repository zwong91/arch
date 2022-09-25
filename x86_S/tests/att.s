
.section .text
.globl main
main:
    # Linus 在汇编程序中直接使用系统调用, 说明as86和gnu at&t 区别
    movl $4, %eax # write   # 系统调用号, 写操作
    movl $1, %ebx # stdout  # 参数1 写调用参数fd, 1 == stdout
    movl $message, %ecx # buffer   # 参数2 缓冲区指针
    movb $'A', message          # 依次替换buffer中0-4位置元素 %ecx = message = message[0] = 'A'
    movb $'B', 1(%ecx)          # message[1] = [%ecx + 1] = 'B'
    movb $'C', (%ecx, %ebx, 2)  # message[2] = [%ecx + %ebx * 2]
    movb $'D', message - 1(, %ebx, 4)  message[3] = [message + %ebx * 4 - 1]
    movb $'E', message(, %ebx, 4)   # message[4] = [message + %ebx * 4]

    movl $(message_end - message), %edx # 参数3 缓冲区buf length
    int $0x80

    movl $1, %eax # exit 调用号, 退出程序
    movl $0, %ebx # status 状态
    int $0x80

.section .data
message:
    .asciz "hello world!!!\n"
message_end:


.section .bss
    .lcomm buffer 256
