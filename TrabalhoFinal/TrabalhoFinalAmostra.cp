#line 1 "W:/Unoesc/10ª Fase - 2015/Instrumentação e Processamento de Sinais/TrabalhoAmostras/TrabalhoFinal/TrabalhoFinalAmostra.c"
int buffer = 40;
char msg[10];
char bufferCanal[40];
int bufferLeitura[40];
int posEscrita;
int posLida;
int inverso;

void leitura(int valor, char canal);
void enviarMensagem(int pos);


int amos1 = 0;
int amos2 = 0;
int amos3 = 0;
int amos4 = 0;
int sinal = 0;
int finalizo = 0;

void interrupt(void){
 if (INTCON.TMR0IF ==1)
 {

 if(sinal == 0){
 amos1 = ADC_Read(0);
 leitura(amos1,'0');
 }

 if(sinal == 1){
 amos2 = ADC_Read(1);
 leitura(amos2,'1');
 }

 if(sinal == 2){
 amos3 = ADC_Read(2);
 leitura(amos3,'2');
 }

 if(sinal == 3){
 amos4 = ADC_Read(3);
 leitura(amos4,'3');
 sinal = 0;
 }else{
 sinal++;
 }

 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 TMR0 = 186;
 }
}

void main() {
 UART1_Init(19200);
 Delay_ms(100);

 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 INTCON.TMR0IE = 1;
 OPTION_REG = 0b10000110;

 TMR0 = 186;






 ADCON1= 0x00;
 TRISA = 0xFF;
 PORTA = 0x00;

 ADC_Init();

 posEscrita = 0;
 posLida = 0;
 inverso = 0;


 while(1)
 {


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
 Delay_ms(40);


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
