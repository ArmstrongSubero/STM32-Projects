#include "uart_transmit.h"
#include <string.h>

char msg[30];

void send_uart(char* myString)
{
	 sprintf(msg, myString);
	 HAL_UART_Transmit(&huart1, (uint8_t*)msg, strlen(msg), HAL_MAX_DELAY);
}

