data    segment
dat1    dw     0ffffh
cn      dw		?
data    ends

code    segment
        assume cs:code,ds:data
begin:
        mov ax,data
        mov ds,ax

		mov bx,dat1
		call bin_show
		call crlf

		mov bx,dat1
		call hex_show
		call crlf

		mov bx,dat1
		call dec_show
    	call crlf

		call count1
		mov bx,cn
		call dec_show

		mov ah,4ch
        int 21h

hex_show proc
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

count1	proc
		mov dx,0
		mov bx,dat1
		mov cx,16
t:      shl bx,1
		jnc next
		inc dx
next:   loop t
		mov cn,dx
		ret
count1	endp

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
