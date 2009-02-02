;; hello-os
;; TAB=4

	org	0x7c00		; このプログラムがどこに読み込まれるのか．
		
;; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述

	jmp	entry
	db	0x90
	db	"HARIBOTE"
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
	db	"HARIBOTEOS "
	db	"FAT12   "
	resb	18

;; プログラム本体
	
entry:
	mov	ax,0
	mov	ss,ax
	mov	sp,0x7c00
	mov	ds,ax
	
; ディスクを読む

	mov	ax,0x0820
	mov	es,ax
	mov	ch,0	; シリンダ0
	mov	dh,0	; ヘッド0
	mov	cl,2	; セクタ2

	mov	si,0	

retry:				
	mov	ah,0x02	; AH=0x02 : ディスク読み込み
	mov	al,1	; 1セクタ
	mov	bx,0
	mov	dl,0x00	; Aドライブ
	int	0x13	; ディスクBIOS呼び出し
	jnc	fin
	add	si,1
	cmp	si,5
	jae	error
	mov	ah,0x00
	mov	dl,0x00
	int	0x13
	jmp	retry

; 読み終わったけどとあえずやることないので寝る
	
fin:
	hlt		; 何かあるまでCPUを停止させる
	jmp	fin	; 無限ループ

error:
	mov	ax,0
	mov	es,ax
	mov	si,msg
	
putloop:
	mov	al,[si]
	add	si,1	; SIに1を足す
	cmp	al,0
	je	fin
	mov	ah,0x0e	; 一文字表示ファンクション
	mov	bx,15	; カラーコード
	int	0x10	; ビデオBIOS呼び出し
	jmp	putloop

msg:

;; メッセージ部分

	db	0x0a,0x0a
	db	"load error"
	db	0x0a
	db	0

	resb	0x1fe - ($-$$)
	
	db	0x55,0xaa
	