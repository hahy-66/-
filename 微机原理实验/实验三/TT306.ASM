data    segment
pass    db   'gegegege'
n		equ	 $ - pass
pasbuf	db  20
		db	?
		db	20 dup(?)
mess1	db	'password:','$'
mess2	db  'welcome!!!$'
mess3	db  'wrong!!please try agin...',0dh,0ah,'$'
mess4   db  'sorry...password is wrong',0dh,0ah,'$'
data    ends

code    segment
        assume cs:code,ds:data,es:data
begin:
        mov ax,data
        mov ds,ax
		mov es,ax

		mov bx,3

 t:     lea dx,mess1
		mov ah,9
		int 21h
        
		lea dx,pasbuf
		mov ah,0ah
		int 21h

		lea si,pass
		lea di,pasbuf
		cmp byte ptr[di+1],n
		jne err_show
		add di,2
		mov cx,n
		cld
		repe cmpsb
		jne err_show
		lea dx,mess2
		call crlf
		mov ah,9
		int 21h
		jmp exit
err_show:call crlf
        lea dx,mess3
		mov ah,9
		int 21h
		dec bx
		jnz t
		lea dx,mess4
		mov ah,9
		int 21h
exit:	mov ah,4ch
        int 21h

crlf	proc
        push ax
		push dx
        mov dl,0dh
		mov ah,2
		int 21h
		mov dl,0ah
		mov ah,2
		int 21h
		pop dx
		pop ax
		ret
crlf	endp
code ends
     end begin
