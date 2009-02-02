	.data
src:
	.byte	2
	.byte	18
	.byte	38
	.byte	44
	.byte	-2
	.byte	10
	.byte	200
msg:
	.string	"%d\n"
	
	.text
	.global	main
main:
	movl	$src,%edi
	movl	%edi,%edx
	movb	$-2,%al
	movl	$(msg-src),%ecx
	cld
	repnz
	scasb
	subl	%edx,%edi
	subl	$1,%edi
	pushl	%edi
	pushl	$msg
	call	printf
	addl	$8,%esp
	ret
	