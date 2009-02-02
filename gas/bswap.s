	.text
msg:	.string	"%08x\n"
	.global	main	
main:
	movl	$0x12345678,%eax
	pushl	%eax
	pushl	$msg
	call	printf
	addl	$4,%esp
	popl	%eax
	bswap	%eax
	pushl	%eax
	pushl	$msg
	call	printf
	addl	$8,%esp	
	ret
	