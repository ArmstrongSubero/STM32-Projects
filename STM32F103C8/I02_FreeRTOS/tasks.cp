#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
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
#line 1 "c:/users/armst/desktop/stm32f103c8t6/mikroc/i02_freertos/stackmacros.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 293 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
typedef struct tskTaskControlBlock
{
 volatile StackType_t *pxTopOfStack;
#line 301 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ListItem_t xStateListItem;
 ListItem_t xEventListItem;
 UBaseType_t uxPriority;
 StackType_t *pxStack;
 char pcTaskName[  (16)  ];
#line 321 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 UBaseType_t uxBasePriority;
 UBaseType_t uxMutexesHeld;
#line 349 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 volatile uint32_t ulNotifiedValue;
 volatile uint8_t ucNotifyState;
#line 363 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
} tskTCB;
#line 367 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
typedef tskTCB TCB_t;
#line 372 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  TCB_t * volatile pxCurrentTCB =  ((void *)0) ;


  static List_t pxReadyTasksLists[  (16)  ];
  static List_t xDelayedTaskList1;
  static List_t xDelayedTaskList2;
  static List_t * volatile pxDelayedTaskList;
  static List_t * volatile pxOverflowDelayedTaskList;
  static List_t xPendingReadyList;



   static List_t xTasksWaitingTermination;
   static volatile UBaseType_t uxDeletedTasksWaitingCleanUp = ( UBaseType_t ) 0U;





   static List_t xSuspendedTaskList;




  static volatile UBaseType_t uxCurrentNumberOfTasks = ( UBaseType_t ) 0U;
  static volatile TickType_t xTickCount = ( TickType_t ) 0U;
  static volatile UBaseType_t uxTopReadyPriority =  ( ( UBaseType_t ) 0U ) ;
  static volatile BaseType_t xSchedulerRunning =  ( ( BaseType_t ) 0 ) ;
  static volatile UBaseType_t uxPendedTicks = ( UBaseType_t ) 0U;
  static volatile BaseType_t xYieldPending =  ( ( BaseType_t ) 0 ) ;
  static volatile BaseType_t xNumOfOverflows = ( BaseType_t ) 0;
  static UBaseType_t uxTaskNumber = ( UBaseType_t ) 0U;
  static volatile TickType_t xNextTaskUnblockTime = ( TickType_t ) 0U;
  static TaskHandle_t xIdleTaskHandle =  ((void *)0) ;
#line 415 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  static volatile UBaseType_t uxSchedulerSuspended = ( UBaseType_t )  ( ( BaseType_t ) 0 ) ;
#line 449 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 static BaseType_t prvTaskIsTaskSuspended( const TaskHandle_t xTask )  ;
#line 456 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvInitialiseTaskLists( void )  ;
#line 469 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static  void prvIdleTask( void *pvParameters ) ;
#line 480 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 static void prvDeleteTCB( TCB_t *pxTCB )  ;
#line 489 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvCheckTasksWaitingTermination( void )  ;
#line 495 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvAddCurrentTaskToDelayedList( TickType_t xTicksToWait, const BaseType_t xCanBlockIndefinitely )  ;
#line 551 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvResetNextTaskUnblockTime( void );
#line 567 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvInitialiseNewTask( TaskFunction_t pxTaskCode,
 const char * const pcName,
 const uint32_t ulStackDepth,
 void * const pvParameters,
 UBaseType_t uxPriority,
 TaskHandle_t * const pxCreatedTask,
 TCB_t *pxNewTCB,
 const MemoryRegion_t * const xRegions )  ;
#line 580 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvAddNewTaskToReadyList( TCB_t *pxNewTCB )  ;
#line 676 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 BaseType_t xTaskCreate( TaskFunction_t pxTaskCode,
 const char * const pcName,
 const uint16_t usStackDepth,
 void * const pvParameters,
 UBaseType_t uxPriority,
 TaskHandle_t * const pxCreatedTask )
 {
 TCB_t *pxNewTCB;
 BaseType_t xReturn;
#line 712 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 StackType_t *pxStack;


 pxStack = ( StackType_t * ) pvPortMalloc( ( ( ( size_t ) usStackDepth ) * sizeof( StackType_t ) ) );

 if( pxStack !=  ((void *)0)  )
 {

 pxNewTCB = ( TCB_t * ) pvPortMalloc( sizeof( TCB_t ) );

 if( pxNewTCB !=  ((void *)0)  )
 {

 pxNewTCB->pxStack = pxStack;
 }
 else
 {
#line 732 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vPortFree( pxStack );
 }
 }
 else
 {
 pxNewTCB =  ((void *)0) ;
 }
 }


 if( pxNewTCB !=  ((void *)0)  )
 {
#line 752 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvInitialiseNewTask( pxTaskCode, pcName, ( uint32_t ) usStackDepth, pvParameters, uxPriority, pxCreatedTask, pxNewTCB,  ((void *)0)  );
 prvAddNewTaskToReadyList( pxNewTCB );
 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 xReturn =  ( -1 ) ;
 }

 return xReturn;
 }




static void prvInitialiseNewTask( TaskFunction_t pxTaskCode,
 const char * const pcName,
 const uint32_t ulStackDepth,
 void * const pvParameters,
 UBaseType_t uxPriority,
 TaskHandle_t * const pxCreatedTask,
 TCB_t *pxNewTCB,
 const MemoryRegion_t * const xRegions )
{
StackType_t *pxTopOfStack;
UBaseType_t x;
#line 806 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 pxTopOfStack = pxNewTCB->pxStack + ( ulStackDepth - ( uint32_t ) 1 );
 pxTopOfStack = ( StackType_t * ) ( ( (  uint32_t  ) pxTopOfStack ) & ( ~( (  uint32_t  )  ( 0x0007 )  ) ) );


  if( ( ( ( ( uint32_t  ) pxTopOfStack & ( uint32_t  ) ( 0x0007 )  ) == 0UL ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 }
#line 827 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 for( x = ( UBaseType_t ) 0; x < ( UBaseType_t )  (16) ; x++ )
 {
 pxNewTCB->pcTaskName[ x ] = pcName[ x ];
#line 834 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pcName[ x ] == 0x00 )
 {
 break;
 }
 else
 {
  ;
 }
 }
#line 846 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxNewTCB->pcTaskName[  (16)  - 1 ] = '\0';
#line 850 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxPriority >= ( UBaseType_t )  (16)  )
 {
 uxPriority = ( UBaseType_t )  (16)  - ( UBaseType_t ) 1U;
 }
 else
 {
  ;
 }

 pxNewTCB->uxPriority = uxPriority;

 {
 pxNewTCB->uxBasePriority = uxPriority;
 pxNewTCB->uxMutexesHeld = 0;
 }


 vListInitialiseItem( &( pxNewTCB->xStateListItem ) );
 vListInitialiseItem( &( pxNewTCB->xEventListItem ) );
#line 872 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ( ( &( pxNewTCB->xStateListItem ) )->pvOwner = ( void * ) ( pxNewTCB ) ) ;


  ( ( &( pxNewTCB->xEventListItem ) )->xItemValue = ( ( TickType_t ) (16)  - ( TickType_t ) uxPriority ) ) ;
  ( ( &( pxNewTCB->xEventListItem ) )->pvOwner = ( void * ) ( pxNewTCB ) ) ;
#line 901 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {

 ( void ) xRegions;
 }
#line 917 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 pxNewTCB->ulNotifiedValue = 0;
 pxNewTCB->ucNotifyState =  ( ( uint8_t ) 0 ) ;
 }
#line 945 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters );
 }


 if( ( void * ) pxCreatedTask !=  ((void *)0)  )
 {
#line 954 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 *pxCreatedTask = ( TaskHandle_t ) pxNewTCB;
 }
 else
 {
  ;
 }
}


static void prvAddNewTaskToReadyList( TCB_t *pxNewTCB )
{
#line 967 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortEnterCritical() ;
 {
 uxCurrentNumberOfTasks++;
 if( pxCurrentTCB ==  ((void *)0)  )
 {
#line 974 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxCurrentTCB = pxNewTCB;

 if( uxCurrentNumberOfTasks == ( UBaseType_t ) 1 )
 {
#line 981 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvInitialiseTaskLists();
 }
 else
 {
  ;
 }
 }
 else
 {
#line 993 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xSchedulerRunning ==  ( ( BaseType_t ) 0 )  )
 {
 if( pxCurrentTCB->uxPriority <= pxNewTCB->uxPriority )
 {
 pxCurrentTCB = pxNewTCB;
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

 uxTaskNumber++;
#line 1018 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;

  ; (uxTopReadyPriority) |= (1UL << (( pxNewTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxNewTCB )->uxPriority ] ), &( ( pxNewTCB )->xStateListItem ) ); ;

  ( void ) pxNewTCB ;
 }
  vPortExitCritical() ;

 if( xSchedulerRunning !=  ( ( BaseType_t ) 0 )  )
 {
#line 1030 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxCurrentTCB->uxPriority < pxNewTCB->uxPriority )
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




 void vTaskDelete( TaskHandle_t xTaskToDelete )
 {
 TCB_t *pxTCB;

  vPortEnterCritical() ;
 {
#line 1056 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTaskToDelete ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTaskToDelete ) ) ;


 if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
  { if( ( ( &( pxReadyTasksLists[ ( pxTCB->uxPriority ) ] ) )->uxNumberOfItems )  == ( UBaseType_t ) 0 ) { (( uxTopReadyPriority )) &= ~(1UL << (( pxTCB->uxPriority ))) ; } } ;
 }
 else
 {
  ;
 }


 if(  ( ( &( pxTCB->xEventListItem ) )->pvContainer )  !=  ((void *)0)  )
 {
 ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
 }
 else
 {
  ;
 }
#line 1082 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 uxTaskNumber++;

 if( pxTCB == pxCurrentTCB )
 {
#line 1091 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &xTasksWaitingTermination, &( pxTCB->xStateListItem ) );
#line 1096 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ++uxDeletedTasksWaitingCleanUp;
#line 1103 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;
 }
 else
 {
 --uxCurrentNumberOfTasks;
 prvDeleteTCB( pxTCB );
#line 1112 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvResetNextTaskUnblockTime();
 }

  ;
 }
  vPortExitCritical() ;
#line 1121 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xSchedulerRunning !=  ( ( BaseType_t ) 0 )  )
 {
 if( pxTCB == pxCurrentTCB )
 {
  if( ( uxSchedulerSuspended == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
 }






 void vTaskDelayUntil( TickType_t * const pxPreviousWakeTime, const TickType_t xTimeIncrement )
 {
 TickType_t xTimeToWake;
 BaseType_t xAlreadyYielded, xShouldDelay =  ( ( BaseType_t ) 0 ) ;

  if( ( pxPreviousWakeTime ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( ( xTimeIncrement > 0U ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( uxSchedulerSuspended == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 vTaskSuspendAll();
 {
#line 1153 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 const TickType_t xConstTickCount = xTickCount;


 xTimeToWake = *pxPreviousWakeTime + xTimeIncrement;

 if( xConstTickCount < *pxPreviousWakeTime )
 {
#line 1165 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ( xTimeToWake < *pxPreviousWakeTime ) && ( xTimeToWake > xConstTickCount ) )
 {
 xShouldDelay =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }
 else
 {
#line 1179 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ( xTimeToWake < *pxPreviousWakeTime ) || ( xTimeToWake > xConstTickCount ) )
 {
 xShouldDelay =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }


 *pxPreviousWakeTime = xTimeToWake;

 if( xShouldDelay !=  ( ( BaseType_t ) 0 )  )
 {
  ;
#line 1198 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvAddCurrentTaskToDelayedList( xTimeToWake - xConstTickCount,  ( ( BaseType_t ) 0 )  );
 }
 else
 {
  ;
 }
 }
 xAlreadyYielded = xTaskResumeAll();
#line 1209 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xAlreadyYielded ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }






 void vTaskDelay( const TickType_t xTicksToDelay )
 {
 BaseType_t xAlreadyYielded =  ( ( BaseType_t ) 0 ) ;


 if( xTicksToDelay > ( TickType_t ) 0U )
 {
  if( ( uxSchedulerSuspended == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 vTaskSuspendAll();
 {
  ;
#line 1243 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvAddCurrentTaskToDelayedList( xTicksToDelay,  ( ( BaseType_t ) 0 )  );
 }
 xAlreadyYielded = xTaskResumeAll();
 }
 else
 {
  ;
 }
#line 1254 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xAlreadyYielded ==  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
#line 1340 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 UBaseType_t uxTaskPriorityGet( TaskHandle_t xTask )
 {
 TCB_t *pxTCB;
 UBaseType_t uxReturn;

  vPortEnterCritical() ;
 {
#line 1349 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTask ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTask ) ) ;
 uxReturn = pxTCB->uxPriority;
 }
  vPortExitCritical() ;

 return uxReturn;
 }






 UBaseType_t uxTaskPriorityGetFromISR( TaskHandle_t xTask )
 {
 TCB_t *pxTCB;
 UBaseType_t uxReturn, uxSavedInterruptState;
#line 1383 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptState =  ulPortRaiseBASEPRI() ;
 {
#line 1389 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTask ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTask ) ) ;
 uxReturn = pxTCB->uxPriority;
 }
  vPortSetBASEPRI(uxSavedInterruptState) ;

 return uxReturn;
 }






 void vTaskPrioritySet( TaskHandle_t xTask, UBaseType_t uxNewPriority )
 {
 TCB_t *pxTCB;
 UBaseType_t uxCurrentBasePriority, uxPriorityUsedOnEntry;
 BaseType_t xYieldRequired =  ( ( BaseType_t ) 0 ) ;

  if( ( ( uxNewPriority < (16)  ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;


 if( uxNewPriority >= ( UBaseType_t )  (16)  )
 {
 uxNewPriority = ( UBaseType_t )  (16)  - ( UBaseType_t ) 1U;
 }
 else
 {
  ;
 }

  vPortEnterCritical() ;
 {
#line 1424 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTask ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTask ) ) ;

  ;


 {
 uxCurrentBasePriority = pxTCB->uxBasePriority;
 }
#line 1438 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxCurrentBasePriority != uxNewPriority )
 {
#line 1442 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxNewPriority > uxCurrentBasePriority )
 {
 if( pxTCB != pxCurrentTCB )
 {
#line 1449 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxNewPriority >= pxCurrentTCB->uxPriority )
 {
 xYieldRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }
 else
 {
#line 1463 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
 }
 else if( pxTCB == pxCurrentTCB )
 {
#line 1470 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
#line 1477 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
#line 1482 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 uxPriorityUsedOnEntry = pxTCB->uxPriority;


 {
#line 1488 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxBasePriority == pxTCB->uxPriority )
 {
 pxTCB->uxPriority = uxNewPriority;
 }
 else
 {
  ;
 }


 pxTCB->uxBasePriority = uxNewPriority;
 }
#line 1508 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( (  ( ( &( pxTCB->xEventListItem ) )->xItemValue )  &  0x80000000UL  ) == 0UL )
 {
  ( ( &( pxTCB->xEventListItem ) )->xItemValue = ( ( ( TickType_t ) (16)  - ( TickType_t ) uxNewPriority ) ) ) ;
 }
 else
 {
  ;
 }
#line 1521 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( BaseType_t ) ( ( &( pxTCB->xStateListItem ) )->pvContainer == ( void * ) ( &( pxReadyTasksLists[ uxPriorityUsedOnEntry ] ) ) ) )  !=  ( ( BaseType_t ) 0 )  )
 {
#line 1526 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
#line 1531 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  (uxTopReadyPriority) &= ~(1UL << (uxPriorityUsedOnEntry)) ;
 }
 else
 {
  ;
 }
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
 }
 else
 {
  ;
 }

 if( xYieldRequired !=  ( ( BaseType_t ) 0 )  )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
#line 1555 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( void ) uxPriorityUsedOnEntry;
 }
 }
  vPortExitCritical() ;
 }






 void vTaskSuspend( TaskHandle_t xTaskToSuspend )
 {
 TCB_t *pxTCB;

  vPortEnterCritical() ;
 {
#line 1574 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTaskToSuspend ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTaskToSuspend ) ) ;

  ;
#line 1580 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
  { if( ( ( &( pxReadyTasksLists[ ( pxTCB->uxPriority ) ] ) )->uxNumberOfItems )  == ( UBaseType_t ) 0 ) { (( uxTopReadyPriority )) &= ~(1UL << (( pxTCB->uxPriority ))) ; } } ;
 }
 else
 {
  ;
 }


 if(  ( ( &( pxTCB->xEventListItem ) )->pvContainer )  !=  ((void *)0)  )
 {
 ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
 }
 else
 {
  ;
 }

 vListInsertEnd( &xSuspendedTaskList, &( pxTCB->xStateListItem ) );
 }
  vPortExitCritical() ;

 if( xSchedulerRunning !=  ( ( BaseType_t ) 0 )  )
 {
#line 1607 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortEnterCritical() ;
 {
 prvResetNextTaskUnblockTime();
 }
  vPortExitCritical() ;
 }
 else
 {
  ;
 }

 if( pxTCB == pxCurrentTCB )
 {
 if( xSchedulerRunning !=  ( ( BaseType_t ) 0 )  )
 {

  if( ( uxSchedulerSuspended == 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
#line 1631 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( &xSuspendedTaskList )->uxNumberOfItems )  == uxCurrentNumberOfTasks )
 {
#line 1637 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxCurrentTCB =  ((void *)0) ;
 }
 else
 {
 vTaskSwitchContext();
 }
 }
 }
 else
 {
  ;
 }
 }






 static BaseType_t prvTaskIsTaskSuspended( const TaskHandle_t xTask )
 {
 BaseType_t xReturn =  ( ( BaseType_t ) 0 ) ;
 const TCB_t * const pxTCB = ( TCB_t * ) xTask;
#line 1665 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( xTask ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;


 if(  ( ( BaseType_t ) ( ( &( pxTCB->xStateListItem ) )->pvContainer == ( void * ) ( &xSuspendedTaskList ) ) )  !=  ( ( BaseType_t ) 0 )  )
 {

 if(  ( ( BaseType_t ) ( ( &( pxTCB->xEventListItem ) )->pvContainer == ( void * ) ( &xPendingReadyList ) ) )  ==  ( ( BaseType_t ) 0 )  )
 {
#line 1675 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( BaseType_t ) ( ( &( pxTCB->xEventListItem ) )->pvContainer == ( void * ) ( ((void *)0)  ) ) )  !=  ( ( BaseType_t ) 0 )  )
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
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

 return xReturn;
 }






 void vTaskResume( TaskHandle_t xTaskToResume )
 {
 TCB_t * const pxTCB = ( TCB_t * ) xTaskToResume;


  if( ( xTaskToResume ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1711 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ( pxTCB !=  ((void *)0)  ) && ( pxTCB != pxCurrentTCB ) )
 {
  vPortEnterCritical() ;
 {
 if( prvTaskIsTaskSuspended( pxTCB ) !=  ( ( BaseType_t ) 0 )  )
 {
  ;
#line 1721 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;


 if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
 {
#line 1730 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
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
 }
 else
 {
  ;
 }
 }







 BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume )
 {
 BaseType_t xYieldRequired =  ( ( BaseType_t ) 0 ) ;
 TCB_t * const pxTCB = ( TCB_t * ) xTaskToResume;
 UBaseType_t uxSavedInterruptStatus;

  if( ( xTaskToResume ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 1780 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 if( prvTaskIsTaskSuspended( pxTCB ) !=  ( ( BaseType_t ) 0 )  )
 {
  ;


 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
#line 1793 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
 {
 xYieldRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }

 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
 }
 else
 {
#line 1810 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
 }
 }
 else
 {
  ;
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xYieldRequired;
 }




void vTaskStartScheduler( void )
{
BaseType_t xReturn;
#line 1858 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {

 xReturn = xTaskCreate( prvIdleTask,
 "IDLE",  ((uint8_t)128) ,
 ( void * )  ((void *)0) ,
 (  ( ( UBaseType_t ) 0U )  |  ( ( UBaseType_t ) 0x00 )  ),
 &xIdleTaskHandle );
 }
#line 1881 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xReturn ==  ( ( ( BaseType_t ) 1 )  )  )
 {
#line 1888 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortRaiseBASEPRI() ;
#line 1898 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xNextTaskUnblockTime =  ( TickType_t ) 0xffffffffUL ;
 xSchedulerRunning =  ( ( BaseType_t ) 1 ) ;
 xTickCount = ( TickType_t ) 0U;
#line 1905 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;
#line 1909 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xPortStartScheduler() !=  ( ( BaseType_t ) 0 )  )
 {
#line 1913 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
 else
 {

 }
 }
 else
 {
#line 1924 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( xReturn != ( -1 )  ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 }
#line 1929 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( void ) xIdleTaskHandle;
}


void vTaskEndScheduler( void )
{
#line 1938 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortRaiseBASEPRI() ;
 xSchedulerRunning =  ( ( BaseType_t ) 0 ) ;
 vPortEndScheduler();
}


void vTaskSuspendAll( void )
{
#line 1950 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ++uxSchedulerSuspended;
}
#line 2017 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
BaseType_t xTaskResumeAll( void )
{
TCB_t *pxTCB =  ((void *)0) ;
BaseType_t xAlreadyYielded =  ( ( BaseType_t ) 0 ) ;
#line 2024 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( uxSchedulerSuspended ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 2031 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortEnterCritical() ;
 {
 --uxSchedulerSuspended;

 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
 if( uxCurrentNumberOfTasks > ( UBaseType_t ) 0U )
 {
#line 2041 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 while(  ( ( BaseType_t ) ( ( &xPendingReadyList )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ==  ( ( BaseType_t ) 0 )  )
 {
 pxTCB = ( TCB_t * )  ( (&( ( ( &xPendingReadyList ) )->xListEnd ))->pxNext->pvOwner ) ;
 ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
#line 2050 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
 {
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }

 if( pxTCB !=  ((void *)0)  )
 {
#line 2068 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvResetNextTaskUnblockTime();
 }
#line 2075 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 UBaseType_t uxPendedCounts = uxPendedTicks;

 if( uxPendedCounts > ( UBaseType_t ) 0U )
 {
 do
 {
 if( xTaskIncrementTick() !=  ( ( BaseType_t ) 0 )  )
 {
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 --uxPendedCounts;
 } while( uxPendedCounts > ( UBaseType_t ) 0U );

 uxPendedTicks = 0;
 }
 else
 {
  ;
 }
 }

 if( xYieldPending !=  ( ( BaseType_t ) 0 )  )
 {

 {
 xAlreadyYielded =  ( ( BaseType_t ) 1 ) ;
 }

  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
 }
 else
 {
  ;
 }
 }
  vPortExitCritical() ;

 return xAlreadyYielded;
}


TickType_t xTaskGetTickCount( void )
{
TickType_t xTicks;


  ;
 {
 xTicks = xTickCount;
 }
  ;

 return xTicks;
}


TickType_t xTaskGetTickCountFromISR( void )
{
TickType_t xReturn;
UBaseType_t uxSavedInterruptStatus;
#line 2161 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortValidateInterruptPriority() ;

 uxSavedInterruptStatus =  0 ;
 {
 xReturn = xTickCount;
 }
  ( void ) uxSavedInterruptStatus ;

 return xReturn;
}


UBaseType_t uxTaskGetNumberOfTasks( void )
{
#line 2177 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 return uxCurrentNumberOfTasks;
}


char *pcTaskGetName( TaskHandle_t xTaskToQuery )
{
TCB_t *pxTCB;
#line 2187 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTaskToQuery ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTaskToQuery ) ) ;
  if( ( pxTCB ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 return &( pxTCB->pcTaskName[ 0 ] );
}
#line 2499 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
BaseType_t xTaskIncrementTick( void )
{
TCB_t * pxTCB;
TickType_t xItemValue;
BaseType_t xSwitchRequired =  ( ( BaseType_t ) 0 ) ;
#line 2508 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;
 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
#line 2513 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 const TickType_t xConstTickCount = xTickCount + 1;
#line 2517 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xTickCount = xConstTickCount;

 if( xConstTickCount == ( TickType_t ) 0U )
 {
  { List_t *pxTemp; if( ( ( ( ( BaseType_t ) ( ( pxDelayedTaskList )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  ) ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ; pxTemp = pxDelayedTaskList; pxDelayedTaskList = pxOverflowDelayedTaskList; pxOverflowDelayedTaskList = pxTemp; xNumOfOverflows++; prvResetNextTaskUnblockTime(); } ;
 }
 else
 {
  ;
 }
#line 2532 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xConstTickCount >= xNextTaskUnblockTime )
 {
 for( ;; )
 {
 if(  ( ( BaseType_t ) ( ( pxDelayedTaskList )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  !=  ( ( BaseType_t ) 0 )  )
 {
#line 2543 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xNextTaskUnblockTime =  ( TickType_t ) 0xffffffffUL ;
 break;
 }
 else
 {
#line 2552 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB = ( TCB_t * )  ( (&( ( pxDelayedTaskList )->xListEnd ))->pxNext->pvOwner ) ;
 xItemValue =  ( ( &( pxTCB->xStateListItem ) )->xItemValue ) ;

 if( xConstTickCount < xItemValue )
 {
#line 2562 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xNextTaskUnblockTime = xItemValue;
 break;
 }
 else
 {
  ;
 }


 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
#line 2575 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( &( pxTCB->xEventListItem ) )->pvContainer )  !=  ((void *)0)  )
 {
 ( void ) uxListRemove( &( pxTCB->xEventListItem ) );
 }
 else
 {
  ;
 }
#line 2586 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
#line 2591 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
#line 2596 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority >= pxCurrentTCB->uxPriority )
 {
 xSwitchRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }

 }
 }
 }
#line 2614 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
 if(  ( ( &( pxReadyTasksLists[ pxCurrentTCB->uxPriority ] ) )->uxNumberOfItems )  > ( UBaseType_t ) 1 )
 {
 xSwitchRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }
#line 2640 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
 else
 {
 ++uxPendedTicks;
#line 2652 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }


 {
 if( xYieldPending !=  ( ( BaseType_t ) 0 )  )
 {
 xSwitchRequired =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
  ;
 }
 }


 return xSwitchRequired;
}
#line 2761 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
void vTaskSwitchContext( void )
{
 if( uxSchedulerSuspended != ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
#line 2767 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xYieldPending =  ( ( BaseType_t ) 0 ) ;
  ;
#line 2802 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;
#line 2806 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  { UBaseType_t uxTopPriority; uxTopPriority = (31UL - (uint32_t)ucPortCountLeadingZeros((uxTopReadyPriority))) ; if( ( ( ( &( pxReadyTasksLists[ uxTopPriority ] ) )->uxNumberOfItems )  > 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ; { List_t * const pxConstList = ( &( pxReadyTasksLists[ uxTopPriority ] ) ); ( pxConstList )->pxIndex = ( pxConstList )->pxIndex->pxNext; if( ( void * ) ( pxConstList )->pxIndex == ( void * ) &( ( pxConstList )->xListEnd ) ) { ( pxConstList )->pxIndex = ( pxConstList )->pxIndex->pxNext; } ( pxCurrentTCB ) = ( pxConstList )->pxIndex->pvOwner; } ; } ;
  ;
#line 2816 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
}


void vTaskPlaceOnEventList( List_t * const pxEventList, const TickType_t xTicksToWait )
{
  if( ( pxEventList ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 2831 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsert( pxEventList, &( pxCurrentTCB->xEventListItem ) );

 prvAddCurrentTaskToDelayedList( xTicksToWait,  ( ( BaseType_t ) 1 )  );
}


void vTaskPlaceOnUnorderedEventList( List_t * pxEventList, const TickType_t xItemValue, const TickType_t xTicksToWait )
{
  if( ( pxEventList ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 2843 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( uxSchedulerSuspended != 0 ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 2848 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ( ( &( pxCurrentTCB->xEventListItem ) )->xItemValue = ( xItemValue | 0x80000000UL  ) ) ;
#line 2855 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( pxEventList, &( pxCurrentTCB->xEventListItem ) );

 prvAddCurrentTaskToDelayedList( xTicksToWait,  ( ( BaseType_t ) 1 )  );
}
#line 2894 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
BaseType_t xTaskRemoveFromEventList( const List_t * const pxEventList )
{
TCB_t *pxUnblockedTCB;
BaseType_t xReturn;
#line 2912 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxUnblockedTCB = ( TCB_t * )  ( (&( ( pxEventList )->xListEnd ))->pxNext->pvOwner ) ;
  if( ( pxUnblockedTCB ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 ( void ) uxListRemove( &( pxUnblockedTCB->xEventListItem ) );

 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
 ( void ) uxListRemove( &( pxUnblockedTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxUnblockedTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxUnblockedTCB )->uxPriority ] ), &( ( pxUnblockedTCB )->xStateListItem ) ); ;
 }
 else
 {
#line 2925 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &( xPendingReadyList ), &( pxUnblockedTCB->xEventListItem ) );
 }

 if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
 {
#line 2933 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn =  ( ( BaseType_t ) 1 ) ;
#line 2937 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
#line 2958 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 return xReturn;
}


BaseType_t xTaskRemoveFromUnorderedEventList( ListItem_t * pxEventListItem, const TickType_t xItemValue )
{
TCB_t *pxUnblockedTCB;
BaseType_t xReturn;
#line 2969 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( uxSchedulerSuspended != ( ( BaseType_t ) 0 )  ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;


  ( ( pxEventListItem )->xItemValue = ( xItemValue | 0x80000000UL  ) ) ;
#line 2976 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxUnblockedTCB = ( TCB_t * )  ( ( pxEventListItem )->pvOwner ) ;
  if( ( pxUnblockedTCB ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 ( void ) uxListRemove( pxEventListItem );
#line 2983 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( void ) uxListRemove( &( pxUnblockedTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxUnblockedTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxUnblockedTCB )->uxPriority ] ), &( ( pxUnblockedTCB )->xStateListItem ) ); ;

 if( pxUnblockedTCB->uxPriority > pxCurrentTCB->uxPriority )
 {
#line 2992 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn =  ( ( BaseType_t ) 1 ) ;
#line 2996 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }

 return xReturn;
}


void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut )
{
  if( ( pxTimeOut ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 pxTimeOut->xOverflowCount = xNumOfOverflows;
 pxTimeOut->xTimeOnEntering = xTickCount;
}


BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut, TickType_t * const pxTicksToWait )
{
BaseType_t xReturn;

  if( ( pxTimeOut ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
  if( ( pxTicksToWait ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  vPortEnterCritical() ;
 {

 const TickType_t xConstTickCount = xTickCount;
#line 3039 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( *pxTicksToWait ==  ( TickType_t ) 0xffffffffUL  )
 {
#line 3044 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 else


 if( ( xNumOfOverflows != pxTimeOut->xOverflowCount ) && ( xConstTickCount >= pxTimeOut->xTimeOnEntering ) )
 {
#line 3056 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 else if( ( ( TickType_t ) ( xConstTickCount - pxTimeOut->xTimeOnEntering ) ) < *pxTicksToWait )
 {

 *pxTicksToWait -= ( xConstTickCount - pxTimeOut->xTimeOnEntering );
 vTaskSetTimeOutState( pxTimeOut );
 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 else
 {
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }
 }
  vPortExitCritical() ;

 return xReturn;
}


void vTaskMissedYield( void )
{
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
}
#line 3131 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static  void prvIdleTask( void *pvParameters ) 
{

 ( void ) pvParameters;
#line 3139 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 for( ;; )
 {
#line 3143 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 prvCheckTasksWaitingTermination();
#line 3156 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
#line 3166 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( &( pxReadyTasksLists[ ( ( UBaseType_t ) 0U )  ] ) )->uxNumberOfItems )  > ( UBaseType_t ) 1 )
 {
  { PENDSVSET_bit = 1; asm DSB; asm ISB; } ;
 }
 else
 {
  ;
 }
 }
#line 3234 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }
}
#line 3333 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
static void prvInitialiseTaskLists( void )
{
UBaseType_t uxPriority;

 for( uxPriority = ( UBaseType_t ) 0U; uxPriority < ( UBaseType_t )  (16) ; uxPriority++ )
 {
 vListInitialise( &( pxReadyTasksLists[ uxPriority ] ) );
 }

 vListInitialise( &xDelayedTaskList1 );
 vListInitialise( &xDelayedTaskList2 );
 vListInitialise( &xPendingReadyList );


 {
 vListInitialise( &xTasksWaitingTermination );
 }



 {
 vListInitialise( &xSuspendedTaskList );
 }
#line 3360 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxDelayedTaskList = &xDelayedTaskList1;
 pxOverflowDelayedTaskList = &xDelayedTaskList2;
}


static void prvCheckTasksWaitingTermination( void )
{




 {
 BaseType_t xListIsEmpty;
#line 3376 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 while( uxDeletedTasksWaitingCleanUp > ( UBaseType_t ) 0U )
 {
 vTaskSuspendAll();
 {
 xListIsEmpty =  ( ( BaseType_t ) ( ( &xTasksWaitingTermination )->uxNumberOfItems == ( UBaseType_t ) 0 ) ) ;
 }
 ( void ) xTaskResumeAll();

 if( xListIsEmpty ==  ( ( BaseType_t ) 0 )  )
 {
 TCB_t *pxTCB;

  vPortEnterCritical() ;
 {
 pxTCB = ( TCB_t * )  ( (&( ( ( &xTasksWaitingTermination ) )->xListEnd ))->pxNext->pvOwner ) ;
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
 --uxCurrentNumberOfTasks;
 --uxDeletedTasksWaitingCleanUp;
 }
  vPortExitCritical() ;

 prvDeleteTCB( pxTCB );
 }
 else
 {
  ;
 }
 }
 }

}
#line 3581 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 static void prvDeleteTCB( TCB_t *pxTCB )
 {
#line 3586 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ( void ) pxTCB ;
#line 3597 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 {
#line 3600 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vPortFree( pxTCB->pxStack );
 vPortFree( pxTCB );
 }
#line 3630 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 }




static void prvResetNextTaskUnblockTime( void )
{
TCB_t *pxTCB;

 if(  ( ( BaseType_t ) ( ( pxDelayedTaskList )->uxNumberOfItems == ( UBaseType_t ) 0 ) )  !=  ( ( BaseType_t ) 0 )  )
 {
#line 3645 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xNextTaskUnblockTime =  ( TickType_t ) 0xffffffffUL ;
 }
 else
 {
#line 3653 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( pxTCB ) = ( TCB_t * )  ( (&( ( pxDelayedTaskList )->xListEnd ))->pxNext->pvOwner ) ;
 xNextTaskUnblockTime =  ( ( &( ( pxTCB )->xStateListItem ) )->xItemValue ) ;
 }
}




 TaskHandle_t xTaskGetCurrentTaskHandle( void )
 {
 TaskHandle_t xReturn;
#line 3668 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn = pxCurrentTCB;

 return xReturn;
 }
#line 3706 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 void vTaskPriorityInherit( TaskHandle_t const pxMutexHolder )
 {
 TCB_t * const pxTCB = ( TCB_t * ) pxMutexHolder;
#line 3712 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxMutexHolder !=  ((void *)0)  )
 {
#line 3717 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority < pxCurrentTCB->uxPriority )
 {
#line 3722 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( (  ( ( &( pxTCB->xEventListItem ) )->xItemValue )  &  0x80000000UL  ) == 0UL )
 {
  ( ( &( pxTCB->xEventListItem ) )->xItemValue = ( ( TickType_t ) (16)  - ( TickType_t ) pxCurrentTCB->uxPriority ) ) ;
 }
 else
 {
  ;
 }
#line 3733 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if(  ( ( BaseType_t ) ( ( &( pxTCB->xStateListItem ) )->pvContainer == ( void * ) ( &( pxReadyTasksLists[ pxTCB->uxPriority ] ) ) ) )  !=  ( ( BaseType_t ) 0 )  )
 {
 if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
  { if( ( ( &( pxReadyTasksLists[ ( pxTCB->uxPriority ) ] ) )->uxNumberOfItems )  == ( UBaseType_t ) 0 ) { (( uxTopReadyPriority )) &= ~(1UL << (( pxTCB->uxPriority ))) ; } } ;
 }
 else
 {
  ;
 }


 pxTCB->uxPriority = pxCurrentTCB->uxPriority;
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
 }
 else
 {

 pxTCB->uxPriority = pxCurrentTCB->uxPriority;
 }

  ;
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






 BaseType_t xTaskPriorityDisinherit( TaskHandle_t const pxMutexHolder )
 {
 TCB_t * const pxTCB = ( TCB_t * ) pxMutexHolder;
 BaseType_t xReturn =  ( ( BaseType_t ) 0 ) ;

 if( pxMutexHolder !=  ((void *)0)  )
 {
#line 3783 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  if( ( pxTCB == pxCurrentTCB ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

  if( ( pxTCB->uxMutexesHeld ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 ( pxTCB->uxMutexesHeld )--;
#line 3790 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority != pxTCB->uxBasePriority )
 {

 if( pxTCB->uxMutexesHeld == ( UBaseType_t ) 0 )
 {
#line 3800 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxListRemove( &( pxTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
  { if( ( ( &( pxReadyTasksLists[ ( pxTCB->uxPriority ) ] ) )->uxNumberOfItems )  == ( UBaseType_t ) 0 ) { (( uxTopReadyPriority )) &= ~(1UL << (( pxTCB->uxPriority ))) ; } } ;
 }
 else
 {
  ;
 }
#line 3811 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ;
 pxTCB->uxPriority = pxTCB->uxBasePriority;
#line 3817 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ( ( &( pxTCB->xEventListItem ) )->xItemValue = ( ( TickType_t ) (16)  - ( TickType_t ) pxTCB->uxPriority ) ) ;
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
#line 3828 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xReturn =  ( ( BaseType_t ) 1 ) ;
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

 return xReturn;
 }
#line 4162 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
TickType_t uxTaskResetEventItemValue( void )
{
TickType_t uxReturn;

 uxReturn =  ( ( &( pxCurrentTCB->xEventListItem ) )->xItemValue ) ;
#line 4170 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  ( ( &( pxCurrentTCB->xEventListItem ) )->xItemValue = ( ( ( TickType_t ) (16)  - ( TickType_t ) pxCurrentTCB->uxPriority ) ) ) ;

 return uxReturn;
}




 void *pvTaskIncrementMutexHeldCount( void )
 {
#line 4182 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxCurrentTCB !=  ((void *)0)  )
 {
 ( pxCurrentTCB->uxMutexesHeld )++;
 }

 return pxCurrentTCB;
 }






 uint32_t ulTaskNotifyTake( BaseType_t xClearCountOnExit, TickType_t xTicksToWait )
 {
 uint32_t ulReturn;

  vPortEnterCritical() ;
 {

 if( pxCurrentTCB->ulNotifiedValue == 0UL )
 {

 pxCurrentTCB->ucNotifyState =  ( ( uint8_t ) 1 ) ;

 if( xTicksToWait > ( TickType_t ) 0 )
 {
 prvAddCurrentTaskToDelayedList( xTicksToWait,  ( ( BaseType_t ) 1 )  );
  ;
#line 4216 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
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

  vPortEnterCritical() ;
 {
  ;
 ulReturn = pxCurrentTCB->ulNotifiedValue;

 if( ulReturn != 0UL )
 {
 if( xClearCountOnExit !=  ( ( BaseType_t ) 0 )  )
 {
 pxCurrentTCB->ulNotifiedValue = 0UL;
 }
 else
 {
 pxCurrentTCB->ulNotifiedValue = ulReturn - 1;
 }
 }
 else
 {
  ;
 }

 pxCurrentTCB->ucNotifyState =  ( ( uint8_t ) 0 ) ;
 }
  vPortExitCritical() ;

 return ulReturn;
 }






 BaseType_t xTaskNotifyWait( uint32_t ulBitsToClearOnEntry, uint32_t ulBitsToClearOnExit, uint32_t *pulNotificationValue, TickType_t xTicksToWait )
 {
 BaseType_t xReturn;

  vPortEnterCritical() ;
 {

 if( pxCurrentTCB->ucNotifyState !=  ( ( uint8_t ) 2 )  )
 {
#line 4275 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxCurrentTCB->ulNotifiedValue &= ~ulBitsToClearOnEntry;


 pxCurrentTCB->ucNotifyState =  ( ( uint8_t ) 1 ) ;

 if( xTicksToWait > ( TickType_t ) 0 )
 {
 prvAddCurrentTaskToDelayedList( xTicksToWait,  ( ( BaseType_t ) 1 )  );
  ;
#line 4289 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
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

  vPortEnterCritical() ;
 {
  ;

 if( pulNotificationValue !=  ((void *)0)  )
 {
#line 4311 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 *pulNotificationValue = pxCurrentTCB->ulNotifiedValue;
 }
#line 4318 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxCurrentTCB->ucNotifyState ==  ( ( uint8_t ) 1 )  )
 {

 xReturn =  ( ( BaseType_t ) 0 ) ;
 }
 else
 {
#line 4327 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxCurrentTCB->ulNotifiedValue &= ~ulBitsToClearOnExit;
 xReturn =  ( ( BaseType_t ) 1 ) ;
 }

 pxCurrentTCB->ucNotifyState =  ( ( uint8_t ) 0 ) ;
 }
  vPortExitCritical() ;

 return xReturn;
 }






 BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )
 {
 TCB_t * pxTCB;
 BaseType_t xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 uint8_t ucOriginalNotifyState;

  if( ( xTaskToNotify ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
 pxTCB = ( TCB_t * ) xTaskToNotify;

  vPortEnterCritical() ;
 {
 if( pulPreviousNotificationValue !=  ((void *)0)  )
 {
 *pulPreviousNotificationValue = pxTCB->ulNotifiedValue;
 }

 ucOriginalNotifyState = pxTCB->ucNotifyState;

 pxTCB->ucNotifyState =  ( ( uint8_t ) 2 ) ;

 switch( eAction )
 {
 case eSetBits :
 pxTCB->ulNotifiedValue |= ulValue;
 break;

 case eIncrement :
 ( pxTCB->ulNotifiedValue )++;
 break;

 case eSetValueWithOverwrite :
 pxTCB->ulNotifiedValue = ulValue;
 break;

 case eSetValueWithoutOverwrite :
 if( ucOriginalNotifyState !=  ( ( uint8_t ) 2 )  )
 {
 pxTCB->ulNotifiedValue = ulValue;
 }
 else
 {

 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;
 }
 break;

 case eNoAction:
#line 4392 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 break;
 }

  ;
#line 4399 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ucOriginalNotifyState ==  ( ( uint8_t ) 1 )  )
 {
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;


  if( ( ( ( &( pxTCB->xEventListItem ) )->pvContainer )  == ((void *)0)  ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 4423 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
 {
#line 4427 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
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

 return xReturn;
 }






 BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue, BaseType_t *pxHigherPriorityTaskWoken )
 {
 TCB_t * pxTCB;
 uint8_t ucOriginalNotifyState;
 BaseType_t xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 UBaseType_t uxSavedInterruptStatus;

  if( ( xTaskToNotify ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 4474 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortValidateInterruptPriority() ;

 pxTCB = ( TCB_t * ) xTaskToNotify;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 if( pulPreviousNotificationValue !=  ((void *)0)  )
 {
 *pulPreviousNotificationValue = pxTCB->ulNotifiedValue;
 }

 ucOriginalNotifyState = pxTCB->ucNotifyState;
 pxTCB->ucNotifyState =  ( ( uint8_t ) 2 ) ;

 switch( eAction )
 {
 case eSetBits :
 pxTCB->ulNotifiedValue |= ulValue;
 break;

 case eIncrement :
 ( pxTCB->ulNotifiedValue )++;
 break;

 case eSetValueWithOverwrite :
 pxTCB->ulNotifiedValue = ulValue;
 break;

 case eSetValueWithoutOverwrite :
 if( ucOriginalNotifyState !=  ( ( uint8_t ) 2 )  )
 {
 pxTCB->ulNotifiedValue = ulValue;
 }
 else
 {

 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;
 }
 break;

 case eNoAction :
#line 4517 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 break;
 }

  ;
#line 4524 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ucOriginalNotifyState ==  ( ( uint8_t ) 1 )  )
 {

  if( ( ( ( &( pxTCB->xEventListItem ) )->pvContainer )  == ((void *)0)  ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
 }
 else
 {
#line 4538 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
 }

 if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
 {
#line 4545 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxHigherPriorityTaskWoken !=  ((void *)0)  )
 {
 *pxHigherPriorityTaskWoken =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
#line 4554 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 }
 else
 {
  ;
 }
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;

 return xReturn;
 }






 void vTaskNotifyGiveFromISR( TaskHandle_t xTaskToNotify, BaseType_t *pxHigherPriorityTaskWoken )
 {
 TCB_t * pxTCB;
 uint8_t ucOriginalNotifyState;
 UBaseType_t uxSavedInterruptStatus;

  if( ( xTaskToNotify ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;
#line 4597 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  vPortValidateInterruptPriority() ;

 pxTCB = ( TCB_t * ) xTaskToNotify;

 uxSavedInterruptStatus =  ulPortRaiseBASEPRI() ;
 {
 ucOriginalNotifyState = pxTCB->ucNotifyState;
 pxTCB->ucNotifyState =  ( ( uint8_t ) 2 ) ;
#line 4608 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 ( pxTCB->ulNotifiedValue )++;

  ;
#line 4614 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( ucOriginalNotifyState ==  ( ( uint8_t ) 1 )  )
 {

  if( ( ( ( &( pxTCB->xEventListItem ) )->pvContainer )  == ((void *)0)  ) == 0 ) { vPortRaiseBASEPRI() ; while( 1 ); } ;

 if( uxSchedulerSuspended == ( UBaseType_t )  ( ( BaseType_t ) 0 )  )
 {
 ( void ) uxListRemove( &( pxTCB->xStateListItem ) );
  ; (uxTopReadyPriority) |= (1UL << (( pxTCB )->uxPriority)) ; vListInsertEnd( &( pxReadyTasksLists[ ( pxTCB )->uxPriority ] ), &( ( pxTCB )->xStateListItem ) ); ;
 }
 else
 {
#line 4628 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &( xPendingReadyList ), &( pxTCB->xEventListItem ) );
 }

 if( pxTCB->uxPriority > pxCurrentTCB->uxPriority )
 {
#line 4635 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( pxHigherPriorityTaskWoken !=  ((void *)0)  )
 {
 *pxHigherPriorityTaskWoken =  ( ( BaseType_t ) 1 ) ;
 }
 else
 {
#line 4644 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xYieldPending =  ( ( BaseType_t ) 1 ) ;
 }
 }
 else
 {
  ;
 }
 }
 }
  vPortSetBASEPRI(uxSavedInterruptStatus) ;
 }







 BaseType_t xTaskNotifyStateClear( TaskHandle_t xTask )
 {
 TCB_t *pxTCB;
 BaseType_t xReturn;
#line 4669 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 pxTCB =  ( ( ( xTask ) == ((void *)0)  ) ? ( TCB_t * ) pxCurrentTCB : ( TCB_t * ) ( xTask ) ) ;

  vPortEnterCritical() ;
 {
 if( pxTCB->ucNotifyState ==  ( ( uint8_t ) 2 )  )
 {
 pxTCB->ucNotifyState =  ( ( uint8_t ) 0 ) ;
 xReturn =  ( ( ( BaseType_t ) 1 )  ) ;
 }
 else
 {
 xReturn =  ( ( ( BaseType_t ) 0 )  ) ;
 }
 }
  vPortExitCritical() ;

 return xReturn;
 }





static void prvAddCurrentTaskToDelayedList( TickType_t xTicksToWait, const BaseType_t xCanBlockIndefinitely )
{
TickType_t xTimeToWake;
const TickType_t xConstTickCount = xTickCount;
#line 4708 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( uxListRemove( &( pxCurrentTCB->xStateListItem ) ) == ( UBaseType_t ) 0 )
 {
#line 4712 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
  (uxTopReadyPriority) &= ~(1UL << (pxCurrentTCB->uxPriority)) ;
 }
 else
 {
  ;
 }


 {
 if( ( xTicksToWait ==  ( TickType_t ) 0xffffffffUL  ) && ( xCanBlockIndefinitely !=  ( ( BaseType_t ) 0 )  ) )
 {
#line 4726 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsertEnd( &xSuspendedTaskList, &( pxCurrentTCB->xStateListItem ) );
 }
 else
 {
#line 4733 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 xTimeToWake = xConstTickCount + xTicksToWait;


  ( ( &( pxCurrentTCB->xStateListItem ) )->xItemValue = ( xTimeToWake ) ) ;

 if( xTimeToWake < xConstTickCount )
 {
#line 4742 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsert( pxOverflowDelayedTaskList, &( pxCurrentTCB->xStateListItem ) );
 }
 else
 {
#line 4748 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 vListInsert( pxDelayedTaskList, &( pxCurrentTCB->xStateListItem ) );
#line 4753 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
 if( xTimeToWake < xNextTaskUnblockTime )
 {
 xNextTaskUnblockTime = xTimeToWake;
 }
 else
 {
  ;
 }
 }
 }
 }
#line 4801 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/tasks.c"
}
