data    segment
arr	    dw     37,280,3100,6,92,427,502,30024,6305,883
n       dw     10
flag    dw     ?
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		lea si,arr
		mov cx,n
t:		mov bx,[si]
		call dec_show
		call space_show
		add si,2
		loop t

		mov ah,4ch
        int 21h



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

space_show	proc
        mov dl,20h
		mov ah,2
		int 21h
		ret
space_show	endp
code ends
     end begin
