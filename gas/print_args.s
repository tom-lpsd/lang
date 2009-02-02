	.text
	.global main
msgpre:
	.string	"argument list is \""
msgtmpl:
	.string	"%s "
msgpost:
	.string	"\b\".\n"
dbgmsg:
	.string "%d\n"
main:	
	pushl	$msgpre
	call	printf
	movl	$0,%eax
	addl	$4,%esp
	movl	4(%esp),%ecx
	movl	$0,%esi
	movl	8(%esp),%edx
loop:
	pushl	%ecx
	pushl	%edx
	pushl	(%edx,%esi,4)
	pushl	$msgtmpl
	call	printf
	movl	$0,%eax
	addl	$8,%esp
	popl	%edx
	popl	%ecx
	addl	$1,%esi
	cmpl	%ecx,%esi
	jz	fin
	jmp	loop
fin:	
	pushl	$msgpost
	call	printf
	movl	$0,%eax
	addl	$4,%esp
	ret

