
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TrabalhoFinalAmostra.c,20 :: 		void interrupt(void){
;TrabalhoFinalAmostra.c,21 :: 		if (INTCON.TMR0IF ==1) // timer 0 interrupt
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;TrabalhoFinalAmostra.c,24 :: 		if(sinal == 0){
	MOVLW      0
	XORWF      _sinal+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt27
	MOVLW      0
	XORWF      _sinal+0, 0
L__interrupt27:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;TrabalhoFinalAmostra.c,25 :: 		amos1 =  ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _amos1+0
	MOVF       R0+1, 0
	MOVWF      _amos1+1
;TrabalhoFinalAmostra.c,26 :: 		leitura(amos1,'0');
	MOVF       R0+0, 0
	MOVWF      FARG_leitura_valor+0
	MOVF       R0+1, 0
	MOVWF      FARG_leitura_valor+1
	MOVLW      48
	MOVWF      FARG_leitura_canal+0
	CALL       _leitura+0
;TrabalhoFinalAmostra.c,27 :: 		}
L_interrupt1:
;TrabalhoFinalAmostra.c,29 :: 		if(sinal == 1){
	MOVLW      0
	XORWF      _sinal+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt28
	MOVLW      1
	XORWF      _sinal+0, 0
L__interrupt28:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;TrabalhoFinalAmostra.c,30 :: 		amos2 =  ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _amos2+0
	MOVF       R0+1, 0
	MOVWF      _amos2+1
;TrabalhoFinalAmostra.c,31 :: 		leitura(amos2,'1');
	MOVF       R0+0, 0
	MOVWF      FARG_leitura_valor+0
	MOVF       R0+1, 0
	MOVWF      FARG_leitura_valor+1
	MOVLW      49
	MOVWF      FARG_leitura_canal+0
	CALL       _leitura+0
;TrabalhoFinalAmostra.c,32 :: 		}
L_interrupt2:
;TrabalhoFinalAmostra.c,34 :: 		if(sinal == 2){
	MOVLW      0
	XORWF      _sinal+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt29
	MOVLW      2
	XORWF      _sinal+0, 0
L__interrupt29:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;TrabalhoFinalAmostra.c,35 :: 		amos3 =  ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _amos3+0
	MOVF       R0+1, 0
	MOVWF      _amos3+1
;TrabalhoFinalAmostra.c,36 :: 		leitura(amos3,'2');
	MOVF       R0+0, 0
	MOVWF      FARG_leitura_valor+0
	MOVF       R0+1, 0
	MOVWF      FARG_leitura_valor+1
	MOVLW      50
	MOVWF      FARG_leitura_canal+0
	CALL       _leitura+0
;TrabalhoFinalAmostra.c,37 :: 		}
L_interrupt3:
;TrabalhoFinalAmostra.c,39 :: 		if(sinal == 3){
	MOVLW      0
	XORWF      _sinal+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt30
	MOVLW      3
	XORWF      _sinal+0, 0
L__interrupt30:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;TrabalhoFinalAmostra.c,40 :: 		amos4 =  ADC_Read(3);
	MOVLW      3
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _amos4+0
	MOVF       R0+1, 0
	MOVWF      _amos4+1
;TrabalhoFinalAmostra.c,41 :: 		leitura(amos4,'3');
	MOVF       R0+0, 0
	MOVWF      FARG_leitura_valor+0
	MOVF       R0+1, 0
	MOVWF      FARG_leitura_valor+1
	MOVLW      51
	MOVWF      FARG_leitura_canal+0
	CALL       _leitura+0
;TrabalhoFinalAmostra.c,42 :: 		sinal = 0;
	CLRF       _sinal+0
	CLRF       _sinal+1
;TrabalhoFinalAmostra.c,43 :: 		}else{
	GOTO       L_interrupt5
L_interrupt4:
;TrabalhoFinalAmostra.c,44 :: 		sinal++;
	INCF       _sinal+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sinal+1, 1
;TrabalhoFinalAmostra.c,45 :: 		}
L_interrupt5:
;TrabalhoFinalAmostra.c,47 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;TrabalhoFinalAmostra.c,48 :: 		INTCON.TMR0IF = 0;   // clear the flag
	BCF        INTCON+0, 2
;TrabalhoFinalAmostra.c,49 :: 		TMR0 = 186;
	MOVLW      186
	MOVWF      TMR0+0
;TrabalhoFinalAmostra.c,50 :: 		}
L_interrupt0:
;TrabalhoFinalAmostra.c,51 :: 		}
L_end_interrupt:
L__interrupt26:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TrabalhoFinalAmostra.c,53 :: 		void main() {
;TrabalhoFinalAmostra.c,54 :: 		UART1_Init(19200);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;TrabalhoFinalAmostra.c,55 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;TrabalhoFinalAmostra.c,57 :: 		INTCON.GIE = 1; //habilita interrupção global;
	BSF        INTCON+0, 7
;TrabalhoFinalAmostra.c,58 :: 		INTCON.PEIE = 1; //habilita interrupção dos perifericos;
	BSF        INTCON+0, 6
;TrabalhoFinalAmostra.c,59 :: 		INTCON.TMR0IE = 1; //habilita interrupção do TMR0;
	BSF        INTCON+0, 5
;TrabalhoFinalAmostra.c,60 :: 		OPTION_REG = 0b10000110; // Modo Temporizador, prescaler 1:32 - 010;
	MOVLW      134
	MOVWF      OPTION_REG+0
;TrabalhoFinalAmostra.c,62 :: 		TMR0 = 186;
	MOVLW      186
	MOVWF      TMR0+0
;TrabalhoFinalAmostra.c,69 :: 		ADCON1= 0x00;
	CLRF       ADCON1+0
;TrabalhoFinalAmostra.c,70 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;TrabalhoFinalAmostra.c,71 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;TrabalhoFinalAmostra.c,73 :: 		ADC_Init();
	CALL       _ADC_Init+0
;TrabalhoFinalAmostra.c,75 :: 		posEscrita = 0;
	CLRF       _posEscrita+0
	CLRF       _posEscrita+1
;TrabalhoFinalAmostra.c,76 :: 		posLida = 0;
	CLRF       _posLida+0
	CLRF       _posLida+1
;TrabalhoFinalAmostra.c,77 :: 		inverso = 0;
	CLRF       _inverso+0
	CLRF       _inverso+1
;TrabalhoFinalAmostra.c,80 :: 		while(1)
L_main7:
;TrabalhoFinalAmostra.c,84 :: 		if(posEscrita < posLida){
	MOVLW      128
	XORWF      _posEscrita+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _posLida+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _posLida+0, 0
	SUBWF      _posEscrita+0, 0
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;TrabalhoFinalAmostra.c,85 :: 		enviarMensagem(posEscrita);
	MOVF       _posEscrita+0, 0
	MOVWF      FARG_enviarMensagem_pos+0
	MOVF       _posEscrita+1, 0
	MOVWF      FARG_enviarMensagem_pos+1
	CALL       _enviarMensagem+0
;TrabalhoFinalAmostra.c,86 :: 		posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
	MOVLW      1
	SUBWF      _buffer+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _buffer+1, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      _posEscrita+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVF       R1+0, 0
	SUBWF      _posEscrita+0, 0
L__main33:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
	INCF       _posEscrita+0, 1
	BTFSC      STATUS+0, 2
	INCF       _posEscrita+1, 1
	MOVF       _posEscrita+0, 0
	MOVWF      ?FLOC___mainT21+0
	MOVF       _posEscrita+1, 0
	MOVWF      ?FLOC___mainT21+1
	GOTO       L_main11
L_main10:
	CLRF       ?FLOC___mainT21+0
	CLRF       ?FLOC___mainT21+1
L_main11:
	MOVF       ?FLOC___mainT21+0, 0
	MOVWF      _posEscrita+0
	MOVF       ?FLOC___mainT21+1, 0
	MOVWF      _posEscrita+1
;TrabalhoFinalAmostra.c,88 :: 		} else{
	GOTO       L_main12
L_main9:
;TrabalhoFinalAmostra.c,89 :: 		if(posEscrita > posLida && inverso){
	MOVLW      128
	XORWF      _posLida+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _posEscrita+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVF       _posEscrita+0, 0
	SUBWF      _posLida+0, 0
L__main34:
	BTFSC      STATUS+0, 0
	GOTO       L_main15
	MOVF       _inverso+0, 0
	IORWF      _inverso+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
L__main24:
;TrabalhoFinalAmostra.c,91 :: 		enviarMensagem(posEscrita);
	MOVF       _posEscrita+0, 0
	MOVWF      FARG_enviarMensagem_pos+0
	MOVF       _posEscrita+1, 0
	MOVWF      FARG_enviarMensagem_pos+1
	CALL       _enviarMensagem+0
;TrabalhoFinalAmostra.c,92 :: 		posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
	MOVLW      1
	SUBWF      _buffer+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _buffer+1, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      _posEscrita+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVF       R1+0, 0
	SUBWF      _posEscrita+0, 0
L__main35:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
	INCF       _posEscrita+0, 1
	BTFSC      STATUS+0, 2
	INCF       _posEscrita+1, 1
	MOVF       _posEscrita+0, 0
	MOVWF      ?FLOC___mainT27+0
	MOVF       _posEscrita+1, 0
	MOVWF      ?FLOC___mainT27+1
	GOTO       L_main17
L_main16:
	CLRF       ?FLOC___mainT27+0
	CLRF       ?FLOC___mainT27+1
L_main17:
	MOVF       ?FLOC___mainT27+0, 0
	MOVWF      _posEscrita+0
	MOVF       ?FLOC___mainT27+1, 0
	MOVWF      _posEscrita+1
;TrabalhoFinalAmostra.c,93 :: 		if(posEscrita == 0){
	MOVLW      0
	XORWF      ?FLOC___mainT27+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVLW      0
	XORWF      ?FLOC___mainT27+0, 0
L__main36:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;TrabalhoFinalAmostra.c,94 :: 		inverso = 0;
	CLRF       _inverso+0
	CLRF       _inverso+1
;TrabalhoFinalAmostra.c,95 :: 		}
L_main18:
;TrabalhoFinalAmostra.c,96 :: 		} else {
	GOTO       L_main19
L_main15:
;TrabalhoFinalAmostra.c,98 :: 		UART1_Write('>');
	MOVLW      62
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,99 :: 		UART1_Write('\0');
	CLRF       FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,100 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
;TrabalhoFinalAmostra.c,103 :: 		}
L_main19:
;TrabalhoFinalAmostra.c,104 :: 		}
L_main12:
;TrabalhoFinalAmostra.c,105 :: 		}
	GOTO       L_main7
;TrabalhoFinalAmostra.c,106 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_leitura:

;TrabalhoFinalAmostra.c,109 :: 		void leitura(int valor, char canal){
;TrabalhoFinalAmostra.c,110 :: 		bufferCanal[posLida] = canal;
	MOVF       _posLida+0, 0
	ADDLW      _bufferCanal+0
	MOVWF      FSR
	MOVF       FARG_leitura_canal+0, 0
	MOVWF      INDF+0
;TrabalhoFinalAmostra.c,111 :: 		bufferLeitura[posLida] = valor;
	MOVF       _posLida+0, 0
	MOVWF      R0+0
	MOVF       _posLida+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _bufferLeitura+0
	MOVWF      FSR
	MOVF       FARG_leitura_valor+0, 0
	MOVWF      INDF+0
	MOVF       FARG_leitura_valor+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;TrabalhoFinalAmostra.c,112 :: 		posLida = posLida < buffer-1 ? ++posLida : 0;
	MOVLW      1
	SUBWF      _buffer+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _buffer+1, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      _posLida+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leitura38
	MOVF       R1+0, 0
	SUBWF      _posLida+0, 0
L__leitura38:
	BTFSC      STATUS+0, 0
	GOTO       L_leitura21
	INCF       _posLida+0, 1
	BTFSC      STATUS+0, 2
	INCF       _posLida+1, 1
	MOVF       _posLida+0, 0
	MOVWF      R3+0
	MOVF       _posLida+1, 0
	MOVWF      R3+1
	GOTO       L_leitura22
L_leitura21:
	CLRF       R3+0
	CLRF       R3+1
L_leitura22:
	MOVF       R3+0, 0
	MOVWF      _posLida+0
	MOVF       R3+1, 0
	MOVWF      _posLida+1
;TrabalhoFinalAmostra.c,113 :: 		if(posLida == 0){
	MOVLW      0
	XORWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__leitura39
	MOVLW      0
	XORWF      R3+0, 0
L__leitura39:
	BTFSS      STATUS+0, 2
	GOTO       L_leitura23
;TrabalhoFinalAmostra.c,114 :: 		inverso = 1;
	MOVLW      1
	MOVWF      _inverso+0
	MOVLW      0
	MOVWF      _inverso+1
;TrabalhoFinalAmostra.c,115 :: 		}
L_leitura23:
;TrabalhoFinalAmostra.c,116 :: 		}
L_end_leitura:
	RETURN
; end of _leitura

_enviarMensagem:

;TrabalhoFinalAmostra.c,118 :: 		void enviarMensagem(int pos){
;TrabalhoFinalAmostra.c,119 :: 		UART1_Write('<');
	MOVLW      60
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,120 :: 		UART1_Write(bufferCanal[pos]);
	MOVF       FARG_enviarMensagem_pos+0, 0
	ADDLW      _bufferCanal+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,121 :: 		UART1_Write(';');
	MOVLW      59
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,122 :: 		IntToStr(bufferLeitura[pos], msg);
	MOVF       FARG_enviarMensagem_pos+0, 0
	MOVWF      R0+0
	MOVF       FARG_enviarMensagem_pos+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _bufferLeitura+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _msg+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;TrabalhoFinalAmostra.c,123 :: 		UART1_Write_Text(msg);
	MOVLW      _msg+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;TrabalhoFinalAmostra.c,124 :: 		UART1_Write(';');
	MOVLW      59
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;TrabalhoFinalAmostra.c,125 :: 		}
L_end_enviarMensagem:
	RETURN
; end of _enviarMensagem
