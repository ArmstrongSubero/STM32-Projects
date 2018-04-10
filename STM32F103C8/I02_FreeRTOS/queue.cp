#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
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
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
#line 88 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
typedef void * QueueHandle_t;
#line 95 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
typedef void * QueueSetHandle_t;
#line 102 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
typedef void * QueueSetMemberHandle_t;
#line 692 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )  ;
#line 821 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue, void * const pvBuffer )  ;
#line 1013 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueGenericReceive( QueueHandle_t xQueue, void * const pvBuffer, TickType_t xTicksToWait, const BaseType_t xJustPeek )  ;
#line 1028 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )  ;
#line 1045 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue )  ;
#line 1059 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
void vQueueDelete( QueueHandle_t xQueue )  ;
#line 1440 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )  ;
BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue, BaseType_t * const pxHigherPriorityTaskWoken )  ;
#line 1530 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void * const pvBuffer, BaseType_t * const pxHigherPriorityTaskWoken )  ;
#line 1536 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue )  ;
BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue )  ;
UBaseType_t uxQueueMessagesWaitingFromISR( const QueueHandle_t xQueue )  ;
#line 1549 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueCRSendFromISR( QueueHandle_t xQueue, const void *pvItemToQueue, BaseType_t xCoRoutinePreviouslyWoken );
BaseType_t xQueueCRReceiveFromISR( QueueHandle_t xQueue, void *pvBuffer, BaseType_t *pxTaskWoken );
BaseType_t xQueueCRSend( QueueHandle_t xQueue, const void *pvItemToQueue, TickType_t xTicksToWait );
BaseType_t xQueueCRReceive( QueueHandle_t xQueue, void *pvBuffer, TickType_t xTicksToWait );
#line 1559 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )  ;
QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType, StaticQueue_t *pxStaticQueue )  ;
QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount )  ;
QueueHandle_t xQueueCreateCountingSemaphoreStatic( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount, StaticQueue_t *pxStaticQueue )  ;
void* xQueueGetMutexHolder( QueueHandle_t xSemaphore )  ;
#line 1569 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex, TickType_t xTicksToWait )  ;
BaseType_t xQueueGiveMutexRecursive( QueueHandle_t pxMutex )  ;
#line 1639 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
 QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType )  ;
#line 1699 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
QueueSetHandle_t xQueueCreateSet( const UBaseType_t uxEventQueueLength )  ;
#line 1723 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueAddToSet( QueueSetMemberHandle_t xQueueOrSemaphore, QueueSetHandle_t xQueueSet )  ;
#line 1742 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
BaseType_t xQueueRemoveFromSet( QueueSetMemberHandle_t xQueueOrSemaphore, QueueSetHandle_t xQueueSet )  ;
#line 1778 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
QueueSetMemberHandle_t xQueueSelectFromSet( QueueSetHandle_t xQueueSet, const TickType_t xTicksToWait )  ;
#line 1783 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/queue.h"
QueueSetMemberHandle_t xQueueSelectFromSetFromISR( QueueSetHandle_t xQueueSet )  ;


void vQueueWaitForMessageRestricted( QueueHandle_t xQueue, TickType_t xTicksToWait, const BaseType_t xWaitIndefinitely )  ;
BaseType_t xQueueGenericReset( QueueHandle_t xQueue, BaseType_t xNewQueue )  ;
void vQueueSetQueueNumber( QueueHandle_t xQueue, UBaseType_t uxQueueNumber )  ;
UBaseType_t uxQueueGetQueueNumber( QueueHandle_t xQueue )  ;
uint8_t ucQueueGetQueueType( QueueHandle_t xQueue )  ;
#line 130 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
typedef struct QueueDefinition
{
 int8_t *pcHead;
 int8_t *pcTail;
 int8_t *pcWriteTo;

 union
 {
 int8_t *pcReadFrom;
 UBaseType_t uxRecursiveCallCount;
 } u;

 List_t xTasksWaitingToSend;
 List_t xTasksWaitingToReceive;

 volatile UBaseType_t uxMessagesWaiting;
 UBaseType_t uxLength;
 UBaseType_t uxItemSize;

 volatile int8_t cRxLock;
 volatile int8_t cTxLock;
#line 165 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
} xQUEUE;
#line 169 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
typedef xQUEUE Queue_t;
#line 208 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static void prvUnlockQueue( Queue_t * const pxQueue )  ;
#line 215 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static BaseType_t prvIsQueueEmpty( const Queue_t *pxQueue )  ;
#line 222 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static BaseType_t prvIsQueueFull( const Queue_t *pxQueue )  ;
#line 228 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static BaseType_t prvCopyDataToQueue( Queue_t * const pxQueue, const void *pvItemToQueue, const BaseType_t xPosition )  ;
#line 233 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static void prvCopyDataFromQueue( Queue_t * const pxQueue, void * const pvBuffer )  ;
#line 247 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static void prvInitialiseNewQueue( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t *pucQueueStorage, const uint8_t ucQueueType, Queue_t *pxNewQueue )  ;
#line 255 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 static void prvInitialiseMutex( Queue_t *pxNewQueue )  ;
#line 279 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
BaseType_t xQueueGenericReset( QueueHandle_t xQueue, BaseType_t xNewQueue )
{
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  vPortEnterCritical() ;
 {
 pxQueue->pcTail = pxQueue->pcHead + ( pxQueue->uxLength * pxQueue->uxItemSize );
 pxQueue->uxMessagesWaiting = ( UBaseType_t ) 0U;
 pxQueue->pcWriteTo = pxQueue->pcHead;
 pxQueue->u.pcReadFrom = pxQueue->pcHead + ( ( pxQueue->uxLength - ( UBaseType_t ) 1U ) * pxQueue->uxItemSize );
 pxQueue->cRxLock =  ( ( int8_t ) -1 ) ;
 pxQueue->cTxLock =  ( ( int8_t ) -1 ) ;

 if( xNewQueue ==  ( ( BaseType_t ) 0 )  )
 {
#line 301 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToSend ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) !=  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
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
 else
 {

 vListInitialise( &( pxQueue->xTasksWaitingToSend ) );
 vListInitialise( &( pxQueue->xTasksWaitingToReceive ) );
 }
 }
  vPortExitCritical() ;
#line 328 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 return  ( ( ( BaseType_t ) 1 )  ) ;
}
#line 386 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType )
 {
 Queue_t *pxNewQueue;
 size_t xQueueSizeInBytes;
 uint8_t *pucQueueStorage;

  if( ( uxQueueLength > ( UBaseType_t ) 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 if( uxItemSize == ( UBaseType_t ) 0 )
 {

 xQueueSizeInBytes = ( size_t ) 0;
 }
 else
 {
#line 403 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 xQueueSizeInBytes = ( size_t ) ( uxQueueLength * uxItemSize );
 }

 pxNewQueue = ( Queue_t * ) pvPortMalloc( sizeof( Queue_t ) + xQueueSizeInBytes );

 if( pxNewQueue !=  ((void *)0)  )
 {
#line 412 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pucQueueStorage = ( ( uint8_t * ) pxNewQueue ) + sizeof( Queue_t );
#line 423 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 prvInitialiseNewQueue( uxQueueLength, uxItemSize, pucQueueStorage, ucQueueType, pxNewQueue );
 }

 return pxNewQueue;
 }




static void prvInitialiseNewQueue( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t *pucQueueStorage, const uint8_t ucQueueType, Queue_t *pxNewQueue )
{
#line 436 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 ( void ) ucQueueType;

 if( uxItemSize == ( UBaseType_t ) 0 )
 {
#line 444 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxNewQueue->pcHead = ( int8_t * ) pxNewQueue;
 }
 else
 {

 pxNewQueue->pcHead = ( int8_t * ) pucQueueStorage;
 }
#line 454 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxNewQueue->uxLength = uxQueueLength;
 pxNewQueue->uxItemSize = uxItemSize;
 ( void ) xQueueGenericReset( pxNewQueue,  ( ( BaseType_t ) 1 )  );
#line 470 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  ;
}




 static void prvInitialiseMutex( Queue_t *pxNewQueue )
 {
 if( pxNewQueue !=  ((void *)0)  )
 {
#line 484 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxNewQueue-> pcTail  =  ((void *)0) ;
 pxNewQueue-> pcHead  =  ((void *)0) ;


 pxNewQueue->u.uxRecursiveCallCount = 0;

  ;


 ( void ) xQueueGenericSend( pxNewQueue,  ((void *)0) , ( TickType_t ) 0U,  ( ( BaseType_t ) 0 )  );
 }
 else
 {
  ;
 }
 }






 QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )
 {
 Queue_t *pxNewQueue;
 const UBaseType_t uxMutexLength = ( UBaseType_t ) 1, uxMutexSize = ( UBaseType_t ) 0;

 pxNewQueue = ( Queue_t * ) xQueueGenericCreate( uxMutexLength, uxMutexSize, ucQueueType );
 prvInitialiseMutex( pxNewQueue );

 return pxNewQueue;
 }
#line 572 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex )
 {
 BaseType_t xReturn;
 Queue_t * const pxMutex = ( Queue_t * ) xMutex;

  if( ( pxMutex ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 585 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( pxMutex-> pcTail  == ( void * ) xTaskGetCurrentTaskHandle() )
 {
  ;
#line 594 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 ( pxMutex->u.uxRecursiveCallCount )--;


 if( pxMutex->u.uxRecursiveCallCount == ( UBaseType_t ) 0 )
 {
#line 601 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 ( void ) xQueueGenericSend( pxMutex,  ((void *)0) ,  ( ( TickType_t ) 0U ) ,  ( ( BaseType_t ) 0 )  );
 }
 else
 {
  ;
 }

 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
#line 614 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;

  ;
 }

 return xReturn;
 }






 BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex, TickType_t xTicksToWait )
 {
 BaseType_t xReturn;
 Queue_t * const pxMutex = ( Queue_t * ) xMutex;

  if( ( pxMutex ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 637 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  ;

 if( pxMutex-> pcTail  == ( void * ) xTaskGetCurrentTaskHandle() )
 {
 ( pxMutex->u.uxRecursiveCallCount )++;
 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 xReturn = xQueueGenericReceive( pxMutex,  ((void *)0) , xTicksToWait,  ( ( BaseType_t ) 0 )  );
#line 651 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( xReturn !=  ( ( ( BaseType_t ) 0 )  )  )
 {
 ( pxMutex->u.uxRecursiveCallCount )++;
 }
 else
 {
  ;
 }
 }

 return xReturn;
 }
#line 697 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount )
 {
 QueueHandle_t xHandle;

  if( ( uxMaxCount != 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( uxInitialCount <= uxMaxCount ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 xHandle = xQueueGenericCreate( uxMaxCount,  ( ( UBaseType_t ) 0 ) ,  ( ( uint8_t ) 2U )  );

 if( xHandle !=  ((void *)0)  )
 {
 ( ( Queue_t * ) xHandle )->uxMessagesWaiting = uxInitialCount;

  ;
 }
 else
 {
  ;
 }

 return xHandle;
 }




BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )
{
BaseType_t xEntryTimeSet =  ( ( BaseType_t ) 0 ) , xYieldRequired;
TimeOut_t xTimeOut;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( pvItemToQueue == ((void *)0)  ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( xCopyPosition == ( ( BaseType_t ) 2 )  ) && ( pxQueue->uxLength != 1 ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 742 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 for( ;; )
 {
  vPortEnterCritical() ;
 {
#line 750 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition ==  ( ( BaseType_t ) 2 )  ) )
 {
  ;
 xYieldRequired = prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
#line 805 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 {
#line 808 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToReceive ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) !=  ( ( BaseType_t ) 0 )  )
 {
#line 816 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
 else if( xYieldRequired !=  ( ( BaseType_t ) 0 )  )
 {
#line 829 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }


  vPortExitCritical() ;
 return  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 if( xTicksToWait == ( TickType_t ) 0 )
 {
#line 847 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortExitCritical() ;
#line 851 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  ;
 return  ( ( BaseType_t ) 0 ) ;
 }
 else if( xEntryTimeSet ==  ( ( BaseType_t ) 0 )  )
 {
#line 858 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vTaskSetTimeOutState( &xTimeOut );
 xEntryTimeSet =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {

  ;
 }
 }
 }
  vPortExitCritical() ;
#line 873 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vTaskSuspendAll();
  vPortEnterCritical() ; { if( ( pxQueue )->cRxLock == ( ( int8_t ) -1 )  ) { ( pxQueue )->cRxLock = ( ( int8_t ) 0 ) ; } if( ( pxQueue )->cTxLock == ( ( int8_t ) -1 )  ) { ( pxQueue )->cTxLock = ( ( int8_t ) 0 ) ; } } vPortExitCritical() ;


 if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) ==  ( ( BaseType_t ) 0 )  )
 {
 if( prvIsQueueFull( pxQueue ) !=  ( ( BaseType_t ) 0 )  )
 {
  ;
 vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToSend ), xTicksToWait );
#line 889 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 prvUnlockQueue( pxQueue );
#line 896 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( xTaskResumeAll() ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 }
 else
 {

 prvUnlockQueue( pxQueue );
 ( void ) xTaskResumeAll();
 }
 }
 else
 {

 prvUnlockQueue( pxQueue );
 ( void ) xTaskResumeAll();

  ;
 return  ( ( BaseType_t ) 0 ) ;
 }
 }
}


BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )
{
BaseType_t xReturn;
UBaseType_t uxSavedInterruptStatus;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( pvItemToQueue == ((void *)0)  ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( xCopyPosition == ( ( BaseType_t ) 2 )  ) && ( pxQueue->uxLength != 1 ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 945 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortValidateInterruptPriority() ;
#line 952 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 if( ( pxQueue->uxMessagesWaiting < pxQueue->uxLength ) || ( xCopyPosition ==  ( ( BaseType_t ) 2 )  ) )
 {
 const int8_t cTxLock = pxQueue->cTxLock;

  ;
#line 965 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 ( void ) prvCopyDataToQueue( pxQueue, pvItemToQueue, xCopyPosition );
#line 969 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( cTxLock ==  ( ( int8_t ) -1 )  )
 {
#line 1023 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 {
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToReceive ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) !=  ( ( BaseType_t ) 0 )  )
 {
#line 1030 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( pxHigherPriorityTaskWoken !=  ((void *)0)  )
 {
 *pxHigherPriorityTaskWoken =  ( ( BaseType_t ) 1 ) ;
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
 else
 {
  ;
 }
 }

 }
 else
 {
#line 1055 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue->cTxLock = ( int8_t ) ( cTxLock + 1 );
 }

 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
  ;
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xReturn;
}


BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue, BaseType_t * const pxHigherPriorityTaskWoken )
{
BaseType_t xReturn;
UBaseType_t uxSavedInterruptStatus;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;
#line 1084 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1088 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  if( ( pxQueue->uxItemSize == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1093 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  if( ( !( ( pxQueue-> pcHead  == ((void *)0)  ) && ( pxQueue-> pcTail  != ((void *)0)  ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1109 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
#line 1118 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( uxMessagesWaiting < pxQueue->uxLength )
 {
 const int8_t cTxLock = pxQueue->cTxLock;

  ;
#line 1130 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue->uxMessagesWaiting = uxMessagesWaiting + 1;
#line 1134 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( cTxLock ==  ( ( int8_t ) -1 )  )
 {
#line 1188 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 {
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToReceive ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) !=  ( ( BaseType_t ) 0 )  )
 {
#line 1195 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( pxHigherPriorityTaskWoken !=  ((void *)0)  )
 {
 *pxHigherPriorityTaskWoken =  ( ( BaseType_t ) 1 ) ;
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
 else
 {
  ;
 }
 }

 }
 else
 {
#line 1220 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue->cTxLock = ( int8_t ) ( cTxLock + 1 );
 }

 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
  ;
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xReturn;
}


BaseType_t xQueueGenericReceive( QueueHandle_t xQueue, void * const pvBuffer, TickType_t xTicksToWait, const BaseType_t xJustPeeking )
{
BaseType_t xEntryTimeSet =  ( ( BaseType_t ) 0 ) ;
TimeOut_t xTimeOut;
int8_t *pcOriginalReadPosition;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( pvBuffer == ((void *)0)  ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1256 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 for( ;; )
 {
  vPortEnterCritical() ;
 {
 const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;
#line 1264 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( uxMessagesWaiting > ( UBaseType_t ) 0 )
 {
#line 1268 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pcOriginalReadPosition = pxQueue->u.pcReadFrom;

 prvCopyDataFromQueue( pxQueue, pvBuffer );

 if( xJustPeeking ==  ( ( BaseType_t ) 0 )  )
 {
  ;


 pxQueue->uxMessagesWaiting = uxMessagesWaiting - 1;


 {
 if( pxQueue-> pcHead  ==  ((void *)0)  )
 {
#line 1285 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue-> pcTail  = ( int8_t * ) pvTaskIncrementMutexHeldCount();
 }
 else
 {
  ;
 }
 }


 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToSend ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) !=  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
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
 else
 {
  ;
#line 1316 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue->u.pcReadFrom = pcOriginalReadPosition;
#line 1320 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToReceive ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) !=  ( ( BaseType_t ) 0 )  )
 {

  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
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
 return  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 if( xTicksToWait == ( TickType_t ) 0 )
 {
#line 1347 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortExitCritical() ;
  ;
 return  ( ( BaseType_t ) 0 ) ;
 }
 else if( xEntryTimeSet ==  ( ( BaseType_t ) 0 )  )
 {
#line 1355 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vTaskSetTimeOutState( &xTimeOut );
 xEntryTimeSet =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {

  ;
 }
 }
 }
  vPortExitCritical() ;
#line 1370 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vTaskSuspendAll();
  vPortEnterCritical() ; { if( ( pxQueue )->cRxLock == ( ( int8_t ) -1 )  ) { ( pxQueue )->cRxLock = ( ( int8_t ) 0 ) ; } if( ( pxQueue )->cTxLock == ( ( int8_t ) -1 )  ) { ( pxQueue )->cTxLock = ( ( int8_t ) 0 ) ; } } vPortExitCritical() ;


 if( xTaskCheckForTimeOut( &xTimeOut, &xTicksToWait ) ==  ( ( BaseType_t ) 0 )  )
 {
 if( prvIsQueueEmpty( pxQueue ) !=  ( ( BaseType_t ) 0 )  )
 {
  ;


 {
 if( pxQueue-> pcHead  ==  ((void *)0)  )
 {
  vPortEnterCritical() ;
 {
 vTaskPriorityInherit( ( void * ) pxQueue-> pcTail  );
 }
  vPortExitCritical() ;
 }
 else
 {
  ;
 }
 }


 vTaskPlaceOnEventList( &( pxQueue->xTasksWaitingToReceive ), xTicksToWait );
 prvUnlockQueue( pxQueue );
 if( xTaskResumeAll() ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
 else
 {

 prvUnlockQueue( pxQueue );
 ( void ) xTaskResumeAll();
 }
 }
 else
 {
 prvUnlockQueue( pxQueue );
 ( void ) xTaskResumeAll();

 if( prvIsQueueEmpty( pxQueue ) !=  ( ( BaseType_t ) 0 )  )
 {
  ;
 return  ( ( BaseType_t ) 0 ) ;
 }
 else
 {
  ;
 }
 }
 }
}


BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void * const pvBuffer, BaseType_t * const pxHigherPriorityTaskWoken )
{
BaseType_t xReturn;
UBaseType_t uxSavedInterruptStatus;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( pvBuffer == ((void *)0)  ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1457 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 const UBaseType_t uxMessagesWaiting = pxQueue->uxMessagesWaiting;


 if( uxMessagesWaiting > ( UBaseType_t ) 0 )
 {
 const int8_t cRxLock = pxQueue->cRxLock;

  ;

 prvCopyDataFromQueue( pxQueue, pvBuffer );
 pxQueue->uxMessagesWaiting = uxMessagesWaiting - 1;
#line 1477 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( cRxLock ==  ( ( int8_t ) -1 )  )
 {
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToSend ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) !=  ( ( BaseType_t ) 0 )  )
 {
#line 1485 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if( pxHigherPriorityTaskWoken !=  ((void *)0)  )
 {
 *pxHigherPriorityTaskWoken =  ( ( BaseType_t ) 1 ) ;
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
 else
 {
  ;
 }
 }
 else
 {
#line 1508 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pxQueue->cRxLock = ( int8_t ) ( cRxLock + 1 );
 }

 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;
  ;
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xReturn;
}


BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue, void * const pvBuffer )
{
BaseType_t xReturn;
UBaseType_t uxSavedInterruptStatus;
int8_t *pcOriginalReadPosition;
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( !( ( pvBuffer == ((void *)0)  ) && ( pxQueue->uxItemSize != ( UBaseType_t ) 0U ) ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( pxQueue->uxItemSize != 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1550 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {

 if( pxQueue->uxMessagesWaiting > ( UBaseType_t ) 0 )
 {
  ;
#line 1561 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 pcOriginalReadPosition = pxQueue->u.pcReadFrom;
 prvCopyDataFromQueue( pxQueue, pvBuffer );
 pxQueue->u.pcReadFrom = pcOriginalReadPosition;

 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;
  ;
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xReturn;
}


UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )
{
UBaseType_t uxReturn;

  if( ( xQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  vPortEnterCritical() ;
 {
 uxReturn = ( ( Queue_t * ) xQueue )->uxMessagesWaiting;
 }
  vPortExitCritical() ;

 return uxReturn;
}


UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue )
{
UBaseType_t uxReturn;
Queue_t *pxQueue;

 pxQueue = ( Queue_t * ) xQueue;
  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  vPortEnterCritical() ;
 {
 uxReturn = pxQueue->uxLength - pxQueue->uxMessagesWaiting;
 }
  vPortExitCritical() ;

 return uxReturn;
}


UBaseType_t uxQueueMessagesWaitingFromISR( const QueueHandle_t xQueue )
{
UBaseType_t uxReturn;

  if( ( xQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 uxReturn = ( ( Queue_t * ) xQueue )->uxMessagesWaiting;

 return uxReturn;
}


void vQueueDelete( QueueHandle_t xQueue )
{
Queue_t * const pxQueue = ( Queue_t * ) xQueue;

  if( ( pxQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  ;
#line 1639 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 {
#line 1642 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vPortFree( pxQueue );
 }
#line 1664 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
}
#line 1697 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
static BaseType_t prvCopyDataToQueue( Queue_t * const pxQueue, const void *pvItemToQueue, const BaseType_t xPosition )
{
BaseType_t xReturn =  ( ( BaseType_t ) 0 ) ;
UBaseType_t uxMessagesWaiting;



 uxMessagesWaiting = pxQueue->uxMessagesWaiting;

 if( pxQueue->uxItemSize == ( UBaseType_t ) 0 )
 {

 {
 if( pxQueue-> pcHead  ==  ((void *)0)  )
 {

 xReturn = xTaskPriorityDisinherit( ( void * ) pxQueue-> pcTail  );
 pxQueue-> pcTail  =  ((void *)0) ;
 }
 else
 {
  ;
 }
 }

 }
 else if( xPosition ==  ( ( BaseType_t ) 0 )  )
 {
 ( void ) memcpy( ( void * ) pxQueue->pcWriteTo, pvItemToQueue, ( size_t ) pxQueue->uxItemSize );
 pxQueue->pcWriteTo += pxQueue->uxItemSize;
 if( pxQueue->pcWriteTo >= pxQueue->pcTail )
 {
 pxQueue->pcWriteTo = pxQueue->pcHead;
 }
 else
 {
  ;
 }
 }
 else
 {
 ( void ) memcpy( ( void * ) pxQueue->u.pcReadFrom, pvItemToQueue, ( size_t ) pxQueue->uxItemSize );
 pxQueue->u.pcReadFrom -= pxQueue->uxItemSize;
 if( pxQueue->u.pcReadFrom < pxQueue->pcHead )
 {
 pxQueue->u.pcReadFrom = ( pxQueue->pcTail - pxQueue->uxItemSize );
 }
 else
 {
  ;
 }

 if( xPosition ==  ( ( BaseType_t ) 2 )  )
 {
 if( uxMessagesWaiting > ( UBaseType_t ) 0 )
 {
#line 1757 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 --uxMessagesWaiting;
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

 pxQueue->uxMessagesWaiting = uxMessagesWaiting + 1;

 return xReturn;
}


static void prvCopyDataFromQueue( Queue_t * const pxQueue, void * const pvBuffer )
{
 if( pxQueue->uxItemSize != ( UBaseType_t ) 0 )
 {
 pxQueue->u.pcReadFrom += pxQueue->uxItemSize;
 if( pxQueue->u.pcReadFrom >= pxQueue->pcTail )
 {
 pxQueue->u.pcReadFrom = pxQueue->pcHead;
 }
 else
 {
  ;
 }
 ( void ) memcpy( ( void * ) pvBuffer, ( void * ) pxQueue->u.pcReadFrom, ( size_t ) pxQueue->uxItemSize );
 }
}


static void prvUnlockQueue( Queue_t * const pxQueue )
{
#line 1802 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
  vPortEnterCritical() ;
 {
 int8_t cTxLock = pxQueue->cTxLock;


 while( cTxLock >  ( ( int8_t ) 0 )  )
 {
#line 1852 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 {
#line 1855 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToReceive ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToReceive ) ) !=  ( ( BaseType_t ) 0 )  )
 {
#line 1861 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/queue.c"
 vTaskMissedYield();
 }
 else
 {
  ;
 }
 }
 else
 {
 break;
 }
 }


 --cTxLock;
 }

 pxQueue->cTxLock =  ( ( int8_t ) -1 ) ;
 }
  vPortExitCritical() ;


  vPortEnterCritical() ;
 {
 int8_t cRxLock = pxQueue->cRxLock;

 while( cRxLock >  ( ( int8_t ) 0 )  )
 {
 if(  ( ( BaseType_t ) ( ( &( pxQueue->xTasksWaitingToSend ) )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 if( xTaskRemoveFromEventList( &( pxQueue->xTasksWaitingToSend ) ) !=  ( ( BaseType_t ) 0 )  )
 {
 vTaskMissedYield();
 }
 else
 {
  ;
 }

 --cRxLock;
 }
 else
 {
 break;
 }
 }

 pxQueue->cRxLock =  ( ( int8_t ) -1 ) ;
 }
  vPortExitCritical() ;
}


static BaseType_t prvIsQueueEmpty( const Queue_t *pxQueue )
{
BaseType_t xReturn;

  vPortEnterCritical() ;
 {
 if( pxQueue->uxMessagesWaiting == ( UBaseType_t ) 0 )
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 }
  vPortExitCritical() ;

 return xReturn;
}


BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue )
{
BaseType_t xReturn;

  if( ( xQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 if( ( ( Queue_t * ) xQueue )->uxMessagesWaiting == ( UBaseType_t ) 0 )
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }

 return xReturn;
}


static BaseType_t prvIsQueueFull( const Queue_t *pxQueue )
{
BaseType_t xReturn;

  vPortEnterCritical() ;
 {
 if( pxQueue->uxMessagesWaiting == pxQueue->uxLength )
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 }
  vPortExitCritical() ;

 return xReturn;
}


BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue )
{
BaseType_t xReturn;

  if( ( xQueue ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 if( ( ( Queue_t * ) xQueue )->uxMessagesWaiting == ( ( Queue_t * ) xQueue )->uxLength )
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }

 return xReturn;
}
