	.MODEL	TINY
COM_ADD		EQU	0F003H
PA_ADD		EQU	0F000H
PB_ADD		EQU	0F001H
PC_ADD		EQU	0F002H
	.STACK	100
	.DATA
LED_Data	DB	01111110B	;�����̵ƣ��ϱ����
		DB	11111110B	;�����̵���˸���ϱ����
		DB	10111110B	;�����Ƶ������ϱ����
		DB	11011011B	;������ƣ��ϱ��̵�
		DB	11011111B	;������ƣ��ϱ��̵���˸
		DB	11011101B	;������ƣ��ϱ��Ƶ���

	.CODE
START:		MOV	AX,@DATA
		MOV	DS,AX
		NOP
		MOV	DX,COM_ADD
		MOV	AL,80H		;PA��PB��PCΪ�������ģʽ
		OUT	DX,AL
		MOV	DX,PA_ADD	;��ȫϨ��
		MOV	AL,0FFH
		OUT	DX,AL
		LEA	BX,LED_Data
START1:		MOV	AL,0
		XLAT
		OUT	DX,AL		;�����̵ƣ��ϱ����
		CALL	DL5S
		MOV	CX,6
START2:		MOV	AL,1
		XLAT
		OUT	DX,AL		;�����̵���˸���ϱ����
		CALL	DL500ms
		MOV	AL,0
		XLAT
		OUT	DX,AL
		CALL	DL500ms
		LOOP	START2
		MOV	AL,2		;�����Ƶ������ϱ����
		XLAT
		OUT	DX,AL
		CALL	DL3S
		MOV	AL,3		;������ƣ��ϱ��̵�
		XLAT
		OUT	DX,AL
		CALL	DL5S
		MOV	CX,6
START3:		MOV	AL,4		;������ƣ��ϱ��̵���˸
		XLAT
		OUT	DX,AL
		CALL	DL500ms
		MOV	AL,3
		XLAT
		OUT	DX,AL
		CALL	DL500ms
		LOOP	START3
		MOV	AL,5		;������ƣ��ϱ��Ƶ���
		XLAT
		OUT	DX,AL
		CALL	DL3S
		JMP	START1


DL500ms		PROC	NEAR
		PUSH	CX
		MOV	CX,60000
DL500ms1:	LOOP	DL500ms1
		POP	CX
		RET
DL500ms		ENDP

DL3S		PROC	NEAR
		PUSH	CX
		MOV	CX,6
DL3S1:		CALL	DL500ms
	 	LOOP	DL3S1
	 	POP	CX
	 	RET
	 	ENDP
			
DL5S		PROC	NEAR
		PUSH	CX
		MOV	CX,10
DL5S1:		CALL	DL500ms
	 	LOOP	DL5S1
	 	POP	CX
	 	RET
		ENDP

	 	END	START
