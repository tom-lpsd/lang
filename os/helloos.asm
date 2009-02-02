;; hello-os
;; TAB=4

	org	0x7c00		; このプログラムがどこに読み込まれるのか．
		
;; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述

	jmp	entry
	db	0x90
	db	"HELLOIPL"
	dw	512
	db	1
	dw	1
	db	2
	dw	224
	dw	2880
	db	0xf0
	dw	9
	dw	18
	dw	2
	dd	0
	dd	2880
	db	0,0,0x29
	dd	0xffffffff
	db	"HELLO-OS   "
	db	"FAT12   "
	resb	18

;; プログラム本体
	
entry:
	mov	ax,0
	mov	ss,ax
	mov	sp,0x7c00
	mov	ds,ax
	mov	es,ax

	mov	si,msg
putloop:
	mov	al,[si]
	add	si,1	; SIに1を足す
	cmp	al,0
	je	next
	mov	ah,0x0e	; 一文字表示ファンクション
	mov	bx,15	; カラーコード
	int	0x10	; ビデオBIOS呼び出し
	jmp	putloop
next:
	mov	ax,1267
	mov	bp,results
	mov	di,1
div10:
	mov	dx,0
	mov	bx,10
	div	bx
	mov	bx,dx
	mov	dl,[digits+bx]
	mov	[bp+di],dl
	inc	di
	cmp	ax,0
	je	fin
	cbw
	jmp	div10
fin:
	dec	di
	mov	al,[bp+di]
	call	print
	cmp	di,1
	je	fin2
	jmp	fin
fin2:
	mov	al,0x0a
	call	print
	mov	al,0x0d
	call	print
fin3:	
	hlt		; 何かあるまでCPUを停止させる
	jmp	fin3
print:	
	mov	ah,0x0e	; 一文字表示ファンクション
	mov	bx,15	; カラーコード
	int	0x10
	ret

msg:

;; メッセージ部分

	db	0x0a,0x0a
	db	"hello, world"
	db	0x0a,0x0d
	db	0
digits:
	db	"0123456789"
results:	
	resb	0x1fe - ($-$$)
	
	db	0x55,0xaa

;; 以下はブートセクタ以外の部分の記述
	
	db	0xf0,0xff,0xff,0x00,0x00,0x00,0x00,0x00
	resb	4600
	db	0xf0,0xff,0xff,0x00,0x00,0x00,0x00,0x00
	resb	1469432
	
