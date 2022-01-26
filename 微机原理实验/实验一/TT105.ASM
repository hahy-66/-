data    segment
dat1    dw     0ffffh
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		call bin_show
		call crlf

		call hex_show
		call crlf

		call dec_show
    	call crlf

		mov ah,4ch
        int 21h

hex_show proc
        mov bx,dat1
        mov cx,4

t2:     push cx
        mov cl,4
        rol bx,cl
        pop cx
        mov dl,bl
        and dl,0fh
        add dl,30h
        cmp dl,39h
        jbe print
        add dl,7
print:  mov ah,2
        int 21h
        loop t2
		ret
hex_show endp

bin_show proc
        mov bx,dat1
        mov cx,16

t1:     rol bx,1
        mov dl,bl
        and dl,01h
        add dl,30h
        mov ah,2
        int 21h
        loop t1
		ret
bin_show endp

dec_show proc
        mov bx,dat1
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
		ret
dec_show endp
        
    

dec_div proc
        mov dx,0
        mov ax,bx
        div cx
        mov bx,dx
        mov dl,al
        add dl,30h
        mov ah,2
        int 21h
        ret
dec_div endp

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
