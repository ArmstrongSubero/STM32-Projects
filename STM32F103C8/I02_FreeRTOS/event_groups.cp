#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
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
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/task.h"
#line 118 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
typedef void * TimerHandle_t;
#line 123 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
typedef void (*TimerCallbackFunction_t)( TimerHandle_t xTimer );
#line 129 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
typedef void (*PendedFunction_t)( void *, uint32_t );
#line 269 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
 TimerHandle_t xTimerCreate( const char * const pcTimerName,
 const TickType_t xTimerPeriodInTicks,
 const UBaseType_t uxAutoReload,
 void * const pvTimerID,
 TimerCallbackFunction_t pxCallbackFunction )  ;
#line 427 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
void *pvTimerGetTimerID( const TimerHandle_t xTimer )  ;
#line 448 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
void vTimerSetTimerID( TimerHandle_t xTimer, void *pvNewID )  ;
#line 485 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
BaseType_t xTimerIsTimerActive( TimerHandle_t xTimer )  ;
#line 493 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
TaskHandle_t xTimerGetTimerDaemonTaskHandle( void )  ;
#line 1228 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
BaseType_t xTimerPendFunctionCallFromISR( PendedFunction_t xFunctionToPend, void *pvParameter1, uint32_t ulParameter2, BaseType_t *pxHigherPriorityTaskWoken )  ;
#line 1262 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
BaseType_t xTimerPendFunctionCall( PendedFunction_t xFunctionToPend, void *pvParameter1, uint32_t ulParameter2, TickType_t xTicksToWait )  ;
#line 1273 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
const char * pcTimerGetName( TimerHandle_t xTimer )  ;
#line 1284 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
TickType_t xTimerGetPeriod( TimerHandle_t xTimer )  ;
#line 1299 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
TickType_t xTimerGetExpiryTime( TimerHandle_t xTimer )  ;
#line 1305 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
BaseType_t xTimerCreateTimerTask( void )  ;
BaseType_t xTimerGenericCommand( TimerHandle_t xTimer, const BaseType_t xCommandID, const TickType_t xOptionalValue, BaseType_t * const pxHigherPriorityTaskWoken, const TickType_t xTicksToWait )  ;
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/timers.h"
#line 123 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
typedef void * EventGroupHandle_t;
#line 133 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
typedef TickType_t EventBits_t;
#line 188 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
 EventGroupHandle_t xEventGroupCreate( void )  ;
#line 336 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToWaitFor, const BaseType_t xClearOnExit, const BaseType_t xWaitForAllBits, TickType_t xTicksToWait )  ;
#line 393 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )  ;
#line 526 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet )  ;
#line 730 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, const EventBits_t uxBitsToWaitFor, TickType_t xTicksToWait )  ;
#line 766 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup )  ;
#line 780 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/event_groups.h"
void vEventGroupDelete( EventGroupHandle_t xEventGroup )  ;


void vEventGroupSetBitsCallback( void *pvEventGroup, const uint32_t ulBitsToSet )  ;
void vEventGroupClearBitsCallback( void *pvEventGroup, const uint32_t ulBitsToClear )  ;
#line 105 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
typedef struct xEventGroupDefinition
{
 EventBits_t uxEventBits;
 List_t xTasksWaitingForBits;
#line 117 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
} EventGroup_t;
#line 129 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
static BaseType_t prvTestWaitCondition( const EventBits_t uxCurrentEventBits, const EventBits_t uxBitsToWaitFor, const BaseType_t xWaitForAllBits )  ;
#line 174 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 EventGroupHandle_t xEventGroupCreate( void )
 {
 EventGroup_t *pxEventBits;


 pxEventBits = ( EventGroup_t * ) pvPortMalloc( sizeof( EventGroup_t ) );

 if( pxEventBits !=  ((void *)0)  )
 {
 pxEventBits->uxEventBits = 0;
 vListInitialise( &( pxEventBits->xTasksWaitingForBits ) );
#line 195 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
  ;
 }
 else
 {
  ;
 }

 return ( EventGroupHandle_t ) pxEventBits;
 }




EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, const EventBits_t uxBitsToWaitFor, TickType_t xTicksToWait )
{
EventBits_t uxOriginalBitValue, uxReturn;
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
BaseType_t xAlreadyYielded;
BaseType_t xTimeoutOccurred =  ( ( BaseType_t ) 0 ) ;

  if( ( ( uxBitsToWaitFor & 0xff000000UL  ) == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( uxBitsToWaitFor != 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 223 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 vTaskSuspendAll();
 {
 uxOriginalBitValue = pxEventBits->uxEventBits;

 ( void ) xEventGroupSetBits( xEventGroup, uxBitsToSet );

 if( ( ( uxOriginalBitValue | uxBitsToSet ) & uxBitsToWaitFor ) == uxBitsToWaitFor )
 {

 uxReturn = ( uxOriginalBitValue | uxBitsToSet );
#line 236 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 pxEventBits->uxEventBits &= ~uxBitsToWaitFor;

 xTicksToWait = 0;
 }
 else
 {
 if( xTicksToWait != ( TickType_t ) 0 )
 {
  ;
#line 249 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor |  0x01000000UL  |  0x04000000UL  ), xTicksToWait );
#line 255 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = 0;
 }
 else
 {
#line 261 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = pxEventBits->uxEventBits;
 }
 }
 }
 xAlreadyYielded = xTaskResumeAll();

 if( xTicksToWait != ( TickType_t ) 0 )
 {
 if( xAlreadyYielded ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
#line 282 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = uxTaskResetEventItemValue();

 if( ( uxReturn &  0x02000000UL  ) == ( EventBits_t ) 0 )
 {

  vPortEnterCritical() ;
 {
 uxReturn = pxEventBits->uxEventBits;
#line 295 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 if( ( uxReturn & uxBitsToWaitFor ) == uxBitsToWaitFor )
 {
 pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
 }
 else
 {
  ;
 }
 }
  vPortExitCritical() ;

 xTimeoutOccurred =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {

 }
#line 315 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn &= ~ 0xff000000UL ;
 }

  ( void ) xTimeoutOccurred ;

 return uxReturn;
}


EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToWaitFor, const BaseType_t xClearOnExit, const BaseType_t xWaitForAllBits, TickType_t xTicksToWait )
{
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
EventBits_t uxReturn, uxControlBits = 0;
BaseType_t xWaitConditionMet, xAlreadyYielded;
BaseType_t xTimeoutOccurred =  ( ( BaseType_t ) 0 ) ;
#line 333 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
  if( ( xEventGroup ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( ( uxBitsToWaitFor & 0xff000000UL  ) == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( uxBitsToWaitFor != 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 342 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 vTaskSuspendAll();
 {
 const EventBits_t uxCurrentEventBits = pxEventBits->uxEventBits;


 xWaitConditionMet = prvTestWaitCondition( uxCurrentEventBits, uxBitsToWaitFor, xWaitForAllBits );

 if( xWaitConditionMet !=  ( ( BaseType_t ) 0 )  )
 {
#line 353 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = uxCurrentEventBits;
 xTicksToWait = ( TickType_t ) 0;


 if( xClearOnExit !=  ( ( BaseType_t ) 0 )  )
 {
 pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
 }
 else
 {
  ;
 }
 }
 else if( xTicksToWait == ( TickType_t ) 0 )
 {
#line 370 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = uxCurrentEventBits;
 }
 else
 {
#line 378 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 if( xClearOnExit !=  ( ( BaseType_t ) 0 )  )
 {
 uxControlBits |=  0x01000000UL ;
 }
 else
 {
  ;
 }

 if( xWaitForAllBits !=  ( ( BaseType_t ) 0 )  )
 {
 uxControlBits |=  0x04000000UL ;
 }
 else
 {
  ;
 }
#line 399 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 vTaskPlaceOnUnorderedEventList( &( pxEventBits->xTasksWaitingForBits ), ( uxBitsToWaitFor | uxControlBits ), xTicksToWait );
#line 404 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = 0;

  ;
 }
 }
 xAlreadyYielded = xTaskResumeAll();

 if( xTicksToWait != ( TickType_t ) 0 )
 {
 if( xAlreadyYielded ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
#line 426 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = uxTaskResetEventItemValue();

 if( ( uxReturn &  0x02000000UL  ) == ( EventBits_t ) 0 )
 {
  vPortEnterCritical() ;
 {

 uxReturn = pxEventBits->uxEventBits;
#line 437 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 if( prvTestWaitCondition( uxReturn, uxBitsToWaitFor, xWaitForAllBits ) !=  ( ( BaseType_t ) 0 )  )
 {
 if( xClearOnExit !=  ( ( BaseType_t ) 0 )  )
 {
 pxEventBits->uxEventBits &= ~uxBitsToWaitFor;
 }
 else
 {
  ;
 }
 }
 else
 {
  ;
 }
 }
  vPortExitCritical() ;


 xTimeoutOccurred =  ( ( BaseType_t ) 0 ) ;
 }
 else
 {

 }


 uxReturn &= ~ 0xff000000UL ;
 }
  ( void ) xTimeoutOccurred ;

 return uxReturn;
}


EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )
{
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
EventBits_t uxReturn;
#line 479 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
  if( ( xEventGroup ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( ( uxBitsToClear & 0xff000000UL  ) == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  vPortEnterCritical() ;
 {
  ;
#line 488 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 uxReturn = pxEventBits->uxEventBits;


 pxEventBits->uxEventBits &= ~uxBitsToClear;
 }
  vPortExitCritical() ;

 return uxReturn;
}
#line 514 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup )
{
UBaseType_t uxSavedInterruptStatus;
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
EventBits_t uxReturn;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 uxReturn = pxEventBits->uxEventBits;
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return uxReturn;
}


EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet )
{
ListItem_t *pxListItem, *pxNext;
ListItem_t const *pxListEnd;
List_t *pxList;
EventBits_t uxBitsToClear = 0, uxBitsWaitedFor, uxControlBits;
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
BaseType_t xMatchFound =  ( ( BaseType_t ) 0 ) ;
#line 541 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
  if( ( xEventGroup ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( ( uxBitsToSet & 0xff000000UL  ) == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 pxList = &( pxEventBits->xTasksWaitingForBits );
 pxListEnd =  ( ( ListItem_t const * ) ( &( ( pxList )->xListEnd ) ) ) ;
 vTaskSuspendAll();
 {
  ;

 pxListItem =  ( ( ( pxList )->xListEnd ).pxNext ) ;


 pxEventBits->uxEventBits |= uxBitsToSet;


 while( pxListItem != pxListEnd )
 {
 pxNext =  ( ( pxListItem )->pxNext ) ;
 uxBitsWaitedFor =  ( ( pxListItem )->xItemValue ) ;
 xMatchFound =  ( ( BaseType_t ) 0 ) ;


 uxControlBits = uxBitsWaitedFor &  0xff000000UL ;
 uxBitsWaitedFor &= ~ 0xff000000UL ;

 if( ( uxControlBits &  0x04000000UL  ) == ( EventBits_t ) 0 )
 {

 if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) != ( EventBits_t ) 0 )
 {
 xMatchFound =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }
 else if( ( uxBitsWaitedFor & pxEventBits->uxEventBits ) == uxBitsWaitedFor )
 {

 xMatchFound =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {

 }

 if( xMatchFound !=  ( ( BaseType_t ) 0 )  )
 {

 if( ( uxControlBits &  0x01000000UL  ) != ( EventBits_t ) 0 )
 {
 uxBitsToClear |= uxBitsWaitedFor;
 }
 else
 {
  ;
 }
#line 605 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 ( void ) xTaskRemoveFromUnorderedEventList( pxListItem, pxEventBits->uxEventBits |  0x02000000UL  );
 }
#line 611 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 pxListItem = pxNext;
 }
#line 616 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 pxEventBits->uxEventBits &= ~uxBitsToClear;
 }
 ( void ) xTaskResumeAll();

 return pxEventBits->uxEventBits;
}


void vEventGroupDelete( EventGroupHandle_t xEventGroup )
{
EventGroup_t *pxEventBits = ( EventGroup_t * ) xEventGroup;
const List_t *pxTasksWaitingForBits = &( pxEventBits->xTasksWaitingForBits );

 vTaskSuspendAll();
 {
  ;

 while(  ( ( pxTasksWaitingForBits )->uxNumberOfItems )  > ( UBaseType_t ) 0 )
 {
#line 637 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
  if( ( pxTasksWaitingForBits->xListEnd.pxNext != ( ListItem_t * ) &( pxTasksWaitingForBits->xListEnd ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 ( void ) xTaskRemoveFromUnorderedEventList( pxTasksWaitingForBits->xListEnd.pxNext,  0x02000000UL  );
 }


 {
#line 645 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 vPortFree( pxEventBits );
 }
#line 661 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 }
 ( void ) xTaskResumeAll();
}
#line 668 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
void vEventGroupSetBitsCallback( void *pvEventGroup, const uint32_t ulBitsToSet )
{
 ( void ) xEventGroupSetBits( pvEventGroup, ( EventBits_t ) ulBitsToSet );
}
#line 676 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
void vEventGroupClearBitsCallback( void *pvEventGroup, const uint32_t ulBitsToClear )
{
 ( void ) xEventGroupClearBits( pvEventGroup, ( EventBits_t ) ulBitsToClear );
}


static BaseType_t prvTestWaitCondition( const EventBits_t uxCurrentEventBits, const EventBits_t uxBitsToWaitFor, const BaseType_t xWaitForAllBits )
{
BaseType_t xWaitConditionMet =  ( ( BaseType_t ) 0 ) ;

 if( xWaitForAllBits ==  ( ( BaseType_t ) 0 )  )
 {
#line 690 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 if( ( uxCurrentEventBits & uxBitsToWaitFor ) != ( EventBits_t ) 0 )
 {
 xWaitConditionMet =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }
 else
 {
#line 703 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/event_groups.c"
 if( ( uxCurrentEventBits & uxBitsToWaitFor ) == uxBitsToWaitFor )
 {
 xWaitConditionMet =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }

 return xWaitConditionMet;
}
