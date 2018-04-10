 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: I09_SD_Card
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to be interfaced with
 *                      and SD card and demonstrates reading and writing files
 *
 * Hardware Description: An SD card is connected to the SPI1 bus.
 *
 * Modified From: Library example provided by Mikroelektronica
 * Created April 10th, 2018, 11:31 AM
 */

#include "__Lib_FAT32.h"

////////////////////////////////////////////////////////////////////////////////
//#define DIR_TEST_1
//#define DIR_TEST_2
#define FILE_TEST
//#define SWAP_TEST
//#define LFN_TEST
////////////////////////////////////////////////////////////////////////////////
//
//          Mmc Library requirements for different MPU families
//
////////////////////////////////////////////////////////////////////////////////

sbit Mmc_Chip_Select           at GPIOB_ODR.B1;

////////////////////////////////////////////////////////////////////////////////
//
//          SPI initialization routines required by Mmc Library
//
////////////////////////////////////////////////////////////////////////////////

void initSPI(void)
{
    // Initialize SPI1 module
    SPI1_Init_Advanced(_SPI_FPCLK_DIV64, _SPI_MASTER  | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI1_PA567);
}

void initFastSPI(void)
{
    SPI1_CR1 = 0;
                       
      // Initialize SPI1 module
    SPI1_Init_Advanced(_SPI_FPCLK_DIV2, _SPI_MASTER  | _SPI_8_BIT |
                       _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                       _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                       &_GPIO_MODULE_SPI1_PA567);
}


////////////////////////////////////////////////////////////////////////////////
//
//  many of these messages are not used in the example,
//  as they are intended for future improvement
//
////////////////////////////////////////////////////////////////////////////////

const char cmd[16][16] =
{
    "init           ",    //  0
    "qformat        ",    //  1
    "mkdir          ",    //  2
    "chdir          ",    //  3
    "rmdir          ",    //  4
    "dir            ",    //  5
    "rendir         ",    //  6
    "assign         ",    //  7
    "read           ",    //  8
    "append         ",    //  9
    "rewrite        ",    // 10
    "delete         ",    // 11
    "rename         ",    // 12
    "swap           ",    // 13
    "set date       ",    // 14
    "get date       "     // 15
};

const char cmdOK[16][16] =
{
    "init ok        ",
    "qformat ok     ",
    "mkdir ok       ",
    "chdir ok       ",
    "rmdir ok       ",
    "dir ok         ",
    "rendir ok      ",
    "assign ok      ",
    "read ok        ",
    "append ok      ",
    "rewrite ok     ",
    "delete ok      ",
    "rename ok      ",
    "swap ok        ",
    "set date ok    ",
    "get date ok    "
};

const char cmdFAIL[16][16] =
{
    "init failed    ",
    "qformat failed ",
    "mkdir failed   ",
    "chdir failed   ",
    "rmdir failed   ",
    "dir failed     ",
    "rendir failed  ",
    "assign failed  ",
    "read failed    ",
    "append failed  ",
    "rewrite failed ",
    "delete failed  ",
    "rename failed  ",
    "swap failed    ",
    "set date failed",
    "get date failed"
};

const char len[16] =
{
    4,
    7,
    5,
    5,
    5,
    3,
    6,
    6,
    4,
    6,
    7,
    6,
    6,
    4,
    8,
    8
};

const char line[16]         =   "***************";
const char unknown[16]      =   "unknown command";
const char startOK[16]      =   "init successful";
const char startFAIL[16]    =   "init failed    ";
const char cmdStart[16]     =   "cmd demo start ";
const char noFileName[16]   =   "NO FILE NAME   ";
const char noDirName[16]    =   "NO DIR NAME    ";
const char noVolumeName[16] =   "NO VOLUME NAME ";

////////////////////////////////////////////////////////////////////////////////

int8   err;
uint8  i, j, attr;
uint16 cnt, bpcl;
uint32 k;
uint32 size;
uint32 totalClusts,
       freeClusts,
       badClusts;

__TIME tm;
__SECTOR sc;
__HANDLE fileHandle[4];

char ch;
char DirName[20];
char FileName[20];
char uartbuf[32];
char del[2] = "\r";

char rdbuf[19] = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '};
char wrbuf[15] = {'[', '+', ']', '-', '-', '-', '+', '+', '+', '=', '=', '=', '~', '~', '~'};

#ifdef SWAP_TEST
char buff[512];
#endif

////////////////////////////////////////////////////////////////////////////////

static char* constToVar(char *dst, const char *src)
{
    char *tmp;

    tmp = dst;
    for (;;)
    {
        *dst = *src;
        if (*src == 0) break;
        src++;
        dst++;
    }
    return tmp;
}

////////////////////////////////////////////////////////////////////////////////

/*char iscmd(char n)
{
    if (0 == memcmp(uartbuf, constToVar(varbuf, cmd[n]), len[n]))
        return 1;
    else
        return 0;
}*/

////////////////////////////////////////////////////////////////////////////////

void UART_Write_ConstText(const char *text)
{
    UART_Write_Text(constToVar(uartbuf, text));
}

////////////////////////////////////////////////////////////////////////////////
//
// main program
//
////////////////////////////////////////////////////////////////////////////////
void main(void)
{
    ///////////////////////////////////////
    //  UART module initialization
    ///////////////////////////////////////
    // Initialize the module at 9600 baud with no parity bit, one stop bit at UART1
    UART1_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, 
                        &_GPIO_MODULE_USART1_PA9_10);
    Delay_ms(100);                  // Wait for UART module to stabilize

    UART_Write(CR);
    UART_Write_ConstText(line);
    UART_Write(CR);
    Delay_ms(100);

    ///////////////////////////////////////
    //  SPI module initialization
    ///////////////////////////////////////
    initSPI();

    ///////////////////////////////////////
    //  initialize storage device.
    //  optionally, we could format the device
    //  instead of just initializing it.
    ///////////////////////////////////////
    err = FAT32_Init();
    //err = FAT32_format("dev0");
    if (err < 0)
    {
            UART_Write(CR);
            UART_Write_Text(constToVar(uartbuf, cmdFAIL[0]));
            UART_Write(CR);

            while(err < 0)  //  ...retry each second
            {
                    err = FAT32_Init();
                    Delay_ms(1000);
            }
    }
    ///////////////////////////////////////
    //  if all went well, reinitialize
    //  SPI with greater speed
    ///////////////////////////////////////
    initFastSPI();
    UART_Write(CR);
    UART_Write_Text(constToVar(uartbuf, cmdOK[0]));
    UART_Write(CR);

    err = FAT32_Dir();
    UART_Write(CR);


    ////////////////////////////////////////////////////////////////////////////
    //
    //  In this section file operation is demonstrated:
    //      - read,
    //      - write,
    //      - append,
    //      - removal.
    //
    ////////////////////////////////////////////////////////////////////////////

    {
            // open some files
            fileHandle[0] = FAT32_Open("FILE1.TXT", FILE_WRITE);
            fileHandle[1] = FAT32_Open("FILE2.TXT", FILE_APPEND);
            fileHandle[2] = FAT32_Open("FILE3.TXT", FILE_APPEND);
            fileHandle[3] = FAT32_Open("FILE4.TXT", FILE_APPEND);

            if (fileHandle[0] < 0) while(1);
            if (fileHandle[1] < 0) while(1);
            if (fileHandle[2] < 0) while(1);
            if (fileHandle[3] < 0) while(1);

            {
                    for (k = 0; k < 1000; k++)
                    {
                            err = FAT32_Write(fileHandle[0], wrbuf, sizeof(wrbuf));
                    }
                    UART_Write(CR);
                    err = FAT32_Close(fileHandle[0]);
            }
            err = FAT32_Dir();
            UART_Write(CR);

            fileHandle[0] = FAT32_Open("FILE1.TXT", FILE_READ);
            if (fileHandle[0] < 0) while(1);

            err = FAT32_Size("FILE1.TXT", &size);
            for (k = 0; k < size;)
            {
                    err = FAT32_Read(fileHandle[0], rdbuf, sizeof(rdbuf));
                    for (cnt = 0; cnt < sizeof(rdbuf); cnt++, k++)
                    {
                            if (k < size)
                            {
                                    UART_Write(rdbuf[cnt]);
                            }
                            else
                            {
                                    break;
                            }
                    }
            }
            UART_Write(CR);
            UART_Write(CR);


            FAT32_Seek(fileHandle[0], 0);   // reset file cursor to 0.
            // FAT32_Seek(fileHandle[0], 5789); // it can be changed to anywhere within a file.

            // read 'rdlen' bytes in "FILE1.TXT" from the position set by FAT32_Seek()
            // and write them to "FILE2.TXT" and "FILE3.TXT"
            err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
            err = FAT32_Write(fileHandle[1], rdbuf, sizeof(rdbuf));
            err = FAT32_Write(fileHandle[2], rdbuf, sizeof(rdbuf));

            // read 3x'rdlen' bytes in "FILE1.TXT" from the current position
            // and write them to "FILE4.TXT"
            err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
            err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));
            err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
            err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));
            err = FAT32_Read (fileHandle[0], rdbuf, sizeof(rdbuf));
            err = FAT32_Write(fileHandle[3], rdbuf, sizeof(rdbuf));

            // close all opened files
            err = FAT32_Close(fileHandle[0]);
            err = FAT32_Close(fileHandle[1]);
            err = FAT32_Close(fileHandle[2]);
            err = FAT32_Close(fileHandle[3]);

            // display new info on modified files.
            // the info is updated only after file closure.
            err = FAT32_Dir();
            UART_Write(CR);

            // change attribute "FILE1.TXT"
            err = FAT32_GetAttr("FILE1.TXT", &attr);
            err = FAT32_SetAttr("FILE1.TXT", attr | ATTR_HIDDEN);

            err = FAT32_Dir();
            UART_Write(CR);
    }

    UART_Write(CR);
    FAT32_GetFreeSpace(&freeClusts, &bpcl);
    UART_Write_Text("Free Space Info:");
    UART_Write(CR);
    UART_Write_Text("Free bytes: ");
    LongWordToStr(freeClusts*bpcl, uartbuf);
    UART_Write_Text(uartbuf);
    UART_Write(CR);

    UART_Write(CR);
    UART_Write_Text(constToVar(uartbuf, line));
    UART_Write(CR);
}