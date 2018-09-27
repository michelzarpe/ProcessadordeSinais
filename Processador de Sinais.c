#define buffer 500
int cont = 0;
char msg[10];
int canal;
char bufferCanal[buffer];
int bufferLeitura[buffer];
int posEscrita;
int posLida;
int inverso;
int crescente = 1;

void leitura(char canal);
void enviarMensagem(int pos);

void Timer1Int() iv IVT_ADDR_T1INTERRUPT{// Timer1 address in the interrupt vector table
  T1IF_bit = 0;
  switch(canal){
     case 0:
       leitura('0');
       canal++;
       break;
     case 1:
       leitura('1');
       canal++;
       break;
     case 2:
       leitura('2');
       canal++;
       break;
     case 3:
       leitura('3');
       canal = 0;
       if(crescente){
         cont++;
         if(cont == 10){
           crescente = 0;
         }
       }
       if(!crescente){
         cont --;
         if(cont == -10){
           crescente = 1;
         }
       }
       break;
  }

}

void main(){
  T1CON            = 0x8010;
  T1IE_bit         = 1;
  T1IF_bit         = 0;
  IPC0             = IPC0 | 0x1000;
  PR1              = 10000;

  canal = 0;
  posEscrita = 0;
  posLida = 0;
  inverso = 0;
  UART1_Init(9600);
  UART1_Write_Text("Hello World");
  
  
  while(1) {
      if(posEscrita < posLida){
         enviarMensagem(posEscrita);
         posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
      } else{
        if(posEscrita > posLida && inverso){
           enviarMensagem(posEscrita);
           posEscrita = posEscrita < buffer-1 ? ++posEscrita : 0;
           if(posEscrita == 0){
             inverso = 0;
           }
        } else {
          UART1_Write('>');
          UART1_Write('\0');
          Delay_ms(150);
        }
      }
  }
}

void leitura(char canal){
  bufferCanal[posLida] = canal;
  bufferLeitura[posLida] = cont;
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
