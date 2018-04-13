#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I22_MPU6050/MPU6050.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i22_mpu6050/stdbool.h"






 typedef int _Bool;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/built_in.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
long int max(long int a, long int b);
long int min(long int a, long int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i22_mpu6050/mpu6050.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i22_mpu6050/madgwickahrs.h"
#line 19 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i22_mpu6050/madgwickahrs.h"
extern volatile float beta;
extern volatile float q0, q1, q2, q3;




void MadgwickAHRSupdate(float gx, float gy, float gz, float ax, float ay, float az, float mx, float my, float mz);
void MadgwickAHRSupdateIMU(float gx, float gy, float gz, float ax, float ay, float az);
#line 31 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I22_MPU6050/MPU6050.c"
volatile int GYRO_XOUT, GYRO_YOUT, GYRO_ZOUT;
volatile int ACCEL_XOUT, ACCEL_YOUT, ACCEL_ZOUT;


double acc_x;
double acc_y;
double acc_z;
double gyro_x;
double gyro_y;
double gyro_z;

int info;
char buf[25];
int cal_var = 0;

double gyro_x_offset;
double gyro_y_offset;
double gyro_z_offset;

char gyro_x_out[10];
char gyro_y_out[10];
char gyro_z_out[10];
char accel_x_out[10];
char accel_y_out[10];
char accel_z_out[10];


char q0_t[10];
char q1_t[10];
char q2_t[10];
char q3_t[10];



void MPU6050_Write(unsigned char addr, int raddr, int rdata)
{
 buf[0] = raddr;
 buf[1] = rdata;
 I2C1_Start();
 I2C1_Write(addr,buf,2,END_MODE_STOP);
}


int MPU6050_Test(void)
{
 buf[0] =  0x75 ;
 I2C1_Start();
 I2C1_Write( 0x68 , buf, 1, END_MODE_RESTART);
 I2C1_Read( 0x68 , buf, 1, END_MODE_STOP);

 if(buf[0] == 0x68)
 {
 return 1;
 }
 else
 {
 return 0;
 }
}


int MPU6050_Read(unsigned short addr, int raddr)
{
 buf[0] = raddr;
 I2C1_Start();
 I2C1_Write(addr, buf, 1, END_MODE_RESTART);
 I2C1_Read (addr, buf, 1, END_MODE_STOP);

 return buf[0];
}


void MPU6050_Init(void)
{

 MPU6050_Write( 0x68 ,  0x6B , 0x00);


 MPU6050_Write( 0x68 ,  0x19 , 109);


 MPU6050_Write( 0x68 ,  0x1C , 0x00);


 MPU6050_Write( 0x68 ,  0x1B , 0x18);


 MPU6050_Write( 0x68 ,  0x1A , 0x00);


 MPU6050_Write( 0x68 ,  0x23 , 0x00);


 MPU6050_Write( 0x68 ,  0x24 , 0x00);


 MPU6050_Write( 0x68 ,  0x37 , 0x00);


 MPU6050_Write( 0x68 ,  0x38 , 0x00);
}


int MPU6050_Accel_Raw(char axis)
{

 int ACCEL_XOUT_H, ACCEL_XOUT_L, ACCEL_YOUT_H;
 int ACCEL_YOUT_L, ACCEL_ZOUT_H, ACCEL_ZOUT_L;


 ACCEL_XOUT_H = MPU6050_Read( 0x68 ,  0x3B );
 ACCEL_XOUT_L = MPU6050_Read( 0x68 ,  0x3C );
 ACCEL_YOUT_H = MPU6050_Read( 0x68 ,  0x3D );
 ACCEL_YOUT_L = MPU6050_Read( 0x68 ,  0x3E );
 ACCEL_ZOUT_H = MPU6050_Read( 0x68 ,  0x3F );
 ACCEL_ZOUT_L = MPU6050_Read( 0x68 ,  0x40 );


 ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
 ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
 ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );



 switch (axis)
 {
 case 'X':
 return ACCEL_XOUT;
 break;
 case 'Y':
 return ACCEL_YOUT;
 break;
 case 'Z':
 return ACCEL_ZOUT;
 break;
 default:
 return 0;
 }
}



double MPU6050_Read_Accel(char axis)
{

 int ACCEL_XOUT_H, ACCEL_XOUT_L, ACCEL_YOUT_H;
 int ACCEL_YOUT_L, ACCEL_ZOUT_H, ACCEL_ZOUT_L;

 float GFORCEX;
 float GFORCEY;
 float GFORCEZ;


 ACCEL_XOUT_H = MPU6050_Read( 0x68 ,  0x3B );
 ACCEL_XOUT_L = MPU6050_Read( 0x68 ,  0x3C );
 ACCEL_YOUT_H = MPU6050_Read( 0x68 ,  0x3D );
 ACCEL_YOUT_L = MPU6050_Read( 0x68 ,  0x3E );
 ACCEL_ZOUT_H = MPU6050_Read( 0x68 ,  0x3F );
 ACCEL_ZOUT_L = MPU6050_Read( 0x68 ,  0x40 );


 ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
 ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
 ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );


 GFORCEX = (ACCEL_XOUT /  8192.0 );
 GFORCEY = (ACCEL_YOUT /  8192.0 );
 GFORCEZ = (ACCEL_ZOUT /  8192.0 );


 switch (axis)
 {
 case 'X':
 return GFORCEX;
 break;
 case 'Y':
 return GFORCEY;
 break;
 case 'Z':
 return GFORCEZ;
 break;
 default:
 return 0;
 }
}


int MPU6050_Gyro_Raw(char axis)
{
 int GYRO_XOUT_H, GYRO_XOUT_L;
 int GYRO_YOUT_H, GYRO_YOUT_L;
 int GYRO_ZOUT_H ,GYRO_ZOUT_L;


 GYRO_XOUT_H = MPU6050_Read( 0x68 ,  0x43 );
 GYRO_XOUT_L = MPU6050_Read( 0x68 ,  0x44 );

 GYRO_YOUT_H = MPU6050_Read( 0x68 ,  0x45 );
 GYRO_YOUT_L = MPU6050_Read( 0x68 ,  0x46 );

 GYRO_ZOUT_H = MPU6050_Read( 0x68 ,  0x47 );
 GYRO_ZOUT_L = MPU6050_Read( 0x68 ,  0x48 );


 GYRO_XOUT = ( GYRO_XOUT_H << 8 | GYRO_XOUT_L );
 GYRO_YOUT = ( GYRO_YOUT_H << 8 | GYRO_YOUT_L );
 GYRO_ZOUT = ( GYRO_ZOUT_H << 8 | GYRO_ZOUT_L );


 switch (axis)
 {
 case 'X':
 return GYRO_XOUT;
 break;
 case 'Y':
 return GYRO_YOUT;
 break;
 case 'Z':
 return GYRO_ZOUT;
 break;
 default:
 return 0;
 }
}



void main() {


 UART1_Init(230400);

 Delay_ms(100);


 I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);
 Delay_ms(1000);


 UART1_Write_Text("Pre Init Okay");
 UART1_Write(13);


 MPU6050_Init();

 info = MPU6050_Test();

 if (info == 1)
 {
 UART1_Write_Text("MPU6050 OK");
 UART1_Write(0x0A);
 UART1_Write(0x0D);
 }

 else
 {
 UART1_Write_Text("MPU6050 Failed");
 UART1_Write(0x0A);
 UART1_Write(0x0D);
 }


 Delay_ms(1000);


 for (cal_var = 0; cal_var <= 64; cal_var++)
 {
 gyro_x_offset += MPU6050_Gyro_Raw('X');
 gyro_y_offset += MPU6050_Gyro_Raw('Y');
 gyro_z_offset += MPU6050_Gyro_Raw('Z');

 Delay_ms(1);
 }


 gyro_x_offset /= 64;
 gyro_y_offset /= 64;
 gyro_z_offset /= 64;

 while(1)
 {

 gyro_x = (MPU6050_Gyro_Raw('X') - gyro_x_offset) / 939.650784f;
 gyro_y = (MPU6050_Gyro_Raw('Y') - gyro_y_offset) / 939.650784f;
 gyro_z = (MPU6050_Gyro_Raw('Z') - gyro_z_offset) / 939.650784f;


 acc_x = MPU6050_Read_Accel('X') / 2.0f;
 acc_y = MPU6050_Read_Accel('Y') / 2.0f;
 acc_z = MPU6050_Read_Accel('Z') / 2.0f;




 UART1_Write_Text("  AccelX: ");
 sprintf(accel_x_out, "%7.2f", acc_x);
 UART1_Write_Text(accel_x_out);

 UART1_Write_Text("  AccelY: ");
 sprintf(accel_y_out, "%7.2f", acc_y);
 UART1_Write_Text(accel_y_out);

 UART1_Write_Text("  AccelZ: ");
 sprintf(accel_z_out, "%7.2f", acc_z);
 UART1_Write_Text(accel_z_out);

 UART1_Write(0x0A);
 UART1_Write(0x0D);




 UART1_Write_Text("  GyroX: ");
 sprintf(gyro_x_out, "%7.2f", gyro_x);
 UART1_Write_Text(gyro_x_out);

 UART1_Write_Text("  GyroY: ");
 sprintf(gyro_y_out, "%7.2f", gyro_y);
 UART1_Write_Text(gyro_y_out);

 UART1_Write_Text("  GyroZ: ");
 sprintf(gyro_z_out, "%7.2f", gyro_z);
 UART1_Write_Text(gyro_z_out);

 UART1_Write(0x0A);
 UART1_Write(0x0D);




 MadgwickAHRSupdateIMU(gyro_x, gyro_y, gyro_z, acc_x, acc_y, acc_z);




 UART1_Write_Text("  Q0: ");
 sprintf(q0_t, "%7.2f", q0);
 UART1_Write_Text(q0_t);

 UART1_Write_Text("  Q1: ");
 sprintf(q1_t, "%7.2f", q1);
 UART1_Write_Text(q1_t);

 UART1_Write_Text("  Q2: ");
 sprintf(q2_t, "%7.2f", q2);
 UART1_Write_Text(q2_t);

 UART1_Write_Text("  Q3: ");
 sprintf(q3_t, "%7.2f", q3);
 UART1_Write_Text(q3_t);

 UART1_Write(0x0A);
 UART1_Write(0x0D);

 Delay_ms(1);
 }

}
