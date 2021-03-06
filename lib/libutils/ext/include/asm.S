/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 */

#if defined(CFG_UNWIND) && defined(__arm__)
#define UNWIND(...) __VA_ARGS__
#else
#define UNWIND(...)
#endif

	.macro FUNC name colon section=default
	.ifc	\section\(),default
	.section .text.\name
	.else
	.section \section , "ax" , %progbits
	.endif
	.global \name
	.type \name , %function
	.balign 4
	\name \colon
UNWIND(	.fnstart)
	.endm

	.macro DATA name colon
	.global \name
	.type \name , %object
	\name \colon
	.endm

	.macro LOCAL_FUNC name colon section=default
	.ifc	\section\(),default
	.section .text.\name
	.else
	.section \section , "ax" , %progbits
	.endif
	.type \name , %function
	.balign 4
	\name \colon
UNWIND(	.fnstart)
	.endm

	.macro LOCAL_DATA name colon
	.type \name , %object
	\name \colon
	.endm

	.macro END_DATA name
	.size \name , .-\name
	.endm

	.macro END_FUNC name
UNWIND(	.fnend)
	.size \name , .-\name
	.endm
