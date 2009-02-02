	.code16
	.global _start
first:	
	jmp	_start
	.byte	0x90
	.ascii	"HELLOIPL"
	.word	512
	.byte	1
	.word	1
	.byte	2
	.word	224
	.word	2880
	.byte	0xf0
	.word	9
	.word	18
	.word	2
	.long	0
	.long	2880
	.byte	0,0,0x29
	.long	0xffffffff
	.ascii	"HELLO-OS   "
	.ascii	"FAT12   "
	.space	18,0
	
_start:	
	movw	$0,%ax
	movw	%ax,%ss
	movw	$0x7c00,%sp
	movw	%ax,%ds
	movw	%ax,%es
	movw	$(msg-first+0x7c00),%bp
	movw	$0,%si
putloop:
	movb	(%bp,%si),%al
	addw	$1,%si
	cmpb	$0,%al
	je	fin
	movb	$0x0e,%ah
	movw	$15,%bx
	int	$0x10
	jmp	putloop
fin:
	hlt
	jmp	fin
msg:
	.ascii	"\nhello, world\n\r"
	.byte	0
last:	
	.space	0x1fe - (last-first),0
	.byte	0x55,0xaa
	.byte	0xf0,0xff,0xff,0x00,0x00,0x00,0x00,0x00
	.space	4600,0
	.byte	0xf0,0xff,0xff,0x00,0x00,0x00,0x00,0x00
	.space	1469432,0
