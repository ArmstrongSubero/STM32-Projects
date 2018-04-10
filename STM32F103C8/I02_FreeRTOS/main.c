 /*
 * File: Main.c
 * Author: Armstrong Subero
 * uC: STM32F103C8T6 w/PLL OSC @ 72 MHz, 3.3v
 * Program: I02_FreeRTOS
 * Compiler: MikroC Pro v6.0.0
 * Program Version: 1.0
 *
 * Program Description: This Program Allows STM32F103C8T6 to use the FreeRTOS
 *                      RTOS to blink LEDs connected to PORTB5, B6 and B7 at a
 *                      rate of ever 250ms, 500ms and ever second.
 *
 * Hardware Description: LEDs are connected via a 1k resistor to PINB5, B6 and 
 *                       B7
 *
 * Created April 9th, 2018, 11:55 PM
 */
 
// Includes

#include "main.h"

// Public Function Definitions

// Task 1
void task1(void *pvParameters)
{
     // set PORTB5 as digital output
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_5);
    
    while (1)
    {
       vTaskDelay(pdMS_TO_TICKS(250));
       GPIOB_ODR.B5 = ~GPIOB_ODR.B5;
    }
}


// Task 2
void task2(void *pvParameters)
{
     // set PORTB6 as digital output
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_6);

    while (1)
    {
       vTaskDelay(pdMS_TO_TICKS(500));
       GPIOB_ODR.B6 = ~GPIOB_ODR.B6;
    }
}

// Task 3
void task3(void *pvParameters)
{
     // set PORTB7 as digital output
     GPIO_Digital_Output(&GPIOB_ODR, _GPIO_PINMASK_7);

    while (1)
    {
       vTaskDelay(pdMS_TO_TICKS(1000));
       GPIOB_ODR.B7 = ~GPIOB_ODR.B7;
    }
}

// Main function, which creates the tasks and starts the scheduler.
void main()
{
    // Create task 1
    xTaskCreate(
        (TaskFunction_t)task1,
        "Task 1",
        configMINIMAL_STACK_SIZE,
        NULL,
        10,
        NULL
    );
    
    // Create task 2
    xTaskCreate(
        (TaskFunction_t)task2,
        "Task 2",
        configMINIMAL_STACK_SIZE,
        NULL,
        10,
        NULL
    );
    
    // Create task 3
    xTaskCreate(
        (TaskFunction_t)task3,
        "Task 3",
        configMINIMAL_STACK_SIZE,
        NULL,
        10,
        NULL
    );

    // Start the RTOS scheduler.
    vTaskStartScheduler();
    
    // Will never reach here.
    while (1);
}
