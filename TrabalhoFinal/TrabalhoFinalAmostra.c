int buffer = 40;
char msg[10];
char bufferCanal[40];
int bufferLeitura[40];
int posEscrita;
int posLida;
int inverso;

void leitura(int valor, char canal);
void enviarMensagem(int pos);

//Variaveis globais
int amos1 = 0;
int amos2 = 0;
int amos3 = 0;
int amos4 = 0;
int sinal = 0;
int finalizo = 0;

void interrupt(void){
     if (INTCON.TMR0IF ==1) // timer 0 interrupt
       {

       if(sinal == 0){
                amos1 =  ADC_Read(0);
                leitura(amos1,'0');
        }

        if(sinal == 1){
                amos2 =  ADC_Read(1);
                leitura(amos2,'1');
        }

        if(sinal == 2){
                amos3 =  ADC_Read(2);
                leitura(amos3,'2');
        }

        if(sinal == 3){
                amos4 =  ADC_Read(3);
                leitura(amos4,'3');
                sinal = 0;
        }else{
                sinal++;
        }
        
    INTCON.TMR0IE = 1;
    INTCON.TMR0IF = 0;   // clear the flag
    TMR0 = 186;
  }
}

void main() {
        UART1_Init(19200);               // Initialize UART module at 9600 bps
        Delay_ms(100);                  // Wait for UART module to stabilize

        INTCON.GIE = 1; //habilita interrupção global;
        INTCON.PEIE = 1; //habilita interrupção dos perifericos;
        INTCON.TMR0IE = 1; //habilita interrupção do TMR0;
        OPTION_REG = 0b10000110; // Modo Temporizador, prescaler 1:32 - 010;
        //OPTION_REG = 0x88;
        TMR0 = 186;
        //INTCON = 0xA0;



        //Parte da Leitura
        //ADCON1 = 0x00;
        ADCON1= 0x00;
        TRISA = 0xFF;
        PORTA = 0x00;

        ADC_Init();

        posEscrita = 0;
        posLida = 0;
        inverso = 0;


        while(1)
        {
              //IntToStr(cont,msg) ;
              // UART1_Write_Text(msg);
               if(posEscrita < posLida){
                        enviarMensagem(posEscrita);
                        posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
                        //finalizo = 0;
                } else{
                        if(posEscrita > posLida && inverso){
                               // finalizo = 0;
                                enviarMensagem(posEscrita);
                                posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
                                if(posEscrita == 0){
                                        inverso = 0;
                                }
                        } else {
                               //if(!finalizo){
                                UART1_Write('>');
                                UART1_Write('\0');
                                Delay_ms(40);
                                //finalizo = 1;
                                //}
                        }
                }
        }
}


void leitura(int valor, char canal){
        bufferCanal[posLida] = canal;
        bufferLeitura[posLida] = valor;
        posLida = posLida < buffer-1 ? ++posLida : 0;
        if(posLida == 0){
           inverso = 1;
        }
}

void enviarMensagem(int pos){
        UART1_Write('<');
        UART1_Write(bufferCanal[pos]);
        UART1_Write(';');
        IntToStr(bufferLeitura[pos], msg);
        UART1_Write_Text(msg);
        UART1_Write(';');
}