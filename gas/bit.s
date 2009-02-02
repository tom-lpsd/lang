	.include	"check_bit.s"
	.text
foo:	.long	.
msg:
	.string	"%x\n"
	.global main
main:
	movl	$0b11,%eax
	ror	%eax
	check_condition c
	ror	%eax
	check_condition c
	ror	%eax
	check_condition c
	ret
	