cb_true_msg:
	.string	"true"
cb_false_msg:
	.string "false"

.altmacro
.macro	check_condition cc
LOCAL	ll
	pushf
	pushl	%edx
	pushl	%esi	
	set\cc	%dl
	leal	cb_true_msg,%esi	
	testb	$1,%dl	
	jnz	ll
	leal	cb_false_msg,%esi
ll:
	pusha
	pushl	%esi
	call	puts
	addl	$4,%esp
	popa
	popl	%esi
	popl	%edx
	popf
.endm
	