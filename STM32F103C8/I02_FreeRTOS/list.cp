#line 1 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
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
#line 79 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
void vListInitialise( List_t * const pxList )
{
#line 84 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 pxList->pxIndex = ( ListItem_t * ) &( pxList->xListEnd );
#line 88 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 pxList->xListEnd.xItemValue =  ( TickType_t ) 0xffffffffUL ;
#line 92 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 pxList->xListEnd.pxNext = ( ListItem_t * ) &( pxList->xListEnd );
 pxList->xListEnd.pxPrevious = ( ListItem_t * ) &( pxList->xListEnd );

 pxList->uxNumberOfItems = ( UBaseType_t ) 0U;
#line 99 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
  ;
  ;
}


void vListInitialiseItem( ListItem_t * const pxItem )
{

 pxItem->pvContainer =  ((void *)0) ;
#line 111 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
  ;
  ;
}


void vListInsertEnd( List_t * const pxList, ListItem_t * const pxNewListItem )
{
ListItem_t * const pxIndex = pxList->pxIndex;
#line 123 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
  ;
  ;
#line 129 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 pxNewListItem->pxNext = pxIndex;
 pxNewListItem->pxPrevious = pxIndex->pxPrevious;


  ;

 pxIndex->pxPrevious->pxNext = pxNewListItem;
 pxIndex->pxPrevious = pxNewListItem;


 pxNewListItem->pvContainer = ( void * ) pxList;

 ( pxList->uxNumberOfItems )++;
}


void vListInsert( List_t * const pxList, ListItem_t * const pxNewListItem )
{
ListItem_t *pxIterator;
const TickType_t xValueOfInsertion = pxNewListItem->xItemValue;
#line 153 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
  ;
  ;
#line 164 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 if( xValueOfInsertion ==  ( TickType_t ) 0xffffffffUL  )
 {
 pxIterator = pxList->xListEnd.pxPrevious;
 }
 else
 {
#line 192 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 for( pxIterator = ( ListItem_t * ) &( pxList->xListEnd ); pxIterator->pxNext->xItemValue <= xValueOfInsertion; pxIterator = pxIterator->pxNext )
 {
#line 196 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 }
 }

 pxNewListItem->pxNext = pxIterator->pxNext;
 pxNewListItem->pxNext->pxPrevious = pxNewListItem;
 pxNewListItem->pxPrevious = pxIterator;
 pxIterator->pxNext = pxNewListItem;
#line 210 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
 pxNewListItem->pvContainer = ( void * ) pxList;

 ( pxList->uxNumberOfItems )++;
}


UBaseType_t uxListRemove( ListItem_t * const pxItemToRemove )
{
#line 220 "C:/Users/armst/Desktop/STM32F103C8T6/MikroC/I02_FreeRTOS/list.c"
List_t * const pxList = ( List_t * ) pxItemToRemove->pvContainer;

 pxItemToRemove->pxNext->pxPrevious = pxItemToRemove->pxPrevious;
 pxItemToRemove->pxPrevious->pxNext = pxItemToRemove->pxNext;


  ;


 if( pxList->pxIndex == pxItemToRemove )
 {
 pxList->pxIndex = pxItemToRemove->pxPrevious;
 }
 else
 {
  ;
 }

 pxItemToRemove->pvContainer =  ((void *)0) ;
 ( pxList->uxNumberOfItems )--;

 return pxList->uxNumberOfItems;
}
