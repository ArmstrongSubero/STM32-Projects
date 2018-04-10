list_ucPortCountLeadingZeros:
;portmacro.h,176 :: 		static inline uint8_t ucPortCountLeadingZeros(uint32_t ulBitmap)
;portmacro.h,178 :: 		asm CLZ R0, R0;
CLZ	R0, R0
;portmacro.h,179 :: 		return R0;
UXTB	R0, R0
;portmacro.h,180 :: 		}
L_end_ucPortCountLeadingZeros:
BX	LR
; end of list_ucPortCountLeadingZeros
list_xPortIsInsideInterrupt:
;portmacro.h,218 :: 		portFORCE_INLINE static BaseType_t xPortIsInsideInterrupt( void )
SUB	SP, SP, #8
;portmacro.h,224 :: 		ulCurrentInterrupt = CPU_REG_GET(CPU_IPSR);
MRS	R12, #5
MOV	R0, R12
STR	R0, [SP, #0]
;portmacro.h,226 :: 		if( ulCurrentInterrupt == 0 )
LDR	R0, [SP, #0]
CMP	R0, #0
IT	NE
BNE	L_list_xPortIsInsideInterrupt0
;portmacro.h,228 :: 		xReturn = pdFALSE;
MOV	R0, #0
STR	R0, [SP, #4]
;portmacro.h,229 :: 		}
IT	AL
BAL	L_list_xPortIsInsideInterrupt1
L_list_xPortIsInsideInterrupt0:
;portmacro.h,232 :: 		xReturn = pdTRUE;
MOV	R0, #1
STR	R0, [SP, #4]
;portmacro.h,233 :: 		}
L_list_xPortIsInsideInterrupt1:
;portmacro.h,235 :: 		return xReturn;
LDR	R0, [SP, #4]
;portmacro.h,236 :: 		}
L_end_xPortIsInsideInterrupt:
ADD	SP, SP, #8
BX	LR
; end of list_xPortIsInsideInterrupt
list_vPortRaiseBASEPRI:
;portmacro.h,239 :: 		portFORCE_INLINE static void vPortRaiseBASEPRI( void )
SUB	SP, SP, #4
;portmacro.h,243 :: 		ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
MOVS	R0, #16
STR	R0, [SP, #0]
;portmacro.h,244 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,246 :: 		asm ISB;
ISB	#15
;portmacro.h,247 :: 		asm DSB;
DSB	#15
;portmacro.h,248 :: 		}
L_end_vPortRaiseBASEPRI:
ADD	SP, SP, #4
BX	LR
; end of list_vPortRaiseBASEPRI
list_ulPortRaiseBASEPRI:
;portmacro.h,251 :: 		portFORCE_INLINE static uint32_t ulPortRaiseBASEPRI( void )
SUB	SP, SP, #8
;portmacro.h,255 :: 		ulOriginalBASEPRI = CPU_REG_GET(CPU_BASEPRI);
MRS	R12, #17
MOV	R0, R12
STR	R0, [SP, #0]
;portmacro.h,256 :: 		ulNewBASEPRI = configMAX_SYSCALL_INTERRUPT_PRIORITY;
MOVS	R0, #16
STR	R0, [SP, #4]
;portmacro.h,257 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewBASEPRI);
LDR	R0, [SP, #4]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,259 :: 		asm ISB;
ISB	#15
;portmacro.h,260 :: 		asm DSB;
DSB	#15
;portmacro.h,264 :: 		return ulOriginalBASEPRI;
LDR	R0, [SP, #0]
;portmacro.h,265 :: 		}
L_end_ulPortRaiseBASEPRI:
ADD	SP, SP, #8
BX	LR
; end of list_ulPortRaiseBASEPRI
list_vPortSetBASEPRI:
;portmacro.h,268 :: 		portFORCE_INLINE static void vPortSetBASEPRI( uint32_t ulNewMaskValue )
;portmacro.h,270 :: 		CPU_REG_SET(CPU_BASEPRI, ulNewMaskValue);
LDR	R0, [SP, #0]
MOV	R12, R0
MSR	#17, R12
;portmacro.h,271 :: 		}
L_end_vPortSetBASEPRI:
BX	LR
; end of list_vPortSetBASEPRI
_vListInitialise:
;list.c,79 :: 		void vListInitialise( List_t * const pxList )
;list.c,84 :: 		pxList->pxIndex = ( ListItem_t * ) &( pxList->xListEnd );                        /*lint !e826 !e740 The mini list structure is used as the list end to save RAM.  This is checked and valid. */
LDR	R0, [SP, #0]
ADDS	R1, R0, #4
LDR	R0, [SP, #0]
ADDS	R0, #8
STR	R0, [R1, #0]
;list.c,88 :: 		pxList->xListEnd.xItemValue = portMAX_DELAY;
LDR	R0, [SP, #0]
ADDS	R0, #8
MOV	R1, R0
MOV	R0, #-1
STR	R0, [R1, #0]
;list.c,92 :: 		pxList->xListEnd.pxNext = ( ListItem_t * ) &( pxList->xListEnd );        /*lint !e826 !e740 The mini list structure is used as the list end to save RAM.  This is checked and valid. */
LDR	R0, [SP, #0]
ADDS	R0, #8
ADDS	R1, R0, #4
LDR	R0, [SP, #0]
ADDS	R0, #8
STR	R0, [R1, #0]
;list.c,93 :: 		pxList->xListEnd.pxPrevious = ( ListItem_t * ) &( pxList->xListEnd );/*lint !e826 !e740 The mini list structure is used as the list end to save RAM.  This is checked and valid. */
LDR	R0, [SP, #0]
ADDS	R0, #8
ADDW	R1, R0, #8
LDR	R0, [SP, #0]
ADDS	R0, #8
STR	R0, [R1, #0]
;list.c,95 :: 		pxList->uxNumberOfItems = ( UBaseType_t ) 0U;
LDR	R0, [SP, #0]
MOV	R1, R0
MOV	R0, #0
STR	R0, [R1, #0]
;list.c,101 :: 		}
L_end_vListInitialise:
BX	LR
; end of _vListInitialise
_vListInitialiseItem:
;list.c,104 :: 		void vListInitialiseItem( ListItem_t * const pxItem )
;list.c,107 :: 		pxItem->pvContainer = NULL;
LDR	R0, [SP, #0]
ADDW	R1, R0, #16
MOVS	R0, #0
STR	R0, [R1, #0]
;list.c,113 :: 		}
L_end_vListInitialiseItem:
BX	LR
; end of _vListInitialiseItem
_vListInsertEnd:
;list.c,116 :: 		void vListInsertEnd( List_t * const pxList, ListItem_t * const pxNewListItem )
SUB	SP, SP, #4
;list.c,118 :: 		ListItem_t * const pxIndex = pxList->pxIndex;
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;list.c,129 :: 		pxNewListItem->pxNext = pxIndex;
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #0]
STR	R0, [R1, #0]
;list.c,130 :: 		pxNewListItem->pxPrevious = pxIndex->pxPrevious;
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #0]
ADDS	R0, #8
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;list.c,135 :: 		pxIndex->pxPrevious->pxNext = pxNewListItem;
LDR	R0, [SP, #0]
ADDS	R0, #8
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
LDR	R0, [SP, #8]
STR	R0, [R1, #0]
;list.c,136 :: 		pxIndex->pxPrevious = pxNewListItem;
LDR	R0, [SP, #0]
ADDW	R1, R0, #8
LDR	R0, [SP, #8]
STR	R0, [R1, #0]
;list.c,139 :: 		pxNewListItem->pvContainer = ( void * ) pxList;
LDR	R0, [SP, #8]
ADDW	R1, R0, #16
LDR	R0, [SP, #4]
STR	R0, [R1, #0]
;list.c,141 :: 		( pxList->uxNumberOfItems )++;
LDR	R0, [SP, #4]
MOV	R1, R0
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;list.c,142 :: 		}
L_end_vListInsertEnd:
ADD	SP, SP, #4
BX	LR
; end of _vListInsertEnd
_vListInsert:
;list.c,145 :: 		void vListInsert( List_t * const pxList, ListItem_t * const pxNewListItem )
SUB	SP, SP, #8
;list.c,148 :: 		const TickType_t xValueOfInsertion = pxNewListItem->xItemValue;
LDR	R0, [SP, #12]
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
;list.c,164 :: 		if( xValueOfInsertion == portMAX_DELAY )
LDR	R0, [SP, #4]
CMP	R0, #-1
IT	NE
BNE	L_vListInsert2
;list.c,166 :: 		pxIterator = pxList->xListEnd.pxPrevious;
LDR	R0, [SP, #8]
ADDS	R0, #8
ADDS	R0, #8
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;list.c,167 :: 		}
IT	AL
BAL	L_vListInsert3
L_vListInsert2:
;list.c,192 :: 		for( pxIterator = ( ListItem_t * ) &( pxList->xListEnd ); pxIterator->pxNext->xItemValue <= xValueOfInsertion; pxIterator = pxIterator->pxNext ) /*lint !e826 !e740 The mini list structure is used as the list end to save RAM.  This is checked and valid. */
LDR	R0, [SP, #8]
ADDS	R0, #8
STR	R0, [SP, #0]
L_vListInsert4:
LDR	R0, [SP, #0]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R1, R0
IT	HI
BHI	L_vListInsert5
LDR	R0, [SP, #0]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;list.c,196 :: 		}
IT	AL
BAL	L_vListInsert4
L_vListInsert5:
;list.c,197 :: 		}
L_vListInsert3:
;list.c,199 :: 		pxNewListItem->pxNext = pxIterator->pxNext;
LDR	R0, [SP, #12]
ADDS	R1, R0, #4
LDR	R0, [SP, #0]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;list.c,200 :: 		pxNewListItem->pxNext->pxPrevious = pxNewListItem;
LDR	R0, [SP, #12]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDW	R1, R0, #8
LDR	R0, [SP, #12]
STR	R0, [R1, #0]
;list.c,201 :: 		pxNewListItem->pxPrevious = pxIterator;
LDR	R0, [SP, #12]
ADDW	R1, R0, #8
LDR	R0, [SP, #0]
STR	R0, [R1, #0]
;list.c,202 :: 		pxIterator->pxNext = pxNewListItem;
LDR	R0, [SP, #0]
ADDS	R1, R0, #4
LDR	R0, [SP, #12]
STR	R0, [R1, #0]
;list.c,210 :: 		pxNewListItem->pvContainer = ( void * ) pxList;
LDR	R0, [SP, #12]
ADDW	R1, R0, #16
LDR	R0, [SP, #8]
STR	R0, [R1, #0]
;list.c,212 :: 		( pxList->uxNumberOfItems )++;
LDR	R0, [SP, #8]
MOV	R1, R0
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;list.c,213 :: 		}
L_end_vListInsert:
ADD	SP, SP, #8
BX	LR
; end of _vListInsert
_uxListRemove:
;list.c,216 :: 		UBaseType_t uxListRemove( ListItem_t * const pxItemToRemove )
SUB	SP, SP, #4
;list.c,220 :: 		List_t * const pxList = ( List_t * ) pxItemToRemove->pvContainer;
LDR	R0, [SP, #4]
ADDS	R0, #16
LDR	R0, [R0, #0]
STR	R0, [SP, #0]
;list.c,222 :: 		pxItemToRemove->pxNext->pxPrevious = pxItemToRemove->pxPrevious;
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, #8
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;list.c,223 :: 		pxItemToRemove->pxPrevious->pxNext = pxItemToRemove->pxNext;
LDR	R0, [SP, #4]
ADDS	R0, #8
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;list.c,229 :: 		if( pxList->pxIndex == pxItemToRemove )
LDR	R0, [SP, #0]
ADDS	R0, R0, #4
LDR	R1, [R0, #0]
LDR	R0, [SP, #4]
CMP	R1, R0
IT	NE
BNE	L_uxListRemove7
;list.c,231 :: 		pxList->pxIndex = pxItemToRemove->pxPrevious;
LDR	R0, [SP, #0]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, #8
LDR	R0, [R0, #0]
STR	R0, [R1, #0]
;list.c,232 :: 		}
IT	AL
BAL	L_uxListRemove8
L_uxListRemove7:
;list.c,236 :: 		}
L_uxListRemove8:
;list.c,238 :: 		pxItemToRemove->pvContainer = NULL;
LDR	R0, [SP, #4]
ADDW	R1, R0, #16
MOVS	R0, #0
STR	R0, [R1, #0]
;list.c,239 :: 		( pxList->uxNumberOfItems )--;
LDR	R0, [SP, #0]
MOV	R1, R0
LDR	R0, [R1, #0]
SUBS	R0, R0, #1
STR	R0, [R1, #0]
;list.c,241 :: 		return pxList->uxNumberOfItems;
LDR	R0, [SP, #0]
LDR	R0, [R0, #0]
;list.c,242 :: 		}
L_end_uxListRemove:
ADD	SP, SP, #4
BX	LR
; end of _uxListRemove
