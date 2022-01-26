data    segment
arr	    dw     37,280,-3100,6,92,427,-502,30024,6305,-883
n       dw     10
flag    dw     ?
max     dw     ?
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		call arr_show	
		call crlf
		call findmax	
		mov  bx,max
		call dec_show

		mov ah,4ch
        int 21h

findmax proc
		lea si,arr
		mov ax,[si]
		add si,2
		mov cx,n
		dec n
t2:		cmp ax,[si]
		jge next
		mov ax,[si]
next:	add si,2
		loop t2
		mov max,ax
        ret
findmax endp

arr_show proc
        lea si,arr
		mov cx,n
t:		mov bx,[si]
		call f_dec_show
		call space_show
		add si,2
		loop t 
        ret
arr_show endp

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

space_show	proc
        mov dl,20h
		mov ah,2
		int 21h
		ret
space_show	endp

crlf	proc
        mov dl,0dh
		mov ah,2
		int 21h
		mov dl,0ah
		mov ah,2
		int 21h
		ret
crlf	endp
code ends
     end begin
