/*
 * File: MPU6050.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: I22_MPU6050
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to be interfaced with
 *                      the MPU6050 and reads the IMU and performs calculations
 *                      using the Madgwick filter to produce unit quaternion
 *                      values that can be used to determine spatial orientation
 *
 * Hardware Description: A MPU6050 is connected to the I2C bus and a CP2104 is
 *                       connected to UART1
 *
 * Created April 13th, 2018, 1:27 AM
 */

 /******************************************************************************
 * Includes and Defines
 ******************************************************************************/
#include "stdbool.h"
#include <built_in.h>
#include <stdio.h>
#include <stdlib.h>
#include "MPU6050.h"
#include "MadgwickAHRS.h"

// Volatile Variables
volatile int   GYRO_XOUT, GYRO_YOUT, GYRO_ZOUT;
volatile int   ACCEL_XOUT, ACCEL_YOUT, ACCEL_ZOUT;

// Global variables
double acc_x;
double acc_y;
double acc_z;
double gyro_x;
double gyro_y;
double gyro_z;

int info;
char buf[25];
int cal_var = 0;

double   gyro_x_offset;
double   gyro_y_offset;
double   gyro_z_offset;

char gyro_x_out[10];
char gyro_y_out[10];
char gyro_z_out[10];
char accel_x_out[10];
char accel_y_out[10];
char accel_z_out[10];

// quaternion values
char q0_t[10];
char q1_t[10];
char q2_t[10];
char q3_t[10];


// Writes to the IMU via I2C1
void MPU6050_Write(unsigned char addr, int raddr, int rdata)
{
  buf[0] = raddr;                          // register address
  buf[1] = rdata;                          // register data
  I2C1_Start();                            // issue I2C start signal
  I2C1_Write(addr,buf,2,END_MODE_STOP);    // write data via I2C bus
}

// Test to ensure MP6050 is connected
int MPU6050_Test(void)
{
    buf[0] =  MPU6050_RA_WHO_AM_I;
    I2C1_Start();
    I2C1_Write(MPU6050_ADDRESS, buf, 1, END_MODE_RESTART);
    I2C1_Read(MPU6050_ADDRESS, buf, 1, END_MODE_STOP);

    if(buf[0] == 0x68)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

// Read  the IMU via I2C1
int MPU6050_Read(unsigned short addr, int raddr)
{
    buf[0] = raddr;
    I2C1_Start();
    I2C1_Write(addr,  buf, 1, END_MODE_RESTART);
    I2C1_Read (addr,  buf, 1, END_MODE_STOP);
    
    return buf[0];
}

// Initializes the IMU
void MPU6050_Init(void)
{
    // Wakeup from sleep
    MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_PWR_MGMT_1, 0x00);
    
    // sample rate = 8kHz / 1 + 109 = 72.7Hz
    MPU6050_Write(MPU6050_ADDRESS,  MPU6050_RA_SMPLRT_DIV, 109);

    // Write Accelerometer to +\- 4g
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_ACCEL_CONFIG, 0x00);

   // gyro scale of 2000 degrees/s
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_GYRO_CONFIG, 0x18);

   // Disable Frame Sync, Set Digital Low pass filter to 256Hz DLPF
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_CONFIG, 0x00);

    // Disable sensor output to FIFO buffer
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_FIFO_EN, 0x00);

    // AUX I2C setup, single master control
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_I2C_MST_CTRL, 0x00);
   
    // Setup INT pin and AUX I2C pass through
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_INT_PIN_CFG, 0x00);

    // Enable data ready interrupt
   MPU6050_Write(MPU6050_ADDRESS, MPU6050_RA_INT_ENABLE, 0x00);
}

// Read the raw accel vlaue from the IMU
int MPU6050_Accel_Raw(char axis)
{
    //Variables for high and low accel values
    int   ACCEL_XOUT_H, ACCEL_XOUT_L, ACCEL_YOUT_H;
    int   ACCEL_YOUT_L, ACCEL_ZOUT_H, ACCEL_ZOUT_L;

    // Read accelerometer values out from H and L registers
    ACCEL_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_H);
    ACCEL_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_L);
    ACCEL_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_H);
    ACCEL_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_L);
    ACCEL_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_H);
    ACCEL_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L);
    
    // Convert received data
    ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
    ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
    ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );
    

    // Return value to user based on reqiested axis
    switch (axis)
    {
        case 'X':
            return ACCEL_XOUT;    //  Accel X Axis
            break;
        case 'Y':
            return ACCEL_YOUT;    // Accel Y Axis
            break;
        case 'Z':
            return ACCEL_ZOUT;    //  Accel Z Axis
            break;
        default:
            return 0;
    }
}


// Read the accel value and convert to G's
double MPU6050_Read_Accel(char axis)
{
    // Variables for high and low accel values
    int  ACCEL_XOUT_H, ACCEL_XOUT_L, ACCEL_YOUT_H;
    int  ACCEL_YOUT_L, ACCEL_ZOUT_H, ACCEL_ZOUT_L;
    
    float  GFORCEX;
    float  GFORCEY;
    float  GFORCEZ;

    // Read accelerometer values out from H and L registers
    ACCEL_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_H);
    ACCEL_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_XOUT_L);
    ACCEL_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_H);
    ACCEL_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_YOUT_L);
    ACCEL_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_H);
    ACCEL_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_ACCEL_ZOUT_L);

    // Convert received data
    ACCEL_XOUT = ( ACCEL_XOUT_H<<8 | ACCEL_XOUT_L );
    ACCEL_YOUT = ( ACCEL_YOUT_H<<8 | ACCEL_YOUT_L );
    ACCEL_ZOUT = ( ACCEL_ZOUT_H<<8 | ACCEL_ZOUT_L );
    
    // Calculate G-Force Data
    GFORCEX = (ACCEL_XOUT  / G_CALC_VAL);
    GFORCEY = (ACCEL_YOUT  / G_CALC_VAL);
    GFORCEZ = (ACCEL_ZOUT  / G_CALC_VAL);

    // Return G's value to user
    switch (axis)
    {
        case 'X':
            return GFORCEX;    //  Gforce X Axis
            break;
        case 'Y':
            return GFORCEY;    // Gforce Y Axis
            break;
        case 'Z':
            return GFORCEZ;    //  Gforce Z Axis
            break;
        default:
            return 0;
    }
}

// Read the raw gyro data from the IMU
int MPU6050_Gyro_Raw(char axis)
{
    int  GYRO_XOUT_H, GYRO_XOUT_L;
    int  GYRO_YOUT_H, GYRO_YOUT_L;
    int  GYRO_ZOUT_H ,GYRO_ZOUT_L;

    /* Read data from gyroscope */
    GYRO_XOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_XOUT_H);
    GYRO_XOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_XOUT_L);

    GYRO_YOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_YOUT_H);
    GYRO_YOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_YOUT_L);
    
    GYRO_ZOUT_H = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_ZOUT_H);
    GYRO_ZOUT_L = MPU6050_Read(MPU6050_ADDRESS, MPU6050_RA_GYRO_ZOUT_L);

    // Convert received data
    GYRO_XOUT = ( GYRO_XOUT_H << 8 | GYRO_XOUT_L );
    GYRO_YOUT = ( GYRO_YOUT_H << 8 | GYRO_YOUT_L );
    GYRO_ZOUT = ( GYRO_ZOUT_H << 8 | GYRO_ZOUT_L );

    // Return value to user
    switch (axis)
    {
        case 'X':
            return GYRO_XOUT;    // Gyro X Axis
            break;
        case 'Y':
            return GYRO_YOUT;    //  Gyro Y Axis
            break;
        case 'Z':
            return GYRO_ZOUT;    //  Gyro Z Axis
            break;
        default:
            return 0;
    }
}


// Main
void main() {

    // Initialize the module at 230400 baud with no parity bit, one stop bit at UART1
    UART1_Init(9600);
    // Wait for UART module to stabilize
    Delay_ms(100);

    //Initialize the MPU6050 module with 400Kbps speed on PORTB
    I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);
    Delay_ms(1000);
    
    // Let us know everything is OK
    UART1_Write_Text("Pre Init Okay");
    UART1_Write(13);
    
    // Initialize the MPU6050 module
    MPU6050_Init();
    
    info = MPU6050_Test();
      
    if (info == 1)
    {
        UART1_Write_Text("MPU6050 OK");
        UART1_Write(0x0A); //Line Feed LF
        UART1_Write(0x0D); //Return Car CR
    }

     else
     {
        UART1_Write_Text("MPU6050 Failed");
        UART1_Write(0x0A); //Line Feed LF
        UART1_Write(0x0D); //Return Car CR
     }
      
      // give sensor a second to stabilize
      Delay_ms(1000);
      
      // Calculate gyro offset
      for (cal_var = 0; cal_var <= 64; cal_var++)
      {
        gyro_x_offset += MPU6050_Gyro_Raw('X');
        gyro_y_offset += MPU6050_Gyro_Raw('Y');
        gyro_z_offset += MPU6050_Gyro_Raw('Z');
        
        Delay_ms(1);
      }
      
      // Determine gyro offset for 64 read values
      gyro_x_offset /= 64;
      gyro_y_offset /= 64;
      gyro_z_offset /= 64;
      
    while(1)
    {
       // Read gyro values and convert to Radians per second
       gyro_x  =  (MPU6050_Gyro_Raw('X')  - gyro_x_offset)  / 939.650784f;
       gyro_y  =  (MPU6050_Gyro_Raw('Y')  - gyro_y_offset)  / 939.650784f;
       gyro_z  =  (MPU6050_Gyro_Raw('Z')  - gyro_z_offset)  / 939.650784f;
       
       // Read accel values  and convert relative to 1G
       acc_x = MPU6050_Read_Accel('X') / 2.0f;
       acc_y = MPU6050_Read_Accel('Y') / 2.0f;
       acc_z = MPU6050_Read_Accel('Z') / 2.0f;

       
       /////////////////////////////////////
       // Apply Madgwick filter on values
       ////////////////////////////////////
       MadgwickAHRSupdateIMU(gyro_x, gyro_y, gyro_z, acc_x, acc_y, acc_z);
       
       ///////////////////////////////////////
       // Send unit quaternion values as csv
       ///////////////////////////////////////
       sprintf(q3_t, "%7.2f,%7.2f,%7.2f,%7.2f\n", q0, q1, q2,q3);
       UART1_Write_Text(q3_t);


       Delay_ms(1);
   }
    
}