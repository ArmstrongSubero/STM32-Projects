#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/croutine.c"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stddef.h"



typedef long ptrdiff_t;


 typedef unsigned long size_t;

typedef unsigned long wchar_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertosconfig.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/projdefs.h"
#line 77 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/projdefs.h"
typedef void (*TaskFunction_t)( void * );
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/deprecated_definitions.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"
#line 98 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
typedef  uint32_t  StackType_t;
typedef int32_t BaseType_t;
typedef uint32_t UBaseType_t;





 typedef uint32_t TickType_t;
#line 140 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
extern void vPortEnterCritical();
extern void vPortExitCritical();
#line 162 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
 extern void vPortSuppressTicksAndSleep(TickType_t xExpectedIdleTime);
#line 176 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
 static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
 {
 asm CLZ R0, R0;
 return R0;
 }
#line 204 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
 void vPortValidateInterruptPriority( void );
#line 218 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portmacro.h"
 inline  static BaseType_t xPortIsInsideInterrupt( void )
{
 uint32_t ulCurrentInterrupt;
 BaseType_t xReturn;


 ulCurrentInterrupt = CPU_REG_GET(CPU_IPSR);

 if( ulCurrentInterrupt == 0 )
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }

 return xReturn;
}


 inline  static void vPortRaiseBASEPRI( void )
{
 uint32_t ulNewBASEPRI;

 ulNewBASEPRI =  0x10 ;
 CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);

 asm ISB;
 asm DSB;
}


 inline  static uint32_t ulPortRaiseBASEPRI( void )
{
 uint32_t ulOriginalBASEPRI, ulNewBASEPRI;

 ulOriginalBASEPRI = CPU_REG_GET(CPU_BASEPRI);
 ulNewBASEPRI =  0x10 ;
 CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);

 asm ISB;
 asm DSB;



 return ulOriginalBASEPRI;
}


 inline  static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
{
 CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
}
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/mpu_wrappers.h"
#line 144 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
 StackType_t *pxPortInitialiseStack( StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters )  ;



typedef struct HeapRegion
{
 uint8_t *pucStartAddress;
 size_t xSizeInBytes;
} HeapRegion_t;
#line 165 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
void vPortDefineHeapRegions( const HeapRegion_t * const pxHeapRegions )  ;
#line 171 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
void *pvPortMalloc( size_t xSize )  ;
void vPortFree( void *pv )  ;
void vPortInitialiseBlocks( void )  ;
size_t xPortGetFreeHeapSize( void )  ;
size_t xPortGetMinimumEverFreeHeapSize( void )  ;
#line 181 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
BaseType_t xPortStartScheduler( void )  ;
#line 188 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/portable.h"
void vPortEndScheduler( void )  ;
#line 874 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
struct xSTATIC_LIST_ITEM
{
 TickType_t xDummy1;
 void *pvDummy2[ 4 ];
};
typedef struct xSTATIC_LIST_ITEM StaticListItem_t;


struct xSTATIC_MINI_LIST_ITEM
{
 TickType_t xDummy1;
 void *pvDummy2[ 2 ];
};
typedef struct xSTATIC_MINI_LIST_ITEM StaticMiniListItem_t;


typedef struct xSTATIC_LIST
{
 UBaseType_t uxDummy1;
 void *pvDummy2;
 StaticMiniListItem_t xDummy3;
} StaticList_t;
#line 910 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
typedef struct xSTATIC_TCB
{
 void *pxDummy1;
#line 916 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
 StaticListItem_t xDummy3[ 2 ];
 UBaseType_t uxDummy5;
 void *pxDummy6;
 uint8_t ucDummy7[  (16)  ];
#line 930 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
 UBaseType_t uxDummy12[ 2 ];
#line 945 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
 uint32_t ulDummy18;
 uint8_t ucDummy19;
#line 952 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
} StaticTask_t;
#line 968 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
typedef struct xSTATIC_QUEUE
{
 void *pvDummy1[ 3 ];

 union
 {
 void *pvDummy2;
 UBaseType_t uxDummy2;
 } u;

 StaticList_t xDummy3[ 2 ];
 UBaseType_t uxDummy4[ 3 ];
 uint8_t ucDummy5[ 2 ];
#line 995 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
} StaticQueue_t;
typedef StaticQueue_t StaticSemaphore_t;
#line 1012 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
typedef struct xSTATIC_EVENT_GROUP
{
 TickType_t xDummy1;
 StaticList_t xDummy2;
#line 1025 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
} StaticEventGroup_t;
#line 1041 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
typedef struct xSTATIC_TIMER
{
 void *pvDummy1;
 StaticListItem_t xDummy2;
 TickType_t xDummy3;
 UBaseType_t uxDummy4;
 void *pvDummy5[ 2 ];
#line 1056 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/freertos.h"
} StaticTimer_t;
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
#line 181 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
struct xLIST_ITEM
{
  
   TickType_t xItemValue;
 struct xLIST_ITEM *   pxNext;
 struct xLIST_ITEM *   pxPrevious;
 void * pvOwner;
 void *   pvContainer;
  
};
typedef struct xLIST_ITEM ListItem_t;

struct xMINI_LIST_ITEM
{
  
   TickType_t xItemValue;
 struct xLIST_ITEM *   pxNext;
 struct xLIST_ITEM *   pxPrevious;
};
typedef struct xMINI_LIST_ITEM MiniListItem_t;
#line 205 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
typedef struct xLIST
{
  
   UBaseType_t uxNumberOfItems;
 ListItem_t *   pxIndex;
 MiniListItem_t xListEnd;
  
} List_t;
#line 386 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
void vListInitialise( List_t * const pxList )  ;
#line 397 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
void vListInitialiseItem( ListItem_t * const pxItem )  ;
#line 410 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
void vListInsert( List_t * const pxList, ListItem_t * const pxNewListItem )  ;
#line 431 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
void vListInsertEnd( List_t * const pxList, ListItem_t * const pxNewListItem )  ;
#line 446 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
UBaseType_t uxListRemove( ListItem_t * const pxItemToRemove )  ;
#line 103 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef void * TaskHandle_t;
#line 109 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef BaseType_t (*TaskHookFunction_t)( void * );


typedef enum
{
 eRunning = 0,
 eReady,
 eBlocked,
 eSuspended,
 eDeleted,
 eInvalid
} eTaskState;


typedef enum
{
 eNoAction = 0,
 eSetBits,
 eIncrement,
 eSetValueWithOverwrite,
 eSetValueWithoutOverwrite
} eNotifyAction;
#line 135 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef struct xTIME_OUT
{
 BaseType_t xOverflowCount;
 TickType_t xTimeOnEntering;
} TimeOut_t;
#line 144 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef struct xMEMORY_REGION
{
 void *pvBaseAddress;
 uint32_t ulLengthInBytes;
 uint32_t ulParameters;
} MemoryRegion_t;
#line 154 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef struct xTASK_PARAMETERS
{
 TaskFunction_t pvTaskCode;
 const char * const pcName;
 uint16_t usStackDepth;
 void *pvParameters;
 UBaseType_t uxPriority;
 StackType_t *puxStackBuffer;
 MemoryRegion_t xRegions[  1  ];
} TaskParameters_t;
#line 167 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
typedef struct xTASK_STATUS
{
 TaskHandle_t xHandle;
 const char *pcTaskName;
 UBaseType_t xTaskNumber;
 eTaskState eCurrentState;
 UBaseType_t uxCurrentPriority;
 UBaseType_t uxBasePriority;
 uint32_t ulRunTimeCounter;
 StackType_t *pxStackBase;
 uint16_t usStackHighWaterMark;
} TaskStatus_t;


typedef enum
{
 eAbortSleep = 0,
 eStandardSleep,
 eNoTasksWaitingTimeout
} eSleepModeStatus;
#line 360 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
 BaseType_t xTaskCreate( TaskFunction_t pxTaskCode,
 const char * const pcName,
 const uint16_t usStackDepth,
 void * const pvParameters,
 UBaseType_t uxPriority,
 TaskHandle_t * const pxCreatedTask )  ;
#line 602 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskAllocateMPURegions( TaskHandle_t xTask, const MemoryRegion_t * const pxRegions )  ;
#line 643 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskDelete( TaskHandle_t xTaskToDelete )  ;
#line 695 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskDelay( const TickType_t xTicksToDelay )  ;
#line 754 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskDelayUntil( TickType_t * const pxPreviousWakeTime, const TickType_t xTimeIncrement )  ;
#line 779 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskAbortDelay( TaskHandle_t xTask )  ;
#line 826 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskPriorityGet( TaskHandle_t xTask )  ;
#line 834 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskPriorityGetFromISR( TaskHandle_t xTask )  ;
#line 852 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
eTaskState eTaskGetState( TaskHandle_t xTask )  ;
#line 908 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskGetInfo( TaskHandle_t xTask, TaskStatus_t *pxTaskStatus, BaseType_t xGetFreeStackSpace, eTaskState eState )  ;
#line 950 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskPrioritySet( TaskHandle_t xTask, UBaseType_t uxNewPriority )  ;
#line 1001 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskSuspend( TaskHandle_t xTaskToSuspend )  ;
#line 1050 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskResume( TaskHandle_t xTaskToResume )  ;
#line 1079 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume )  ;
#line 1112 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskStartScheduler( void )  ;
#line 1168 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskEndScheduler( void )  ;
#line 1219 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskSuspendAll( void )  ;
#line 1273 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskResumeAll( void )  ;
#line 1288 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TickType_t xTaskGetTickCount( void )  ;
#line 1304 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TickType_t xTaskGetTickCountFromISR( void )  ;
#line 1318 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskGetNumberOfTasks( void )  ;
#line 1331 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
char *pcTaskGetName( TaskHandle_t xTaskToQuery )  ;
#line 1347 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TaskHandle_t xTaskGetHandle( const char *pcNameToQuery )  ;
#line 1368 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskGetStackHighWaterMark( TaskHandle_t xTask )  ;
#line 1421 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskCallApplicationTaskHook( TaskHandle_t xTask, void *pvParameter )  ;
#line 1430 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TaskHandle_t xTaskGetIdleTaskHandle( void )  ;
#line 1529 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskGetSystemState( TaskStatus_t * const pxTaskStatusArray, const UBaseType_t uxArraySize, uint32_t * const pulTotalRunTime )  ;
#line 1576 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskList( char * pcWriteBuffer )  ;
#line 1630 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskGetRunTimeStats( char *pcWriteBuffer )  ;
#line 1711 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )  ;
#line 1802 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue, BaseType_t *pxHigherPriorityTaskWoken )  ;
#line 1879 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskNotifyWait( uint32_t ulBitsToClearOnEntry, uint32_t ulBitsToClearOnExit, uint32_t *pulNotificationValue, TickType_t xTicksToWait )  ;
#line 1980 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskNotifyGiveFromISR( TaskHandle_t xTaskToNotify, BaseType_t *pxHigherPriorityTaskWoken )  ;
#line 2049 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
uint32_t ulTaskNotifyTake( BaseType_t xClearCountOnExit, TickType_t xTicksToWait )  ;
#line 2065 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskNotifyStateClear( TaskHandle_t xTask );
#line 2086 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskIncrementTick( void )  ;
#line 2119 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskPlaceOnEventList( List_t * const pxEventList, const TickType_t xTicksToWait )  ;
void vTaskPlaceOnUnorderedEventList( List_t * pxEventList, const TickType_t xItemValue, const TickType_t xTicksToWait )  ;
#line 2133 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskPlaceOnEventListRestricted( List_t * const pxEventList, TickType_t xTicksToWait, const BaseType_t xWaitIndefinitely )  ;
#line 2159 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskRemoveFromEventList( const List_t * const pxEventList )  ;
BaseType_t xTaskRemoveFromUnorderedEventList( ListItem_t * pxEventListItem, const TickType_t xItemValue )  ;
#line 2170 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskSwitchContext( void )  ;
#line 2176 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TickType_t uxTaskResetEventItemValue( void )  ;
#line 2181 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
TaskHandle_t xTaskGetCurrentTaskHandle( void )  ;
#line 2186 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut )  ;
#line 2192 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut, TickType_t * const pxTicksToWait )  ;
#line 2198 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskMissedYield( void )  ;
#line 2204 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskGetSchedulerState( void )  ;
#line 2210 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskPriorityInherit( TaskHandle_t const pxMutexHolder )  ;
#line 2216 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
BaseType_t xTaskPriorityDisinherit( TaskHandle_t const pxMutexHolder )  ;
#line 2221 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
UBaseType_t uxTaskGetTaskNumber( TaskHandle_t xTask )  ;
#line 2227 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskSetTaskNumber( TaskHandle_t xTask, const UBaseType_t uxHandle )  ;
#line 2237 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void vTaskStepTick( const TickType_t xTicksToJump )  ;
#line 2253 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
eSleepModeStatus eTaskConfirmSleepModeStatus( void )  ;
#line 2259 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
void *pvTaskIncrementMutexHeldCount( void )  ;
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/list.h"
#line 86 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
typedef void * CoRoutineHandle_t;


typedef void (*crCOROUTINE_CODE)( CoRoutineHandle_t, UBaseType_t );

typedef struct corCoRoutineControlBlock
{
 crCOROUTINE_CODE pxCoRoutineFunction;
 ListItem_t xGenericListItem;
 ListItem_t xEventListItem;
 UBaseType_t uxPriority;
 UBaseType_t uxIndex;
 uint16_t uxState;
} CRCB_t;
#line 173 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
BaseType_t xCoRoutineCreate( crCOROUTINE_CODE pxCoRoutineCode, UBaseType_t uxPriority, UBaseType_t uxIndex );
#line 215 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
void vCoRoutineSchedule( void );
#line 747 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
void vCoRoutineAddToDelayedList( TickType_t xTicksToDelay, List_t *pxEventList );
#line 756 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/croutine.h"
BaseType_t xCoRoutineRemoveFromEventList( const List_t *pxEventList );
