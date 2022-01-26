data    segment
flag    dw     ?
dat1    dw     ?
f2      dw     0 
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		call f_dec_in
		mov  dat1,bx
		call f_dec_show

		mov ah,4ch
        int 21h

f_dec_in proc
        mov bx,0
		mov ah,1
		int 21h
		cmp al,'-'
		jnz posi
		mov f2,1
		jmp nega
posi:	sub al,30h
        mov ah,0
		mov bx,ax  
nega:	call dec_in
        cmp f2,1
		jnz	e3
		neg bx
e3:     ret
f_dec_in endp

dec_in proc
indig: mov ah,1
	   int 21h
	   sub al,30h
	   jb  exit2
	   cmp al,9
	   ja  exit2
	   cbw
	   xchg ax,bx
	   mov  cx,10
	   mul  cx
	   xchg ax,bx
	   add bx,ax
	   jmp indig
 exit2:ret
dec_in endp

f_dec_show proc
		and bx,bx
		jns show
		mov dl,'-'
		mov ah,2
		int 21h
		neg bx
show:	call dec_show
		ret
f_dec_show endp

dec_show proc
        push cx
		mov flag,1
        mov cx,10000
        call dec_div
        mov cx,1000
        call dec_div
        mov cx,100
        call dec_div
        mov cx,10
        call dec_div
        mov cx,1
        call dec_div
		pop cx
		ret
dec_show endp
        
    

dec_div proc
        mov dx,0
        mov ax,bx
        div cx
        mov bx,dx
        mov dl,al
		cmp dl,0
		jnz print
		cmp flag,1
		jz  exit
print:  add dl,30h
        mov ah,2
        int 21h
		mov flag,0
exit:   ret
dec_div endp

code ends
     end begin
