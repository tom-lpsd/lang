	.data
tbl:
	.byte	't'
	.byte	'f'
	.byte	'g'
	.byte	'h'
msg:
	.string	"%c\n"
	
	.text
	
	.global	main
main:
	movl	$tbl,%ebx
	movb	$1,%al
	xlatb
	movb	$0,%ah
	pushw	%ax
	pushl	$msg
	call	printf
	addl	$6,%esp
	ret
	