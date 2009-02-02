	.data
src:
	.string	"source\n"
dest:
	.string	"origin\n"
	.text
	.global	main
main:
	pushl	$dest
	call	printf
	addl	$4,%esp
	movl	$(dest-src),%ecx
	movl	$src,%esi
	movl	$dest,%edi
	cld
	rep
	movsb
	pushl	$dest
	call	printf
	addl	$4,%esp
	ret
	