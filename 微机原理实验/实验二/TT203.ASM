data    segment
dat1    dw     -21080
flag    dw     ?
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		mov bx,dat1
		call f_dec_show

		mov ah,4ch
        int 21h

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
