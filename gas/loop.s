	.text
msg:
	.string	"OK: %d\n"
	.global	main
main:
	movl	$10,%ecx
1:
	pushl	%ecx
	pushl	$msg
	call	printf
	addl	$4,%esp
	popl	%ecx
	loopl	1b
	ret
	