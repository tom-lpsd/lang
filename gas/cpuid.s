	.text
	.global	main
msg:	.string	"%x\n"
main:
	movl	$1,%eax
	cpuid
	push	%edx
	pushl	$msg
	call	printf
	add	$8,%esp
	ret
	
	