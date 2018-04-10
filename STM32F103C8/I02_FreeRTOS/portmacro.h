/*
    FreeRTOS V9.0.0 - Copyright (C) 2016 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.

    ***************************************************************************
    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<
    ***************************************************************************

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org/FAQHelp.html - Having a problem?  Start by reading
    the FAQ page "My application does not run, what could be wrong?".  Have you
    defined configASSERT()?

    http://www.FreeRTOS.org/support - In return for receiving this top quality
    embedded software for free we request you assist our global community by
    participating in the support forum.

    http://www.FreeRTOS.org/training - Investing in training allows your team to
    be as productive as possible as early as possible.  Now you can receive
    FreeRTOS training directly from Richard Barry, CEO of Real Time Engineers
    Ltd, and the world's leading authority on the world's leading RTOS.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd. license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/

#ifndef PORTMACRO_H
#define PORTMACRO_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

//-----------------------------------------------------------
// Port specific definitions.
//
// The settings in this file configure FreeRTOS correctly for the
// given hardware and compiler.
//
// These settings should not be altered.
//-----------------------------------------------------------


// Type definitions.
#define portCHAR            uint8_t
#define portFLOAT           float
#define portDOUBLE          double
#define portLONG            int32_t
#define portSHORT           int16_t
#define portSTACK_TYPE      uint32_t
#define portBASE_TYPE       int32_t

typedef portSTACK_TYPE StackType_t;
typedef int32_t BaseType_t;
typedef uint32_t UBaseType_t;

#if( configUSE_16_BIT_TICKS == 1 )
    typedef uint16_t TickType_t;
    #define portMAX_DELAY ( TickType_t ) 0xffff
#else
    typedef uint32_t TickType_t;
    #define portMAX_DELAY ( TickType_t ) 0xffffffffUL

    // 32-bit tick type on a 32-bit architecture, so reads of the tick count do
    // not need to be guarded with a critical section.
    #define portTICK_TYPE_IS_ATOMIC 1
#endif
//-----------------------------------------------------------

// Architecture specifics.
#define portSTACK_GROWTH     (-1)
#define portTICK_PERIOD_MS   ((TickType_t)1000 / configTICK_RATE_HZ)
#define portBYTE_ALIGNMENT   8
//-----------------------------------------------------------

// Scheduler utilities.
#define portYIELD()                                                            \
{                                                                              \
    /* Set a PendSV to request a context switch. */                            \
    PENDSVSET_bit = 1;                                                         \
                                                                               \
    /* Barriers are normally not required but do ensure the code is completely \
    within the specified behaviour for the architecture. */                    \
    asm DSB;                                                                   \
    asm ISB;                                                                   \
}

#define portEND_SWITCHING_ISR(xSwitchRequired)                                 \
    if (xSwitchRequired != pdFALSE) portYIELD()
    
#define portYIELD_FROM_ISR(x) portEND_SWITCHING_ISR(x)
//-----------------------------------------------------------

// Critical section management.
extern void vPortEnterCritical();
extern void vPortExitCritical();
#define portSET_INTERRUPT_MASK_FROM_ISR()        ulPortRaiseBASEPRI()
#define portCLEAR_INTERRUPT_MASK_FROM_ISR(x)     vPortSetBASEPRI(x)
#define portDISABLE_INTERRUPTS()                 vPortRaiseBASEPRI()
#define portENABLE_INTERRUPTS()                  vPortSetBASEPRI(0)
#define portENTER_CRITICAL()                     vPortEnterCritical()
#define portEXIT_CRITICAL()                      vPortExitCritical()

//-----------------------------------------------------------

// Task function macros as described on the FreeRTOS.org WEB site.  These are
// not necessary for to use this port.  They are defined so the common demo
// files (which build with all the ports) will build.
#define portTASK_FUNCTION_PROTO(vFunction, pvParameters)                       \
    void vFunction( void *pvParameters )
#define portTASK_FUNCTION(vFunction, pvParameters)                             \
    void vFunction( void *pvParameters )
//-----------------------------------------------------------

// Tickless idle/low power functionality.
#ifndef portSUPPRESS_TICKS_AND_SLEEP
    extern void vPortSuppressTicksAndSleep(TickType_t xExpectedIdleTime);
    #define portSUPPRESS_TICKS_AND_SLEEP( xExpectedIdleTime )                  \
        vPortSuppressTicksAndSleep( xExpectedIdleTime )    
#endif
//-----------------------------------------------------------

// Architecture specific optimisations.
#ifndef configUSE_PORT_OPTIMISED_TASK_SELECTION
    #define configUSE_PORT_OPTIMISED_TASK_SELECTION  1
#endif

#if configUSE_PORT_OPTIMISED_TASK_SELECTION == 1

    // Generic helper function.
    static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
    {
        asm CLZ R0, R0;
        return R0;
    }
    
    // Check the configuration.
    #if( configMAX_PRIORITIES > 32 )
    #error configUSE_PORT_OPTIMISED_TASK_SELECTION can only be set to 1 when configMAX_PRIORITIES is less than or equal to 32. It is very rare that a system requires more than 10 to 15 difference priorities as tasks that share a priority will time slice.
    #endif
    
    // Store/clear the ready priorities in a bit map.
    #define portRECORD_READY_PRIORITY(uxPriority, uxReadyPriorities)           \
        (uxReadyPriorities) |= (1UL << (uxPriority))
    #define portRESET_READY_PRIORITY(uxPriority, uxReadyPriorities)            \
        (uxReadyPriorities) &= ~(1UL << (uxPriority))
    
    //-----------------------------------------------------------
    
    #define portGET_HIGHEST_PRIORITY(uxTopPriority, uxReadyPriorities)         \
        uxTopPriority =                                                        \
            (31UL - (uint32_t)ucPortCountLeadingZeros((uxReadyPriorities)))

#endif // configUSE_PORT_OPTIMISED_TASK_SELECTION

//-----------------------------------------------------------

#ifdef configASSERT
    void vPortValidateInterruptPriority( void );
    #define portASSERT_IF_INTERRUPT_PRIORITY_INVALID()                         \
        vPortValidateInterruptPriority()
#endif

// portNOP() is not required by this port.
#define portNOP()

#define portINLINE inline

#ifndef portFORCE_INLINE
    #define portFORCE_INLINE inline
#endif

portFORCE_INLINE static BaseType_t xPortIsInsideInterrupt( void )
{
    uint32_t ulCurrentInterrupt;
    BaseType_t xReturn;

    // Obtain the number of the currently executing interrupt.
    ulCurrentInterrupt = CPU_REG_GET(CPU_IPSR);

    if( ulCurrentInterrupt == 0 )
    {
        xReturn = pdFALSE;
    }
    else
    {
        xReturn = pdTRUE;
    }

    return xReturn;
}
//-----------------------------------------------------------

portFORCE_INLINE static void vPortRaiseBASEPRI( void )
{
    uint32_t ulNewBASEPRI;

    ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
    CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
    
    asm ISB;
    asm DSB;
}
//-----------------------------------------------------------

portFORCE_INLINE static uint32_t ulPortRaiseBASEPRI( void )
{
    uint32_t ulOriginalBASEPRI, ulNewBASEPRI;

    ulOriginalBASEPRI = CPU_REG_GET(CPU_BASEPRI);
    ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
    CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
    
    asm ISB;
    asm DSB;

    // This return will not be reached but is necessary
    // to prevent compiler warnings.
    return ulOriginalBASEPRI;
}
//-----------------------------------------------------------

portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
{
    CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
}
//-----------------------------------------------------------


#ifdef __cplusplus
}
#endif

#endif /* PORTMACRO_H */