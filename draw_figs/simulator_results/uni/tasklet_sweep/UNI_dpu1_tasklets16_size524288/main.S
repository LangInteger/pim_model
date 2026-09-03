	.text
	.file	"task.c"
                                        // Start of file scope inline assembly
	.section	.data.my_barrier,"aw",@progbits
	.type	my_barrier,@object
	.globl	my_barrier
	.p2align	2
my_barrier:
	.byte	255
	.byte	16
	.byte	16
	.byte	__atomic_bit_barrier_my_barrier
	.size	my_barrier, 4
	.text

                                        // End of file scope inline assembly
	.file	1 "/root/uPIMulator/benchmark" "UNI/dpu/task.c"
	.file	2 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/stdlib/stdint.h"
	.file	3 "/root/uPIMulator/benchmark" "UNI/dpu/../support/common.h"
	.section	.text.unique,"ax",@progbits
	.globl	unique                          // -- Begin function unique
	.type	unique,@function
unique:                                 // @unique
.Lfunc_begin0:
	.loc	1 27 0                          // UNI/dpu/task.c:27:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:input <- $r1
	.cfi_def_cfa_offset 0
	.loc	1 29 19 prologue_end            // UNI/dpu/task.c:29:19
	ld d2, r1, 0
.Ltmp0:
	//DEBUG_VALUE: unique:pos <- 0
	//DEBUG_VALUE: unique:output <- $r0
	.loc	1 29 17 is_stmt 0               // UNI/dpu/task.c:29:17
	sd r0, 0, d2
.Ltmp1:
	//DEBUG_VALUE: j <- 1
	//DEBUG_VALUE: unique:pos <- 1
	.loc	1 33 12 is_stmt 1               // UNI/dpu/task.c:33:12
	ld d4, r1, 8
	.loc	1 33 24 is_stmt 0               // UNI/dpu/task.c:33:24
	ld d6, r1, 0
	move r2, 1
.Ltmp2:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r5, r7, .LBB0_1
.Ltmp3:
// %bb.255:
	jneq r4, r6, .LBB0_1
// %bb.256:
// %bb.2:
.Ltmp4:
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: unique:pos <- 1
	//DEBUG_VALUE: j <- 1
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 2
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 16
.Ltmp5:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_3
.Ltmp6:
// %bb.257:
	jneq r6, r4, .LBB0_3
// %bb.258:
.LBB0_4:
.Ltmp7:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 3
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 24
.Ltmp8:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_5
.Ltmp9:
// %bb.259:
	jneq r6, r4, .LBB0_5
// %bb.260:
.LBB0_6:
.Ltmp10:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 3
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 4
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 32
.Ltmp11:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_7
.Ltmp12:
// %bb.261:
	jneq r6, r4, .LBB0_7
// %bb.262:
.LBB0_8:
.Ltmp13:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 4
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 5
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 40
.Ltmp14:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_9
.Ltmp15:
// %bb.263:
	jneq r6, r4, .LBB0_9
// %bb.264:
.LBB0_10:
.Ltmp16:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 5
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 6
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 48
.Ltmp17:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_11
.Ltmp18:
// %bb.265:
	jneq r6, r4, .LBB0_11
// %bb.266:
.LBB0_12:
.Ltmp19:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 6
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 7
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 56
.Ltmp20:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_13
.Ltmp21:
// %bb.267:
	jneq r6, r4, .LBB0_13
// %bb.268:
.LBB0_14:
.Ltmp22:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 7
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 8
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 64
.Ltmp23:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_15
.Ltmp24:
// %bb.269:
	jneq r6, r4, .LBB0_15
// %bb.270:
.LBB0_16:
.Ltmp25:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 8
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 9
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 72
.Ltmp26:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_17
.Ltmp27:
// %bb.271:
	jneq r6, r4, .LBB0_17
// %bb.272:
.LBB0_18:
.Ltmp28:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 9
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 10
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 80
.Ltmp29:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_19
.Ltmp30:
// %bb.273:
	jneq r6, r4, .LBB0_19
// %bb.274:
.LBB0_20:
.Ltmp31:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 10
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 11
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 88
.Ltmp32:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_21
.Ltmp33:
// %bb.275:
	jneq r6, r4, .LBB0_21
// %bb.276:
.LBB0_22:
.Ltmp34:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 11
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 12
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 96
.Ltmp35:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_23
.Ltmp36:
// %bb.277:
	jneq r6, r4, .LBB0_23
// %bb.278:
.LBB0_24:
.Ltmp37:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 12
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 13
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 104
.Ltmp38:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_25
.Ltmp39:
// %bb.279:
	jneq r6, r4, .LBB0_25
// %bb.280:
.LBB0_26:
.Ltmp40:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 13
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 14
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 112
.Ltmp41:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_27
.Ltmp42:
// %bb.281:
	jneq r6, r4, .LBB0_27
// %bb.282:
.LBB0_28:
.Ltmp43:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 14
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 15
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 120
.Ltmp44:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_29
.Ltmp45:
// %bb.283:
	jneq r6, r4, .LBB0_29
// %bb.284:
.LBB0_30:
.Ltmp46:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 15
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 16
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 128
.Ltmp47:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_31
.Ltmp48:
// %bb.285:
	jneq r6, r4, .LBB0_31
// %bb.286:
.LBB0_32:
.Ltmp49:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 16
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 17
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 136
.Ltmp50:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_33
.Ltmp51:
// %bb.287:
	jneq r6, r4, .LBB0_33
// %bb.288:
.LBB0_34:
.Ltmp52:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 17
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 18
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 144
.Ltmp53:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_35
.Ltmp54:
// %bb.289:
	jneq r6, r4, .LBB0_35
// %bb.290:
.LBB0_36:
.Ltmp55:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 18
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 19
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 152
.Ltmp56:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_37
.Ltmp57:
// %bb.291:
	jneq r6, r4, .LBB0_37
// %bb.292:
.LBB0_38:
.Ltmp58:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 19
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 20
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 160
.Ltmp59:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_39
.Ltmp60:
// %bb.293:
	jneq r6, r4, .LBB0_39
// %bb.294:
.LBB0_40:
.Ltmp61:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 20
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 21
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 168
.Ltmp62:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_41
.Ltmp63:
// %bb.295:
	jneq r6, r4, .LBB0_41
// %bb.296:
.LBB0_42:
.Ltmp64:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 21
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 22
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 176
.Ltmp65:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_43
.Ltmp66:
// %bb.297:
	jneq r6, r4, .LBB0_43
// %bb.298:
.LBB0_44:
.Ltmp67:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 22
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 23
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 184
.Ltmp68:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_45
.Ltmp69:
// %bb.299:
	jneq r6, r4, .LBB0_45
// %bb.300:
.LBB0_46:
.Ltmp70:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 23
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 24
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 192
.Ltmp71:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_47
.Ltmp72:
// %bb.301:
	jneq r6, r4, .LBB0_47
// %bb.302:
.LBB0_48:
.Ltmp73:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 24
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 25
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 200
.Ltmp74:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_49
.Ltmp75:
// %bb.303:
	jneq r6, r4, .LBB0_49
// %bb.304:
.LBB0_50:
.Ltmp76:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 25
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 26
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 208
.Ltmp77:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_51
.Ltmp78:
// %bb.305:
	jneq r6, r4, .LBB0_51
// %bb.306:
.LBB0_52:
.Ltmp79:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 26
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 27
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 216
.Ltmp80:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_53
.Ltmp81:
// %bb.307:
	jneq r6, r4, .LBB0_53
// %bb.308:
.LBB0_54:
.Ltmp82:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 27
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 28
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 224
.Ltmp83:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_55
.Ltmp84:
// %bb.309:
	jneq r6, r4, .LBB0_55
// %bb.310:
.LBB0_56:
.Ltmp85:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 28
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 29
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 232
.Ltmp86:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_57
.Ltmp87:
// %bb.311:
	jneq r6, r4, .LBB0_57
// %bb.312:
.LBB0_58:
.Ltmp88:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 29
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 30
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 240
.Ltmp89:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_59
.Ltmp90:
// %bb.313:
	jneq r6, r4, .LBB0_59
// %bb.314:
.LBB0_60:
.Ltmp91:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 30
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 31
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 248
.Ltmp92:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_61
.Ltmp93:
// %bb.315:
	jneq r6, r4, .LBB0_61
// %bb.316:
.LBB0_62:
.Ltmp94:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 31
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 32
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 256
.Ltmp95:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_63
.Ltmp96:
// %bb.317:
	jneq r6, r4, .LBB0_63
// %bb.318:
.LBB0_64:
.Ltmp97:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 32
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 33
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 264
.Ltmp98:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_65
.Ltmp99:
// %bb.319:
	jneq r6, r4, .LBB0_65
// %bb.320:
.LBB0_66:
.Ltmp100:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 33
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 34
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 272
.Ltmp101:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_67
.Ltmp102:
// %bb.321:
	jneq r6, r4, .LBB0_67
// %bb.322:
.LBB0_68:
.Ltmp103:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 34
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 35
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 280
.Ltmp104:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_69
.Ltmp105:
// %bb.323:
	jneq r6, r4, .LBB0_69
// %bb.324:
.LBB0_70:
.Ltmp106:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 35
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 36
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 288
.Ltmp107:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_71
.Ltmp108:
// %bb.325:
	jneq r6, r4, .LBB0_71
// %bb.326:
.LBB0_72:
.Ltmp109:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 36
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 37
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 296
.Ltmp110:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_73
.Ltmp111:
// %bb.327:
	jneq r6, r4, .LBB0_73
// %bb.328:
.LBB0_74:
.Ltmp112:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 37
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 38
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 304
.Ltmp113:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_75
.Ltmp114:
// %bb.329:
	jneq r6, r4, .LBB0_75
// %bb.330:
.LBB0_76:
.Ltmp115:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 38
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 39
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 312
.Ltmp116:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_77
.Ltmp117:
// %bb.331:
	jneq r6, r4, .LBB0_77
// %bb.332:
.LBB0_78:
.Ltmp118:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 39
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 40
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 320
.Ltmp119:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_79
.Ltmp120:
// %bb.333:
	jneq r6, r4, .LBB0_79
// %bb.334:
.LBB0_80:
.Ltmp121:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 40
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 41
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 328
.Ltmp122:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_81
.Ltmp123:
// %bb.335:
	jneq r6, r4, .LBB0_81
// %bb.336:
.LBB0_82:
.Ltmp124:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 41
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 42
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 336
.Ltmp125:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_83
.Ltmp126:
// %bb.337:
	jneq r6, r4, .LBB0_83
// %bb.338:
.LBB0_84:
.Ltmp127:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 42
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 43
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 344
.Ltmp128:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_85
.Ltmp129:
// %bb.339:
	jneq r6, r4, .LBB0_85
// %bb.340:
.LBB0_86:
.Ltmp130:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 43
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 44
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 352
.Ltmp131:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_87
.Ltmp132:
// %bb.341:
	jneq r6, r4, .LBB0_87
// %bb.342:
.LBB0_88:
.Ltmp133:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 44
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 45
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 360
.Ltmp134:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_89
.Ltmp135:
// %bb.343:
	jneq r6, r4, .LBB0_89
// %bb.344:
.LBB0_90:
.Ltmp136:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 45
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 46
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 368
.Ltmp137:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_91
.Ltmp138:
// %bb.345:
	jneq r6, r4, .LBB0_91
// %bb.346:
.LBB0_92:
.Ltmp139:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 46
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 47
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 376
.Ltmp140:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_93
.Ltmp141:
// %bb.347:
	jneq r6, r4, .LBB0_93
// %bb.348:
.LBB0_94:
.Ltmp142:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 47
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 48
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 384
.Ltmp143:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_95
.Ltmp144:
// %bb.349:
	jneq r6, r4, .LBB0_95
// %bb.350:
.LBB0_96:
.Ltmp145:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 48
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 49
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 392
.Ltmp146:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_97
.Ltmp147:
// %bb.351:
	jneq r6, r4, .LBB0_97
// %bb.352:
.LBB0_98:
.Ltmp148:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 49
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 50
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 400
.Ltmp149:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_99
.Ltmp150:
// %bb.353:
	jneq r6, r4, .LBB0_99
// %bb.354:
.LBB0_100:
.Ltmp151:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 50
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 51
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 408
.Ltmp152:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_101
.Ltmp153:
// %bb.355:
	jneq r6, r4, .LBB0_101
// %bb.356:
.LBB0_102:
.Ltmp154:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 51
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 52
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 416
.Ltmp155:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_103
.Ltmp156:
// %bb.357:
	jneq r6, r4, .LBB0_103
// %bb.358:
.LBB0_104:
.Ltmp157:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 52
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 53
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 424
.Ltmp158:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_105
.Ltmp159:
// %bb.359:
	jneq r6, r4, .LBB0_105
// %bb.360:
.LBB0_106:
.Ltmp160:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 53
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 54
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 432
.Ltmp161:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_107
.Ltmp162:
// %bb.361:
	jneq r6, r4, .LBB0_107
// %bb.362:
.LBB0_108:
.Ltmp163:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 54
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 55
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 440
.Ltmp164:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_109
.Ltmp165:
// %bb.363:
	jneq r6, r4, .LBB0_109
// %bb.364:
.LBB0_110:
.Ltmp166:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 55
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 56
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 448
.Ltmp167:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_111
.Ltmp168:
// %bb.365:
	jneq r6, r4, .LBB0_111
// %bb.366:
.LBB0_112:
.Ltmp169:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 56
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 57
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 456
.Ltmp170:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_113
.Ltmp171:
// %bb.367:
	jneq r6, r4, .LBB0_113
// %bb.368:
.LBB0_114:
.Ltmp172:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 57
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 58
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 464
.Ltmp173:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_115
.Ltmp174:
// %bb.369:
	jneq r6, r4, .LBB0_115
// %bb.370:
.LBB0_116:
.Ltmp175:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 58
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 59
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 472
.Ltmp176:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_117
.Ltmp177:
// %bb.371:
	jneq r6, r4, .LBB0_117
// %bb.372:
.LBB0_118:
.Ltmp178:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 59
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 60
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 480
.Ltmp179:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_119
.Ltmp180:
// %bb.373:
	jneq r6, r4, .LBB0_119
// %bb.374:
.LBB0_120:
.Ltmp181:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 60
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 61
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 488
.Ltmp182:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_121
.Ltmp183:
// %bb.375:
	jneq r6, r4, .LBB0_121
// %bb.376:
.LBB0_122:
.Ltmp184:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 61
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 62
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 496
.Ltmp185:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_123
.Ltmp186:
// %bb.377:
	jneq r6, r4, .LBB0_123
// %bb.378:
.LBB0_124:
.Ltmp187:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 62
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 63
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 504
.Ltmp188:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_125
.Ltmp189:
// %bb.379:
	jneq r6, r4, .LBB0_125
// %bb.380:
.LBB0_126:
.Ltmp190:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 63
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 64
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 512
.Ltmp191:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_127
.Ltmp192:
// %bb.381:
	jneq r6, r4, .LBB0_127
// %bb.382:
.LBB0_128:
.Ltmp193:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 64
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 65
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 520
.Ltmp194:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_129
.Ltmp195:
// %bb.383:
	jneq r6, r4, .LBB0_129
// %bb.384:
.LBB0_130:
.Ltmp196:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 65
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 66
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 528
.Ltmp197:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_131
.Ltmp198:
// %bb.385:
	jneq r6, r4, .LBB0_131
// %bb.386:
.LBB0_132:
.Ltmp199:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 66
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 67
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 536
.Ltmp200:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_133
.Ltmp201:
// %bb.387:
	jneq r6, r4, .LBB0_133
// %bb.388:
.LBB0_134:
.Ltmp202:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 67
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 68
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 544
.Ltmp203:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_135
.Ltmp204:
// %bb.389:
	jneq r6, r4, .LBB0_135
// %bb.390:
.LBB0_136:
.Ltmp205:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 68
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 69
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 552
.Ltmp206:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_137
.Ltmp207:
// %bb.391:
	jneq r6, r4, .LBB0_137
// %bb.392:
.LBB0_138:
.Ltmp208:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 69
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 70
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 560
.Ltmp209:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_139
.Ltmp210:
// %bb.393:
	jneq r6, r4, .LBB0_139
// %bb.394:
.LBB0_140:
.Ltmp211:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 70
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 71
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 568
.Ltmp212:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_141
.Ltmp213:
// %bb.395:
	jneq r6, r4, .LBB0_141
// %bb.396:
.LBB0_142:
.Ltmp214:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 71
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 72
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 576
.Ltmp215:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_143
.Ltmp216:
// %bb.397:
	jneq r6, r4, .LBB0_143
// %bb.398:
.LBB0_144:
.Ltmp217:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 72
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 73
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 584
.Ltmp218:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_145
.Ltmp219:
// %bb.399:
	jneq r6, r4, .LBB0_145
// %bb.400:
.LBB0_146:
.Ltmp220:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 73
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 74
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 592
.Ltmp221:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_147
.Ltmp222:
// %bb.401:
	jneq r6, r4, .LBB0_147
// %bb.402:
.LBB0_148:
.Ltmp223:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 74
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 75
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 600
.Ltmp224:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_149
.Ltmp225:
// %bb.403:
	jneq r6, r4, .LBB0_149
// %bb.404:
.LBB0_150:
.Ltmp226:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 75
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 76
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 608
.Ltmp227:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_151
.Ltmp228:
// %bb.405:
	jneq r6, r4, .LBB0_151
// %bb.406:
.LBB0_152:
.Ltmp229:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 76
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 77
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 616
.Ltmp230:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_153
.Ltmp231:
// %bb.407:
	jneq r6, r4, .LBB0_153
// %bb.408:
.LBB0_154:
.Ltmp232:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 77
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 78
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 624
.Ltmp233:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_155
.Ltmp234:
// %bb.409:
	jneq r6, r4, .LBB0_155
// %bb.410:
.LBB0_156:
.Ltmp235:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 78
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 79
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 632
.Ltmp236:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_157
.Ltmp237:
// %bb.411:
	jneq r6, r4, .LBB0_157
// %bb.412:
.LBB0_158:
.Ltmp238:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 79
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 80
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 640
.Ltmp239:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_159
.Ltmp240:
// %bb.413:
	jneq r6, r4, .LBB0_159
// %bb.414:
.LBB0_160:
.Ltmp241:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 80
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 81
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 648
.Ltmp242:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_161
.Ltmp243:
// %bb.415:
	jneq r6, r4, .LBB0_161
// %bb.416:
.LBB0_162:
.Ltmp244:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 81
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 82
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 656
.Ltmp245:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_163
.Ltmp246:
// %bb.417:
	jneq r6, r4, .LBB0_163
// %bb.418:
.LBB0_164:
.Ltmp247:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 82
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 83
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 664
.Ltmp248:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_165
.Ltmp249:
// %bb.419:
	jneq r6, r4, .LBB0_165
// %bb.420:
.LBB0_166:
.Ltmp250:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 83
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 84
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 672
.Ltmp251:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_167
.Ltmp252:
// %bb.421:
	jneq r6, r4, .LBB0_167
// %bb.422:
.LBB0_168:
.Ltmp253:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 84
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 85
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 680
.Ltmp254:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_169
.Ltmp255:
// %bb.423:
	jneq r6, r4, .LBB0_169
// %bb.424:
.LBB0_170:
.Ltmp256:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 85
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 86
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 688
.Ltmp257:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_171
.Ltmp258:
// %bb.425:
	jneq r6, r4, .LBB0_171
// %bb.426:
.LBB0_172:
.Ltmp259:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 86
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 87
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 696
.Ltmp260:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_173
.Ltmp261:
// %bb.427:
	jneq r6, r4, .LBB0_173
// %bb.428:
.LBB0_174:
.Ltmp262:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 87
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 88
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 704
.Ltmp263:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_175
.Ltmp264:
// %bb.429:
	jneq r6, r4, .LBB0_175
// %bb.430:
.LBB0_176:
.Ltmp265:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 88
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 89
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 712
.Ltmp266:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_177
.Ltmp267:
// %bb.431:
	jneq r6, r4, .LBB0_177
// %bb.432:
.LBB0_178:
.Ltmp268:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 89
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 90
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 720
.Ltmp269:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_179
.Ltmp270:
// %bb.433:
	jneq r6, r4, .LBB0_179
// %bb.434:
.LBB0_180:
.Ltmp271:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 90
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 91
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 728
.Ltmp272:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_181
.Ltmp273:
// %bb.435:
	jneq r6, r4, .LBB0_181
// %bb.436:
.LBB0_182:
.Ltmp274:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 91
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 92
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 736
.Ltmp275:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_183
.Ltmp276:
// %bb.437:
	jneq r6, r4, .LBB0_183
// %bb.438:
.LBB0_184:
.Ltmp277:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 92
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 93
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 744
.Ltmp278:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_185
.Ltmp279:
// %bb.439:
	jneq r6, r4, .LBB0_185
// %bb.440:
.LBB0_186:
.Ltmp280:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 93
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 94
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 752
.Ltmp281:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_187
.Ltmp282:
// %bb.441:
	jneq r6, r4, .LBB0_187
// %bb.442:
.LBB0_188:
.Ltmp283:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 94
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 95
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 760
.Ltmp284:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_189
.Ltmp285:
// %bb.443:
	jneq r6, r4, .LBB0_189
// %bb.444:
.LBB0_190:
.Ltmp286:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 95
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 96
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 768
.Ltmp287:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_191
.Ltmp288:
// %bb.445:
	jneq r6, r4, .LBB0_191
// %bb.446:
.LBB0_192:
.Ltmp289:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 96
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 97
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 776
.Ltmp290:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_193
.Ltmp291:
// %bb.447:
	jneq r6, r4, .LBB0_193
// %bb.448:
.LBB0_194:
.Ltmp292:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 97
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 98
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 784
.Ltmp293:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_195
.Ltmp294:
// %bb.449:
	jneq r6, r4, .LBB0_195
// %bb.450:
.LBB0_196:
.Ltmp295:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 98
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 99
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 792
.Ltmp296:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_197
.Ltmp297:
// %bb.451:
	jneq r6, r4, .LBB0_197
// %bb.452:
.LBB0_198:
.Ltmp298:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 99
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 100
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 800
.Ltmp299:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_199
.Ltmp300:
// %bb.453:
	jneq r6, r4, .LBB0_199
// %bb.454:
.LBB0_200:
.Ltmp301:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 100
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 101
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 808
.Ltmp302:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_201
.Ltmp303:
// %bb.455:
	jneq r6, r4, .LBB0_201
// %bb.456:
.LBB0_202:
.Ltmp304:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 101
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 102
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 816
.Ltmp305:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_203
.Ltmp306:
// %bb.457:
	jneq r6, r4, .LBB0_203
// %bb.458:
.LBB0_204:
.Ltmp307:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 102
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 103
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 824
.Ltmp308:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_205
.Ltmp309:
// %bb.459:
	jneq r6, r4, .LBB0_205
// %bb.460:
.LBB0_206:
.Ltmp310:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 103
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 104
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 832
.Ltmp311:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_207
.Ltmp312:
// %bb.461:
	jneq r6, r4, .LBB0_207
// %bb.462:
.LBB0_208:
.Ltmp313:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 104
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 105
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 840
.Ltmp314:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_209
.Ltmp315:
// %bb.463:
	jneq r6, r4, .LBB0_209
// %bb.464:
.LBB0_210:
.Ltmp316:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 105
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 106
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 848
.Ltmp317:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_211
.Ltmp318:
// %bb.465:
	jneq r6, r4, .LBB0_211
// %bb.466:
.LBB0_212:
.Ltmp319:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 106
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 107
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 856
.Ltmp320:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_213
.Ltmp321:
// %bb.467:
	jneq r6, r4, .LBB0_213
// %bb.468:
.LBB0_214:
.Ltmp322:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 107
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 108
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 864
.Ltmp323:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_215
.Ltmp324:
// %bb.469:
	jneq r6, r4, .LBB0_215
// %bb.470:
.LBB0_216:
.Ltmp325:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 108
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 109
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 872
.Ltmp326:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_217
.Ltmp327:
// %bb.471:
	jneq r6, r4, .LBB0_217
// %bb.472:
.LBB0_218:
.Ltmp328:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 109
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 110
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 880
.Ltmp329:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_219
.Ltmp330:
// %bb.473:
	jneq r6, r4, .LBB0_219
// %bb.474:
.LBB0_220:
.Ltmp331:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 110
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 111
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 888
.Ltmp332:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_221
.Ltmp333:
// %bb.475:
	jneq r6, r4, .LBB0_221
// %bb.476:
.LBB0_222:
.Ltmp334:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 111
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 112
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 896
.Ltmp335:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_223
.Ltmp336:
// %bb.477:
	jneq r6, r4, .LBB0_223
// %bb.478:
.LBB0_224:
.Ltmp337:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 112
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 113
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 904
.Ltmp338:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_225
.Ltmp339:
// %bb.479:
	jneq r6, r4, .LBB0_225
// %bb.480:
.LBB0_226:
.Ltmp340:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 113
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 114
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 912
.Ltmp341:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_227
.Ltmp342:
// %bb.481:
	jneq r6, r4, .LBB0_227
// %bb.482:
.LBB0_228:
.Ltmp343:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 114
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 115
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 920
.Ltmp344:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_229
.Ltmp345:
// %bb.483:
	jneq r6, r4, .LBB0_229
// %bb.484:
.LBB0_230:
.Ltmp346:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 115
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 116
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 928
.Ltmp347:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_231
.Ltmp348:
// %bb.485:
	jneq r6, r4, .LBB0_231
// %bb.486:
.LBB0_232:
.Ltmp349:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 116
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 117
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 936
.Ltmp350:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_233
.Ltmp351:
// %bb.487:
	jneq r6, r4, .LBB0_233
// %bb.488:
.LBB0_234:
.Ltmp352:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 117
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 118
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 944
.Ltmp353:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_235
.Ltmp354:
// %bb.489:
	jneq r6, r4, .LBB0_235
// %bb.490:
.LBB0_236:
.Ltmp355:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 118
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 119
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 952
.Ltmp356:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_237
.Ltmp357:
// %bb.491:
	jneq r6, r4, .LBB0_237
// %bb.492:
.LBB0_238:
.Ltmp358:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 119
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 120
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 960
.Ltmp359:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_239
.Ltmp360:
// %bb.493:
	jneq r6, r4, .LBB0_239
// %bb.494:
.LBB0_240:
.Ltmp361:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 120
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 121
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 968
.Ltmp362:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_241
.Ltmp363:
// %bb.495:
	jneq r6, r4, .LBB0_241
// %bb.496:
.LBB0_242:
.Ltmp364:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 121
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 122
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 976
.Ltmp365:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_243
.Ltmp366:
// %bb.497:
	jneq r6, r4, .LBB0_243
// %bb.498:
.LBB0_244:
.Ltmp367:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 122
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 123
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 984
.Ltmp368:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_245
.Ltmp369:
// %bb.499:
	jneq r6, r4, .LBB0_245
// %bb.500:
.LBB0_246:
.Ltmp370:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 123
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 124
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 992
.Ltmp371:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_247
.Ltmp372:
// %bb.501:
	jneq r6, r4, .LBB0_247
// %bb.502:
.LBB0_248:
.Ltmp373:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 124
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 125
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1000
.Ltmp374:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_249
.Ltmp375:
// %bb.503:
	jneq r6, r4, .LBB0_249
// %bb.504:
.LBB0_250:
.Ltmp376:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 125
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 126
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1008
.Ltmp377:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_251
.Ltmp378:
// %bb.505:
	jneq r6, r4, .LBB0_251
// %bb.506:
.LBB0_252:
.Ltmp379:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 126
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 127
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1016
.Ltmp380:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_253
.Ltmp381:
// %bb.507:
	jneq r6, r4, .LBB0_253
.Ltmp382:
// %bb.508:
.LBB0_254:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	.loc	1 0 0                           // UNI/dpu/task.c:0:0
	move r0, r2
.Ltmp383:
	//DEBUG_VALUE: j <- 128
	//DEBUG_VALUE: unique:pos <- $r0
	.loc	1 38 5 is_stmt 1                // UNI/dpu/task.c:38:5
	jump r23
.Ltmp384:
.LBB0_1:
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: unique:pos <- 1
	//DEBUG_VALUE: j <- 1
	.loc	1 34 25                         // UNI/dpu/task.c:34:25
	sd r0, 8, d4
.Ltmp385:
	//DEBUG_VALUE: unique:pos <- 2
	.loc	1 33 24                         // UNI/dpu/task.c:33:24
	ld d4, r1, 8
	move r2, 2
.Ltmp386:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 2
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	ld d6, r1, 16
.Ltmp387:
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_510
.Ltmp388:
// %bb.509:
	jeq r6, r4, .LBB0_4
.LBB0_510:
.LBB0_3:
.Ltmp389:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 2
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp390:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 16
.Ltmp391:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp392:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 3
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 24
.Ltmp393:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_512
.Ltmp394:
// %bb.511:
	jeq r6, r4, .LBB0_6
.LBB0_512:
.LBB0_5:
.Ltmp395:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 3
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp396:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 24
.Ltmp397:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp398:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 4
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 32
.Ltmp399:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_514
.Ltmp400:
// %bb.513:
	jeq r6, r4, .LBB0_8
.LBB0_514:
.LBB0_7:
.Ltmp401:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 4
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp402:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 32
.Ltmp403:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp404:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 5
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 40
.Ltmp405:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_516
.Ltmp406:
// %bb.515:
	jeq r6, r4, .LBB0_10
.LBB0_516:
.LBB0_9:
.Ltmp407:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 5
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp408:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 40
.Ltmp409:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp410:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 6
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 48
.Ltmp411:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_518
.Ltmp412:
// %bb.517:
	jeq r6, r4, .LBB0_12
.LBB0_518:
.LBB0_11:
.Ltmp413:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 6
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp414:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 48
.Ltmp415:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp416:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 7
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 56
.Ltmp417:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_520
.Ltmp418:
// %bb.519:
	jeq r6, r4, .LBB0_14
.LBB0_520:
.LBB0_13:
.Ltmp419:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 7
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp420:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 56
.Ltmp421:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp422:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 8
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 64
.Ltmp423:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_522
.Ltmp424:
// %bb.521:
	jeq r6, r4, .LBB0_16
.LBB0_522:
.LBB0_15:
.Ltmp425:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 8
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp426:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 64
.Ltmp427:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp428:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 9
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 72
.Ltmp429:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_524
.Ltmp430:
// %bb.523:
	jeq r6, r4, .LBB0_18
.LBB0_524:
.LBB0_17:
.Ltmp431:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 9
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp432:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 72
.Ltmp433:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp434:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 10
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 80
.Ltmp435:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_526
.Ltmp436:
// %bb.525:
	jeq r6, r4, .LBB0_20
.LBB0_526:
.LBB0_19:
.Ltmp437:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 10
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp438:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 80
.Ltmp439:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp440:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 11
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 88
.Ltmp441:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_528
.Ltmp442:
// %bb.527:
	jeq r6, r4, .LBB0_22
.LBB0_528:
.LBB0_21:
.Ltmp443:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 11
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp444:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 88
.Ltmp445:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp446:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 12
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 96
.Ltmp447:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_530
.Ltmp448:
// %bb.529:
	jeq r6, r4, .LBB0_24
.LBB0_530:
.LBB0_23:
.Ltmp449:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 12
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp450:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 96
.Ltmp451:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp452:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 13
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 104
.Ltmp453:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_532
.Ltmp454:
// %bb.531:
	jeq r6, r4, .LBB0_26
.LBB0_532:
.LBB0_25:
.Ltmp455:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 13
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp456:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 104
.Ltmp457:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp458:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 14
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 112
.Ltmp459:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_534
.Ltmp460:
// %bb.533:
	jeq r6, r4, .LBB0_28
.LBB0_534:
.LBB0_27:
.Ltmp461:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 14
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp462:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 112
.Ltmp463:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp464:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 15
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 120
.Ltmp465:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_536
.Ltmp466:
// %bb.535:
	jeq r6, r4, .LBB0_30
.LBB0_536:
.LBB0_29:
.Ltmp467:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 15
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp468:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 120
.Ltmp469:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp470:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 16
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 128
.Ltmp471:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_538
.Ltmp472:
// %bb.537:
	jeq r6, r4, .LBB0_32
.LBB0_538:
.LBB0_31:
.Ltmp473:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 16
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp474:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 128
.Ltmp475:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp476:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 17
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 136
.Ltmp477:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_540
.Ltmp478:
// %bb.539:
	jeq r6, r4, .LBB0_34
.LBB0_540:
.LBB0_33:
.Ltmp479:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 17
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp480:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 136
.Ltmp481:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp482:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 18
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 144
.Ltmp483:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_542
.Ltmp484:
// %bb.541:
	jeq r6, r4, .LBB0_36
.LBB0_542:
.LBB0_35:
.Ltmp485:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 18
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp486:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 144
.Ltmp487:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp488:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 19
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 152
.Ltmp489:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_544
.Ltmp490:
// %bb.543:
	jeq r6, r4, .LBB0_38
.LBB0_544:
.LBB0_37:
.Ltmp491:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 19
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp492:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 152
.Ltmp493:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp494:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 20
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 160
.Ltmp495:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_546
.Ltmp496:
// %bb.545:
	jeq r6, r4, .LBB0_40
.LBB0_546:
.LBB0_39:
.Ltmp497:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 20
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp498:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 160
.Ltmp499:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp500:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 21
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 168
.Ltmp501:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_548
.Ltmp502:
// %bb.547:
	jeq r6, r4, .LBB0_42
.LBB0_548:
.LBB0_41:
.Ltmp503:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 21
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp504:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 168
.Ltmp505:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp506:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 22
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 176
.Ltmp507:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_550
.Ltmp508:
// %bb.549:
	jeq r6, r4, .LBB0_44
.LBB0_550:
.LBB0_43:
.Ltmp509:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 22
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp510:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 176
.Ltmp511:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp512:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 23
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 184
.Ltmp513:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_552
.Ltmp514:
// %bb.551:
	jeq r6, r4, .LBB0_46
.LBB0_552:
.LBB0_45:
.Ltmp515:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 23
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp516:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 184
.Ltmp517:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp518:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 24
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 192
.Ltmp519:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_554
.Ltmp520:
// %bb.553:
	jeq r6, r4, .LBB0_48
.LBB0_554:
.LBB0_47:
.Ltmp521:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 24
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp522:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 192
.Ltmp523:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp524:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 25
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 200
.Ltmp525:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_556
.Ltmp526:
// %bb.555:
	jeq r6, r4, .LBB0_50
.LBB0_556:
.LBB0_49:
.Ltmp527:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 25
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp528:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 200
.Ltmp529:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp530:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 26
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 208
.Ltmp531:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_558
.Ltmp532:
// %bb.557:
	jeq r6, r4, .LBB0_52
.LBB0_558:
.LBB0_51:
.Ltmp533:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 26
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp534:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 208
.Ltmp535:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp536:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 27
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 216
.Ltmp537:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_560
.Ltmp538:
// %bb.559:
	jeq r6, r4, .LBB0_54
.LBB0_560:
.LBB0_53:
.Ltmp539:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 27
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp540:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 216
.Ltmp541:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp542:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 28
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 224
.Ltmp543:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_562
.Ltmp544:
// %bb.561:
	jeq r6, r4, .LBB0_56
.LBB0_562:
.LBB0_55:
.Ltmp545:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 28
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp546:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 224
.Ltmp547:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp548:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 29
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 232
.Ltmp549:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_564
.Ltmp550:
// %bb.563:
	jeq r6, r4, .LBB0_58
.LBB0_564:
.LBB0_57:
.Ltmp551:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 29
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp552:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 232
.Ltmp553:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp554:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 30
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 240
.Ltmp555:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_566
.Ltmp556:
// %bb.565:
	jeq r6, r4, .LBB0_60
.LBB0_566:
.LBB0_59:
.Ltmp557:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 30
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp558:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 240
.Ltmp559:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp560:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 31
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 248
.Ltmp561:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_568
.Ltmp562:
// %bb.567:
	jeq r6, r4, .LBB0_62
.LBB0_568:
.LBB0_61:
.Ltmp563:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 31
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp564:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 248
.Ltmp565:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp566:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 32
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 256
.Ltmp567:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_570
.Ltmp568:
// %bb.569:
	jeq r6, r4, .LBB0_64
.LBB0_570:
.LBB0_63:
.Ltmp569:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 32
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp570:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 256
.Ltmp571:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp572:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 33
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 264
.Ltmp573:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_572
.Ltmp574:
// %bb.571:
	jeq r6, r4, .LBB0_66
.LBB0_572:
.LBB0_65:
.Ltmp575:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 33
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp576:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 264
.Ltmp577:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp578:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 34
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 272
.Ltmp579:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_574
.Ltmp580:
// %bb.573:
	jeq r6, r4, .LBB0_68
.LBB0_574:
.LBB0_67:
.Ltmp581:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 34
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp582:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 272
.Ltmp583:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp584:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 35
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 280
.Ltmp585:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_576
.Ltmp586:
// %bb.575:
	jeq r6, r4, .LBB0_70
.LBB0_576:
.LBB0_69:
.Ltmp587:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 35
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp588:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 280
.Ltmp589:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp590:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 36
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 288
.Ltmp591:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_578
.Ltmp592:
// %bb.577:
	jeq r6, r4, .LBB0_72
.LBB0_578:
.LBB0_71:
.Ltmp593:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 36
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp594:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 288
.Ltmp595:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp596:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 37
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 296
.Ltmp597:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_580
.Ltmp598:
// %bb.579:
	jeq r6, r4, .LBB0_74
.LBB0_580:
.LBB0_73:
.Ltmp599:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 37
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp600:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 296
.Ltmp601:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp602:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 38
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 304
.Ltmp603:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_582
.Ltmp604:
// %bb.581:
	jeq r6, r4, .LBB0_76
.LBB0_582:
.LBB0_75:
.Ltmp605:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 38
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp606:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 304
.Ltmp607:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp608:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 39
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 312
.Ltmp609:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_584
.Ltmp610:
// %bb.583:
	jeq r6, r4, .LBB0_78
.LBB0_584:
.LBB0_77:
.Ltmp611:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 39
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp612:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 312
.Ltmp613:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp614:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 40
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 320
.Ltmp615:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_586
.Ltmp616:
// %bb.585:
	jeq r6, r4, .LBB0_80
.LBB0_586:
.LBB0_79:
.Ltmp617:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 40
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp618:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 320
.Ltmp619:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp620:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 41
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 328
.Ltmp621:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_588
.Ltmp622:
// %bb.587:
	jeq r6, r4, .LBB0_82
.LBB0_588:
.LBB0_81:
.Ltmp623:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 41
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp624:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 328
.Ltmp625:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp626:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 42
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 336
.Ltmp627:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_590
.Ltmp628:
// %bb.589:
	jeq r6, r4, .LBB0_84
.LBB0_590:
.LBB0_83:
.Ltmp629:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 42
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp630:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 336
.Ltmp631:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp632:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 43
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 344
.Ltmp633:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_592
.Ltmp634:
// %bb.591:
	jeq r6, r4, .LBB0_86
.LBB0_592:
.LBB0_85:
.Ltmp635:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 43
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp636:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 344
.Ltmp637:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp638:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 44
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 352
.Ltmp639:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_594
.Ltmp640:
// %bb.593:
	jeq r6, r4, .LBB0_88
.LBB0_594:
.LBB0_87:
.Ltmp641:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 44
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp642:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 352
.Ltmp643:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp644:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 45
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 360
.Ltmp645:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_596
.Ltmp646:
// %bb.595:
	jeq r6, r4, .LBB0_90
.LBB0_596:
.LBB0_89:
.Ltmp647:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 45
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp648:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 360
.Ltmp649:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp650:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 46
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 368
.Ltmp651:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_598
.Ltmp652:
// %bb.597:
	jeq r6, r4, .LBB0_92
.LBB0_598:
.LBB0_91:
.Ltmp653:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 46
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp654:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 368
.Ltmp655:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp656:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 47
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 376
.Ltmp657:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_600
.Ltmp658:
// %bb.599:
	jeq r6, r4, .LBB0_94
.LBB0_600:
.LBB0_93:
.Ltmp659:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 47
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp660:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 376
.Ltmp661:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp662:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 48
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 384
.Ltmp663:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_602
.Ltmp664:
// %bb.601:
	jeq r6, r4, .LBB0_96
.LBB0_602:
.LBB0_95:
.Ltmp665:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 48
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp666:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 384
.Ltmp667:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp668:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 49
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 392
.Ltmp669:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_604
.Ltmp670:
// %bb.603:
	jeq r6, r4, .LBB0_98
.LBB0_604:
.LBB0_97:
.Ltmp671:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 49
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp672:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 392
.Ltmp673:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp674:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 50
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 400
.Ltmp675:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_606
.Ltmp676:
// %bb.605:
	jeq r6, r4, .LBB0_100
.LBB0_606:
.LBB0_99:
.Ltmp677:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 50
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp678:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 400
.Ltmp679:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp680:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 51
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 408
.Ltmp681:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_608
.Ltmp682:
// %bb.607:
	jeq r6, r4, .LBB0_102
.LBB0_608:
.LBB0_101:
.Ltmp683:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 51
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp684:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 408
.Ltmp685:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp686:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 52
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 416
.Ltmp687:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_610
.Ltmp688:
// %bb.609:
	jeq r6, r4, .LBB0_104
.LBB0_610:
.LBB0_103:
.Ltmp689:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 52
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp690:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 416
.Ltmp691:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp692:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 53
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 424
.Ltmp693:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_612
.Ltmp694:
// %bb.611:
	jeq r6, r4, .LBB0_106
.LBB0_612:
.LBB0_105:
.Ltmp695:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 53
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp696:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 424
.Ltmp697:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp698:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 54
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 432
.Ltmp699:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_614
.Ltmp700:
// %bb.613:
	jeq r6, r4, .LBB0_108
.LBB0_614:
.LBB0_107:
.Ltmp701:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 54
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp702:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 432
.Ltmp703:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp704:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 55
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 440
.Ltmp705:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_616
.Ltmp706:
// %bb.615:
	jeq r6, r4, .LBB0_110
.LBB0_616:
.LBB0_109:
.Ltmp707:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 55
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp708:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 440
.Ltmp709:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp710:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 56
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 448
.Ltmp711:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_618
.Ltmp712:
// %bb.617:
	jeq r6, r4, .LBB0_112
.LBB0_618:
.LBB0_111:
.Ltmp713:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 56
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp714:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 448
.Ltmp715:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp716:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 57
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 456
.Ltmp717:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_620
.Ltmp718:
// %bb.619:
	jeq r6, r4, .LBB0_114
.LBB0_620:
.LBB0_113:
.Ltmp719:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 57
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp720:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 456
.Ltmp721:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp722:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 58
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 464
.Ltmp723:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_622
.Ltmp724:
// %bb.621:
	jeq r6, r4, .LBB0_116
.LBB0_622:
.LBB0_115:
.Ltmp725:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 58
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp726:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 464
.Ltmp727:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp728:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 59
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 472
.Ltmp729:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_624
.Ltmp730:
// %bb.623:
	jeq r6, r4, .LBB0_118
.LBB0_624:
.LBB0_117:
.Ltmp731:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 59
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp732:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 472
.Ltmp733:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp734:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 60
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 480
.Ltmp735:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_626
.Ltmp736:
// %bb.625:
	jeq r6, r4, .LBB0_120
.LBB0_626:
.LBB0_119:
.Ltmp737:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 60
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp738:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 480
.Ltmp739:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp740:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 61
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 488
.Ltmp741:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_628
.Ltmp742:
// %bb.627:
	jeq r6, r4, .LBB0_122
.LBB0_628:
.LBB0_121:
.Ltmp743:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 61
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp744:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 488
.Ltmp745:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp746:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 62
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 496
.Ltmp747:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_630
.Ltmp748:
// %bb.629:
	jeq r6, r4, .LBB0_124
.LBB0_630:
.LBB0_123:
.Ltmp749:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 62
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp750:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 496
.Ltmp751:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp752:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 63
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 504
.Ltmp753:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_632
.Ltmp754:
// %bb.631:
	jeq r6, r4, .LBB0_126
.LBB0_632:
.LBB0_125:
.Ltmp755:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 63
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp756:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 504
.Ltmp757:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp758:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 64
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 512
.Ltmp759:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_634
.Ltmp760:
// %bb.633:
	jeq r6, r4, .LBB0_128
.LBB0_634:
.LBB0_127:
.Ltmp761:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 64
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp762:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 512
.Ltmp763:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp764:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 65
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 520
.Ltmp765:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_636
.Ltmp766:
// %bb.635:
	jeq r6, r4, .LBB0_130
.LBB0_636:
.LBB0_129:
.Ltmp767:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 65
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp768:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 520
.Ltmp769:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp770:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 66
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 528
.Ltmp771:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_638
.Ltmp772:
// %bb.637:
	jeq r6, r4, .LBB0_132
.LBB0_638:
.LBB0_131:
.Ltmp773:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 66
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp774:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 528
.Ltmp775:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp776:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 67
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 536
.Ltmp777:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_640
.Ltmp778:
// %bb.639:
	jeq r6, r4, .LBB0_134
.LBB0_640:
.LBB0_133:
.Ltmp779:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 67
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp780:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 536
.Ltmp781:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp782:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 68
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 544
.Ltmp783:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_642
.Ltmp784:
// %bb.641:
	jeq r6, r4, .LBB0_136
.LBB0_642:
.LBB0_135:
.Ltmp785:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 68
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp786:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 544
.Ltmp787:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp788:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 69
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 552
.Ltmp789:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_644
.Ltmp790:
// %bb.643:
	jeq r6, r4, .LBB0_138
.LBB0_644:
.LBB0_137:
.Ltmp791:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 69
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp792:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 552
.Ltmp793:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp794:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 70
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 560
.Ltmp795:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_646
.Ltmp796:
// %bb.645:
	jeq r6, r4, .LBB0_140
.LBB0_646:
.LBB0_139:
.Ltmp797:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 70
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp798:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 560
.Ltmp799:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp800:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 71
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 568
.Ltmp801:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_648
.Ltmp802:
// %bb.647:
	jeq r6, r4, .LBB0_142
.LBB0_648:
.LBB0_141:
.Ltmp803:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 71
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp804:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 568
.Ltmp805:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp806:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 72
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 576
.Ltmp807:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_650
.Ltmp808:
// %bb.649:
	jeq r6, r4, .LBB0_144
.LBB0_650:
.LBB0_143:
.Ltmp809:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 72
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp810:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 576
.Ltmp811:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp812:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 73
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 584
.Ltmp813:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_652
.Ltmp814:
// %bb.651:
	jeq r6, r4, .LBB0_146
.LBB0_652:
.LBB0_145:
.Ltmp815:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 73
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp816:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 584
.Ltmp817:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp818:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 74
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 592
.Ltmp819:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_654
.Ltmp820:
// %bb.653:
	jeq r6, r4, .LBB0_148
.LBB0_654:
.LBB0_147:
.Ltmp821:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 74
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp822:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 592
.Ltmp823:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp824:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 75
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 600
.Ltmp825:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_656
.Ltmp826:
// %bb.655:
	jeq r6, r4, .LBB0_150
.LBB0_656:
.LBB0_149:
.Ltmp827:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 75
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp828:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 600
.Ltmp829:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp830:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 76
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 608
.Ltmp831:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_658
.Ltmp832:
// %bb.657:
	jeq r6, r4, .LBB0_152
.LBB0_658:
.LBB0_151:
.Ltmp833:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 76
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp834:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 608
.Ltmp835:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp836:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 77
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 616
.Ltmp837:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_660
.Ltmp838:
// %bb.659:
	jeq r6, r4, .LBB0_154
.LBB0_660:
.LBB0_153:
.Ltmp839:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 77
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp840:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 616
.Ltmp841:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp842:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 78
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 624
.Ltmp843:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_662
.Ltmp844:
// %bb.661:
	jeq r6, r4, .LBB0_156
.LBB0_662:
.LBB0_155:
.Ltmp845:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 78
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp846:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 624
.Ltmp847:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp848:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 79
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 632
.Ltmp849:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_664
.Ltmp850:
// %bb.663:
	jeq r6, r4, .LBB0_158
.LBB0_664:
.LBB0_157:
.Ltmp851:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 79
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp852:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 632
.Ltmp853:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp854:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 80
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 640
.Ltmp855:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_666
.Ltmp856:
// %bb.665:
	jeq r6, r4, .LBB0_160
.LBB0_666:
.LBB0_159:
.Ltmp857:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 80
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp858:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 640
.Ltmp859:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp860:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 81
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 648
.Ltmp861:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_668
.Ltmp862:
// %bb.667:
	jeq r6, r4, .LBB0_162
.LBB0_668:
.LBB0_161:
.Ltmp863:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 81
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp864:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 648
.Ltmp865:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp866:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 82
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 656
.Ltmp867:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_670
.Ltmp868:
// %bb.669:
	jeq r6, r4, .LBB0_164
.LBB0_670:
.LBB0_163:
.Ltmp869:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 82
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp870:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 656
.Ltmp871:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp872:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 83
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 664
.Ltmp873:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_672
.Ltmp874:
// %bb.671:
	jeq r6, r4, .LBB0_166
.LBB0_672:
.LBB0_165:
.Ltmp875:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 83
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp876:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 664
.Ltmp877:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp878:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 84
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 672
.Ltmp879:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_674
.Ltmp880:
// %bb.673:
	jeq r6, r4, .LBB0_168
.LBB0_674:
.LBB0_167:
.Ltmp881:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 84
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp882:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 672
.Ltmp883:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp884:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 85
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 680
.Ltmp885:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_676
.Ltmp886:
// %bb.675:
	jeq r6, r4, .LBB0_170
.LBB0_676:
.LBB0_169:
.Ltmp887:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 85
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp888:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 680
.Ltmp889:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp890:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 86
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 688
.Ltmp891:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_678
.Ltmp892:
// %bb.677:
	jeq r6, r4, .LBB0_172
.LBB0_678:
.LBB0_171:
.Ltmp893:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 86
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp894:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 688
.Ltmp895:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp896:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 87
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 696
.Ltmp897:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_680
.Ltmp898:
// %bb.679:
	jeq r6, r4, .LBB0_174
.LBB0_680:
.LBB0_173:
.Ltmp899:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 87
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp900:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 696
.Ltmp901:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp902:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 88
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 704
.Ltmp903:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_682
.Ltmp904:
// %bb.681:
	jeq r6, r4, .LBB0_176
.LBB0_682:
.LBB0_175:
.Ltmp905:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 88
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp906:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 704
.Ltmp907:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp908:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 89
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 712
.Ltmp909:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_684
.Ltmp910:
// %bb.683:
	jeq r6, r4, .LBB0_178
.LBB0_684:
.LBB0_177:
.Ltmp911:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 89
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp912:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 712
.Ltmp913:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp914:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 90
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 720
.Ltmp915:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_686
.Ltmp916:
// %bb.685:
	jeq r6, r4, .LBB0_180
.LBB0_686:
.LBB0_179:
.Ltmp917:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 90
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp918:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 720
.Ltmp919:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp920:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 91
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 728
.Ltmp921:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_688
.Ltmp922:
// %bb.687:
	jeq r6, r4, .LBB0_182
.LBB0_688:
.LBB0_181:
.Ltmp923:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 91
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp924:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 728
.Ltmp925:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp926:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 92
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 736
.Ltmp927:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_690
.Ltmp928:
// %bb.689:
	jeq r6, r4, .LBB0_184
.LBB0_690:
.LBB0_183:
.Ltmp929:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 92
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp930:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 736
.Ltmp931:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp932:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 93
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 744
.Ltmp933:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_692
.Ltmp934:
// %bb.691:
	jeq r6, r4, .LBB0_186
.LBB0_692:
.LBB0_185:
.Ltmp935:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 93
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp936:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 744
.Ltmp937:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp938:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 94
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 752
.Ltmp939:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_694
.Ltmp940:
// %bb.693:
	jeq r6, r4, .LBB0_188
.LBB0_694:
.LBB0_187:
.Ltmp941:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 94
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp942:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 752
.Ltmp943:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp944:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 95
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 760
.Ltmp945:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_696
.Ltmp946:
// %bb.695:
	jeq r6, r4, .LBB0_190
.LBB0_696:
.LBB0_189:
.Ltmp947:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 95
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp948:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 760
.Ltmp949:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp950:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 96
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 768
.Ltmp951:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_698
.Ltmp952:
// %bb.697:
	jeq r6, r4, .LBB0_192
.LBB0_698:
.LBB0_191:
.Ltmp953:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 96
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp954:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 768
.Ltmp955:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp956:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 97
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 776
.Ltmp957:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_700
.Ltmp958:
// %bb.699:
	jeq r6, r4, .LBB0_194
.LBB0_700:
.LBB0_193:
.Ltmp959:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 97
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp960:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 776
.Ltmp961:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp962:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 98
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 784
.Ltmp963:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_702
.Ltmp964:
// %bb.701:
	jeq r6, r4, .LBB0_196
.LBB0_702:
.LBB0_195:
.Ltmp965:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 98
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp966:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 784
.Ltmp967:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp968:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 99
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 792
.Ltmp969:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_704
.Ltmp970:
// %bb.703:
	jeq r6, r4, .LBB0_198
.LBB0_704:
.LBB0_197:
.Ltmp971:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 99
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp972:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 792
.Ltmp973:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp974:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 100
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 800
.Ltmp975:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_706
.Ltmp976:
// %bb.705:
	jeq r6, r4, .LBB0_200
.LBB0_706:
.LBB0_199:
.Ltmp977:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 100
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp978:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 800
.Ltmp979:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp980:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 101
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 808
.Ltmp981:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_708
.Ltmp982:
// %bb.707:
	jeq r6, r4, .LBB0_202
.LBB0_708:
.LBB0_201:
.Ltmp983:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 101
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp984:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 808
.Ltmp985:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp986:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 102
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 816
.Ltmp987:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_710
.Ltmp988:
// %bb.709:
	jeq r6, r4, .LBB0_204
.LBB0_710:
.LBB0_203:
.Ltmp989:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 102
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp990:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 816
.Ltmp991:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp992:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 103
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 824
.Ltmp993:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_712
.Ltmp994:
// %bb.711:
	jeq r6, r4, .LBB0_206
.LBB0_712:
.LBB0_205:
.Ltmp995:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 103
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp996:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 824
.Ltmp997:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp998:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 104
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 832
.Ltmp999:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_714
.Ltmp1000:
// %bb.713:
	jeq r6, r4, .LBB0_208
.LBB0_714:
.LBB0_207:
.Ltmp1001:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 104
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1002:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 832
.Ltmp1003:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1004:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 105
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 840
.Ltmp1005:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_716
.Ltmp1006:
// %bb.715:
	jeq r6, r4, .LBB0_210
.LBB0_716:
.LBB0_209:
.Ltmp1007:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 105
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1008:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 840
.Ltmp1009:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1010:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 106
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 848
.Ltmp1011:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_718
.Ltmp1012:
// %bb.717:
	jeq r6, r4, .LBB0_212
.LBB0_718:
.LBB0_211:
.Ltmp1013:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 106
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1014:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 848
.Ltmp1015:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1016:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 107
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 856
.Ltmp1017:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_720
.Ltmp1018:
// %bb.719:
	jeq r6, r4, .LBB0_214
.LBB0_720:
.LBB0_213:
.Ltmp1019:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 107
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1020:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 856
.Ltmp1021:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1022:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 108
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 864
.Ltmp1023:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_722
.Ltmp1024:
// %bb.721:
	jeq r6, r4, .LBB0_216
.LBB0_722:
.LBB0_215:
.Ltmp1025:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 108
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1026:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 864
.Ltmp1027:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1028:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 109
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 872
.Ltmp1029:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_724
.Ltmp1030:
// %bb.723:
	jeq r6, r4, .LBB0_218
.LBB0_724:
.LBB0_217:
.Ltmp1031:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 109
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1032:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 872
.Ltmp1033:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1034:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 110
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 880
.Ltmp1035:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_726
.Ltmp1036:
// %bb.725:
	jeq r6, r4, .LBB0_220
.LBB0_726:
.LBB0_219:
.Ltmp1037:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 110
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1038:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 880
.Ltmp1039:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1040:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 111
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 888
.Ltmp1041:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_728
.Ltmp1042:
// %bb.727:
	jeq r6, r4, .LBB0_222
.LBB0_728:
.LBB0_221:
.Ltmp1043:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 111
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1044:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 888
.Ltmp1045:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1046:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 112
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 896
.Ltmp1047:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_730
.Ltmp1048:
// %bb.729:
	jeq r6, r4, .LBB0_224
.LBB0_730:
.LBB0_223:
.Ltmp1049:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 112
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1050:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 896
.Ltmp1051:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1052:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 113
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 904
.Ltmp1053:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_732
.Ltmp1054:
// %bb.731:
	jeq r6, r4, .LBB0_226
.LBB0_732:
.LBB0_225:
.Ltmp1055:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 113
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1056:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 904
.Ltmp1057:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1058:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 114
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 912
.Ltmp1059:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_734
.Ltmp1060:
// %bb.733:
	jeq r6, r4, .LBB0_228
.LBB0_734:
.LBB0_227:
.Ltmp1061:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 114
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1062:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 912
.Ltmp1063:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1064:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 115
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 920
.Ltmp1065:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_736
.Ltmp1066:
// %bb.735:
	jeq r6, r4, .LBB0_230
.LBB0_736:
.LBB0_229:
.Ltmp1067:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 115
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1068:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 920
.Ltmp1069:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1070:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 116
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 928
.Ltmp1071:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_738
.Ltmp1072:
// %bb.737:
	jeq r6, r4, .LBB0_232
.LBB0_738:
.LBB0_231:
.Ltmp1073:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 116
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1074:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 928
.Ltmp1075:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1076:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 117
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 936
.Ltmp1077:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_740
.Ltmp1078:
// %bb.739:
	jeq r6, r4, .LBB0_234
.LBB0_740:
.LBB0_233:
.Ltmp1079:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 117
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1080:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 936
.Ltmp1081:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1082:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 118
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 944
.Ltmp1083:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_742
.Ltmp1084:
// %bb.741:
	jeq r6, r4, .LBB0_236
.LBB0_742:
.LBB0_235:
.Ltmp1085:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 118
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1086:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 944
.Ltmp1087:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1088:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 119
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 952
.Ltmp1089:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_744
.Ltmp1090:
// %bb.743:
	jeq r6, r4, .LBB0_238
.LBB0_744:
.LBB0_237:
.Ltmp1091:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 119
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1092:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 952
.Ltmp1093:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1094:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 120
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 960
.Ltmp1095:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_746
.Ltmp1096:
// %bb.745:
	jeq r6, r4, .LBB0_240
.LBB0_746:
.LBB0_239:
.Ltmp1097:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 120
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1098:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 960
.Ltmp1099:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1100:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 121
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 968
.Ltmp1101:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_748
.Ltmp1102:
// %bb.747:
	jeq r6, r4, .LBB0_242
.LBB0_748:
.LBB0_241:
.Ltmp1103:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 121
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1104:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 968
.Ltmp1105:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1106:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 122
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 976
.Ltmp1107:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_750
.Ltmp1108:
// %bb.749:
	jeq r6, r4, .LBB0_244
.LBB0_750:
.LBB0_243:
.Ltmp1109:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 122
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1110:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 976
.Ltmp1111:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1112:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 123
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 984
.Ltmp1113:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_752
.Ltmp1114:
// %bb.751:
	jeq r6, r4, .LBB0_246
.LBB0_752:
.LBB0_245:
.Ltmp1115:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 123
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1116:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 984
.Ltmp1117:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1118:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 124
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 992
.Ltmp1119:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_754
.Ltmp1120:
// %bb.753:
	jeq r6, r4, .LBB0_248
.LBB0_754:
.LBB0_247:
.Ltmp1121:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 124
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1122:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 992
.Ltmp1123:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1124:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 125
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1000
.Ltmp1125:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_756
.Ltmp1126:
// %bb.755:
	jeq r6, r4, .LBB0_250
.LBB0_756:
.LBB0_249:
.Ltmp1127:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 125
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1128:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 1000
.Ltmp1129:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1130:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 126
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1008
.Ltmp1131:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_758
.Ltmp1132:
// %bb.757:
	jeq r6, r4, .LBB0_252
.LBB0_758:
.LBB0_251:
.Ltmp1133:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 126
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r3, r0, r2, 3
	.loc	1 34 25 is_stmt 0               // UNI/dpu/task.c:34:25
	sd r3, 0, d6
.Ltmp1134:
	.loc	1 33 24 is_stmt 1               // UNI/dpu/task.c:33:24
	ld d4, r1, 1008
.Ltmp1135:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1136:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: j <- 127
	.loc	1 33 12                         // UNI/dpu/task.c:33:12
	ld d6, r1, 1016
.Ltmp1137:
	.loc	1 33 12 is_stmt 0               // UNI/dpu/task.c:33:12
	jneq r7, r5, .LBB0_760
.Ltmp1138:
// %bb.759:
	jeq r6, r4, .LBB0_254
.LBB0_760:
.LBB0_253:
.Ltmp1139:
	//DEBUG_VALUE: unique:pos <- $r2
	//DEBUG_VALUE: unique:input <- $r1
	//DEBUG_VALUE: unique:output <- $r0
	//DEBUG_VALUE: j <- 127
	.loc	1 34 13 is_stmt 1               // UNI/dpu/task.c:34:13
	lsl_add r0, r0, r2, 3
.Ltmp1140:
	.loc	1 35 16                         // UNI/dpu/task.c:35:16
	add r2, r2, 1
.Ltmp1141:
	//DEBUG_VALUE: unique:pos <- $r2
	.loc	1 34 25                         // UNI/dpu/task.c:34:25
	sd r0, 0, d6
.Ltmp1142:
	//DEBUG_VALUE: unique:pos <- $r2
	.loc	1 0 0 is_stmt 0                 // UNI/dpu/task.c:0:0
	move r0, r2
.Ltmp1143:
	//DEBUG_VALUE: j <- 128
	//DEBUG_VALUE: unique:pos <- $r0
	.loc	1 38 5 is_stmt 1                // UNI/dpu/task.c:38:5
	jump r23
.Ltmp1144:
.Lfunc_end0:
	.size	unique, .Lfunc_end0-unique
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.unique
	.long	.Lfunc_begin0
	.byte	0
	.section	.text.unique,"ax",@progbits
                                        // -- End function
	.section	.text.handshake_sync,"ax",@progbits
	.globl	handshake_sync                  // -- Begin function handshake_sync
	.type	handshake_sync,@function
handshake_sync:                         // @handshake_sync
.Lfunc_begin1:
	.loc	1 42 0                          // UNI/dpu/task.c:42:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: handshake_sync:output <- $r1
	//DEBUG_VALUE: handshake_sync:l_count <- $r2
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r3
	.cfi_def_cfa_offset -40
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 32, d22
	add r22, r22, 40
	.cfi_offset 15, -16
	.cfi_offset 14, -12
	sd r22, -16, d14
	.cfi_offset 17, -24
	.cfi_offset 16, -20
	sd r22, -24, d16
	.cfi_offset 19, -32
	.cfi_offset 18, -28
	sd r22, -32, d18
	.cfi_offset 21, -40
	.cfi_offset 20, -36
	sd r22, -40, d20
	move r17, r3
	move r15, r2
	move r16, r1
	move r14, r0
.Ltmp1145:
	//DEBUG_VALUE: handshake_sync:result <- [$r14+0]
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r17
	//DEBUG_VALUE: handshake_sync:l_count <- $r15
	//DEBUG_VALUE: handshake_sync:output <- $r16
	.loc	1 45 8 prologue_end             // UNI/dpu/task.c:45:8
	jeq r17, 0, .LBB1_1
.Ltmp1146:
// %bb.2:
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r17
	//DEBUG_VALUE: handshake_sync:output <- $r16
	//DEBUG_VALUE: handshake_sync:l_count <- $r15
	//DEBUG_VALUE: handshake_sync:result <- [$r14+0]
	.loc	1 46 39                         // UNI/dpu/task.c:46:39
	add r0, r17, -1
	.loc	1 46 9 is_stmt 0                // UNI/dpu/task.c:46:9
	call r23, handshake_wait_for
.Ltmp1147:
	.loc	1 47 19 is_stmt 1               // UNI/dpu/task.c:47:19
	lsl r0, r17, 2
	lw r18, r0, message
.Ltmp1148:
	//DEBUG_VALUE: handshake_sync:p_count <- $r18
	.loc	1 48 19                         // UNI/dpu/task.c:48:19
	lsl r1, r17, 3
	ld d2, r1, message_value
	.loc	1 48 48 is_stmt 0               // UNI/dpu/task.c:48:48
	ld d4, r16, 0
	.loc	1 49 19 is_stmt 1               // UNI/dpu/task.c:49:19
	lw r20, r0, message_offset
.Ltmp1149:
	//DEBUG_VALUE: handshake_sync:offset <- undef
	//DEBUG_VALUE: handshake_sync:o_count <- $r20
	.loc	1 48 45                         // UNI/dpu/task.c:48:45
	sub zero, r3, r5
	subc r19, r2, r4, xz
.Ltmp1150:
	//DEBUG_VALUE: handshake_sync:offset <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r19
	.loc	1 57 8                          // UNI/dpu/task.c:57:8
	jleu r17, 14, .LBB1_3
	jump .LBB1_4
.Ltmp1151:
.LBB1_1:
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r17
	//DEBUG_VALUE: handshake_sync:output <- $r16
	//DEBUG_VALUE: handshake_sync:l_count <- $r15
	//DEBUG_VALUE: handshake_sync:result <- [$r14+0]
	//DEBUG_VALUE: handshake_sync:p_count <- 0
	.loc	1 53 19                         // UNI/dpu/task.c:53:19
	ld d0, zero, message_last_from_last
	.loc	1 53 45 is_stmt 0               // UNI/dpu/task.c:53:45
	ld d2, r16, 0
	move r20, 0
.Ltmp1152:
	//DEBUG_VALUE: handshake_sync:o_count <- 0
	.loc	1 53 42                         // UNI/dpu/task.c:53:42
	sub zero, r1, r3
	subc r19, r0, r2, xz
.Ltmp1153:
	//DEBUG_VALUE: handshake_sync:offset <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r19
	.loc	1 0 42                          // UNI/dpu/task.c:0:42
	move r18, r20
.Ltmp1154:
.LBB1_3:
	//DEBUG_VALUE: handshake_sync:offset <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r19
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r17
	//DEBUG_VALUE: handshake_sync:output <- $r16
	//DEBUG_VALUE: handshake_sync:l_count <- $r15
	//DEBUG_VALUE: handshake_sync:result <- [$r14+0]
	.loc	1 58 43 is_stmt 1               // UNI/dpu/task.c:58:43
	add r0, r18, r15
	.loc	1 58 28 is_stmt 0               // UNI/dpu/task.c:58:28
	add r1, r17, 1
	.loc	1 58 9                          // UNI/dpu/task.c:58:9
	lsl r2, r1, 2
	.loc	1 58 33                         // UNI/dpu/task.c:58:33
	sw r2, message, r0
	.loc	1 59 41 is_stmt 1               // UNI/dpu/task.c:59:41
	lsl_add r0, r16, r15, 3
	ld d4, r0, -8
	.loc	1 59 9 is_stmt 0                // UNI/dpu/task.c:59:9
	lsl r0, r1, 3
	.loc	1 59 39                         // UNI/dpu/task.c:59:39
	sd r0, message_value, d4
	.loc	1 60 50 is_stmt 1               // UNI/dpu/task.c:60:50
	add r0, r20, r19
	.loc	1 60 40 is_stmt 0               // UNI/dpu/task.c:60:40
	sw r2, message_offset, r0
	.loc	1 61 9 is_stmt 1                // UNI/dpu/task.c:61:9
	call r23, handshake_notify
.Ltmp1155:
.LBB1_4:
	//DEBUG_VALUE: handshake_sync:offset <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r19
	//DEBUG_VALUE: handshake_sync:tasklet_id <- $r17
	//DEBUG_VALUE: handshake_sync:output <- $r16
	//DEBUG_VALUE: handshake_sync:l_count <- $r15
	//DEBUG_VALUE: handshake_sync:result <- [$r14+0]
	.loc	1 63 20                         // UNI/dpu/task.c:63:20
	sw r14, 0, r18
	sw r14, 4, r20
	sw r14, 8, r19
	.loc	1 65 1                          // UNI/dpu/task.c:65:1
	ld d20, r22, -40
	ld d18, r22, -32
.Ltmp1156:
	ld d16, r22, -24
.Ltmp1157:
	ld d14, r22, -16
.Ltmp1158:
	ld d22, r22, -8
	jump r23
.Ltmp1159:
.Lfunc_end1:
	.size	handshake_sync, .Lfunc_end1-handshake_sync
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.handshake_sync
	.long	.Lfunc_begin1
	.byte	40
	.section	.text.handshake_sync,"ax",@progbits
                                        // -- End function
	.section	.text.main_kernel1,"ax",@progbits
	.globl	main_kernel1                    // -- Begin function main_kernel1
	.type	main_kernel1,@function
main_kernel1:                           // @main_kernel1
.Lfunc_begin2:
	.loc	1 80 0                          // UNI/dpu/task.c:80:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -56
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 48, d22
	add r22, r22, 56
	.cfi_offset 15, -32
	.cfi_offset 14, -28
.Ltmp1160:
	sd r22, -32, d14
	.cfi_offset 17, -40
	.cfi_offset 16, -36
	sd r22, -40, d16
	.cfi_offset 19, -48
	.cfi_offset 18, -44
	sd r22, -48, d18
	.cfi_offset 21, -56
	.cfi_offset 20, -52
	sd r22, -56, d20
.Ltmp1161:
	//DEBUG_VALUE: main_kernel1:tasklet_id <- $r14
	.file	4 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/defs.h"
	.loc	4 35 12 prologue_end            // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/defs.h:35:12
	move r14, id, nz, .LBB2_2
.Ltmp1162:
// %bb.1:
	.loc	1 86 9                          // UNI/dpu/task.c:86:9
	call r23, mem_reset
.Ltmp1163:
.LBB2_2:
	.loc	1 89 5                          // UNI/dpu/task.c:89:5
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp1164:
	//DEBUG_VALUE: main_kernel1:result <- undef
	.loc	1 93 57                         // UNI/dpu/task.c:93:57
	lw r18, zero, DPU_INPUT_ARGUMENTS
.Ltmp1165:
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	.loc	1 96 40                         // UNI/dpu/task.c:96:40
	lsl r19, r14, 10
.Ltmp1166:
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- undef
	//DEBUG_VALUE: main_kernel1:base_tasklet <- $r19
	.loc	1 0 40 is_stmt 0                // UNI/dpu/task.c:0:40
	move r16, 1024
	.loc	1 101 24 is_stmt 1              // UNI/dpu/task.c:101:24
	move r0, r16
	call r23, mem_alloc
.Ltmp1167:
	move r15, r0
.Ltmp1168:
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 102 24                        // UNI/dpu/task.c:102:24
	move r0, r16
	call r23, mem_alloc
.Ltmp1169:
	move r16, r0
.Ltmp1170:
	//DEBUG_VALUE: main_kernel1:mram_base_addr_A <- undef
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	.loc	1 105 8                         // UNI/dpu/task.c:105:8
	jneq r14, 15, .LBB2_4
.Ltmp1171:
// %bb.3:
	//DEBUG_VALUE: main_kernel1:base_tasklet <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 106 31                        // UNI/dpu/task.c:106:31
	move r0, message_partial_count
	sw r0, 0, 0
	move.u d0, 4294967295
	.loc	1 107 32                        // UNI/dpu/task.c:107:32
	sd zero, message_last_from_last, d0
.Ltmp1172:
.LBB2_4:
	//DEBUG_VALUE: main_kernel1:base_tasklet <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- undef
	.loc	1 110 5                         // UNI/dpu/task.c:110:5
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp1173:
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:i <- 0
	.loc	1 113 5                         // UNI/dpu/task.c:113:5
	jgeu r19, r18, .LBB2_11
.Ltmp1174:
// %bb.5:
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:base_tasklet <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	//DEBUG_VALUE: main_kernel1:i <- 0
	.loc	1 0 5 is_stmt 0                 // UNI/dpu/task.c:0:5
	move r0, __sys_used_mram_end
	add r20, r0, r18
.Ltmp1175:
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	move r21, 0, true, .LBB2_6
.Ltmp1176:
.LBB2_10:                               //   in Loop: Header=BB2_6 Depth=1
	//DEBUG_VALUE: main_kernel1:i <- $r21
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: l_count <- $r17
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 141 9 is_stmt 1               // UNI/dpu/task.c:141:9
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp1177:
	.loc	1 113 95                        // UNI/dpu/task.c:113:95
	add r19, r19, 16384
.Ltmp1178:
	//DEBUG_VALUE: byte_index <- $r19
	.loc	1 143 10                        // UNI/dpu/task.c:143:10
	add r21, r21, 1
.Ltmp1179:
	//DEBUG_VALUE: main_kernel1:i <- $r21
	.loc	1 113 5                         // UNI/dpu/task.c:113:5
	jgeu r19, r18, .LBB2_11
.Ltmp1180:
.LBB2_6:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	//DEBUG_VALUE: main_kernel1:i <- $r21
	//DEBUG_VALUE: byte_index <- $r19
	.loc	1 116 61                        // UNI/dpu/task.c:116:61
	move r0, __sys_used_mram_end
	add r0, r19, r0
.Ltmp1181:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- 1024
	//DEBUG_VALUE: mram_read:to <- $r15
	//DEBUG_VALUE: mram_read:from <- $r0
	.file	5 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h"
	.loc	5 39 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:39:24
	ldma r15, r0, 127
.Ltmp1182:
	.loc	1 119 32                        // UNI/dpu/task.c:119:32
	move r0, r16
.Ltmp1183:
	move r1, r15
	call r23, unique
.Ltmp1184:
	move r17, r0
.Ltmp1185:
	//DEBUG_VALUE: l_count <- $r17
	.loc	1 0 32 is_stmt 0                // UNI/dpu/task.c:0:32
	add r0, r22, -24
	.loc	1 122 26 is_stmt 1              // UNI/dpu/task.c:122:26
	move r1, r16
	move r2, r17
	move r3, r14
	call r23, handshake_sync
.Ltmp1186:
	.loc	1 125 38                        // UNI/dpu/task.c:125:38
	lw r0, r22, -16
	.loc	1 125 81 is_stmt 0              // UNI/dpu/task.c:125:81
	lw r3, zero, message_partial_count
	.loc	1 125 114                       // UNI/dpu/task.c:125:114
	lw r1, r22, -24
	.loc	1 125 127                       // UNI/dpu/task.c:125:127
	lw r2, r22, -20
	.loc	1 125 21                        // UNI/dpu/task.c:125:21
	lsl_add r4, r16, r0, 3
	.loc	1 125 103                       // UNI/dpu/task.c:125:103
	add r3, r1, r3
	.loc	1 125 116                       // UNI/dpu/task.c:125:116
	sub r3, r3, r2
	.loc	1 125 78                        // UNI/dpu/task.c:125:78
	lsl_add r3, r20, r3, 3
.Ltmp1187:
	//DEBUG_VALUE: mram_write:to <- $r3
	//DEBUG_VALUE: mram_write:from <- $r4
	//DEBUG_VALUE: mram_write:nb_of_bytes <- [DW_OP_constu 3, DW_OP_shl, DW_OP_stack_value] $r17
	.loc	5 61 24 is_stmt 1               // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:61:24
	and r5, r17, 536870911
	add r5, r5, -1
	lsl_add r4, r4, r5, 24
.Ltmp1188:
	sdma r4, r3, 0
.Ltmp1189:
	.loc	1 128 28                        // UNI/dpu/task.c:128:28
	or r3, r21, r14, z, .LBB2_7
.Ltmp1190:
// %bb.8:                               //   in Loop: Header=BB2_6 Depth=1
	//DEBUG_VALUE: main_kernel1:i <- $r21
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: l_count <- $r17
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 133 12                        // UNI/dpu/task.c:133:12
	jneq r14, 15, .LBB2_10
	jump .LBB2_9
.Ltmp1191:
.LBB2_7:                                //   in Loop: Header=BB2_6 Depth=1
	//DEBUG_VALUE: main_kernel1:i <- $r21
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: l_count <- $r17
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 129 29                        // UNI/dpu/task.c:129:29
	ld d4, r16, 0
	.loc	1 129 27 is_stmt 0              // UNI/dpu/task.c:129:27
	lsl r3, r14, 3
	lsl_add r3, r3, r14, 4
	move r6, DPU_RESULTS
	add r3, r6, r3
	sd r3, 8, d4
.Ltmp1192:
	.loc	1 133 12 is_stmt 1              // UNI/dpu/task.c:133:12
	jneq r14, 15, .LBB2_10
.Ltmp1193:
.LBB2_9:                                //   in Loop: Header=BB2_6 Depth=1
	//DEBUG_VALUE: main_kernel1:i <- $r21
	//DEBUG_VALUE: main_kernel1:mram_base_addr_B <- $r20
	//DEBUG_VALUE: byte_index <- $r19
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: l_count <- $r17
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 134 38                        // UNI/dpu/task.c:134:38
	lsl_add r3, r16, r17, 3
	ld d4, r3, -8
	.loc	1 134 36 is_stmt 0              // UNI/dpu/task.c:134:36
	sd zero, message_last_from_last, d4
	.loc	1 135 28 is_stmt 1              // UNI/dpu/task.c:135:28
	ld d4, r3, -8
	.loc	1 135 26 is_stmt 0              // UNI/dpu/task.c:135:26
	lsl r3, r14, 3
	lsl_add r3, r3, r14, 4
	move r6, DPU_RESULTS
	add r6, r6, r3
	sd r6, 16, d4
	.loc	1 136 31 is_stmt 1              // UNI/dpu/task.c:136:31
	lw r4, zero, message_partial_count
	.loc	1 136 76 is_stmt 0              // UNI/dpu/task.c:136:76
	add r1, r17, r1
	add r0, r0, r2
	sub r0, r1, r0
	.loc	1 136 89                        // UNI/dpu/task.c:136:89
	add r0, r0, r4
	.loc	1 136 29                        // UNI/dpu/task.c:136:29
	sw r3, DPU_RESULTS, r0
	.loc	1 137 35 is_stmt 1              // UNI/dpu/task.c:137:35
	sw zero, message_partial_count, r0
	jump .LBB2_10
.Ltmp1194:
.LBB2_11:
	//DEBUG_VALUE: main_kernel1:input_size_dpu_bytes <- $r18
	//DEBUG_VALUE: main_kernel1:cache_B <- $r16
	//DEBUG_VALUE: main_kernel1:cache_A <- $r15
	.loc	1 0 35 is_stmt 0                // UNI/dpu/task.c:0:35
	move r0, 0
	.loc	1 146 5 is_stmt 1               // UNI/dpu/task.c:146:5
	ld d20, r22, -56
	ld d18, r22, -48
.Ltmp1195:
	ld d16, r22, -40
.Ltmp1196:
	ld d14, r22, -32
.Ltmp1197:
	ld d22, r22, -8
	jump r23
.Ltmp1198:
.Lfunc_end2:
	.size	main_kernel1, .Lfunc_end2-main_kernel1
	.cfi_endproc
	.file	6 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/sysdef.h"
	.section	.stack_sizes,"o",@progbits,.text.main_kernel1
	.long	.Lfunc_begin2
	.byte	56
	.section	.text.main_kernel1,"ax",@progbits
                                        // -- End function
	.section	.text.main,"ax",@progbits
	.globl	main                            // -- Begin function main
	.type	main,@function
main:                                   // @main
.Lfunc_begin3:
	.loc	1 74 0                          // UNI/dpu/task.c:74:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -8
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 0, d22
	add r22, r22, 8
.Ltmp1199:
	.loc	1 76 40 prologue_end            // UNI/dpu/task.c:76:40
	move r0, DPU_INPUT_ARGUMENTS
	lw r0, r0, 4
	.loc	1 76 12 is_stmt 0               // UNI/dpu/task.c:76:12
	lsl r0, r0, 2
	lw r0, r0, kernels
	call r23, r0
.Ltmp1200:
	.loc	1 76 5                          // UNI/dpu/task.c:76:5
	ld d22, r22, -8
	jump r23
.Ltmp1201:
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.main
	.long	.Lfunc_begin3
	.byte	8
	.section	.text.main,"ax",@progbits
                                        // -- End function
	.type	message,@object                 // @message
	.section	.bss.message,"aw",@nobits
	.globl	message
	.p2align	2
message:
	.zero	64
	.size	message, 64

	.type	message_value,@object           // @message_value
	.section	.bss.message_value,"aw",@nobits
	.globl	message_value
	.p2align	3
message_value:
	.zero	128
	.size	message_value, 128

	.type	message_offset,@object          // @message_offset
	.section	.bss.message_offset,"aw",@nobits
	.globl	message_offset
	.p2align	2
message_offset:
	.zero	64
	.size	message_offset, 64

	.type	message_last_from_last,@object  // @message_last_from_last
	.section	.bss.message_last_from_last,"aw",@nobits
	.globl	message_last_from_last
	.p2align	3
message_last_from_last:
	.quad	0                               // 0x0
	.size	message_last_from_last, 8

	.type	kernels,@object                 // @kernels
	.section	.data.kernels,"aw",@progbits
	.globl	kernels
	.p2align	2
kernels:
	.long	main_kernel1
	.size	kernels, 4

	.type	DPU_INPUT_ARGUMENTS,@object     // @DPU_INPUT_ARGUMENTS
	.section	.dpu_host,"aw",@progbits
	.globl	DPU_INPUT_ARGUMENTS
	.p2align	3
DPU_INPUT_ARGUMENTS:
	.zero	8
	.size	DPU_INPUT_ARGUMENTS, 8

	.type	DPU_RESULTS,@object             // @DPU_RESULTS
	.globl	DPU_RESULTS
	.p2align	3
DPU_RESULTS:
	.zero	384
	.size	DPU_RESULTS, 384

	.type	message_partial_count,@object   // @message_partial_count
	.section	.bss.message_partial_count,"aw",@nobits
	.globl	message_partial_count
	.p2align	2
message_partial_count:
	.long	0                               // 0x0
	.size	message_partial_count, 4

	.type	__atomic_bit_barrier_my_barrier,@object // @__atomic_bit_barrier_my_barrier
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit_barrier_my_barrier
__atomic_bit_barrier_my_barrier:
	.byte	0                               // 0x0
	.size	__atomic_bit_barrier_my_barrier, 1

	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Lfunc_begin0-.Lfunc_begin0
	.long	.Ltmp3-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp4-.Lfunc_begin0
	.long	.Ltmp6-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp7-.Lfunc_begin0
	.long	.Ltmp9-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp10-.Lfunc_begin0
	.long	.Ltmp12-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp13-.Lfunc_begin0
	.long	.Ltmp15-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp16-.Lfunc_begin0
	.long	.Ltmp18-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp19-.Lfunc_begin0
	.long	.Ltmp21-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp22-.Lfunc_begin0
	.long	.Ltmp24-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp25-.Lfunc_begin0
	.long	.Ltmp27-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp28-.Lfunc_begin0
	.long	.Ltmp30-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp31-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp34-.Lfunc_begin0
	.long	.Ltmp36-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp37-.Lfunc_begin0
	.long	.Ltmp39-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp40-.Lfunc_begin0
	.long	.Ltmp42-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp43-.Lfunc_begin0
	.long	.Ltmp45-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp46-.Lfunc_begin0
	.long	.Ltmp48-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp49-.Lfunc_begin0
	.long	.Ltmp51-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp52-.Lfunc_begin0
	.long	.Ltmp54-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp55-.Lfunc_begin0
	.long	.Ltmp57-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp58-.Lfunc_begin0
	.long	.Ltmp60-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp61-.Lfunc_begin0
	.long	.Ltmp63-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp64-.Lfunc_begin0
	.long	.Ltmp66-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp67-.Lfunc_begin0
	.long	.Ltmp69-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp70-.Lfunc_begin0
	.long	.Ltmp72-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp73-.Lfunc_begin0
	.long	.Ltmp75-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp76-.Lfunc_begin0
	.long	.Ltmp78-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp79-.Lfunc_begin0
	.long	.Ltmp81-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp82-.Lfunc_begin0
	.long	.Ltmp84-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp85-.Lfunc_begin0
	.long	.Ltmp87-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp88-.Lfunc_begin0
	.long	.Ltmp90-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp91-.Lfunc_begin0
	.long	.Ltmp93-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp94-.Lfunc_begin0
	.long	.Ltmp96-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp97-.Lfunc_begin0
	.long	.Ltmp99-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp100-.Lfunc_begin0
	.long	.Ltmp102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp103-.Lfunc_begin0
	.long	.Ltmp105-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp106-.Lfunc_begin0
	.long	.Ltmp108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp109-.Lfunc_begin0
	.long	.Ltmp111-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp112-.Lfunc_begin0
	.long	.Ltmp114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp115-.Lfunc_begin0
	.long	.Ltmp117-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp118-.Lfunc_begin0
	.long	.Ltmp120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp121-.Lfunc_begin0
	.long	.Ltmp123-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp124-.Lfunc_begin0
	.long	.Ltmp126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp127-.Lfunc_begin0
	.long	.Ltmp129-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp130-.Lfunc_begin0
	.long	.Ltmp132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp133-.Lfunc_begin0
	.long	.Ltmp135-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp136-.Lfunc_begin0
	.long	.Ltmp138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp139-.Lfunc_begin0
	.long	.Ltmp141-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp142-.Lfunc_begin0
	.long	.Ltmp144-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp145-.Lfunc_begin0
	.long	.Ltmp147-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp148-.Lfunc_begin0
	.long	.Ltmp150-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp151-.Lfunc_begin0
	.long	.Ltmp153-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp154-.Lfunc_begin0
	.long	.Ltmp156-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp157-.Lfunc_begin0
	.long	.Ltmp159-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp160-.Lfunc_begin0
	.long	.Ltmp162-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp163-.Lfunc_begin0
	.long	.Ltmp165-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp166-.Lfunc_begin0
	.long	.Ltmp168-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp169-.Lfunc_begin0
	.long	.Ltmp171-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp172-.Lfunc_begin0
	.long	.Ltmp174-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp175-.Lfunc_begin0
	.long	.Ltmp177-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp178-.Lfunc_begin0
	.long	.Ltmp180-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp181-.Lfunc_begin0
	.long	.Ltmp183-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp184-.Lfunc_begin0
	.long	.Ltmp186-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp187-.Lfunc_begin0
	.long	.Ltmp189-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp190-.Lfunc_begin0
	.long	.Ltmp192-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp193-.Lfunc_begin0
	.long	.Ltmp195-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp196-.Lfunc_begin0
	.long	.Ltmp198-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp199-.Lfunc_begin0
	.long	.Ltmp201-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp202-.Lfunc_begin0
	.long	.Ltmp204-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp205-.Lfunc_begin0
	.long	.Ltmp207-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp208-.Lfunc_begin0
	.long	.Ltmp210-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp211-.Lfunc_begin0
	.long	.Ltmp213-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp214-.Lfunc_begin0
	.long	.Ltmp216-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp217-.Lfunc_begin0
	.long	.Ltmp219-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp220-.Lfunc_begin0
	.long	.Ltmp222-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp223-.Lfunc_begin0
	.long	.Ltmp225-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp226-.Lfunc_begin0
	.long	.Ltmp228-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp229-.Lfunc_begin0
	.long	.Ltmp231-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp232-.Lfunc_begin0
	.long	.Ltmp234-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp235-.Lfunc_begin0
	.long	.Ltmp237-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp238-.Lfunc_begin0
	.long	.Ltmp240-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp241-.Lfunc_begin0
	.long	.Ltmp243-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp244-.Lfunc_begin0
	.long	.Ltmp246-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp247-.Lfunc_begin0
	.long	.Ltmp249-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp250-.Lfunc_begin0
	.long	.Ltmp252-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp253-.Lfunc_begin0
	.long	.Ltmp255-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp256-.Lfunc_begin0
	.long	.Ltmp258-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp259-.Lfunc_begin0
	.long	.Ltmp261-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp262-.Lfunc_begin0
	.long	.Ltmp264-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp265-.Lfunc_begin0
	.long	.Ltmp267-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp268-.Lfunc_begin0
	.long	.Ltmp270-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp271-.Lfunc_begin0
	.long	.Ltmp273-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp274-.Lfunc_begin0
	.long	.Ltmp276-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp277-.Lfunc_begin0
	.long	.Ltmp279-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp280-.Lfunc_begin0
	.long	.Ltmp282-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp283-.Lfunc_begin0
	.long	.Ltmp285-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp286-.Lfunc_begin0
	.long	.Ltmp288-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp289-.Lfunc_begin0
	.long	.Ltmp291-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp292-.Lfunc_begin0
	.long	.Ltmp294-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp295-.Lfunc_begin0
	.long	.Ltmp297-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp298-.Lfunc_begin0
	.long	.Ltmp300-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp301-.Lfunc_begin0
	.long	.Ltmp303-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp304-.Lfunc_begin0
	.long	.Ltmp306-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp307-.Lfunc_begin0
	.long	.Ltmp309-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp310-.Lfunc_begin0
	.long	.Ltmp312-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp313-.Lfunc_begin0
	.long	.Ltmp315-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp316-.Lfunc_begin0
	.long	.Ltmp318-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp319-.Lfunc_begin0
	.long	.Ltmp321-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp322-.Lfunc_begin0
	.long	.Ltmp324-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp325-.Lfunc_begin0
	.long	.Ltmp327-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp328-.Lfunc_begin0
	.long	.Ltmp330-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp331-.Lfunc_begin0
	.long	.Ltmp333-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp334-.Lfunc_begin0
	.long	.Ltmp336-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp337-.Lfunc_begin0
	.long	.Ltmp339-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp340-.Lfunc_begin0
	.long	.Ltmp342-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp343-.Lfunc_begin0
	.long	.Ltmp345-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp346-.Lfunc_begin0
	.long	.Ltmp348-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp349-.Lfunc_begin0
	.long	.Ltmp351-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp352-.Lfunc_begin0
	.long	.Ltmp354-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp355-.Lfunc_begin0
	.long	.Ltmp357-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp358-.Lfunc_begin0
	.long	.Ltmp360-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp361-.Lfunc_begin0
	.long	.Ltmp363-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp364-.Lfunc_begin0
	.long	.Ltmp366-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp367-.Lfunc_begin0
	.long	.Ltmp369-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp370-.Lfunc_begin0
	.long	.Ltmp372-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp373-.Lfunc_begin0
	.long	.Ltmp375-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp376-.Lfunc_begin0
	.long	.Ltmp378-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp379-.Lfunc_begin0
	.long	.Ltmp381-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp382-.Lfunc_begin0
	.long	.Ltmp383-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp384-.Lfunc_begin0
	.long	.Ltmp388-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp389-.Lfunc_begin0
	.long	.Ltmp394-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp395-.Lfunc_begin0
	.long	.Ltmp400-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp401-.Lfunc_begin0
	.long	.Ltmp406-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp407-.Lfunc_begin0
	.long	.Ltmp412-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp413-.Lfunc_begin0
	.long	.Ltmp418-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp419-.Lfunc_begin0
	.long	.Ltmp424-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp425-.Lfunc_begin0
	.long	.Ltmp430-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp431-.Lfunc_begin0
	.long	.Ltmp436-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp437-.Lfunc_begin0
	.long	.Ltmp442-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp443-.Lfunc_begin0
	.long	.Ltmp448-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp449-.Lfunc_begin0
	.long	.Ltmp454-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp455-.Lfunc_begin0
	.long	.Ltmp460-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp461-.Lfunc_begin0
	.long	.Ltmp466-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp467-.Lfunc_begin0
	.long	.Ltmp472-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp473-.Lfunc_begin0
	.long	.Ltmp478-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp479-.Lfunc_begin0
	.long	.Ltmp484-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp485-.Lfunc_begin0
	.long	.Ltmp490-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp491-.Lfunc_begin0
	.long	.Ltmp496-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp497-.Lfunc_begin0
	.long	.Ltmp502-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp503-.Lfunc_begin0
	.long	.Ltmp508-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp509-.Lfunc_begin0
	.long	.Ltmp514-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp515-.Lfunc_begin0
	.long	.Ltmp520-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp521-.Lfunc_begin0
	.long	.Ltmp526-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp527-.Lfunc_begin0
	.long	.Ltmp532-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp533-.Lfunc_begin0
	.long	.Ltmp538-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp539-.Lfunc_begin0
	.long	.Ltmp544-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp545-.Lfunc_begin0
	.long	.Ltmp550-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp551-.Lfunc_begin0
	.long	.Ltmp556-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp557-.Lfunc_begin0
	.long	.Ltmp562-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp563-.Lfunc_begin0
	.long	.Ltmp568-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp569-.Lfunc_begin0
	.long	.Ltmp574-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp575-.Lfunc_begin0
	.long	.Ltmp580-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp581-.Lfunc_begin0
	.long	.Ltmp586-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp587-.Lfunc_begin0
	.long	.Ltmp592-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp593-.Lfunc_begin0
	.long	.Ltmp598-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp599-.Lfunc_begin0
	.long	.Ltmp604-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp605-.Lfunc_begin0
	.long	.Ltmp610-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp611-.Lfunc_begin0
	.long	.Ltmp616-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp617-.Lfunc_begin0
	.long	.Ltmp622-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp623-.Lfunc_begin0
	.long	.Ltmp628-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp629-.Lfunc_begin0
	.long	.Ltmp634-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp635-.Lfunc_begin0
	.long	.Ltmp640-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp641-.Lfunc_begin0
	.long	.Ltmp646-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp647-.Lfunc_begin0
	.long	.Ltmp652-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp653-.Lfunc_begin0
	.long	.Ltmp658-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp659-.Lfunc_begin0
	.long	.Ltmp664-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp665-.Lfunc_begin0
	.long	.Ltmp670-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp671-.Lfunc_begin0
	.long	.Ltmp676-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp677-.Lfunc_begin0
	.long	.Ltmp682-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp683-.Lfunc_begin0
	.long	.Ltmp688-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp689-.Lfunc_begin0
	.long	.Ltmp694-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp695-.Lfunc_begin0
	.long	.Ltmp700-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp701-.Lfunc_begin0
	.long	.Ltmp706-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp707-.Lfunc_begin0
	.long	.Ltmp712-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp713-.Lfunc_begin0
	.long	.Ltmp718-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp719-.Lfunc_begin0
	.long	.Ltmp724-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp725-.Lfunc_begin0
	.long	.Ltmp730-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp731-.Lfunc_begin0
	.long	.Ltmp736-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp737-.Lfunc_begin0
	.long	.Ltmp742-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp743-.Lfunc_begin0
	.long	.Ltmp748-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp749-.Lfunc_begin0
	.long	.Ltmp754-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp755-.Lfunc_begin0
	.long	.Ltmp760-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp761-.Lfunc_begin0
	.long	.Ltmp766-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp767-.Lfunc_begin0
	.long	.Ltmp772-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp773-.Lfunc_begin0
	.long	.Ltmp778-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp779-.Lfunc_begin0
	.long	.Ltmp784-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp785-.Lfunc_begin0
	.long	.Ltmp790-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp791-.Lfunc_begin0
	.long	.Ltmp796-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp797-.Lfunc_begin0
	.long	.Ltmp802-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp803-.Lfunc_begin0
	.long	.Ltmp808-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp809-.Lfunc_begin0
	.long	.Ltmp814-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp815-.Lfunc_begin0
	.long	.Ltmp820-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp821-.Lfunc_begin0
	.long	.Ltmp826-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp827-.Lfunc_begin0
	.long	.Ltmp832-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp833-.Lfunc_begin0
	.long	.Ltmp838-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp839-.Lfunc_begin0
	.long	.Ltmp844-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp845-.Lfunc_begin0
	.long	.Ltmp850-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp851-.Lfunc_begin0
	.long	.Ltmp856-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp857-.Lfunc_begin0
	.long	.Ltmp862-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp863-.Lfunc_begin0
	.long	.Ltmp868-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp869-.Lfunc_begin0
	.long	.Ltmp874-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp875-.Lfunc_begin0
	.long	.Ltmp880-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp881-.Lfunc_begin0
	.long	.Ltmp886-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp887-.Lfunc_begin0
	.long	.Ltmp892-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp893-.Lfunc_begin0
	.long	.Ltmp898-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp899-.Lfunc_begin0
	.long	.Ltmp904-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp905-.Lfunc_begin0
	.long	.Ltmp910-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp911-.Lfunc_begin0
	.long	.Ltmp916-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp917-.Lfunc_begin0
	.long	.Ltmp922-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp923-.Lfunc_begin0
	.long	.Ltmp928-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp929-.Lfunc_begin0
	.long	.Ltmp934-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp935-.Lfunc_begin0
	.long	.Ltmp940-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp941-.Lfunc_begin0
	.long	.Ltmp946-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp947-.Lfunc_begin0
	.long	.Ltmp952-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp953-.Lfunc_begin0
	.long	.Ltmp958-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp959-.Lfunc_begin0
	.long	.Ltmp964-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp965-.Lfunc_begin0
	.long	.Ltmp970-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp971-.Lfunc_begin0
	.long	.Ltmp976-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp977-.Lfunc_begin0
	.long	.Ltmp982-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp983-.Lfunc_begin0
	.long	.Ltmp988-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp989-.Lfunc_begin0
	.long	.Ltmp994-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp995-.Lfunc_begin0
	.long	.Ltmp1000-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1001-.Lfunc_begin0
	.long	.Ltmp1006-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1007-.Lfunc_begin0
	.long	.Ltmp1012-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1013-.Lfunc_begin0
	.long	.Ltmp1018-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1019-.Lfunc_begin0
	.long	.Ltmp1024-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1025-.Lfunc_begin0
	.long	.Ltmp1030-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1031-.Lfunc_begin0
	.long	.Ltmp1036-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1037-.Lfunc_begin0
	.long	.Ltmp1042-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1043-.Lfunc_begin0
	.long	.Ltmp1048-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1049-.Lfunc_begin0
	.long	.Ltmp1054-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1055-.Lfunc_begin0
	.long	.Ltmp1060-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1061-.Lfunc_begin0
	.long	.Ltmp1066-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1067-.Lfunc_begin0
	.long	.Ltmp1072-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1073-.Lfunc_begin0
	.long	.Ltmp1078-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1079-.Lfunc_begin0
	.long	.Ltmp1084-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1085-.Lfunc_begin0
	.long	.Ltmp1090-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1091-.Lfunc_begin0
	.long	.Ltmp1096-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1097-.Lfunc_begin0
	.long	.Ltmp1102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1103-.Lfunc_begin0
	.long	.Ltmp1108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1109-.Lfunc_begin0
	.long	.Ltmp1114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1115-.Lfunc_begin0
	.long	.Ltmp1120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1121-.Lfunc_begin0
	.long	.Ltmp1126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1127-.Lfunc_begin0
	.long	.Ltmp1132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1133-.Lfunc_begin0
	.long	.Ltmp1138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp1139-.Lfunc_begin0
	.long	.Ltmp1140-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc1:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Lfunc_begin0-.Lfunc_begin0
	.long	.Ltmp3-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp4-.Lfunc_begin0
	.long	.Ltmp6-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp7-.Lfunc_begin0
	.long	.Ltmp9-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp10-.Lfunc_begin0
	.long	.Ltmp12-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp13-.Lfunc_begin0
	.long	.Ltmp15-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp16-.Lfunc_begin0
	.long	.Ltmp18-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp19-.Lfunc_begin0
	.long	.Ltmp21-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp22-.Lfunc_begin0
	.long	.Ltmp24-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp25-.Lfunc_begin0
	.long	.Ltmp27-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp28-.Lfunc_begin0
	.long	.Ltmp30-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp31-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp34-.Lfunc_begin0
	.long	.Ltmp36-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp37-.Lfunc_begin0
	.long	.Ltmp39-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp40-.Lfunc_begin0
	.long	.Ltmp42-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp43-.Lfunc_begin0
	.long	.Ltmp45-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp46-.Lfunc_begin0
	.long	.Ltmp48-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp49-.Lfunc_begin0
	.long	.Ltmp51-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp52-.Lfunc_begin0
	.long	.Ltmp54-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp55-.Lfunc_begin0
	.long	.Ltmp57-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp58-.Lfunc_begin0
	.long	.Ltmp60-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp61-.Lfunc_begin0
	.long	.Ltmp63-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp64-.Lfunc_begin0
	.long	.Ltmp66-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp67-.Lfunc_begin0
	.long	.Ltmp69-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp70-.Lfunc_begin0
	.long	.Ltmp72-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp73-.Lfunc_begin0
	.long	.Ltmp75-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp76-.Lfunc_begin0
	.long	.Ltmp78-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp79-.Lfunc_begin0
	.long	.Ltmp81-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp82-.Lfunc_begin0
	.long	.Ltmp84-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp85-.Lfunc_begin0
	.long	.Ltmp87-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp88-.Lfunc_begin0
	.long	.Ltmp90-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp91-.Lfunc_begin0
	.long	.Ltmp93-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp94-.Lfunc_begin0
	.long	.Ltmp96-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp97-.Lfunc_begin0
	.long	.Ltmp99-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp100-.Lfunc_begin0
	.long	.Ltmp102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp103-.Lfunc_begin0
	.long	.Ltmp105-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp106-.Lfunc_begin0
	.long	.Ltmp108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp109-.Lfunc_begin0
	.long	.Ltmp111-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp112-.Lfunc_begin0
	.long	.Ltmp114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp115-.Lfunc_begin0
	.long	.Ltmp117-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp118-.Lfunc_begin0
	.long	.Ltmp120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp121-.Lfunc_begin0
	.long	.Ltmp123-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp124-.Lfunc_begin0
	.long	.Ltmp126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp127-.Lfunc_begin0
	.long	.Ltmp129-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp130-.Lfunc_begin0
	.long	.Ltmp132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp133-.Lfunc_begin0
	.long	.Ltmp135-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp136-.Lfunc_begin0
	.long	.Ltmp138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp139-.Lfunc_begin0
	.long	.Ltmp141-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp142-.Lfunc_begin0
	.long	.Ltmp144-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp145-.Lfunc_begin0
	.long	.Ltmp147-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp148-.Lfunc_begin0
	.long	.Ltmp150-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp151-.Lfunc_begin0
	.long	.Ltmp153-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp154-.Lfunc_begin0
	.long	.Ltmp156-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp157-.Lfunc_begin0
	.long	.Ltmp159-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp160-.Lfunc_begin0
	.long	.Ltmp162-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp163-.Lfunc_begin0
	.long	.Ltmp165-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp166-.Lfunc_begin0
	.long	.Ltmp168-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp169-.Lfunc_begin0
	.long	.Ltmp171-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp172-.Lfunc_begin0
	.long	.Ltmp174-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp175-.Lfunc_begin0
	.long	.Ltmp177-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp178-.Lfunc_begin0
	.long	.Ltmp180-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp181-.Lfunc_begin0
	.long	.Ltmp183-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp184-.Lfunc_begin0
	.long	.Ltmp186-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp187-.Lfunc_begin0
	.long	.Ltmp189-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp190-.Lfunc_begin0
	.long	.Ltmp192-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp193-.Lfunc_begin0
	.long	.Ltmp195-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp196-.Lfunc_begin0
	.long	.Ltmp198-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp199-.Lfunc_begin0
	.long	.Ltmp201-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp202-.Lfunc_begin0
	.long	.Ltmp204-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp205-.Lfunc_begin0
	.long	.Ltmp207-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp208-.Lfunc_begin0
	.long	.Ltmp210-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp211-.Lfunc_begin0
	.long	.Ltmp213-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp214-.Lfunc_begin0
	.long	.Ltmp216-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp217-.Lfunc_begin0
	.long	.Ltmp219-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp220-.Lfunc_begin0
	.long	.Ltmp222-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp223-.Lfunc_begin0
	.long	.Ltmp225-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp226-.Lfunc_begin0
	.long	.Ltmp228-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp229-.Lfunc_begin0
	.long	.Ltmp231-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp232-.Lfunc_begin0
	.long	.Ltmp234-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp235-.Lfunc_begin0
	.long	.Ltmp237-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp238-.Lfunc_begin0
	.long	.Ltmp240-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp241-.Lfunc_begin0
	.long	.Ltmp243-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp244-.Lfunc_begin0
	.long	.Ltmp246-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp247-.Lfunc_begin0
	.long	.Ltmp249-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp250-.Lfunc_begin0
	.long	.Ltmp252-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp253-.Lfunc_begin0
	.long	.Ltmp255-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp256-.Lfunc_begin0
	.long	.Ltmp258-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp259-.Lfunc_begin0
	.long	.Ltmp261-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp262-.Lfunc_begin0
	.long	.Ltmp264-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp265-.Lfunc_begin0
	.long	.Ltmp267-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp268-.Lfunc_begin0
	.long	.Ltmp270-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp271-.Lfunc_begin0
	.long	.Ltmp273-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp274-.Lfunc_begin0
	.long	.Ltmp276-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp277-.Lfunc_begin0
	.long	.Ltmp279-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp280-.Lfunc_begin0
	.long	.Ltmp282-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp283-.Lfunc_begin0
	.long	.Ltmp285-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp286-.Lfunc_begin0
	.long	.Ltmp288-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp289-.Lfunc_begin0
	.long	.Ltmp291-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp292-.Lfunc_begin0
	.long	.Ltmp294-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp295-.Lfunc_begin0
	.long	.Ltmp297-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp298-.Lfunc_begin0
	.long	.Ltmp300-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp301-.Lfunc_begin0
	.long	.Ltmp303-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp304-.Lfunc_begin0
	.long	.Ltmp306-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp307-.Lfunc_begin0
	.long	.Ltmp309-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp310-.Lfunc_begin0
	.long	.Ltmp312-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp313-.Lfunc_begin0
	.long	.Ltmp315-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp316-.Lfunc_begin0
	.long	.Ltmp318-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp319-.Lfunc_begin0
	.long	.Ltmp321-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp322-.Lfunc_begin0
	.long	.Ltmp324-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp325-.Lfunc_begin0
	.long	.Ltmp327-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp328-.Lfunc_begin0
	.long	.Ltmp330-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp331-.Lfunc_begin0
	.long	.Ltmp333-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp334-.Lfunc_begin0
	.long	.Ltmp336-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp337-.Lfunc_begin0
	.long	.Ltmp339-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp340-.Lfunc_begin0
	.long	.Ltmp342-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp343-.Lfunc_begin0
	.long	.Ltmp345-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp346-.Lfunc_begin0
	.long	.Ltmp348-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp349-.Lfunc_begin0
	.long	.Ltmp351-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp352-.Lfunc_begin0
	.long	.Ltmp354-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp355-.Lfunc_begin0
	.long	.Ltmp357-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp358-.Lfunc_begin0
	.long	.Ltmp360-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp361-.Lfunc_begin0
	.long	.Ltmp363-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp364-.Lfunc_begin0
	.long	.Ltmp366-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp367-.Lfunc_begin0
	.long	.Ltmp369-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp370-.Lfunc_begin0
	.long	.Ltmp372-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp373-.Lfunc_begin0
	.long	.Ltmp375-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp376-.Lfunc_begin0
	.long	.Ltmp378-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp379-.Lfunc_begin0
	.long	.Ltmp381-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp382-.Lfunc_begin0
	.long	.Ltmp388-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp389-.Lfunc_begin0
	.long	.Ltmp394-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp395-.Lfunc_begin0
	.long	.Ltmp400-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp401-.Lfunc_begin0
	.long	.Ltmp406-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp407-.Lfunc_begin0
	.long	.Ltmp412-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp413-.Lfunc_begin0
	.long	.Ltmp418-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp419-.Lfunc_begin0
	.long	.Ltmp424-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp425-.Lfunc_begin0
	.long	.Ltmp430-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp431-.Lfunc_begin0
	.long	.Ltmp436-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp437-.Lfunc_begin0
	.long	.Ltmp442-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp443-.Lfunc_begin0
	.long	.Ltmp448-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp449-.Lfunc_begin0
	.long	.Ltmp454-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp455-.Lfunc_begin0
	.long	.Ltmp460-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp461-.Lfunc_begin0
	.long	.Ltmp466-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp467-.Lfunc_begin0
	.long	.Ltmp472-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp473-.Lfunc_begin0
	.long	.Ltmp478-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp479-.Lfunc_begin0
	.long	.Ltmp484-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp485-.Lfunc_begin0
	.long	.Ltmp490-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp491-.Lfunc_begin0
	.long	.Ltmp496-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp497-.Lfunc_begin0
	.long	.Ltmp502-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp503-.Lfunc_begin0
	.long	.Ltmp508-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp509-.Lfunc_begin0
	.long	.Ltmp514-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp515-.Lfunc_begin0
	.long	.Ltmp520-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp521-.Lfunc_begin0
	.long	.Ltmp526-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp527-.Lfunc_begin0
	.long	.Ltmp532-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp533-.Lfunc_begin0
	.long	.Ltmp538-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp539-.Lfunc_begin0
	.long	.Ltmp544-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp545-.Lfunc_begin0
	.long	.Ltmp550-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp551-.Lfunc_begin0
	.long	.Ltmp556-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp557-.Lfunc_begin0
	.long	.Ltmp562-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp563-.Lfunc_begin0
	.long	.Ltmp568-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp569-.Lfunc_begin0
	.long	.Ltmp574-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp575-.Lfunc_begin0
	.long	.Ltmp580-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp581-.Lfunc_begin0
	.long	.Ltmp586-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp587-.Lfunc_begin0
	.long	.Ltmp592-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp593-.Lfunc_begin0
	.long	.Ltmp598-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp599-.Lfunc_begin0
	.long	.Ltmp604-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp605-.Lfunc_begin0
	.long	.Ltmp610-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp611-.Lfunc_begin0
	.long	.Ltmp616-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp617-.Lfunc_begin0
	.long	.Ltmp622-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp623-.Lfunc_begin0
	.long	.Ltmp628-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp629-.Lfunc_begin0
	.long	.Ltmp634-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp635-.Lfunc_begin0
	.long	.Ltmp640-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp641-.Lfunc_begin0
	.long	.Ltmp646-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp647-.Lfunc_begin0
	.long	.Ltmp652-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp653-.Lfunc_begin0
	.long	.Ltmp658-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp659-.Lfunc_begin0
	.long	.Ltmp664-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp665-.Lfunc_begin0
	.long	.Ltmp670-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp671-.Lfunc_begin0
	.long	.Ltmp676-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp677-.Lfunc_begin0
	.long	.Ltmp682-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp683-.Lfunc_begin0
	.long	.Ltmp688-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp689-.Lfunc_begin0
	.long	.Ltmp694-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp695-.Lfunc_begin0
	.long	.Ltmp700-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp701-.Lfunc_begin0
	.long	.Ltmp706-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp707-.Lfunc_begin0
	.long	.Ltmp712-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp713-.Lfunc_begin0
	.long	.Ltmp718-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp719-.Lfunc_begin0
	.long	.Ltmp724-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp725-.Lfunc_begin0
	.long	.Ltmp730-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp731-.Lfunc_begin0
	.long	.Ltmp736-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp737-.Lfunc_begin0
	.long	.Ltmp742-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp743-.Lfunc_begin0
	.long	.Ltmp748-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp749-.Lfunc_begin0
	.long	.Ltmp754-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp755-.Lfunc_begin0
	.long	.Ltmp760-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp761-.Lfunc_begin0
	.long	.Ltmp766-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp767-.Lfunc_begin0
	.long	.Ltmp772-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp773-.Lfunc_begin0
	.long	.Ltmp778-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp779-.Lfunc_begin0
	.long	.Ltmp784-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp785-.Lfunc_begin0
	.long	.Ltmp790-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp791-.Lfunc_begin0
	.long	.Ltmp796-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp797-.Lfunc_begin0
	.long	.Ltmp802-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp803-.Lfunc_begin0
	.long	.Ltmp808-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp809-.Lfunc_begin0
	.long	.Ltmp814-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp815-.Lfunc_begin0
	.long	.Ltmp820-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp821-.Lfunc_begin0
	.long	.Ltmp826-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp827-.Lfunc_begin0
	.long	.Ltmp832-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp833-.Lfunc_begin0
	.long	.Ltmp838-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp839-.Lfunc_begin0
	.long	.Ltmp844-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp845-.Lfunc_begin0
	.long	.Ltmp850-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp851-.Lfunc_begin0
	.long	.Ltmp856-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp857-.Lfunc_begin0
	.long	.Ltmp862-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp863-.Lfunc_begin0
	.long	.Ltmp868-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp869-.Lfunc_begin0
	.long	.Ltmp874-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp875-.Lfunc_begin0
	.long	.Ltmp880-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp881-.Lfunc_begin0
	.long	.Ltmp886-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp887-.Lfunc_begin0
	.long	.Ltmp892-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp893-.Lfunc_begin0
	.long	.Ltmp898-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp899-.Lfunc_begin0
	.long	.Ltmp904-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp905-.Lfunc_begin0
	.long	.Ltmp910-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp911-.Lfunc_begin0
	.long	.Ltmp916-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp917-.Lfunc_begin0
	.long	.Ltmp922-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp923-.Lfunc_begin0
	.long	.Ltmp928-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp929-.Lfunc_begin0
	.long	.Ltmp934-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp935-.Lfunc_begin0
	.long	.Ltmp940-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp941-.Lfunc_begin0
	.long	.Ltmp946-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp947-.Lfunc_begin0
	.long	.Ltmp952-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp953-.Lfunc_begin0
	.long	.Ltmp958-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp959-.Lfunc_begin0
	.long	.Ltmp964-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp965-.Lfunc_begin0
	.long	.Ltmp970-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp971-.Lfunc_begin0
	.long	.Ltmp976-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp977-.Lfunc_begin0
	.long	.Ltmp982-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp983-.Lfunc_begin0
	.long	.Ltmp988-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp989-.Lfunc_begin0
	.long	.Ltmp994-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp995-.Lfunc_begin0
	.long	.Ltmp1000-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1001-.Lfunc_begin0
	.long	.Ltmp1006-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1007-.Lfunc_begin0
	.long	.Ltmp1012-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1013-.Lfunc_begin0
	.long	.Ltmp1018-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1019-.Lfunc_begin0
	.long	.Ltmp1024-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1025-.Lfunc_begin0
	.long	.Ltmp1030-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1031-.Lfunc_begin0
	.long	.Ltmp1036-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1037-.Lfunc_begin0
	.long	.Ltmp1042-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1043-.Lfunc_begin0
	.long	.Ltmp1048-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1049-.Lfunc_begin0
	.long	.Ltmp1054-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1055-.Lfunc_begin0
	.long	.Ltmp1060-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1061-.Lfunc_begin0
	.long	.Ltmp1066-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1067-.Lfunc_begin0
	.long	.Ltmp1072-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1073-.Lfunc_begin0
	.long	.Ltmp1078-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1079-.Lfunc_begin0
	.long	.Ltmp1084-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1085-.Lfunc_begin0
	.long	.Ltmp1090-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1091-.Lfunc_begin0
	.long	.Ltmp1096-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1097-.Lfunc_begin0
	.long	.Ltmp1102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1103-.Lfunc_begin0
	.long	.Ltmp1108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1109-.Lfunc_begin0
	.long	.Ltmp1114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1115-.Lfunc_begin0
	.long	.Ltmp1120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1121-.Lfunc_begin0
	.long	.Ltmp1126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1127-.Lfunc_begin0
	.long	.Ltmp1132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1133-.Lfunc_begin0
	.long	.Ltmp1138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1139-.Lfunc_begin0
	.long	.Lfunc_end0-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc2:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp0-.Lfunc_begin0
	.long	.Ltmp1-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1-.Lfunc_begin0
	.long	.Ltmp3-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp4-.Lfunc_begin0
	.long	.Ltmp6-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp7-.Lfunc_begin0
	.long	.Ltmp9-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp10-.Lfunc_begin0
	.long	.Ltmp12-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp13-.Lfunc_begin0
	.long	.Ltmp15-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp16-.Lfunc_begin0
	.long	.Ltmp18-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp19-.Lfunc_begin0
	.long	.Ltmp21-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp22-.Lfunc_begin0
	.long	.Ltmp24-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp25-.Lfunc_begin0
	.long	.Ltmp27-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp28-.Lfunc_begin0
	.long	.Ltmp30-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp31-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp34-.Lfunc_begin0
	.long	.Ltmp36-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp37-.Lfunc_begin0
	.long	.Ltmp39-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp40-.Lfunc_begin0
	.long	.Ltmp42-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp43-.Lfunc_begin0
	.long	.Ltmp45-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp46-.Lfunc_begin0
	.long	.Ltmp48-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp49-.Lfunc_begin0
	.long	.Ltmp51-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp52-.Lfunc_begin0
	.long	.Ltmp54-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp55-.Lfunc_begin0
	.long	.Ltmp57-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp58-.Lfunc_begin0
	.long	.Ltmp60-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp61-.Lfunc_begin0
	.long	.Ltmp63-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp64-.Lfunc_begin0
	.long	.Ltmp66-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp67-.Lfunc_begin0
	.long	.Ltmp69-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp70-.Lfunc_begin0
	.long	.Ltmp72-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp73-.Lfunc_begin0
	.long	.Ltmp75-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp76-.Lfunc_begin0
	.long	.Ltmp78-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp79-.Lfunc_begin0
	.long	.Ltmp81-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp82-.Lfunc_begin0
	.long	.Ltmp84-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp85-.Lfunc_begin0
	.long	.Ltmp87-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp88-.Lfunc_begin0
	.long	.Ltmp90-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp91-.Lfunc_begin0
	.long	.Ltmp93-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp94-.Lfunc_begin0
	.long	.Ltmp96-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp97-.Lfunc_begin0
	.long	.Ltmp99-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp100-.Lfunc_begin0
	.long	.Ltmp102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp103-.Lfunc_begin0
	.long	.Ltmp105-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp106-.Lfunc_begin0
	.long	.Ltmp108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp109-.Lfunc_begin0
	.long	.Ltmp111-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp112-.Lfunc_begin0
	.long	.Ltmp114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp115-.Lfunc_begin0
	.long	.Ltmp117-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp118-.Lfunc_begin0
	.long	.Ltmp120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp121-.Lfunc_begin0
	.long	.Ltmp123-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp124-.Lfunc_begin0
	.long	.Ltmp126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp127-.Lfunc_begin0
	.long	.Ltmp129-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp130-.Lfunc_begin0
	.long	.Ltmp132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp133-.Lfunc_begin0
	.long	.Ltmp135-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp136-.Lfunc_begin0
	.long	.Ltmp138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp139-.Lfunc_begin0
	.long	.Ltmp141-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp142-.Lfunc_begin0
	.long	.Ltmp144-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp145-.Lfunc_begin0
	.long	.Ltmp147-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp148-.Lfunc_begin0
	.long	.Ltmp150-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp151-.Lfunc_begin0
	.long	.Ltmp153-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp154-.Lfunc_begin0
	.long	.Ltmp156-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp157-.Lfunc_begin0
	.long	.Ltmp159-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp160-.Lfunc_begin0
	.long	.Ltmp162-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp163-.Lfunc_begin0
	.long	.Ltmp165-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp166-.Lfunc_begin0
	.long	.Ltmp168-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp169-.Lfunc_begin0
	.long	.Ltmp171-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp172-.Lfunc_begin0
	.long	.Ltmp174-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp175-.Lfunc_begin0
	.long	.Ltmp177-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp178-.Lfunc_begin0
	.long	.Ltmp180-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp181-.Lfunc_begin0
	.long	.Ltmp183-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp184-.Lfunc_begin0
	.long	.Ltmp186-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp187-.Lfunc_begin0
	.long	.Ltmp189-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp190-.Lfunc_begin0
	.long	.Ltmp192-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp193-.Lfunc_begin0
	.long	.Ltmp195-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp196-.Lfunc_begin0
	.long	.Ltmp198-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp199-.Lfunc_begin0
	.long	.Ltmp201-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp202-.Lfunc_begin0
	.long	.Ltmp204-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp205-.Lfunc_begin0
	.long	.Ltmp207-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp208-.Lfunc_begin0
	.long	.Ltmp210-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp211-.Lfunc_begin0
	.long	.Ltmp213-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp214-.Lfunc_begin0
	.long	.Ltmp216-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp217-.Lfunc_begin0
	.long	.Ltmp219-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp220-.Lfunc_begin0
	.long	.Ltmp222-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp223-.Lfunc_begin0
	.long	.Ltmp225-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp226-.Lfunc_begin0
	.long	.Ltmp228-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp229-.Lfunc_begin0
	.long	.Ltmp231-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp232-.Lfunc_begin0
	.long	.Ltmp234-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp235-.Lfunc_begin0
	.long	.Ltmp237-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp238-.Lfunc_begin0
	.long	.Ltmp240-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp241-.Lfunc_begin0
	.long	.Ltmp243-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp244-.Lfunc_begin0
	.long	.Ltmp246-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp247-.Lfunc_begin0
	.long	.Ltmp249-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp250-.Lfunc_begin0
	.long	.Ltmp252-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp253-.Lfunc_begin0
	.long	.Ltmp255-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp256-.Lfunc_begin0
	.long	.Ltmp258-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp259-.Lfunc_begin0
	.long	.Ltmp261-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp262-.Lfunc_begin0
	.long	.Ltmp264-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp265-.Lfunc_begin0
	.long	.Ltmp267-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp268-.Lfunc_begin0
	.long	.Ltmp270-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp271-.Lfunc_begin0
	.long	.Ltmp273-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp274-.Lfunc_begin0
	.long	.Ltmp276-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp277-.Lfunc_begin0
	.long	.Ltmp279-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp280-.Lfunc_begin0
	.long	.Ltmp282-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp283-.Lfunc_begin0
	.long	.Ltmp285-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp286-.Lfunc_begin0
	.long	.Ltmp288-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp289-.Lfunc_begin0
	.long	.Ltmp291-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp292-.Lfunc_begin0
	.long	.Ltmp294-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp295-.Lfunc_begin0
	.long	.Ltmp297-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp298-.Lfunc_begin0
	.long	.Ltmp300-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp301-.Lfunc_begin0
	.long	.Ltmp303-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp304-.Lfunc_begin0
	.long	.Ltmp306-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp307-.Lfunc_begin0
	.long	.Ltmp309-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp310-.Lfunc_begin0
	.long	.Ltmp312-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp313-.Lfunc_begin0
	.long	.Ltmp315-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp316-.Lfunc_begin0
	.long	.Ltmp318-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp319-.Lfunc_begin0
	.long	.Ltmp321-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp322-.Lfunc_begin0
	.long	.Ltmp324-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp325-.Lfunc_begin0
	.long	.Ltmp327-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp328-.Lfunc_begin0
	.long	.Ltmp330-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp331-.Lfunc_begin0
	.long	.Ltmp333-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp334-.Lfunc_begin0
	.long	.Ltmp336-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp337-.Lfunc_begin0
	.long	.Ltmp339-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp340-.Lfunc_begin0
	.long	.Ltmp342-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp343-.Lfunc_begin0
	.long	.Ltmp345-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp346-.Lfunc_begin0
	.long	.Ltmp348-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp349-.Lfunc_begin0
	.long	.Ltmp351-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp352-.Lfunc_begin0
	.long	.Ltmp354-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp355-.Lfunc_begin0
	.long	.Ltmp357-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp358-.Lfunc_begin0
	.long	.Ltmp360-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp361-.Lfunc_begin0
	.long	.Ltmp363-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp364-.Lfunc_begin0
	.long	.Ltmp366-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp367-.Lfunc_begin0
	.long	.Ltmp369-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp370-.Lfunc_begin0
	.long	.Ltmp372-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp373-.Lfunc_begin0
	.long	.Ltmp375-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp376-.Lfunc_begin0
	.long	.Ltmp378-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp379-.Lfunc_begin0
	.long	.Ltmp381-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp382-.Lfunc_begin0
	.long	.Ltmp383-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp383-.Lfunc_begin0
	.long	.Ltmp384-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp384-.Lfunc_begin0
	.long	.Ltmp385-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp385-.Lfunc_begin0
	.long	.Ltmp386-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp386-.Lfunc_begin0
	.long	.Ltmp388-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp389-.Lfunc_begin0
	.long	.Ltmp394-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp395-.Lfunc_begin0
	.long	.Ltmp400-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp401-.Lfunc_begin0
	.long	.Ltmp406-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp407-.Lfunc_begin0
	.long	.Ltmp412-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp413-.Lfunc_begin0
	.long	.Ltmp418-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp419-.Lfunc_begin0
	.long	.Ltmp424-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp425-.Lfunc_begin0
	.long	.Ltmp430-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp431-.Lfunc_begin0
	.long	.Ltmp436-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp437-.Lfunc_begin0
	.long	.Ltmp442-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp443-.Lfunc_begin0
	.long	.Ltmp448-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp449-.Lfunc_begin0
	.long	.Ltmp454-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp455-.Lfunc_begin0
	.long	.Ltmp460-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp461-.Lfunc_begin0
	.long	.Ltmp466-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp467-.Lfunc_begin0
	.long	.Ltmp472-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp473-.Lfunc_begin0
	.long	.Ltmp478-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp479-.Lfunc_begin0
	.long	.Ltmp484-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp485-.Lfunc_begin0
	.long	.Ltmp490-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp491-.Lfunc_begin0
	.long	.Ltmp496-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp497-.Lfunc_begin0
	.long	.Ltmp502-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp503-.Lfunc_begin0
	.long	.Ltmp508-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp509-.Lfunc_begin0
	.long	.Ltmp514-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp515-.Lfunc_begin0
	.long	.Ltmp520-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp521-.Lfunc_begin0
	.long	.Ltmp526-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp527-.Lfunc_begin0
	.long	.Ltmp532-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp533-.Lfunc_begin0
	.long	.Ltmp538-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp539-.Lfunc_begin0
	.long	.Ltmp544-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp545-.Lfunc_begin0
	.long	.Ltmp550-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp551-.Lfunc_begin0
	.long	.Ltmp556-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp557-.Lfunc_begin0
	.long	.Ltmp562-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp563-.Lfunc_begin0
	.long	.Ltmp568-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp569-.Lfunc_begin0
	.long	.Ltmp574-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp575-.Lfunc_begin0
	.long	.Ltmp580-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp581-.Lfunc_begin0
	.long	.Ltmp586-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp587-.Lfunc_begin0
	.long	.Ltmp592-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp593-.Lfunc_begin0
	.long	.Ltmp598-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp599-.Lfunc_begin0
	.long	.Ltmp604-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp605-.Lfunc_begin0
	.long	.Ltmp610-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp611-.Lfunc_begin0
	.long	.Ltmp616-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp617-.Lfunc_begin0
	.long	.Ltmp622-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp623-.Lfunc_begin0
	.long	.Ltmp628-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp629-.Lfunc_begin0
	.long	.Ltmp634-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp635-.Lfunc_begin0
	.long	.Ltmp640-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp641-.Lfunc_begin0
	.long	.Ltmp646-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp647-.Lfunc_begin0
	.long	.Ltmp652-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp653-.Lfunc_begin0
	.long	.Ltmp658-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp659-.Lfunc_begin0
	.long	.Ltmp664-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp665-.Lfunc_begin0
	.long	.Ltmp670-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp671-.Lfunc_begin0
	.long	.Ltmp676-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp677-.Lfunc_begin0
	.long	.Ltmp682-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp683-.Lfunc_begin0
	.long	.Ltmp688-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp689-.Lfunc_begin0
	.long	.Ltmp694-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp695-.Lfunc_begin0
	.long	.Ltmp700-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp701-.Lfunc_begin0
	.long	.Ltmp706-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp707-.Lfunc_begin0
	.long	.Ltmp712-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp713-.Lfunc_begin0
	.long	.Ltmp718-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp719-.Lfunc_begin0
	.long	.Ltmp724-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp725-.Lfunc_begin0
	.long	.Ltmp730-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp731-.Lfunc_begin0
	.long	.Ltmp736-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp737-.Lfunc_begin0
	.long	.Ltmp742-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp743-.Lfunc_begin0
	.long	.Ltmp748-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp749-.Lfunc_begin0
	.long	.Ltmp754-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp755-.Lfunc_begin0
	.long	.Ltmp760-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp761-.Lfunc_begin0
	.long	.Ltmp766-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp767-.Lfunc_begin0
	.long	.Ltmp772-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp773-.Lfunc_begin0
	.long	.Ltmp778-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp779-.Lfunc_begin0
	.long	.Ltmp784-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp785-.Lfunc_begin0
	.long	.Ltmp790-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp791-.Lfunc_begin0
	.long	.Ltmp796-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp797-.Lfunc_begin0
	.long	.Ltmp802-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp803-.Lfunc_begin0
	.long	.Ltmp808-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp809-.Lfunc_begin0
	.long	.Ltmp814-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp815-.Lfunc_begin0
	.long	.Ltmp820-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp821-.Lfunc_begin0
	.long	.Ltmp826-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp827-.Lfunc_begin0
	.long	.Ltmp832-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp833-.Lfunc_begin0
	.long	.Ltmp838-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp839-.Lfunc_begin0
	.long	.Ltmp844-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp845-.Lfunc_begin0
	.long	.Ltmp850-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp851-.Lfunc_begin0
	.long	.Ltmp856-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp857-.Lfunc_begin0
	.long	.Ltmp862-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp863-.Lfunc_begin0
	.long	.Ltmp868-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp869-.Lfunc_begin0
	.long	.Ltmp874-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp875-.Lfunc_begin0
	.long	.Ltmp880-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp881-.Lfunc_begin0
	.long	.Ltmp886-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp887-.Lfunc_begin0
	.long	.Ltmp892-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp893-.Lfunc_begin0
	.long	.Ltmp898-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp899-.Lfunc_begin0
	.long	.Ltmp904-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp905-.Lfunc_begin0
	.long	.Ltmp910-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp911-.Lfunc_begin0
	.long	.Ltmp916-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp917-.Lfunc_begin0
	.long	.Ltmp922-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp923-.Lfunc_begin0
	.long	.Ltmp928-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp929-.Lfunc_begin0
	.long	.Ltmp934-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp935-.Lfunc_begin0
	.long	.Ltmp940-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp941-.Lfunc_begin0
	.long	.Ltmp946-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp947-.Lfunc_begin0
	.long	.Ltmp952-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp953-.Lfunc_begin0
	.long	.Ltmp958-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp959-.Lfunc_begin0
	.long	.Ltmp964-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp965-.Lfunc_begin0
	.long	.Ltmp970-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp971-.Lfunc_begin0
	.long	.Ltmp976-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp977-.Lfunc_begin0
	.long	.Ltmp982-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp983-.Lfunc_begin0
	.long	.Ltmp988-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp989-.Lfunc_begin0
	.long	.Ltmp994-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp995-.Lfunc_begin0
	.long	.Ltmp1000-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1001-.Lfunc_begin0
	.long	.Ltmp1006-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1007-.Lfunc_begin0
	.long	.Ltmp1012-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1013-.Lfunc_begin0
	.long	.Ltmp1018-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1019-.Lfunc_begin0
	.long	.Ltmp1024-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1025-.Lfunc_begin0
	.long	.Ltmp1030-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1031-.Lfunc_begin0
	.long	.Ltmp1036-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1037-.Lfunc_begin0
	.long	.Ltmp1042-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1043-.Lfunc_begin0
	.long	.Ltmp1048-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1049-.Lfunc_begin0
	.long	.Ltmp1054-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1055-.Lfunc_begin0
	.long	.Ltmp1060-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1061-.Lfunc_begin0
	.long	.Ltmp1066-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1067-.Lfunc_begin0
	.long	.Ltmp1072-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1073-.Lfunc_begin0
	.long	.Ltmp1078-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1079-.Lfunc_begin0
	.long	.Ltmp1084-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1085-.Lfunc_begin0
	.long	.Ltmp1090-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1091-.Lfunc_begin0
	.long	.Ltmp1096-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1097-.Lfunc_begin0
	.long	.Ltmp1102-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1103-.Lfunc_begin0
	.long	.Ltmp1108-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1109-.Lfunc_begin0
	.long	.Ltmp1114-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1115-.Lfunc_begin0
	.long	.Ltmp1120-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1121-.Lfunc_begin0
	.long	.Ltmp1126-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1127-.Lfunc_begin0
	.long	.Ltmp1132-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1133-.Lfunc_begin0
	.long	.Ltmp1138-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1139-.Lfunc_begin0
	.long	.Ltmp1143-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1143-.Lfunc_begin0
	.long	.Lfunc_end0-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc3:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp1-.Lfunc_begin0
	.long	.Ltmp3-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp4-.Lfunc_begin0
	.long	.Ltmp6-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp7-.Lfunc_begin0
	.long	.Ltmp9-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	51                              // DW_OP_lit3
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp10-.Lfunc_begin0
	.long	.Ltmp12-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	52                              // DW_OP_lit4
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp13-.Lfunc_begin0
	.long	.Ltmp15-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	53                              // DW_OP_lit5
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp16-.Lfunc_begin0
	.long	.Ltmp18-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	54                              // DW_OP_lit6
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp19-.Lfunc_begin0
	.long	.Ltmp21-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	55                              // DW_OP_lit7
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp22-.Lfunc_begin0
	.long	.Ltmp24-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	56                              // DW_OP_lit8
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp25-.Lfunc_begin0
	.long	.Ltmp27-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	57                              // DW_OP_lit9
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp28-.Lfunc_begin0
	.long	.Ltmp30-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	58                              // DW_OP_lit10
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp31-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	59                              // DW_OP_lit11
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp34-.Lfunc_begin0
	.long	.Ltmp36-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	60                              // DW_OP_lit12
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp37-.Lfunc_begin0
	.long	.Ltmp39-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	61                              // DW_OP_lit13
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp40-.Lfunc_begin0
	.long	.Ltmp42-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	62                              // DW_OP_lit14
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp43-.Lfunc_begin0
	.long	.Ltmp45-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	63                              // DW_OP_lit15
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp46-.Lfunc_begin0
	.long	.Ltmp48-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	64                              // DW_OP_lit16
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp49-.Lfunc_begin0
	.long	.Ltmp51-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	65                              // DW_OP_lit17
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp52-.Lfunc_begin0
	.long	.Ltmp54-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	66                              // DW_OP_lit18
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp55-.Lfunc_begin0
	.long	.Ltmp57-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	67                              // DW_OP_lit19
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp58-.Lfunc_begin0
	.long	.Ltmp60-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	68                              // DW_OP_lit20
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp61-.Lfunc_begin0
	.long	.Ltmp63-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	69                              // DW_OP_lit21
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp64-.Lfunc_begin0
	.long	.Ltmp66-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	70                              // DW_OP_lit22
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp67-.Lfunc_begin0
	.long	.Ltmp69-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	71                              // DW_OP_lit23
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp70-.Lfunc_begin0
	.long	.Ltmp72-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	72                              // DW_OP_lit24
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp73-.Lfunc_begin0
	.long	.Ltmp75-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	73                              // DW_OP_lit25
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp76-.Lfunc_begin0
	.long	.Ltmp78-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	74                              // DW_OP_lit26
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp79-.Lfunc_begin0
	.long	.Ltmp81-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	75                              // DW_OP_lit27
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp82-.Lfunc_begin0
	.long	.Ltmp84-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	76                              // DW_OP_lit28
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp85-.Lfunc_begin0
	.long	.Ltmp87-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	77                              // DW_OP_lit29
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp88-.Lfunc_begin0
	.long	.Ltmp90-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	78                              // DW_OP_lit30
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp91-.Lfunc_begin0
	.long	.Ltmp93-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	79                              // DW_OP_lit31
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp94-.Lfunc_begin0
	.long	.Ltmp96-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	32                              // 32
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp97-.Lfunc_begin0
	.long	.Ltmp99-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	33                              // 33
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp100-.Lfunc_begin0
	.long	.Ltmp102-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	34                              // 34
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp103-.Lfunc_begin0
	.long	.Ltmp105-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	35                              // 35
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp106-.Lfunc_begin0
	.long	.Ltmp108-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	36                              // 36
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp109-.Lfunc_begin0
	.long	.Ltmp111-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	37                              // 37
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp112-.Lfunc_begin0
	.long	.Ltmp114-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	38                              // 38
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp115-.Lfunc_begin0
	.long	.Ltmp117-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	39                              // 39
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp118-.Lfunc_begin0
	.long	.Ltmp120-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	40                              // 40
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp121-.Lfunc_begin0
	.long	.Ltmp123-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	41                              // 41
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp124-.Lfunc_begin0
	.long	.Ltmp126-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	42                              // 42
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp127-.Lfunc_begin0
	.long	.Ltmp129-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	43                              // 43
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp130-.Lfunc_begin0
	.long	.Ltmp132-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	44                              // 44
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp133-.Lfunc_begin0
	.long	.Ltmp135-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	45                              // 45
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp136-.Lfunc_begin0
	.long	.Ltmp138-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	46                              // 46
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp139-.Lfunc_begin0
	.long	.Ltmp141-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	47                              // 47
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp142-.Lfunc_begin0
	.long	.Ltmp144-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	48                              // 48
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp145-.Lfunc_begin0
	.long	.Ltmp147-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	49                              // 49
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp148-.Lfunc_begin0
	.long	.Ltmp150-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	50                              // 50
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp151-.Lfunc_begin0
	.long	.Ltmp153-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	51                              // 51
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp154-.Lfunc_begin0
	.long	.Ltmp156-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	52                              // 52
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp157-.Lfunc_begin0
	.long	.Ltmp159-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	53                              // 53
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp160-.Lfunc_begin0
	.long	.Ltmp162-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	54                              // 54
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp163-.Lfunc_begin0
	.long	.Ltmp165-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	55                              // 55
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp166-.Lfunc_begin0
	.long	.Ltmp168-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	56                              // 56
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp169-.Lfunc_begin0
	.long	.Ltmp171-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	57                              // 57
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp172-.Lfunc_begin0
	.long	.Ltmp174-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	58                              // 58
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp175-.Lfunc_begin0
	.long	.Ltmp177-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	59                              // 59
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp178-.Lfunc_begin0
	.long	.Ltmp180-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	60                              // 60
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp181-.Lfunc_begin0
	.long	.Ltmp183-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	61                              // 61
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp184-.Lfunc_begin0
	.long	.Ltmp186-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	62                              // 62
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp187-.Lfunc_begin0
	.long	.Ltmp189-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	63                              // 63
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp190-.Lfunc_begin0
	.long	.Ltmp192-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	64                              // 64
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp193-.Lfunc_begin0
	.long	.Ltmp195-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	65                              // 65
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp196-.Lfunc_begin0
	.long	.Ltmp198-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	66                              // 66
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp199-.Lfunc_begin0
	.long	.Ltmp201-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	67                              // 67
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp202-.Lfunc_begin0
	.long	.Ltmp204-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	68                              // 68
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp205-.Lfunc_begin0
	.long	.Ltmp207-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	69                              // 69
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp208-.Lfunc_begin0
	.long	.Ltmp210-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	70                              // 70
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp211-.Lfunc_begin0
	.long	.Ltmp213-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	71                              // 71
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp214-.Lfunc_begin0
	.long	.Ltmp216-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	72                              // 72
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp217-.Lfunc_begin0
	.long	.Ltmp219-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	73                              // 73
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp220-.Lfunc_begin0
	.long	.Ltmp222-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	74                              // 74
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp223-.Lfunc_begin0
	.long	.Ltmp225-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	75                              // 75
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp226-.Lfunc_begin0
	.long	.Ltmp228-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	76                              // 76
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp229-.Lfunc_begin0
	.long	.Ltmp231-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	77                              // 77
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp232-.Lfunc_begin0
	.long	.Ltmp234-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	78                              // 78
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp235-.Lfunc_begin0
	.long	.Ltmp237-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	79                              // 79
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp238-.Lfunc_begin0
	.long	.Ltmp240-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	80                              // 80
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp241-.Lfunc_begin0
	.long	.Ltmp243-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	81                              // 81
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp244-.Lfunc_begin0
	.long	.Ltmp246-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	82                              // 82
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp247-.Lfunc_begin0
	.long	.Ltmp249-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	83                              // 83
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp250-.Lfunc_begin0
	.long	.Ltmp252-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	84                              // 84
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp253-.Lfunc_begin0
	.long	.Ltmp255-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	85                              // 85
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp256-.Lfunc_begin0
	.long	.Ltmp258-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	86                              // 86
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp259-.Lfunc_begin0
	.long	.Ltmp261-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	87                              // 87
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp262-.Lfunc_begin0
	.long	.Ltmp264-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	88                              // 88
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp265-.Lfunc_begin0
	.long	.Ltmp267-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	89                              // 89
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp268-.Lfunc_begin0
	.long	.Ltmp270-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	90                              // 90
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp271-.Lfunc_begin0
	.long	.Ltmp273-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	91                              // 91
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp274-.Lfunc_begin0
	.long	.Ltmp276-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	92                              // 92
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp277-.Lfunc_begin0
	.long	.Ltmp279-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	93                              // 93
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp280-.Lfunc_begin0
	.long	.Ltmp282-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	94                              // 94
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp283-.Lfunc_begin0
	.long	.Ltmp285-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	95                              // 95
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp286-.Lfunc_begin0
	.long	.Ltmp288-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	96                              // 96
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp289-.Lfunc_begin0
	.long	.Ltmp291-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	97                              // 97
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp292-.Lfunc_begin0
	.long	.Ltmp294-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	98                              // 98
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp295-.Lfunc_begin0
	.long	.Ltmp297-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	99                              // 99
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp298-.Lfunc_begin0
	.long	.Ltmp300-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	100                             // 100
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp301-.Lfunc_begin0
	.long	.Ltmp303-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	101                             // 101
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp304-.Lfunc_begin0
	.long	.Ltmp306-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	102                             // 102
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp307-.Lfunc_begin0
	.long	.Ltmp309-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	103                             // 103
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp310-.Lfunc_begin0
	.long	.Ltmp312-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	104                             // 104
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp313-.Lfunc_begin0
	.long	.Ltmp315-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	105                             // 105
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp316-.Lfunc_begin0
	.long	.Ltmp318-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	106                             // 106
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp319-.Lfunc_begin0
	.long	.Ltmp321-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	107                             // 107
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp322-.Lfunc_begin0
	.long	.Ltmp324-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	108                             // 108
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp325-.Lfunc_begin0
	.long	.Ltmp327-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	109                             // 109
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp328-.Lfunc_begin0
	.long	.Ltmp330-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	110                             // 110
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp331-.Lfunc_begin0
	.long	.Ltmp333-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	111                             // 111
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp334-.Lfunc_begin0
	.long	.Ltmp336-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	112                             // 112
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp337-.Lfunc_begin0
	.long	.Ltmp339-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	113                             // 113
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp340-.Lfunc_begin0
	.long	.Ltmp342-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	114                             // 114
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp343-.Lfunc_begin0
	.long	.Ltmp345-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	115                             // 115
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp346-.Lfunc_begin0
	.long	.Ltmp348-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	116                             // 116
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp349-.Lfunc_begin0
	.long	.Ltmp351-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	117                             // 117
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp352-.Lfunc_begin0
	.long	.Ltmp354-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	118                             // 118
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp355-.Lfunc_begin0
	.long	.Ltmp357-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	119                             // 119
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp358-.Lfunc_begin0
	.long	.Ltmp360-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	120                             // 120
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp361-.Lfunc_begin0
	.long	.Ltmp363-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	121                             // 121
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp364-.Lfunc_begin0
	.long	.Ltmp366-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	122                             // 122
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp367-.Lfunc_begin0
	.long	.Ltmp369-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	123                             // 123
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp370-.Lfunc_begin0
	.long	.Ltmp372-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	124                             // 124
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp373-.Lfunc_begin0
	.long	.Ltmp375-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	125                             // 125
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp376-.Lfunc_begin0
	.long	.Ltmp378-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	126                             // 126
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp379-.Lfunc_begin0
	.long	.Ltmp381-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	127                             // 127
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp384-.Lfunc_begin0
	.long	.Ltmp386-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp386-.Lfunc_begin0
	.long	.Ltmp388-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp389-.Lfunc_begin0
	.long	.Ltmp392-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp392-.Lfunc_begin0
	.long	.Ltmp394-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	51                              // DW_OP_lit3
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp395-.Lfunc_begin0
	.long	.Ltmp398-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	51                              // DW_OP_lit3
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp398-.Lfunc_begin0
	.long	.Ltmp400-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	52                              // DW_OP_lit4
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp401-.Lfunc_begin0
	.long	.Ltmp404-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	52                              // DW_OP_lit4
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp404-.Lfunc_begin0
	.long	.Ltmp406-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	53                              // DW_OP_lit5
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp407-.Lfunc_begin0
	.long	.Ltmp410-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	53                              // DW_OP_lit5
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp410-.Lfunc_begin0
	.long	.Ltmp412-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	54                              // DW_OP_lit6
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp413-.Lfunc_begin0
	.long	.Ltmp416-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	54                              // DW_OP_lit6
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp416-.Lfunc_begin0
	.long	.Ltmp418-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	55                              // DW_OP_lit7
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp419-.Lfunc_begin0
	.long	.Ltmp422-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	55                              // DW_OP_lit7
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp422-.Lfunc_begin0
	.long	.Ltmp424-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	56                              // DW_OP_lit8
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp425-.Lfunc_begin0
	.long	.Ltmp428-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	56                              // DW_OP_lit8
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp428-.Lfunc_begin0
	.long	.Ltmp430-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	57                              // DW_OP_lit9
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp431-.Lfunc_begin0
	.long	.Ltmp434-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	57                              // DW_OP_lit9
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp434-.Lfunc_begin0
	.long	.Ltmp436-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	58                              // DW_OP_lit10
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp437-.Lfunc_begin0
	.long	.Ltmp440-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	58                              // DW_OP_lit10
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp440-.Lfunc_begin0
	.long	.Ltmp442-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	59                              // DW_OP_lit11
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp443-.Lfunc_begin0
	.long	.Ltmp446-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	59                              // DW_OP_lit11
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp446-.Lfunc_begin0
	.long	.Ltmp448-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	60                              // DW_OP_lit12
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp449-.Lfunc_begin0
	.long	.Ltmp452-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	60                              // DW_OP_lit12
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp452-.Lfunc_begin0
	.long	.Ltmp454-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	61                              // DW_OP_lit13
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp455-.Lfunc_begin0
	.long	.Ltmp458-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	61                              // DW_OP_lit13
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp458-.Lfunc_begin0
	.long	.Ltmp460-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	62                              // DW_OP_lit14
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp461-.Lfunc_begin0
	.long	.Ltmp464-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	62                              // DW_OP_lit14
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp464-.Lfunc_begin0
	.long	.Ltmp466-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	63                              // DW_OP_lit15
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp467-.Lfunc_begin0
	.long	.Ltmp470-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	63                              // DW_OP_lit15
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp470-.Lfunc_begin0
	.long	.Ltmp472-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	64                              // DW_OP_lit16
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp473-.Lfunc_begin0
	.long	.Ltmp476-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	64                              // DW_OP_lit16
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp476-.Lfunc_begin0
	.long	.Ltmp478-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	65                              // DW_OP_lit17
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp479-.Lfunc_begin0
	.long	.Ltmp482-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	65                              // DW_OP_lit17
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp482-.Lfunc_begin0
	.long	.Ltmp484-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	66                              // DW_OP_lit18
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp485-.Lfunc_begin0
	.long	.Ltmp488-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	66                              // DW_OP_lit18
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp488-.Lfunc_begin0
	.long	.Ltmp490-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	67                              // DW_OP_lit19
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp491-.Lfunc_begin0
	.long	.Ltmp494-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	67                              // DW_OP_lit19
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp494-.Lfunc_begin0
	.long	.Ltmp496-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	68                              // DW_OP_lit20
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp497-.Lfunc_begin0
	.long	.Ltmp500-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	68                              // DW_OP_lit20
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp500-.Lfunc_begin0
	.long	.Ltmp502-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	69                              // DW_OP_lit21
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp503-.Lfunc_begin0
	.long	.Ltmp506-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	69                              // DW_OP_lit21
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp506-.Lfunc_begin0
	.long	.Ltmp508-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	70                              // DW_OP_lit22
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp509-.Lfunc_begin0
	.long	.Ltmp512-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	70                              // DW_OP_lit22
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp512-.Lfunc_begin0
	.long	.Ltmp514-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	71                              // DW_OP_lit23
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp515-.Lfunc_begin0
	.long	.Ltmp518-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	71                              // DW_OP_lit23
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp518-.Lfunc_begin0
	.long	.Ltmp520-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	72                              // DW_OP_lit24
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp521-.Lfunc_begin0
	.long	.Ltmp524-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	72                              // DW_OP_lit24
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp524-.Lfunc_begin0
	.long	.Ltmp526-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	73                              // DW_OP_lit25
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp527-.Lfunc_begin0
	.long	.Ltmp530-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	73                              // DW_OP_lit25
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp530-.Lfunc_begin0
	.long	.Ltmp532-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	74                              // DW_OP_lit26
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp533-.Lfunc_begin0
	.long	.Ltmp536-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	74                              // DW_OP_lit26
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp536-.Lfunc_begin0
	.long	.Ltmp538-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	75                              // DW_OP_lit27
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp539-.Lfunc_begin0
	.long	.Ltmp542-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	75                              // DW_OP_lit27
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp542-.Lfunc_begin0
	.long	.Ltmp544-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	76                              // DW_OP_lit28
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp545-.Lfunc_begin0
	.long	.Ltmp548-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	76                              // DW_OP_lit28
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp548-.Lfunc_begin0
	.long	.Ltmp550-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	77                              // DW_OP_lit29
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp551-.Lfunc_begin0
	.long	.Ltmp554-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	77                              // DW_OP_lit29
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp554-.Lfunc_begin0
	.long	.Ltmp556-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	78                              // DW_OP_lit30
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp557-.Lfunc_begin0
	.long	.Ltmp560-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	78                              // DW_OP_lit30
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp560-.Lfunc_begin0
	.long	.Ltmp562-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	79                              // DW_OP_lit31
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp563-.Lfunc_begin0
	.long	.Ltmp566-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	79                              // DW_OP_lit31
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp566-.Lfunc_begin0
	.long	.Ltmp568-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	32                              // 32
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp569-.Lfunc_begin0
	.long	.Ltmp572-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	32                              // 32
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp572-.Lfunc_begin0
	.long	.Ltmp574-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	33                              // 33
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp575-.Lfunc_begin0
	.long	.Ltmp578-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	33                              // 33
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp578-.Lfunc_begin0
	.long	.Ltmp580-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	34                              // 34
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp581-.Lfunc_begin0
	.long	.Ltmp584-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	34                              // 34
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp584-.Lfunc_begin0
	.long	.Ltmp586-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	35                              // 35
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp587-.Lfunc_begin0
	.long	.Ltmp590-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	35                              // 35
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp590-.Lfunc_begin0
	.long	.Ltmp592-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	36                              // 36
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp593-.Lfunc_begin0
	.long	.Ltmp596-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	36                              // 36
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp596-.Lfunc_begin0
	.long	.Ltmp598-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	37                              // 37
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp599-.Lfunc_begin0
	.long	.Ltmp602-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	37                              // 37
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp602-.Lfunc_begin0
	.long	.Ltmp604-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	38                              // 38
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp605-.Lfunc_begin0
	.long	.Ltmp608-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	38                              // 38
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp608-.Lfunc_begin0
	.long	.Ltmp610-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	39                              // 39
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp611-.Lfunc_begin0
	.long	.Ltmp614-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	39                              // 39
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp614-.Lfunc_begin0
	.long	.Ltmp616-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	40                              // 40
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp617-.Lfunc_begin0
	.long	.Ltmp620-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	40                              // 40
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp620-.Lfunc_begin0
	.long	.Ltmp622-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	41                              // 41
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp623-.Lfunc_begin0
	.long	.Ltmp626-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	41                              // 41
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp626-.Lfunc_begin0
	.long	.Ltmp628-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	42                              // 42
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp629-.Lfunc_begin0
	.long	.Ltmp632-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	42                              // 42
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp632-.Lfunc_begin0
	.long	.Ltmp634-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	43                              // 43
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp635-.Lfunc_begin0
	.long	.Ltmp638-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	43                              // 43
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp638-.Lfunc_begin0
	.long	.Ltmp640-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	44                              // 44
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp641-.Lfunc_begin0
	.long	.Ltmp644-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	44                              // 44
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp644-.Lfunc_begin0
	.long	.Ltmp646-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	45                              // 45
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp647-.Lfunc_begin0
	.long	.Ltmp650-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	45                              // 45
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp650-.Lfunc_begin0
	.long	.Ltmp652-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	46                              // 46
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp653-.Lfunc_begin0
	.long	.Ltmp656-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	46                              // 46
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp656-.Lfunc_begin0
	.long	.Ltmp658-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	47                              // 47
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp659-.Lfunc_begin0
	.long	.Ltmp662-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	47                              // 47
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp662-.Lfunc_begin0
	.long	.Ltmp664-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	48                              // 48
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp665-.Lfunc_begin0
	.long	.Ltmp668-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	48                              // 48
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp668-.Lfunc_begin0
	.long	.Ltmp670-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	49                              // 49
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp671-.Lfunc_begin0
	.long	.Ltmp674-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	49                              // 49
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp674-.Lfunc_begin0
	.long	.Ltmp676-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	50                              // 50
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp677-.Lfunc_begin0
	.long	.Ltmp680-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	50                              // 50
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp680-.Lfunc_begin0
	.long	.Ltmp682-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	51                              // 51
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp683-.Lfunc_begin0
	.long	.Ltmp686-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	51                              // 51
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp686-.Lfunc_begin0
	.long	.Ltmp688-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	52                              // 52
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp689-.Lfunc_begin0
	.long	.Ltmp692-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	52                              // 52
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp692-.Lfunc_begin0
	.long	.Ltmp694-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	53                              // 53
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp695-.Lfunc_begin0
	.long	.Ltmp698-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	53                              // 53
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp698-.Lfunc_begin0
	.long	.Ltmp700-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	54                              // 54
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp701-.Lfunc_begin0
	.long	.Ltmp704-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	54                              // 54
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp704-.Lfunc_begin0
	.long	.Ltmp706-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	55                              // 55
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp707-.Lfunc_begin0
	.long	.Ltmp710-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	55                              // 55
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp710-.Lfunc_begin0
	.long	.Ltmp712-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	56                              // 56
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp713-.Lfunc_begin0
	.long	.Ltmp716-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	56                              // 56
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp716-.Lfunc_begin0
	.long	.Ltmp718-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	57                              // 57
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp719-.Lfunc_begin0
	.long	.Ltmp722-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	57                              // 57
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp722-.Lfunc_begin0
	.long	.Ltmp724-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	58                              // 58
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp725-.Lfunc_begin0
	.long	.Ltmp728-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	58                              // 58
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp728-.Lfunc_begin0
	.long	.Ltmp730-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	59                              // 59
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp731-.Lfunc_begin0
	.long	.Ltmp734-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	59                              // 59
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp734-.Lfunc_begin0
	.long	.Ltmp736-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	60                              // 60
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp737-.Lfunc_begin0
	.long	.Ltmp740-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	60                              // 60
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp740-.Lfunc_begin0
	.long	.Ltmp742-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	61                              // 61
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp743-.Lfunc_begin0
	.long	.Ltmp746-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	61                              // 61
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp746-.Lfunc_begin0
	.long	.Ltmp748-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	62                              // 62
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp749-.Lfunc_begin0
	.long	.Ltmp752-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	62                              // 62
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp752-.Lfunc_begin0
	.long	.Ltmp754-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	63                              // 63
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp755-.Lfunc_begin0
	.long	.Ltmp758-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	63                              // 63
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp758-.Lfunc_begin0
	.long	.Ltmp760-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	64                              // 64
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp761-.Lfunc_begin0
	.long	.Ltmp764-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	64                              // 64
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp764-.Lfunc_begin0
	.long	.Ltmp766-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	65                              // 65
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp767-.Lfunc_begin0
	.long	.Ltmp770-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	65                              // 65
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp770-.Lfunc_begin0
	.long	.Ltmp772-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	66                              // 66
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp773-.Lfunc_begin0
	.long	.Ltmp776-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	66                              // 66
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp776-.Lfunc_begin0
	.long	.Ltmp778-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	67                              // 67
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp779-.Lfunc_begin0
	.long	.Ltmp782-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	67                              // 67
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp782-.Lfunc_begin0
	.long	.Ltmp784-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	68                              // 68
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp785-.Lfunc_begin0
	.long	.Ltmp788-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	68                              // 68
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp788-.Lfunc_begin0
	.long	.Ltmp790-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	69                              // 69
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp791-.Lfunc_begin0
	.long	.Ltmp794-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	69                              // 69
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp794-.Lfunc_begin0
	.long	.Ltmp796-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	70                              // 70
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp797-.Lfunc_begin0
	.long	.Ltmp800-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	70                              // 70
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp800-.Lfunc_begin0
	.long	.Ltmp802-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	71                              // 71
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp803-.Lfunc_begin0
	.long	.Ltmp806-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	71                              // 71
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp806-.Lfunc_begin0
	.long	.Ltmp808-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	72                              // 72
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp809-.Lfunc_begin0
	.long	.Ltmp812-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	72                              // 72
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp812-.Lfunc_begin0
	.long	.Ltmp814-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	73                              // 73
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp815-.Lfunc_begin0
	.long	.Ltmp818-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	73                              // 73
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp818-.Lfunc_begin0
	.long	.Ltmp820-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	74                              // 74
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp821-.Lfunc_begin0
	.long	.Ltmp824-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	74                              // 74
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp824-.Lfunc_begin0
	.long	.Ltmp826-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	75                              // 75
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp827-.Lfunc_begin0
	.long	.Ltmp830-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	75                              // 75
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp830-.Lfunc_begin0
	.long	.Ltmp832-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	76                              // 76
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp833-.Lfunc_begin0
	.long	.Ltmp836-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	76                              // 76
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp836-.Lfunc_begin0
	.long	.Ltmp838-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	77                              // 77
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp839-.Lfunc_begin0
	.long	.Ltmp842-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	77                              // 77
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp842-.Lfunc_begin0
	.long	.Ltmp844-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	78                              // 78
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp845-.Lfunc_begin0
	.long	.Ltmp848-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	78                              // 78
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp848-.Lfunc_begin0
	.long	.Ltmp850-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	79                              // 79
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp851-.Lfunc_begin0
	.long	.Ltmp854-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	79                              // 79
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp854-.Lfunc_begin0
	.long	.Ltmp856-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	80                              // 80
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp857-.Lfunc_begin0
	.long	.Ltmp860-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	80                              // 80
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp860-.Lfunc_begin0
	.long	.Ltmp862-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	81                              // 81
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp863-.Lfunc_begin0
	.long	.Ltmp866-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	81                              // 81
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp866-.Lfunc_begin0
	.long	.Ltmp868-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	82                              // 82
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp869-.Lfunc_begin0
	.long	.Ltmp872-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	82                              // 82
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp872-.Lfunc_begin0
	.long	.Ltmp874-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	83                              // 83
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp875-.Lfunc_begin0
	.long	.Ltmp878-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	83                              // 83
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp878-.Lfunc_begin0
	.long	.Ltmp880-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	84                              // 84
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp881-.Lfunc_begin0
	.long	.Ltmp884-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	84                              // 84
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp884-.Lfunc_begin0
	.long	.Ltmp886-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	85                              // 85
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp887-.Lfunc_begin0
	.long	.Ltmp890-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	85                              // 85
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp890-.Lfunc_begin0
	.long	.Ltmp892-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	86                              // 86
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp893-.Lfunc_begin0
	.long	.Ltmp896-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	86                              // 86
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp896-.Lfunc_begin0
	.long	.Ltmp898-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	87                              // 87
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp899-.Lfunc_begin0
	.long	.Ltmp902-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	87                              // 87
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp902-.Lfunc_begin0
	.long	.Ltmp904-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	88                              // 88
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp905-.Lfunc_begin0
	.long	.Ltmp908-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	88                              // 88
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp908-.Lfunc_begin0
	.long	.Ltmp910-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	89                              // 89
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp911-.Lfunc_begin0
	.long	.Ltmp914-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	89                              // 89
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp914-.Lfunc_begin0
	.long	.Ltmp916-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	90                              // 90
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp917-.Lfunc_begin0
	.long	.Ltmp920-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	90                              // 90
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp920-.Lfunc_begin0
	.long	.Ltmp922-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	91                              // 91
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp923-.Lfunc_begin0
	.long	.Ltmp926-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	91                              // 91
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp926-.Lfunc_begin0
	.long	.Ltmp928-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	92                              // 92
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp929-.Lfunc_begin0
	.long	.Ltmp932-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	92                              // 92
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp932-.Lfunc_begin0
	.long	.Ltmp934-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	93                              // 93
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp935-.Lfunc_begin0
	.long	.Ltmp938-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	93                              // 93
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp938-.Lfunc_begin0
	.long	.Ltmp940-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	94                              // 94
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp941-.Lfunc_begin0
	.long	.Ltmp944-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	94                              // 94
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp944-.Lfunc_begin0
	.long	.Ltmp946-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	95                              // 95
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp947-.Lfunc_begin0
	.long	.Ltmp950-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	95                              // 95
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp950-.Lfunc_begin0
	.long	.Ltmp952-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	96                              // 96
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp953-.Lfunc_begin0
	.long	.Ltmp956-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	96                              // 96
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp956-.Lfunc_begin0
	.long	.Ltmp958-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	97                              // 97
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp959-.Lfunc_begin0
	.long	.Ltmp962-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	97                              // 97
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp962-.Lfunc_begin0
	.long	.Ltmp964-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	98                              // 98
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp965-.Lfunc_begin0
	.long	.Ltmp968-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	98                              // 98
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp968-.Lfunc_begin0
	.long	.Ltmp970-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	99                              // 99
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp971-.Lfunc_begin0
	.long	.Ltmp974-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	99                              // 99
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp974-.Lfunc_begin0
	.long	.Ltmp976-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	100                             // 100
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp977-.Lfunc_begin0
	.long	.Ltmp980-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	100                             // 100
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp980-.Lfunc_begin0
	.long	.Ltmp982-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	101                             // 101
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp983-.Lfunc_begin0
	.long	.Ltmp986-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	101                             // 101
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp986-.Lfunc_begin0
	.long	.Ltmp988-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	102                             // 102
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp989-.Lfunc_begin0
	.long	.Ltmp992-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	102                             // 102
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp992-.Lfunc_begin0
	.long	.Ltmp994-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	103                             // 103
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp995-.Lfunc_begin0
	.long	.Ltmp998-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	103                             // 103
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp998-.Lfunc_begin0
	.long	.Ltmp1000-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	104                             // 104
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1001-.Lfunc_begin0
	.long	.Ltmp1004-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	104                             // 104
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1004-.Lfunc_begin0
	.long	.Ltmp1006-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	105                             // 105
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1007-.Lfunc_begin0
	.long	.Ltmp1010-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	105                             // 105
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1010-.Lfunc_begin0
	.long	.Ltmp1012-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	106                             // 106
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1013-.Lfunc_begin0
	.long	.Ltmp1016-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	106                             // 106
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1016-.Lfunc_begin0
	.long	.Ltmp1018-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	107                             // 107
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1019-.Lfunc_begin0
	.long	.Ltmp1022-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	107                             // 107
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1022-.Lfunc_begin0
	.long	.Ltmp1024-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	108                             // 108
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1025-.Lfunc_begin0
	.long	.Ltmp1028-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	108                             // 108
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1028-.Lfunc_begin0
	.long	.Ltmp1030-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	109                             // 109
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1031-.Lfunc_begin0
	.long	.Ltmp1034-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	109                             // 109
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1034-.Lfunc_begin0
	.long	.Ltmp1036-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	110                             // 110
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1037-.Lfunc_begin0
	.long	.Ltmp1040-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	110                             // 110
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1040-.Lfunc_begin0
	.long	.Ltmp1042-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	111                             // 111
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1043-.Lfunc_begin0
	.long	.Ltmp1046-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	111                             // 111
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1046-.Lfunc_begin0
	.long	.Ltmp1048-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	112                             // 112
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1049-.Lfunc_begin0
	.long	.Ltmp1052-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	112                             // 112
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1052-.Lfunc_begin0
	.long	.Ltmp1054-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	113                             // 113
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1055-.Lfunc_begin0
	.long	.Ltmp1058-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	113                             // 113
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1058-.Lfunc_begin0
	.long	.Ltmp1060-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	114                             // 114
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1061-.Lfunc_begin0
	.long	.Ltmp1064-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	114                             // 114
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1064-.Lfunc_begin0
	.long	.Ltmp1066-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	115                             // 115
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1067-.Lfunc_begin0
	.long	.Ltmp1070-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	115                             // 115
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1070-.Lfunc_begin0
	.long	.Ltmp1072-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	116                             // 116
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1073-.Lfunc_begin0
	.long	.Ltmp1076-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	116                             // 116
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1076-.Lfunc_begin0
	.long	.Ltmp1078-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	117                             // 117
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1079-.Lfunc_begin0
	.long	.Ltmp1082-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	117                             // 117
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1082-.Lfunc_begin0
	.long	.Ltmp1084-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	118                             // 118
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1085-.Lfunc_begin0
	.long	.Ltmp1088-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	118                             // 118
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1088-.Lfunc_begin0
	.long	.Ltmp1090-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	119                             // 119
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1091-.Lfunc_begin0
	.long	.Ltmp1094-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	119                             // 119
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1094-.Lfunc_begin0
	.long	.Ltmp1096-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	120                             // 120
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1097-.Lfunc_begin0
	.long	.Ltmp1100-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	120                             // 120
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1100-.Lfunc_begin0
	.long	.Ltmp1102-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	121                             // 121
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1103-.Lfunc_begin0
	.long	.Ltmp1106-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	121                             // 121
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1106-.Lfunc_begin0
	.long	.Ltmp1108-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	122                             // 122
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1109-.Lfunc_begin0
	.long	.Ltmp1112-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	122                             // 122
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1112-.Lfunc_begin0
	.long	.Ltmp1114-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	123                             // 123
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1115-.Lfunc_begin0
	.long	.Ltmp1118-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	123                             // 123
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1118-.Lfunc_begin0
	.long	.Ltmp1120-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	124                             // 124
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1121-.Lfunc_begin0
	.long	.Ltmp1124-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	124                             // 124
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1124-.Lfunc_begin0
	.long	.Ltmp1126-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	125                             // 125
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1127-.Lfunc_begin0
	.long	.Ltmp1130-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	125                             // 125
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1130-.Lfunc_begin0
	.long	.Ltmp1132-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	126                             // 126
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1133-.Lfunc_begin0
	.long	.Ltmp1136-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	126                             // 126
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1136-.Lfunc_begin0
	.long	.Ltmp1138-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	127                             // 127
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1139-.Lfunc_begin0
	.long	.Ltmp1143-.Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	127                             // 127
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1143-.Lfunc_begin0
	.long	.Lfunc_end0-.Lfunc_begin0
	.short	4                               // Loc expr size
	.byte	16                              // DW_OP_constu
	.byte	128                             // 128
	.byte	1                               // 
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc4:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Lfunc_begin1-.Lfunc_begin1
	.long	.Ltmp1145-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp1145-.Lfunc_begin1
	.long	.Ltmp1157-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	0
	.long	0
.Ldebug_loc5:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Lfunc_begin1-.Lfunc_begin1
	.long	.Ltmp1145-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp1145-.Lfunc_begin1
	.long	.Ltmp1158-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc6:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Lfunc_begin1-.Lfunc_begin1
	.long	.Ltmp1145-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	.Ltmp1145-.Lfunc_begin1
	.long	.Ltmp1157-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	97                              // DW_OP_reg17
	.long	0
	.long	0
.Ldebug_loc7:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp1145-.Lfunc_begin1
	.long	.Ltmp1158-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	126                             // DW_OP_breg14
	.byte	0                               // 0
	.long	0
	.long	0
.Ldebug_loc8:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp1148-.Lfunc_begin1
	.long	.Ltmp1151-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	98                              // DW_OP_reg18
	.long	.Ltmp1151-.Lfunc_begin1
	.long	.Ltmp1154-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc9:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp1150-.Lfunc_begin1
	.long	.Ltmp1151-.Lfunc_begin1
	.short	6                               // Loc expr size
	.byte	131                             // DW_OP_breg19
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1153-.Lfunc_begin1
	.long	.Ltmp1156-.Lfunc_begin1
	.short	6                               // Loc expr size
	.byte	131                             // DW_OP_breg19
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc10:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp1149-.Lfunc_begin1
	.long	.Ltmp1151-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	100                             // DW_OP_reg20
	.long	.Ltmp1152-.Lfunc_begin1
	.long	.Ltmp1154-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc11:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1161-.Lfunc_begin2
	.long	.Ltmp1162-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
.Ldebug_loc12:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1165-.Lfunc_begin2
	.long	.Ltmp1195-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	98                              // DW_OP_reg18
	.long	0
	.long	0
.Ldebug_loc13:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1175-.Lfunc_begin2
	.long	.Ltmp1194-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	100                             // DW_OP_reg20
	.long	0
	.long	0
.Ldebug_loc14:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1166-.Lfunc_begin2
	.long	.Ltmp1176-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	99                              // DW_OP_reg19
	.long	0
	.long	0
.Ldebug_loc15:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1168-.Lfunc_begin2
	.long	.Ltmp1197-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc16:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1170-.Lfunc_begin2
	.long	.Ltmp1196-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	0
	.long	0
.Ldebug_loc17:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1173-.Lfunc_begin2
	.long	.Ltmp1176-.Lfunc_begin2
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp1176-.Lfunc_begin2
	.long	.Ltmp1194-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	101                             // DW_OP_reg21
	.long	0
	.long	0
.Ldebug_loc18:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1176-.Lfunc_begin2
	.long	.Ltmp1180-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	97                              // DW_OP_reg17
	.long	.Ltmp1185-.Lfunc_begin2
	.long	.Ltmp1194-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	97                              // DW_OP_reg17
	.long	0
	.long	0
.Ldebug_loc19:
	.long	-1
	.long	.Lfunc_begin2                   //   base address
	.long	.Ltmp1187-.Lfunc_begin2
	.long	.Ltmp1188-.Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	21                              // DW_TAG_subroutine_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	19                              // DW_TAG_structure_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	13                              // DW_TAG_member
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	56                              // DW_AT_data_member_location
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	4                               // DW_TAG_enumeration_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	40                              // DW_TAG_enumerator
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	15                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	16                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	17                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	18                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	19                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	20                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	21                              // Abbreviation Code
	.ascii	"\211\202\001"                  // DW_TAG_GNU_call_site
	.byte	0                               // DW_CHILDREN_no
	.ascii	"\223B"                         // DW_AT_GNU_call_site_target
	.byte	24                              // DW_FORM_exprloc
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	22                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	23                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	24                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	25                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	26                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	0                               // DW_CHILDREN_no
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	27                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	28                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	29                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	1                               // DW_CHILDREN_yes
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	30                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	31                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	32                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 // Length of Unit
.Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x4c5 DW_TAG_compile_unit
	.long	.Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	.Linfo_string1                  // DW_AT_name
	.long	.Lline_table_start0             // DW_AT_stmt_list
	.long	.Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	.Ldebug_ranges2                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	.Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	72                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	kernels
	.byte	3                               // Abbrev [3] 0x37:0xc DW_TAG_array_type
	.long	67                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x3c:0x6 DW_TAG_subrange_type
	.long	84                              // DW_AT_type
	.byte	1                               // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x43:0x5 DW_TAG_pointer_type
	.long	72                              // DW_AT_type
	.byte	6                               // Abbrev [6] 0x48:0x5 DW_TAG_subroutine_type
	.long	77                              // DW_AT_type
                                        // DW_AT_prototyped
	.byte	7                               // Abbrev [7] 0x4d:0x7 DW_TAG_base_type
	.long	.Linfo_string4                  // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	8                               // Abbrev [8] 0x54:0x7 DW_TAG_base_type
	.long	.Linfo_string5                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	9                               // Abbrev [9] 0x5b:0x12 DW_TAG_variable
	.long	.Linfo_string6                  // DW_AT_name
	.long	109                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	16                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	DPU_INPUT_ARGUMENTS
	.byte	10                              // Abbrev [10] 0x6d:0xb DW_TAG_typedef
	.long	120                             // DW_AT_type
	.long	.Linfo_string13                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	15                              // DW_AT_decl_line
	.byte	11                              // Abbrev [11] 0x78:0x1d DW_TAG_structure_type
	.byte	8                               // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	9                               // DW_AT_decl_line
	.byte	12                              // Abbrev [12] 0x7c:0xc DW_TAG_member
	.long	.Linfo_string7                  // DW_AT_name
	.long	149                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	10                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	12                              // Abbrev [12] 0x88:0xc DW_TAG_member
	.long	.Linfo_string10                 // DW_AT_name
	.long	167                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	14                              // DW_AT_decl_line
	.byte	4                               // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	10                              // Abbrev [10] 0x95:0xb DW_TAG_typedef
	.long	160                             // DW_AT_type
	.long	.Linfo_string9                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	7                               // Abbrev [7] 0xa0:0x7 DW_TAG_base_type
	.long	.Linfo_string8                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	13                              // Abbrev [13] 0xa7:0x19 DW_TAG_enumeration_type
	.long	160                             // DW_AT_type
	.long	.Linfo_string3                  // DW_AT_name
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	11                              // DW_AT_decl_line
	.byte	14                              // Abbrev [14] 0xb3:0x6 DW_TAG_enumerator
	.long	.Linfo_string11                 // DW_AT_name
	.byte	0                               // DW_AT_const_value
	.byte	14                              // Abbrev [14] 0xb9:0x6 DW_TAG_enumerator
	.long	.Linfo_string12                 // DW_AT_name
	.byte	1                               // DW_AT_const_value
	.byte	0                               // End Of Children Mark
	.byte	9                               // Abbrev [9] 0xc0:0x12 DW_TAG_variable
	.long	.Linfo_string14                 // DW_AT_name
	.long	210                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	17                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	DPU_RESULTS
	.byte	3                               // Abbrev [3] 0xd2:0xc DW_TAG_array_type
	.long	222                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0xd7:0x6 DW_TAG_subrange_type
	.long	84                              // DW_AT_type
	.byte	16                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	10                              // Abbrev [10] 0xde:0xb DW_TAG_typedef
	.long	233                             // DW_AT_type
	.long	.Linfo_string20                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	21                              // DW_AT_decl_line
	.byte	11                              // Abbrev [11] 0xe9:0x29 DW_TAG_structure_type
	.byte	24                              // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	17                              // DW_AT_decl_line
	.byte	12                              // Abbrev [12] 0xed:0xc DW_TAG_member
	.long	.Linfo_string15                 // DW_AT_name
	.long	149                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	12                              // Abbrev [12] 0xf9:0xc DW_TAG_member
	.long	.Linfo_string16                 // DW_AT_name
	.long	274                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.byte	8                               // DW_AT_data_member_location
	.byte	12                              // Abbrev [12] 0x105:0xc DW_TAG_member
	.long	.Linfo_string19                 // DW_AT_name
	.long	274                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	20                              // DW_AT_decl_line
	.byte	16                              // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	10                              // Abbrev [10] 0x112:0xb DW_TAG_typedef
	.long	285                             // DW_AT_type
	.long	.Linfo_string18                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	7                               // Abbrev [7] 0x11d:0x7 DW_TAG_base_type
	.long	.Linfo_string17                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	2                               // Abbrev [2] 0x124:0x11 DW_TAG_variable
	.long	.Linfo_string21                 // DW_AT_name
	.long	309                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	20                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	message
	.byte	3                               // Abbrev [3] 0x135:0xc DW_TAG_array_type
	.long	149                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0x13a:0x6 DW_TAG_subrange_type
	.long	84                              // DW_AT_type
	.byte	16                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	2                               // Abbrev [2] 0x141:0x11 DW_TAG_variable
	.long	.Linfo_string22                 // DW_AT_name
	.long	338                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	21                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	message_value
	.byte	3                               // Abbrev [3] 0x152:0xc DW_TAG_array_type
	.long	274                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0x157:0x6 DW_TAG_subrange_type
	.long	84                              // DW_AT_type
	.byte	16                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	2                               // Abbrev [2] 0x15e:0x11 DW_TAG_variable
	.long	.Linfo_string23                 // DW_AT_name
	.long	309                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	22                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	message_offset
	.byte	2                               // Abbrev [2] 0x16f:0x11 DW_TAG_variable
	.long	.Linfo_string24                 // DW_AT_name
	.long	149                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	23                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	message_partial_count
	.byte	2                               // Abbrev [2] 0x180:0x11 DW_TAG_variable
	.long	.Linfo_string25                 // DW_AT_name
	.long	274                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	24                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	message_last_from_last
	.byte	2                               // Abbrev [2] 0x191:0x11 DW_TAG_variable
	.long	.Linfo_string26                 // DW_AT_name
	.long	418                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	68                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit_barrier_my_barrier
	.byte	10                              // Abbrev [10] 0x1a2:0xb DW_TAG_typedef
	.long	429                             // DW_AT_type
	.long	.Linfo_string28                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	7                               // Abbrev [7] 0x1ad:0x7 DW_TAG_base_type
	.long	.Linfo_string27                 // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	15                              // Abbrev [15] 0x1b4:0x1 DW_TAG_pointer_type
	.byte	5                               // Abbrev [5] 0x1b5:0x5 DW_TAG_pointer_type
	.long	274                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x1ba:0x5 DW_TAG_pointer_type
	.long	447                             // DW_AT_type
	.byte	16                              // Abbrev [16] 0x1bf:0x1 DW_TAG_const_type
	.byte	17                              // Abbrev [17] 0x1c0:0x58 DW_TAG_subprogram
	.long	.Lfunc_begin0                   // DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string36                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	160                             // DW_AT_type
                                        // DW_AT_external
	.byte	18                              // Abbrev [18] 0x1d5:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc0                    // DW_AT_location
	.long	.Linfo_string44                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.long	437                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x1e4:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc1                    // DW_AT_location
	.long	.Linfo_string45                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.long	437                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1f3:0xf DW_TAG_variable
	.long	.Ldebug_loc2                    // DW_AT_location
	.long	.Linfo_string46                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	28                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	20                              // Abbrev [20] 0x202:0x15 DW_TAG_lexical_block
	.long	.Ldebug_ranges0                 // DW_AT_ranges
	.byte	19                              // Abbrev [19] 0x207:0xf DW_TAG_variable
	.long	.Ldebug_loc3                    // DW_AT_location
	.long	.Linfo_string47                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	32                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	17                              // Abbrev [17] 0x218:0x8d DW_TAG_subprogram
	.long	.Lfunc_begin1                   // DW_AT_low_pc
	.long	.Lfunc_end1-.Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string37                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	1174                            // DW_AT_type
                                        // DW_AT_external
	.byte	18                              // Abbrev [18] 0x22d:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc4                    // DW_AT_location
	.long	.Linfo_string44                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	437                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x23c:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc5                    // DW_AT_location
	.long	.Linfo_string48                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x24b:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc6                    // DW_AT_location
	.long	.Linfo_string49                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x25a:0xf DW_TAG_variable
	.long	.Ldebug_loc7                    // DW_AT_location
	.long	.Linfo_string50                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	63                              // DW_AT_decl_line
	.long	1174                            // DW_AT_type
	.byte	19                              // Abbrev [19] 0x269:0xf DW_TAG_variable
	.long	.Ldebug_loc8                    // DW_AT_location
	.long	.Linfo_string51                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x278:0xf DW_TAG_variable
	.long	.Ldebug_loc9                    // DW_AT_location
	.long	.Linfo_string52                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x287:0xf DW_TAG_variable
	.long	.Ldebug_loc10                   // DW_AT_location
	.long	.Linfo_string53                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	21                              // Abbrev [21] 0x296:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1147                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x29d:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1155                       // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x2a5:0xc DW_TAG_subprogram
	.long	.Linfo_string29                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	689                             // DW_AT_type
	.byte	1                               // DW_AT_inline
	.byte	10                              // Abbrev [10] 0x2b1:0xb DW_TAG_typedef
	.long	160                             // DW_AT_type
	.long	.Linfo_string30                 // DW_AT_name
	.byte	6                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	23                              // Abbrev [23] 0x2bc:0x2a DW_TAG_subprogram
	.long	.Linfo_string31                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	24                              // Abbrev [24] 0x2c4:0xb DW_TAG_formal_parameter
	.long	.Linfo_string32                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	442                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x2cf:0xb DW_TAG_formal_parameter
	.long	.Linfo_string33                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	436                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x2da:0xb DW_TAG_formal_parameter
	.long	.Linfo_string34                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x2e6:0x2a DW_TAG_subprogram
	.long	.Linfo_string35                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	24                              // Abbrev [24] 0x2ee:0xb DW_TAG_formal_parameter
	.long	.Linfo_string32                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	442                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x2f9:0xb DW_TAG_formal_parameter
	.long	.Linfo_string33                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	436                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x304:0xb DW_TAG_formal_parameter
	.long	.Linfo_string34                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	17                              // Abbrev [17] 0x310:0x169 DW_TAG_subprogram
	.long	.Lfunc_begin2                   // DW_AT_low_pc
	.long	.Lfunc_end2-.Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string42                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	80                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	77                              // DW_AT_type
                                        // DW_AT_external
	.byte	19                              // Abbrev [19] 0x325:0xf DW_TAG_variable
	.long	.Ldebug_loc11                   // DW_AT_location
	.long	.Linfo_string49                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	81                              // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	25                              // Abbrev [25] 0x334:0xb DW_TAG_variable
	.long	.Linfo_string50                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	91                              // DW_AT_decl_line
	.long	1226                            // DW_AT_type
	.byte	19                              // Abbrev [19] 0x33f:0xf DW_TAG_variable
	.long	.Ldebug_loc12                   // DW_AT_location
	.long	.Linfo_string55                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	93                              // DW_AT_decl_line
	.long	149                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x34e:0xf DW_TAG_variable
	.long	.Ldebug_loc13                   // DW_AT_location
	.long	.Linfo_string56                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	98                              // DW_AT_decl_line
	.long	149                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x35d:0xf DW_TAG_variable
	.long	.Ldebug_loc14                   // DW_AT_location
	.long	.Linfo_string57                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	96                              // DW_AT_decl_line
	.long	149                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x36c:0xf DW_TAG_variable
	.long	.Ldebug_loc15                   // DW_AT_location
	.long	.Linfo_string58                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	437                             // DW_AT_type
	.byte	25                              // Abbrev [25] 0x37b:0xb DW_TAG_variable
	.long	.Linfo_string59                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	97                              // DW_AT_decl_line
	.long	149                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x386:0xf DW_TAG_variable
	.long	.Ldebug_loc16                   // DW_AT_location
	.long	.Linfo_string60                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	102                             // DW_AT_decl_line
	.long	437                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x395:0xf DW_TAG_variable
	.long	.Ldebug_loc17                   // DW_AT_location
	.long	.Linfo_string62                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	112                             // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	26                              // Abbrev [26] 0x3a4:0x10 DW_TAG_inlined_subroutine
	.long	677                             // DW_AT_abstract_origin
	.long	.Ltmp1160                       // DW_AT_low_pc
	.long	.Ltmp1162-.Ltmp1160             // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	81                              // DW_AT_call_line
	.byte	31                              // DW_AT_call_column
	.byte	27                              // Abbrev [27] 0x3b4:0x8c DW_TAG_lexical_block
	.long	.Ltmp1173                       // DW_AT_low_pc
	.long	.Ltmp1194-.Ltmp1173             // DW_AT_high_pc
	.byte	28                              // Abbrev [28] 0x3bd:0xd DW_TAG_variable
	.byte	1                               // DW_AT_location
	.byte	99
	.long	.Linfo_string61                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	113                             // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	20                              // Abbrev [20] 0x3ca:0x75 DW_TAG_lexical_block
	.long	.Ldebug_ranges1                 // DW_AT_ranges
	.byte	28                              // Abbrev [28] 0x3cf:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	104
	.long	.Linfo_string54                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	122                             // DW_AT_decl_line
	.long	1174                            // DW_AT_type
	.byte	19                              // Abbrev [19] 0x3dd:0xf DW_TAG_variable
	.long	.Ldebug_loc18                   // DW_AT_location
	.long	.Linfo_string48                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	119                             // DW_AT_decl_line
	.long	160                             // DW_AT_type
	.byte	29                              // Abbrev [29] 0x3ec:0x26 DW_TAG_inlined_subroutine
	.long	700                             // DW_AT_abstract_origin
	.long	.Ltmp1181                       // DW_AT_low_pc
	.long	.Ltmp1182-.Ltmp1181             // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	116                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	30                              // Abbrev [30] 0x3fc:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	708                             // DW_AT_abstract_origin
	.byte	30                              // Abbrev [30] 0x403:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	95
	.long	719                             // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x40a:0x7 DW_TAG_formal_parameter
	.ascii	"\200\b"                        // DW_AT_const_value
	.long	730                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	29                              // Abbrev [29] 0x412:0x2c DW_TAG_inlined_subroutine
	.long	742                             // DW_AT_abstract_origin
	.long	.Ltmp1187                       // DW_AT_low_pc
	.long	.Ltmp1189-.Ltmp1187             // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	125                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	32                              // Abbrev [32] 0x422:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc19                   // DW_AT_location
	.long	750                             // DW_AT_abstract_origin
	.byte	30                              // Abbrev [30] 0x42b:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	761                             // DW_AT_abstract_origin
	.byte	30                              // Abbrev [30] 0x432:0xb DW_TAG_formal_parameter
	.byte	5                               // DW_AT_location
	.byte	129
	.byte	0
	.byte	51
	.byte	36
	.byte	159
	.long	772                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	21                              // Abbrev [21] 0x440:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1163                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x447:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1164                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x44e:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1167                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x455:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1169                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x45c:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1173                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x463:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1177                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x46a:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1184                       // DW_AT_low_pc
	.byte	21                              // Abbrev [21] 0x471:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1186                       // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	17                              // Abbrev [17] 0x479:0x1d DW_TAG_subprogram
	.long	.Lfunc_begin3                   // DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string43                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	74                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	77                              // DW_AT_type
                                        // DW_AT_external
	.byte	21                              // Abbrev [21] 0x48e:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp1200                       // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	10                              // Abbrev [10] 0x496:0xb DW_TAG_typedef
	.long	1185                            // DW_AT_type
	.long	.Linfo_string41                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	11                              // Abbrev [11] 0x4a1:0x29 DW_TAG_structure_type
	.byte	12                              // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	12                              // Abbrev [12] 0x4a5:0xc DW_TAG_member
	.long	.Linfo_string38                 // DW_AT_name
	.long	160                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	12                              // Abbrev [12] 0x4b1:0xc DW_TAG_member
	.long	.Linfo_string39                 // DW_AT_name
	.long	160                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	4                               // DW_AT_data_member_location
	.byte	12                              // Abbrev [12] 0x4bd:0xc DW_TAG_member
	.long	.Linfo_string40                 // DW_AT_name
	.long	160                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	8                               // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x4ca:0x5 DW_TAG_pointer_type
	.long	222                             // DW_AT_type
	.byte	0                               // End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.Ltmp1
	.long	.Ltmp382
	.long	.Ltmp384
	.long	.Ltmp1142
	.long	0
	.long	0
.Ldebug_ranges1:
	.long	.Ltmp1176
	.long	.Ltmp1177
	.long	.Ltmp1178
	.long	.Ltmp1179
	.long	.Ltmp1180
	.long	.Ltmp1194
	.long	0
	.long	0
.Ldebug_ranges2:
	.long	.Lfunc_begin0
	.long	.Lfunc_end0
	.long	.Lfunc_begin1
	.long	.Lfunc_end1
	.long	.Lfunc_begin2
	.long	.Lfunc_end2
	.long	.Lfunc_begin3
	.long	.Lfunc_end3
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
.Linfo_string1:
	.asciz	"/root/uPIMulator/benchmark/UNI/dpu/task.c" // string offset=106
.Linfo_string2:
	.asciz	"/root/uPIMulator/benchmark/build" // string offset=148
.Linfo_string3:
	.asciz	"kernels"                       // string offset=181
.Linfo_string4:
	.asciz	"int"                           // string offset=189
.Linfo_string5:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=193
.Linfo_string6:
	.asciz	"DPU_INPUT_ARGUMENTS"           // string offset=213
.Linfo_string7:
	.asciz	"size"                          // string offset=233
.Linfo_string8:
	.asciz	"unsigned int"                  // string offset=238
.Linfo_string9:
	.asciz	"uint32_t"                      // string offset=251
.Linfo_string10:
	.asciz	"kernel"                        // string offset=260
.Linfo_string11:
	.asciz	"kernel1"                       // string offset=267
.Linfo_string12:
	.asciz	"nr_kernels"                    // string offset=275
.Linfo_string13:
	.asciz	"dpu_arguments_t"               // string offset=286
.Linfo_string14:
	.asciz	"DPU_RESULTS"                   // string offset=302
.Linfo_string15:
	.asciz	"t_count"                       // string offset=314
.Linfo_string16:
	.asciz	"first"                         // string offset=322
.Linfo_string17:
	.asciz	"long long int"                 // string offset=328
.Linfo_string18:
	.asciz	"int64_t"                       // string offset=342
.Linfo_string19:
	.asciz	"last"                          // string offset=350
.Linfo_string20:
	.asciz	"dpu_results_t"                 // string offset=355
.Linfo_string21:
	.asciz	"message"                       // string offset=369
.Linfo_string22:
	.asciz	"message_value"                 // string offset=377
.Linfo_string23:
	.asciz	"message_offset"                // string offset=391
.Linfo_string24:
	.asciz	"message_partial_count"         // string offset=406
.Linfo_string25:
	.asciz	"message_last_from_last"        // string offset=428
.Linfo_string26:
	.asciz	"__atomic_bit_barrier_my_barrier" // string offset=451
.Linfo_string27:
	.asciz	"unsigned char"                 // string offset=483
.Linfo_string28:
	.asciz	"uint8_t"                       // string offset=497
.Linfo_string29:
	.asciz	"me"                            // string offset=505
.Linfo_string30:
	.asciz	"sysname_t"                     // string offset=508
.Linfo_string31:
	.asciz	"mram_read"                     // string offset=518
.Linfo_string32:
	.asciz	"from"                          // string offset=528
.Linfo_string33:
	.asciz	"to"                            // string offset=533
.Linfo_string34:
	.asciz	"nb_of_bytes"                   // string offset=536
.Linfo_string35:
	.asciz	"mram_write"                    // string offset=548
.Linfo_string36:
	.asciz	"unique"                        // string offset=559
.Linfo_string37:
	.asciz	"handshake_sync"                // string offset=566
.Linfo_string38:
	.asciz	"x"                             // string offset=581
.Linfo_string39:
	.asciz	"y"                             // string offset=583
.Linfo_string40:
	.asciz	"z"                             // string offset=585
.Linfo_string41:
	.asciz	"uint3"                         // string offset=587
.Linfo_string42:
	.asciz	"main_kernel1"                  // string offset=593
.Linfo_string43:
	.asciz	"main"                          // string offset=606
.Linfo_string44:
	.asciz	"output"                        // string offset=611
.Linfo_string45:
	.asciz	"input"                         // string offset=618
.Linfo_string46:
	.asciz	"pos"                           // string offset=624
.Linfo_string47:
	.asciz	"j"                             // string offset=628
.Linfo_string48:
	.asciz	"l_count"                       // string offset=630
.Linfo_string49:
	.asciz	"tasklet_id"                    // string offset=638
.Linfo_string50:
	.asciz	"result"                        // string offset=649
.Linfo_string51:
	.asciz	"p_count"                       // string offset=656
.Linfo_string52:
	.asciz	"offset"                        // string offset=664
.Linfo_string53:
	.asciz	"o_count"                       // string offset=671
.Linfo_string54:
	.asciz	"po_count"                      // string offset=679
.Linfo_string55:
	.asciz	"input_size_dpu_bytes"          // string offset=688
.Linfo_string56:
	.asciz	"mram_base_addr_B"              // string offset=709
.Linfo_string57:
	.asciz	"base_tasklet"                  // string offset=726
.Linfo_string58:
	.asciz	"cache_A"                       // string offset=739
.Linfo_string59:
	.asciz	"mram_base_addr_A"              // string offset=747
.Linfo_string60:
	.asciz	"cache_B"                       // string offset=764
.Linfo_string61:
	.asciz	"byte_index"                    // string offset=772
.Linfo_string62:
	.asciz	"i"                             // string offset=783
	.addrsig
	.addrsig_sym main_kernel1
	.addrsig_sym DPU_INPUT_ARGUMENTS
	.addrsig_sym my_barrier
	.addrsig_sym DPU_RESULTS
	.addrsig_sym __sys_used_mram_end
	.section	.debug_line,"",@progbits
.Lline_table_start0:
	.text
	.file	"memset.c"
	.file	1 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.file	2 "/root/uPIMulator/sdk" "stdlib/memset.c"
	.section	.text.__memset_wram_4align,"ax",@progbits
	.globl	__memset_wram_4align            // -- Begin function __memset_wram_4align
	.type	__memset_wram_4align,@function
__memset_wram_4align:                   // @__memset_wram_4align
stdlib.memset..Lfunc_begin0:
	.loc	2 27 0                          // stdlib/memset.c:27:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r0
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r0
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	//DEBUG_VALUE: __memset_wram_4align:len <- $r2
	//DEBUG_VALUE: __memset_wram_4align:len <- $r2
	.cfi_def_cfa_offset 0
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r0
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r0
	//DEBUG_VALUE: __memset_wram_4align:cccc <- undef
	//DEBUG_VALUE: i <- 0
	.loc	2 34 34 prologue_end            // stdlib/memset.c:34:34
	lsr r2, r2, 2, z, stdlib.memset..LBB0_3
stdlib.memset..Ltmp0:
// %bb.1:
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r0
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r0
	//DEBUG_VALUE: i <- 0
	.loc	2 0 34 is_stmt 0                // stdlib/memset.c:0:34
	and r3, r1, 255
	lsl_add r1, r3, r1, 24
stdlib.memset..Ltmp1:
	lsl_add r1, r1, r3, 8
	lsl_add r1, r1, r3, 16
stdlib.memset..Ltmp2:
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r1
	move r3, r0
stdlib.memset..Ltmp3:
stdlib.memset..LBB0_2:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r1
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r0
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r0
	//DEBUG_VALUE: i <- undef
	.loc	2 35 19 is_stmt 1               // stdlib/memset.c:35:19
	sw r3, 0, r1
stdlib.memset..Ltmp4:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 34 28                         // stdlib/memset.c:34:28
	add r3, r3, 4
	add r2, r2, -1, nz, stdlib.memset..LBB0_2
stdlib.memset..Ltmp5:
stdlib.memset..LBB0_3:
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r0
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r0
	.loc	2 38 5                          // stdlib/memset.c:38:5
	jump r23
stdlib.memset..Ltmp6:
stdlib.memset..Lfunc_end0:
	.size	__memset_wram_4align, stdlib.memset..Lfunc_end0-__memset_wram_4align
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__memset_wram_4align
	.long	stdlib.memset..Lfunc_begin0
	.byte	0
	.section	.text.__memset_wram_4align,"ax",@progbits
                                        // -- End function
	.section	.text.memset,"ax",@progbits
	.globl	memset                          // -- Begin function memset
	.type	memset,@function
memset:                                 // @memset
stdlib.memset..Lfunc_begin1:
	.loc	2 43 0                          // stdlib/memset.c:43:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:len <- $r2
	.cfi_def_cfa_offset 0
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:align_offset <- $r3
	.loc	2 46 47 prologue_end            // stdlib/memset.c:46:47
	and r3, r0, 3, z, stdlib.memset..LBB1_1
stdlib.memset..Ltmp7:
// %bb.2:
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 51 33                         // stdlib/memset.c:51:33
	sub r4, 4, r3
stdlib.memset..Ltmp8:
	//DEBUG_VALUE: head_len <- $r4
	.loc	2 52 13                         // stdlib/memset.c:52:13
	move r3, r2
	jgtu r4, r2, stdlib.memset..LBB1_4
stdlib.memset..Ltmp9:
// %bb.3:
	//DEBUG_VALUE: head_len <- $r4
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	move r3, r4
stdlib.memset..Ltmp10:
stdlib.memset..LBB1_4:
	//DEBUG_VALUE: head_len <- $r4
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: head_len <- $r3
	//DEBUG_VALUE: __memset_wram_1align:dest <- $r0
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: __memset_wram_1align:len <- $r3
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- $r0
	//DEBUG_VALUE: i <- 0
	.loc	2 15 5                          // stdlib/memset.c:15:5
	jeq r3, 0, stdlib.memset..LBB1_7
stdlib.memset..Ltmp11:
// %bb.5:
	//DEBUG_VALUE: __memset_wram_1align:len <- $r3
	//DEBUG_VALUE: head_len <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- $r0
	//DEBUG_VALUE: __memset_wram_1align:dest <- $r0
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 0 5 is_stmt 0                 // stdlib/memset.c:0:5
	move r4, r0
	move r5, r3
stdlib.memset..Ltmp12:
stdlib.memset..LBB1_6:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_wram_1align:len <- $r3
	//DEBUG_VALUE: head_len <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- $r0
	//DEBUG_VALUE: __memset_wram_1align:dest <- $r0
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: i <- undef
	.loc	2 16 18 is_stmt 1               // stdlib/memset.c:16:18
	sb r4, 0, r1
stdlib.memset..Ltmp13:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 15 28                         // stdlib/memset.c:15:28
	add r4, r4, 1
	add r5, r5, -1, nz, stdlib.memset..LBB1_6
stdlib.memset..Ltmp14:
stdlib.memset..LBB1_7:
	//DEBUG_VALUE: head_len <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 58 13                         // stdlib/memset.c:58:13
	sub r2, r2, r3
stdlib.memset..Ltmp15:
	//DEBUG_VALUE: memset:len <- $r2
	.loc	2 59 11                         // stdlib/memset.c:59:11
	add r3, r0, r3
stdlib.memset..Ltmp16:
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:d <- $r3
	.loc	2 63 9                          // stdlib/memset.c:63:9
	jgeu r2, 4, stdlib.memset..LBB1_9
stdlib.memset..Ltmp17:
stdlib.memset..LBB1_12:
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:d <- $r3
	.loc	2 73 9                          // stdlib/memset.c:73:9
	jeq r2, 0, stdlib.memset..LBB1_14
stdlib.memset..Ltmp18:
stdlib.memset..LBB1_13:                               // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: i <- undef
	.loc	2 16 18                         // stdlib/memset.c:16:18
	sb r3, 0, r1
stdlib.memset..Ltmp19:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 15 28                         // stdlib/memset.c:15:28
	add r3, r3, 1
	add r2, r2, -1, nz, stdlib.memset..LBB1_13
stdlib.memset..Ltmp20:
stdlib.memset..LBB1_14:
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 77 5                          // stdlib/memset.c:77:5
	jump r23
stdlib.memset..Ltmp21:
stdlib.memset..LBB1_1:
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:d <- $r0
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 0 0 is_stmt 0                 // stdlib/memset.c:0:0
	move r3, r0
	//DEBUG_VALUE: memset:len <- $r2
stdlib.memset..Ltmp22:
	//DEBUG_VALUE: memset:d <- $r3
	.loc	2 63 9 is_stmt 1                // stdlib/memset.c:63:9
	jltu r2, 4, stdlib.memset..LBB1_12
stdlib.memset..Ltmp23:
stdlib.memset..LBB1_9:
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 64 31                         // stdlib/memset.c:64:31
	and r4, r2, -4
stdlib.memset..Ltmp24:
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r3
	//DEBUG_VALUE: __memset_wram_4align:len <- [DW_OP_constu 18446744073709551612, DW_OP_and, DW_OP_stack_value] $r2
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r3
	//DEBUG_VALUE: body_len <- [DW_OP_constu 18446744073709551612, DW_OP_and, DW_OP_stack_value] $r2
	.loc	2 31 7                          // stdlib/memset.c:31:7
	and r5, r1, 255
stdlib.memset..Ltmp25:
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	.loc	2 32 14                         // stdlib/memset.c:32:14
	lsl_add r6, r5, r1, 24
	.loc	2 32 25 is_stmt 0               // stdlib/memset.c:32:25
	lsl_add r6, r6, r5, 8
	.loc	2 32 37                         // stdlib/memset.c:32:37
	lsl_add r5, r6, r5, 16
stdlib.memset..Ltmp26:
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r5
	.loc	2 34 34 is_stmt 1               // stdlib/memset.c:34:34
	lsr r6, r2, 2
	move r7, r3
stdlib.memset..Ltmp27:
stdlib.memset..LBB1_10:                               // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r5
	//DEBUG_VALUE: __memset_wram_4align:dest <- $r3
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- $r3
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: body_len <- [DW_OP_constu 18446744073709551612, DW_OP_and, DW_OP_stack_value] $r2
	//DEBUG_VALUE: __memset_wram_4align:len <- [DW_OP_constu 18446744073709551612, DW_OP_and, DW_OP_stack_value] $r2
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	//DEBUG_VALUE: i <- undef
	.loc	2 35 19                         // stdlib/memset.c:35:19
	sw r7, 0, r5
stdlib.memset..Ltmp28:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 34 28                         // stdlib/memset.c:34:28
	add r7, r7, 4
	add r6, r6, -1, nz, stdlib.memset..LBB1_10
stdlib.memset..Ltmp29:
// %bb.11:
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: body_len <- [DW_OP_constu 18446744073709551612, DW_OP_and, DW_OP_stack_value] $r2
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:c <- $r1
	//DEBUG_VALUE: memset:dest <- $r0
	//DEBUG_VALUE: memset:align_off_mask <- 3
	//DEBUG_VALUE: memset:align <- 4
	.loc	2 68 13                         // stdlib/memset.c:68:13
	and r2, r2, 3
stdlib.memset..Ltmp30:
	//DEBUG_VALUE: memset:len <- $r2
	.loc	2 69 11                         // stdlib/memset.c:69:11
	add r3, r3, r4
stdlib.memset..Ltmp31:
	//DEBUG_VALUE: memset:d <- $r3
	//DEBUG_VALUE: memset:len <- $r2
	//DEBUG_VALUE: memset:d <- $r3
	.loc	2 73 9                          // stdlib/memset.c:73:9
	jneq r2, 0, stdlib.memset..LBB1_13
	jump stdlib.memset..LBB1_14
stdlib.memset..Ltmp32:
stdlib.memset..Lfunc_end1:
	.size	memset, stdlib.memset..Lfunc_end1-memset
	.cfi_endproc
	.file	3 "/root/uPIMulator/sdk" "stdlib/stddef.h"
	.section	.stack_sizes,"o",@progbits,.text.memset
	.long	stdlib.memset..Lfunc_begin1
	.byte	0
	.section	.text.memset,"ax",@progbits
                                        // -- End function
	.section	.text.__memset_mram_8align,"ax",@progbits
	.globl	__memset_mram_8align            // -- Begin function __memset_mram_8align
	.type	__memset_mram_8align,@function
__memset_mram_8align:                   // @__memset_mram_8align
stdlib.memset..Lfunc_begin2:
	.loc	2 87 0                          // stdlib/memset.c:87:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r0
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r0
	//DEBUG_VALUE: __memset_mram_8align:c <- $r1
	//DEBUG_VALUE: __memset_mram_8align:c <- $r1
	//DEBUG_VALUE: __memset_mram_8align:len <- $r2
	//DEBUG_VALUE: __memset_mram_8align:len <- $r2
	//DEBUG_VALUE: __memset_wram_4align:dest <- undef
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	//DEBUG_VALUE: __memset_wram_4align:len <- 8
	.cfi_def_cfa_offset 0
	//DEBUG_VALUE: __memset_mram_8align:cache <- undef
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- undef
	.loc	2 31 7 prologue_end             // stdlib/memset.c:31:7
	and r3, r1, 255
stdlib.memset..Ltmp33:
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	.loc	2 32 14                         // stdlib/memset.c:32:14
	lsl_add r1, r3, r1, 24
stdlib.memset..Ltmp34:
	.loc	2 32 25 is_stmt 0               // stdlib/memset.c:32:25
	lsl_add r1, r1, r3, 8
	.loc	2 32 37                         // stdlib/memset.c:32:37
	lsl_add r1, r1, r3, 16
stdlib.memset..Ltmp35:
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r1
	.loc	2 35 19 is_stmt 1               // stdlib/memset.c:35:19
	sw r22, 0, r1
stdlib.memset..Ltmp36:
	//DEBUG_VALUE: i <- 1
	sw r22, 4, r1
stdlib.memset..Ltmp37:
	//DEBUG_VALUE: idx <- 0
	//DEBUG_VALUE: i <- 2
	.loc	2 93 5                          // stdlib/memset.c:93:5
	jeq r2, 0, stdlib.memset..LBB2_3
stdlib.memset..Ltmp38:
// %bb.1:
	//DEBUG_VALUE: __memset_mram_8align:len <- $r2
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r1
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r0
	//DEBUG_VALUE: i <- 2
	//DEBUG_VALUE: idx <- 0
	//DEBUG_VALUE: __memset_wram_4align:len <- 8
	.loc	2 0 5 is_stmt 0                 // stdlib/memset.c:0:5
	move r1, 0
stdlib.memset..Ltmp39:
stdlib.memset..LBB2_2:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_mram_8align:len <- $r2
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r0
	//DEBUG_VALUE: idx <- $r1
	//DEBUG_VALUE: mram_write:to <- undef
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	.file	4 "/root/uPIMulator/sdk" "syslib/mram.h"
	.loc	4 53 24 is_stmt 1               // syslib/mram.h:53:24
	add r3, r0, r1
	add r4, r22, 0
stdlib.memset..Ltmp40:
	.loc	2 93 43                         // stdlib/memset.c:93:43
	add r1, r1, 8
stdlib.memset..Ltmp41:
	//DEBUG_VALUE: mram_write:from <- $r22
	//DEBUG_VALUE: idx <- $r1
	.loc	4 53 24                         // syslib/mram.h:53:24
	sdma r4, r3, 0
stdlib.memset..Ltmp42:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	.loc	2 93 5                          // stdlib/memset.c:93:5
	jltu r1, r2, stdlib.memset..LBB2_2
stdlib.memset..Ltmp43:
stdlib.memset..LBB2_3:
	//DEBUG_VALUE: __memset_mram_8align:len <- $r2
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r0
	.loc	2 97 5                          // stdlib/memset.c:97:5
	jump r23
stdlib.memset..Ltmp44:
stdlib.memset..Lfunc_end2:
	.size	__memset_mram_8align, stdlib.memset..Lfunc_end2-__memset_mram_8align
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__memset_mram_8align
	.long	stdlib.memset..Lfunc_begin2
	.byte	8
	.section	.text.__memset_mram_8align,"ax",@progbits
                                        // -- End function
	.section	.text.__memset_mram,"ax",@progbits
	.globl	__memset_mram                   // -- Begin function __memset_mram
	.type	__memset_mram,@function
__memset_mram:                          // @__memset_mram
stdlib.memset..Lfunc_begin3:
	.loc	2 102 0                         // stdlib/memset.c:102:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:len <- $r2
	.cfi_def_cfa_offset 0
	//DEBUG_VALUE: __memset_mram:cache <- undef
	.loc	2 105 68 prologue_end           // stdlib/memset.c:105:68
	and r3, r0, -8
stdlib.memset..Ltmp45:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:align_offset <- $r6
	.loc	2 106 47                        // stdlib/memset.c:106:47
	and r6, r0, 7, z, stdlib.memset..LBB3_7
stdlib.memset..Ltmp46:
// %bb.1:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 110 50                        // stdlib/memset.c:110:50
	sub r5, 8, r6
stdlib.memset..Ltmp47:
	//DEBUG_VALUE: head_len <- $r5
	.loc	2 111 13                        // stdlib/memset.c:111:13
	move r4, r2
	jgtu r5, r2, stdlib.memset..LBB3_3
stdlib.memset..Ltmp48:
// %bb.2:
	//DEBUG_VALUE: head_len <- $r5
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	move r4, r5
stdlib.memset..Ltmp49:
stdlib.memset..LBB3_3:
	//DEBUG_VALUE: head_len <- $r5
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: head_len <- $r4
	.loc	2 0 13 is_stmt 0                // stdlib/memset.c:0:13
	add r5, r22, 8
stdlib.memset..Ltmp50:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_read:from <- $r3
	.loc	4 35 24 is_stmt 1               // syslib/mram.h:35:24
	ldma r5, r3, 0
stdlib.memset..Ltmp51:
	//DEBUG_VALUE: mram_read:to <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- undef
	//DEBUG_VALUE: __memset_wram_1align:len <- $r4
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: __memset_wram_1align:dest <- undef
	.loc	2 15 5                          // stdlib/memset.c:15:5
	jeq r4, 0, stdlib.memset..LBB3_6
stdlib.memset..Ltmp52:
// %bb.4:
	//DEBUG_VALUE: __memset_wram_1align:len <- $r4
	//DEBUG_VALUE: head_len <- $r4
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: i <- 0
	or r6, r5, r6
	move r7, r4
stdlib.memset..Ltmp53:
stdlib.memset..LBB3_5:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_wram_1align:len <- $r4
	//DEBUG_VALUE: head_len <- $r4
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: i <- undef
	.loc	2 16 18                         // stdlib/memset.c:16:18
	sb r6, 0, r1
stdlib.memset..Ltmp54:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 15 28                         // stdlib/memset.c:15:28
	add r6, r6, 1
	add r7, r7, -1, nz, stdlib.memset..LBB3_5
stdlib.memset..Ltmp55:
stdlib.memset..LBB3_6:
	//DEBUG_VALUE: head_len <- $r4
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: mram_write:to <- $r3
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	.loc	4 53 24                         // syslib/mram.h:53:24
	sdma r5, r3, 0
stdlib.memset..Ltmp56:
	.loc	2 119 13                        // stdlib/memset.c:119:13
	sub r2, r2, r4
stdlib.memset..Ltmp57:
	//DEBUG_VALUE: __memset_mram:len <- $r2
	.loc	2 120 11                        // stdlib/memset.c:120:11
	add r3, r3, 8
stdlib.memset..Ltmp58:
	//DEBUG_VALUE: mram_write:from <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: __memset_mram:d <- $r3
stdlib.memset..LBB3_7:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:d <- $r3
	.loc	2 124 9                         // stdlib/memset.c:124:9
	jltu r2, 8, stdlib.memset..LBB3_12
stdlib.memset..Ltmp59:
// %bb.8:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 31 7                          // stdlib/memset.c:31:7
	and r4, r1, 255
stdlib.memset..Ltmp60:
	//DEBUG_VALUE: __memset_wram_4align:c <- [DW_OP_constu 255, DW_OP_and, DW_OP_stack_value] $r1
	.loc	2 32 14                         // stdlib/memset.c:32:14
	lsl_add r5, r4, r1, 24
	.loc	2 32 25 is_stmt 0               // stdlib/memset.c:32:25
	lsl_add r5, r5, r4, 8
	.loc	2 32 37                         // stdlib/memset.c:32:37
	lsl_add r4, r5, r4, 16
stdlib.memset..Ltmp61:
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: __memset_wram_4align:cccc <- $r4
	.loc	2 35 19 is_stmt 1               // stdlib/memset.c:35:19
	sw r22, 0, r4
stdlib.memset..Ltmp62:
	//DEBUG_VALUE: i <- 1
	sw r22, 4, r4
stdlib.memset..Ltmp63:
	//DEBUG_VALUE: i <- 2
	//DEBUG_VALUE: __memset_wram_4align:dest32 <- undef
	//DEBUG_VALUE: __memset_wram_4align:len <- 8
	//DEBUG_VALUE: __memset_wram_4align:dest <- undef
	//DEBUG_VALUE: __memset_mram_8align:cache <- undef
	//DEBUG_VALUE: __memset_mram_8align:c <- $r1
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r3
	//DEBUG_VALUE: __memset_mram_8align:len <- $r4
	//DEBUG_VALUE: body_len <- $r4
	//DEBUG_VALUE: idx <- 0
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	.loc	2 125 31                        // stdlib/memset.c:125:31
	and r4, r2, -8, z, stdlib.memset..LBB3_11
stdlib.memset..Ltmp64:
// %bb.9:
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r3
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_wram_4align:c <- $r1
	//DEBUG_VALUE: __memset_mram_8align:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: idx <- 0
	//DEBUG_VALUE: __memset_wram_4align:len <- 8
	//DEBUG_VALUE: i <- 2
	.loc	2 0 31 is_stmt 0                // stdlib/memset.c:0:31
	move r5, 0
stdlib.memset..Ltmp65:
stdlib.memset..LBB3_10:                               // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_mram_8align:dest <- $r3
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram_8align:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: idx <- $r5
	//DEBUG_VALUE: mram_write:to <- undef
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	.loc	4 53 24 is_stmt 1               // syslib/mram.h:53:24
	add r6, r3, r5
	add r7, r22, 0
stdlib.memset..Ltmp66:
	.loc	2 93 43                         // stdlib/memset.c:93:43
	add r5, r5, 8
stdlib.memset..Ltmp67:
	//DEBUG_VALUE: mram_write:from <- $r22
	//DEBUG_VALUE: idx <- $r5
	.loc	4 53 24                         // syslib/mram.h:53:24
	sdma r7, r6, 0
stdlib.memset..Ltmp68:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	.loc	2 93 5                          // stdlib/memset.c:93:5
	jltu r5, r4, stdlib.memset..LBB3_10
stdlib.memset..Ltmp69:
stdlib.memset..LBB3_11:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 129 13                        // stdlib/memset.c:129:13
	and r2, r2, 7
stdlib.memset..Ltmp70:
	//DEBUG_VALUE: __memset_mram:len <- $r2
	.loc	2 130 11                        // stdlib/memset.c:130:11
	add r3, r3, r4
stdlib.memset..Ltmp71:
	//DEBUG_VALUE: __memset_mram:d <- $r3
stdlib.memset..LBB3_12:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:d <- $r3
	.loc	2 134 9                         // stdlib/memset.c:134:9
	jeq r2, 0, stdlib.memset..LBB3_16
stdlib.memset..Ltmp72:
// %bb.13:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:len <- $r2
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 0 9 is_stmt 0                 // stdlib/memset.c:0:9
	add r4, r22, 8
stdlib.memset..Ltmp73:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_read:from <- $r3
	.loc	4 35 24 is_stmt 1               // syslib/mram.h:35:24
	ldma r4, r3, 0
stdlib.memset..Ltmp74:
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: __memset_wram_1align:dest <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: mram_read:to <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: __memset_wram_1align:len <- $r2
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
stdlib.memset..LBB3_14:                               // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: __memset_wram_1align:dest <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: __memset_wram_1align:dest8 <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_wram_1align:c <- $r1
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	//DEBUG_VALUE: i <- undef
	.loc	2 16 18                         // stdlib/memset.c:16:18
	sb r4, 0, r1
stdlib.memset..Ltmp75:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 15 28                         // stdlib/memset.c:15:28
	add r4, r4, 1
	add r2, r2, -1, nz, stdlib.memset..LBB3_14
stdlib.memset..Ltmp76:
// %bb.15:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:c <- $r1
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 0 28 is_stmt 0                // stdlib/memset.c:0:28
	add r1, r22, 8
stdlib.memset..Ltmp77:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_write:to <- $r3
	.loc	4 53 24 is_stmt 1               // syslib/mram.h:53:24
	sdma r1, r3, 0
stdlib.memset..Ltmp78:
	//DEBUG_VALUE: mram_write:from <- [DW_OP_plus_uconst 8, DW_OP_stack_value] $r22
stdlib.memset..LBB3_16:
	//DEBUG_VALUE: __memset_mram:d <- $r3
	//DEBUG_VALUE: __memset_mram:dest <- $r0
	.loc	2 140 5                         // stdlib/memset.c:140:5
	jump r23
stdlib.memset..Ltmp79:
stdlib.memset..Lfunc_end3:
	.size	__memset_mram, stdlib.memset..Lfunc_end3-__memset_mram
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__memset_mram
	.long	stdlib.memset..Lfunc_begin3
	.byte	16
	.section	.text.__memset_mram,"ax",@progbits
                                        // -- End function
	.section	.debug_loc,"",@progbits
stdlib.memset..Ldebug_loc0:
	.long	-1
	.long	stdlib.memset..Lfunc_begin0                   //   base address
	.long	stdlib.memset..Lfunc_begin0-stdlib.memset..Lfunc_begin0
	.long	stdlib.memset..Ltmp1-stdlib.memset..Lfunc_begin0
	.short	7                               // Loc expr size
	.byte	113                             // DW_OP_breg1
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	255                             // 255
	.byte	1                               // 
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc1:
	.long	-1
	.long	stdlib.memset..Lfunc_begin0                   //   base address
	.long	stdlib.memset..Lfunc_begin0-stdlib.memset..Lfunc_begin0
	.long	stdlib.memset..Ltmp0-stdlib.memset..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
stdlib.memset..Ldebug_loc2:
	.long	-1
	.long	stdlib.memset..Lfunc_begin0                   //   base address
	.long	stdlib.memset..Ltmp2-stdlib.memset..Lfunc_begin0
	.long	stdlib.memset..Ltmp5-stdlib.memset..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc3:
	.long	-1
	.long	stdlib.memset..Lfunc_begin0                   //   base address
	.long	stdlib.memset..Lfunc_begin0-stdlib.memset..Lfunc_begin0
	.long	stdlib.memset..Ltmp3-stdlib.memset..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc4:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Lfunc_begin1-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp18-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	stdlib.memset..Ltmp21-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Lfunc_end1-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
stdlib.memset..Ldebug_loc5:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Lfunc_begin1-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp16-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.memset..Ltmp16-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp18-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	stdlib.memset..Ltmp21-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp22-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.memset..Ltmp22-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Lfunc_end1-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
stdlib.memset..Ldebug_loc6:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Lfunc_begin1-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp7-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
stdlib.memset..Ldebug_loc7:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp8-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp10-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	stdlib.memset..Ltmp10-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp16-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
stdlib.memset..Ldebug_loc8:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp10-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp12-stdlib.memset..Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc9:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp24-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp25-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	stdlib.memset..Ltmp25-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp29-stdlib.memset..Lfunc_begin1
	.short	7                               // Loc expr size
	.byte	113                             // DW_OP_breg1
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	255                             // 255
	.byte	1                               // 
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc10:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp24-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp30-stdlib.memset..Lfunc_begin1
	.short	15                              // Loc expr size
	.byte	114                             // DW_OP_breg2
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	252                             // 18446744073709551612
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	255                             // 
	.byte	1                               // 
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc11:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp26-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp27-stdlib.memset..Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc12:
	.long	-1
	.long	stdlib.memset..Lfunc_begin1                   //   base address
	.long	stdlib.memset..Ltmp26-stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Ltmp29-stdlib.memset..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	85                              // DW_OP_reg5
	.long	0
	.long	0
stdlib.memset..Ldebug_loc13:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Lfunc_begin2-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp34-stdlib.memset..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc14:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Lfunc_begin2-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp33-stdlib.memset..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	stdlib.memset..Ltmp33-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp34-stdlib.memset..Lfunc_begin2
	.short	7                               // Loc expr size
	.byte	113                             // DW_OP_breg1
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	255                             // 255
	.byte	1                               // 
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc15:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Ltmp35-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp36-stdlib.memset..Lfunc_begin2
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp36-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp37-stdlib.memset..Lfunc_begin2
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp37-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp38-stdlib.memset..Lfunc_begin2
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc16:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Ltmp35-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp38-stdlib.memset..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc17:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Ltmp37-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp39-stdlib.memset..Lfunc_begin2
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp39-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp43-stdlib.memset..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc18:
	.long	-1
	.long	stdlib.memset..Lfunc_begin2                   //   base address
	.long	stdlib.memset..Ltmp41-stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Ltmp43-stdlib.memset..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	102                             // DW_OP_reg22
	.long	0
	.long	0
stdlib.memset..Ldebug_loc19:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Lfunc_begin3-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp77-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc20:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Lfunc_begin3-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp74-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
stdlib.memset..Ldebug_loc21:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp45-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Lfunc_end3-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
stdlib.memset..Ldebug_loc22:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp45-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp46-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	86                              // DW_OP_reg6
	.long	0
	.long	0
stdlib.memset..Ldebug_loc23:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp47-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp49-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	85                              // DW_OP_reg5
	.long	stdlib.memset..Ltmp49-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp58-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
stdlib.memset..Ldebug_loc24:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp51-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp53-stdlib.memset..Lfunc_begin3
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc25:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp60-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp63-stdlib.memset..Lfunc_begin3
	.short	7                               // Loc expr size
	.byte	113                             // DW_OP_breg1
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	255                             // 255
	.byte	1                               // 
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp63-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp64-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc26:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp61-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp62-stdlib.memset..Lfunc_begin3
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp62-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp63-stdlib.memset..Lfunc_begin3
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.memset..Ltmp63-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp64-stdlib.memset..Lfunc_begin3
	.short	2                               // Loc expr size
	.byte	50                              // DW_OP_lit2
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.memset..Ldebug_loc27:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp61-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp64-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
stdlib.memset..Ldebug_loc28:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp65-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp69-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
stdlib.memset..Ldebug_loc29:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp65-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp69-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
stdlib.memset..Ldebug_loc30:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp63-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp64-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
stdlib.memset..Ldebug_loc31:
	.long	-1
	.long	stdlib.memset..Lfunc_begin3                   //   base address
	.long	stdlib.memset..Ltmp67-stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Ltmp69-stdlib.memset..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	102                             // DW_OP_reg22
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	15                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	16                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	17                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	18                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	19                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	20                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	21                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	22                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	1                               // DW_CHILDREN_yes
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	23                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	24                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	25                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	26                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	27                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	28                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	1                               // DW_CHILDREN_yes
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	29                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	30                              // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	31                              // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	32                              // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	33                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	34                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
stdlib.memset..Lcu_begin0:
	.long	stdlib.memset..Ldebug_info_end0-stdlib.memset..Ldebug_info_start0 // Length of Unit
stdlib.memset..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x659 DW_TAG_compile_unit
	.long	stdlib.memset..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	stdlib.memset..Linfo_string1                  // DW_AT_name
	.long	stdlib.memset..Lline_table_start0             // DW_AT_stmt_list
	.long	stdlib.memset..Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	stdlib.memset..Ldebug_ranges3                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x5 DW_TAG_pointer_type
	.long	43                              // DW_AT_type
	.byte	3                               // Abbrev [3] 0x2b:0xb DW_TAG_typedef
	.long	54                              // DW_AT_type
	.long	stdlib.memset..Linfo_string5                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	21                              // DW_AT_decl_line
	.byte	3                               // Abbrev [3] 0x36:0xb DW_TAG_typedef
	.long	65                              // DW_AT_type
	.long	stdlib.memset..Linfo_string4                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x41:0x7 DW_TAG_base_type
	.long	stdlib.memset..Linfo_string3                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // Abbrev [3] 0x48:0xb DW_TAG_typedef
	.long	65                              // DW_AT_type
	.long	stdlib.memset..Linfo_string6                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	144                             // DW_AT_decl_line
	.byte	2                               // Abbrev [2] 0x53:0x5 DW_TAG_pointer_type
	.long	88                              // DW_AT_type
	.byte	3                               // Abbrev [3] 0x58:0xb DW_TAG_typedef
	.long	99                              // DW_AT_type
	.long	stdlib.memset..Linfo_string8                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x63:0x7 DW_TAG_base_type
	.long	stdlib.memset..Linfo_string7                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	5                               // Abbrev [5] 0x6a:0x1 DW_TAG_pointer_type
	.byte	6                               // Abbrev [6] 0x6b:0x4c DW_TAG_subprogram
	.long	stdlib.memset..Lfunc_begin0                   // DW_AT_low_pc
	.long	stdlib.memset..Lfunc_end0-stdlib.memset..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	271                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x7a:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	283                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x81:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc0                    // DW_AT_location
	.long	294                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x8a:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc1                    // DW_AT_location
	.long	305                             // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x93:0x7 DW_TAG_variable
	.byte	1                               // DW_AT_location
	.byte	80
	.long	316                             // DW_AT_abstract_origin
	.byte	10                              // Abbrev [10] 0x9a:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc2                    // DW_AT_location
	.long	327                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0xa3:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Lfunc_begin0                   // DW_AT_low_pc
	.long	stdlib.memset..Ltmp5-stdlib.memset..Lfunc_begin0            // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0xac:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc3                    // DW_AT_location
	.long	339                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	12                              // Abbrev [12] 0xb7:0x46 DW_TAG_subprogram
	.long	stdlib.memset..Linfo_string9                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	106                             // DW_AT_type
	.byte	1                               // DW_AT_inline
	.byte	13                              // Abbrev [13] 0xc3:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0xce:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string11                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
	.long	253                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0xd9:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	14                              // Abbrev [14] 0xe4:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	14                              // DW_AT_decl_line
	.long	83                              // DW_AT_type
	.byte	15                              // Abbrev [15] 0xef:0xd DW_TAG_lexical_block
	.byte	14                              // Abbrev [14] 0xf0:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	15                              // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	4                               // Abbrev [4] 0xfd:0x7 DW_TAG_base_type
	.long	stdlib.memset..Linfo_string12                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // Abbrev [3] 0x104:0xb DW_TAG_typedef
	.long	65                              // DW_AT_type
	.long	stdlib.memset..Linfo_string14                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.byte	16                              // Abbrev [16] 0x10f:0x51 DW_TAG_subprogram
	.long	stdlib.memset..Linfo_string17                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	106                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_inline
	.byte	13                              // Abbrev [13] 0x11b:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x126:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string11                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	253                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x131:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	14                              // Abbrev [14] 0x13c:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string18                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	29                              // DW_AT_decl_line
	.long	38                              // DW_AT_type
	.byte	14                              // Abbrev [14] 0x147:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string19                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	28                              // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	15                              // Abbrev [15] 0x152:0xd DW_TAG_lexical_block
	.byte	14                              // Abbrev [14] 0x153:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	34                              // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	17                              // Abbrev [17] 0x160:0x160 DW_TAG_subprogram
	.long	stdlib.memset..Lfunc_begin1                   // DW_AT_low_pc
	.long	stdlib.memset..Lfunc_end1-stdlib.memset..Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.memset..Linfo_string30                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	106                             // DW_AT_type
                                        // DW_AT_external
	.byte	18                              // Abbrev [18] 0x175:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	stdlib.memset..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x182:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	stdlib.memset..Linfo_string11                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	253                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x18f:0xf DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc4                    // DW_AT_location
	.long	stdlib.memset..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	42                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	20                              // Abbrev [20] 0x19e:0xc DW_TAG_variable
	.byte	4                               // DW_AT_const_value
	.long	stdlib.memset..Linfo_string32                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	44                              // DW_AT_decl_line
	.long	1630                            // DW_AT_type
	.byte	20                              // Abbrev [20] 0x1aa:0xc DW_TAG_variable
	.byte	3                               // DW_AT_const_value
	.long	stdlib.memset..Linfo_string33                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	45                              // DW_AT_decl_line
	.long	1630                            // DW_AT_type
	.byte	21                              // Abbrev [21] 0x1b6:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc5                    // DW_AT_location
	.long	stdlib.memset..Linfo_string34                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	47                              // DW_AT_decl_line
	.long	83                              // DW_AT_type
	.byte	21                              // Abbrev [21] 0x1c5:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc6                    // DW_AT_location
	.long	stdlib.memset..Linfo_string35                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	46                              // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	11                              // Abbrev [11] 0x1d4:0x59 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp7                          // DW_AT_low_pc
	.long	stdlib.memset..Ltmp16-stdlib.memset..Ltmp7                  // DW_AT_high_pc
	.byte	21                              // Abbrev [21] 0x1dd:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc7                    // DW_AT_location
	.long	stdlib.memset..Linfo_string36                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	22                              // Abbrev [22] 0x1ec:0x40 DW_TAG_inlined_subroutine
	.long	183                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp10                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp14-stdlib.memset..Ltmp10                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	56                              // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x1fc:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	195                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x203:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	206                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x20a:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	217                             // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x211:0x7 DW_TAG_variable
	.byte	1                               // DW_AT_location
	.byte	80
	.long	228                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x218:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp10                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp14-stdlib.memset..Ltmp10                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x221:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc8                    // DW_AT_location
	.long	240                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x22d:0x20 DW_TAG_inlined_subroutine
	.long	183                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp18                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp20-stdlib.memset..Ltmp18                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	74                              // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	11                              // Abbrev [11] 0x23d:0xf DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp18                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp20-stdlib.memset..Ltmp18                 // DW_AT_high_pc
	.byte	23                              // Abbrev [23] 0x246:0x5 DW_TAG_variable
	.long	240                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	11                              // Abbrev [11] 0x24d:0x72 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp23                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp31-stdlib.memset..Ltmp23                 // DW_AT_high_pc
	.byte	21                              // Abbrev [21] 0x256:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc10                   // DW_AT_location
	.long	stdlib.memset..Linfo_string37                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	64                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	22                              // Abbrev [22] 0x265:0x59 DW_TAG_inlined_subroutine
	.long	271                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp24                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp29-stdlib.memset..Ltmp24                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	66                              // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x275:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	283                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x27c:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc9                    // DW_AT_location
	.long	294                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x285:0x15 DW_TAG_formal_parameter
	.byte	15                              // DW_AT_location
	.byte	114
	.byte	0
	.byte	16
	.ascii	"\374\377\377\377\377\377\377\377\377\001"
	.byte	26
	.byte	159
	.long	305                             // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x29a:0x7 DW_TAG_variable
	.byte	1                               // DW_AT_location
	.byte	83
	.long	316                             // DW_AT_abstract_origin
	.byte	10                              // Abbrev [10] 0x2a1:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc12                   // DW_AT_location
	.long	327                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x2aa:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp26                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp29-stdlib.memset..Ltmp26                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x2b3:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc11                   // DW_AT_location
	.long	339                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	24                              // Abbrev [24] 0x2c0:0x2a DW_TAG_subprogram
	.long	stdlib.memset..Linfo_string20                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	13                              // Abbrev [13] 0x2c8:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string21                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	746                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x2d3:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string22                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x2de:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string23                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	65                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	2                               // Abbrev [2] 0x2ea:0x5 DW_TAG_pointer_type
	.long	751                             // DW_AT_type
	.byte	25                              // Abbrev [25] 0x2ef:0x1 DW_TAG_const_type
	.byte	6                               // Abbrev [6] 0x2f0:0xae DW_TAG_subprogram
	.long	stdlib.memset..Lfunc_begin2                   // DW_AT_low_pc
	.long	stdlib.memset..Lfunc_end2-stdlib.memset..Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	968                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x2ff:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	980                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x306:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc13                   // DW_AT_location
	.long	991                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x30f:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1002                            // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x316:0x8 DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	0
	.long	1013                            // DW_AT_abstract_origin
	.byte	23                              // Abbrev [23] 0x31e:0x5 DW_TAG_variable
	.long	1025                            // DW_AT_abstract_origin
	.byte	22                              // Abbrev [22] 0x323:0x46 DW_TAG_inlined_subroutine
	.long	271                             // DW_AT_abstract_origin
	.long	stdlib.memset..Lfunc_begin2                   // DW_AT_low_pc
	.long	stdlib.memset..Ltmp37-stdlib.memset..Lfunc_begin2           // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	91                              // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	26                              // Abbrev [26] 0x333:0x5 DW_TAG_formal_parameter
	.long	283                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x338:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc14                   // DW_AT_location
	.long	294                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x341:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	305                             // DW_AT_abstract_origin
	.byte	23                              // Abbrev [23] 0x347:0x5 DW_TAG_variable
	.long	316                             // DW_AT_abstract_origin
	.byte	10                              // Abbrev [10] 0x34c:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc16                   // DW_AT_location
	.long	327                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x355:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp35                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp37-stdlib.memset..Ltmp35                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x35e:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc15                   // DW_AT_location
	.long	339                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	11                              // Abbrev [11] 0x369:0x34 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp37                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp43-stdlib.memset..Ltmp37                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x372:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc17                   // DW_AT_location
	.long	1037                            // DW_AT_abstract_origin
	.byte	28                              // Abbrev [28] 0x37b:0x21 DW_TAG_inlined_subroutine
	.long	704                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ldebug_ranges0                 // DW_AT_ranges
	.byte	2                               // DW_AT_call_file
	.byte	94                              // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	8                               // Abbrev [8] 0x387:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc18                   // DW_AT_location
	.long	712                             // DW_AT_abstract_origin
	.byte	26                              // Abbrev [26] 0x390:0x5 DW_TAG_formal_parameter
	.long	723                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x395:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	734                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	24                              // Abbrev [24] 0x39e:0x2a DW_TAG_subprogram
	.long	stdlib.memset..Linfo_string24                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	13                              // Abbrev [13] 0x3a6:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string21                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	746                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x3b1:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string22                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x3bc:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string23                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	65                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	16                              // Abbrev [16] 0x3c8:0x52 DW_TAG_subprogram
	.long	stdlib.memset..Linfo_string25                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	86                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	106                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_inline
	.byte	13                              // Abbrev [13] 0x3d4:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	86                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x3df:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string11                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	86                              // DW_AT_decl_line
	.long	253                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x3ea:0xb DW_TAG_formal_parameter
	.long	stdlib.memset..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	86                              // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	29                              // Abbrev [29] 0x3f5:0xc DW_TAG_variable
	.long	stdlib.memset..Linfo_string26                 // DW_AT_name
	.byte	8                               // DW_AT_alignment
	.byte	2                               // DW_AT_decl_file
	.byte	88                              // DW_AT_decl_line
	.long	1050                            // DW_AT_type
	.byte	14                              // Abbrev [14] 0x401:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string28                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	89                              // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	15                              // Abbrev [15] 0x40c:0xd DW_TAG_lexical_block
	.byte	14                              // Abbrev [14] 0x40d:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string29                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	93                              // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x41a:0xc DW_TAG_array_type
	.long	88                              // DW_AT_type
	.byte	31                              // Abbrev [31] 0x41f:0x6 DW_TAG_subrange_type
	.long	1062                            // DW_AT_type
	.byte	8                               // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	32                              // Abbrev [32] 0x426:0x7 DW_TAG_base_type
	.long	stdlib.memset..Linfo_string27                 // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	17                              // Abbrev [17] 0x42d:0x231 DW_TAG_subprogram
	.long	stdlib.memset..Lfunc_begin3                   // DW_AT_low_pc
	.long	stdlib.memset..Lfunc_end3-stdlib.memset..Lfunc_begin3       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.memset..Linfo_string31                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	106                             // DW_AT_type
                                        // DW_AT_external
	.byte	18                              // Abbrev [18] 0x442:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	stdlib.memset..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x44f:0xf DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc19                   // DW_AT_location
	.long	stdlib.memset..Linfo_string11                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	253                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x45e:0xf DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc20                   // DW_AT_location
	.long	stdlib.memset..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	33                              // Abbrev [33] 0x46d:0xf DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	8
	.long	stdlib.memset..Linfo_string26                 // DW_AT_name
	.byte	8                               // DW_AT_alignment
	.byte	2                               // DW_AT_decl_file
	.byte	103                             // DW_AT_decl_line
	.long	1050                            // DW_AT_type
	.byte	14                              // Abbrev [14] 0x47c:0xb DW_TAG_variable
	.long	stdlib.memset..Linfo_string28                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	104                             // DW_AT_decl_line
	.long	106                             // DW_AT_type
	.byte	21                              // Abbrev [21] 0x487:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc21                   // DW_AT_location
	.long	stdlib.memset..Linfo_string34                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	105                             // DW_AT_decl_line
	.long	83                              // DW_AT_type
	.byte	21                              // Abbrev [21] 0x496:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc22                   // DW_AT_location
	.long	stdlib.memset..Linfo_string35                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	106                             // DW_AT_decl_line
	.long	54                              // DW_AT_type
	.byte	11                              // Abbrev [11] 0x4a5:0x91 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp46                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp58-stdlib.memset..Ltmp46                 // DW_AT_high_pc
	.byte	21                              // Abbrev [21] 0x4ae:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc23                   // DW_AT_location
	.long	stdlib.memset..Linfo_string36                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	110                             // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	22                              // Abbrev [22] 0x4bd:0x1e DW_TAG_inlined_subroutine
	.long	926                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp50                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp51-stdlib.memset..Ltmp50                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	115                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x4cd:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	934                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x4d4:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	956                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x4db:0x3c DW_TAG_inlined_subroutine
	.long	183                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp51                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp55-stdlib.memset..Ltmp51                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	116                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	26                              // Abbrev [26] 0x4eb:0x5 DW_TAG_formal_parameter
	.long	195                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x4f0:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	206                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x4f7:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	84
	.long	217                             // DW_AT_abstract_origin
	.byte	23                              // Abbrev [23] 0x4fe:0x5 DW_TAG_variable
	.long	228                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x503:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp51                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp55-stdlib.memset..Ltmp51                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x50c:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc24                   // DW_AT_location
	.long	240                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x517:0x1e DW_TAG_inlined_subroutine
	.long	704                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp55                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp56-stdlib.memset..Ltmp55                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	117                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x527:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	723                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x52e:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	734                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	11                              // Abbrev [11] 0x536:0xa8 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp59                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp71-stdlib.memset..Ltmp59                 // DW_AT_high_pc
	.byte	21                              // Abbrev [21] 0x53f:0xf DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc30                   // DW_AT_location
	.long	stdlib.memset..Linfo_string37                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	125                             // DW_AT_decl_line
	.long	260                             // DW_AT_type
	.byte	28                              // Abbrev [28] 0x54e:0x8f DW_TAG_inlined_subroutine
	.long	968                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ldebug_ranges1                 // DW_AT_ranges
	.byte	2                               // DW_AT_call_file
	.byte	127                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	8                               // Abbrev [8] 0x55a:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc29                   // DW_AT_location
	.long	980                             // DW_AT_abstract_origin
	.byte	8                               // Abbrev [8] 0x563:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc28                   // DW_AT_location
	.long	991                             // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x56c:0x8 DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	0
	.long	1013                            // DW_AT_abstract_origin
	.byte	22                              // Abbrev [22] 0x574:0x36 DW_TAG_inlined_subroutine
	.long	271                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp59                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp63-stdlib.memset..Ltmp59                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	91                              // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	8                               // Abbrev [8] 0x584:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc25                   // DW_AT_location
	.long	294                             // DW_AT_abstract_origin
	.byte	10                              // Abbrev [10] 0x58d:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc27                   // DW_AT_location
	.long	327                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x596:0x13 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp61                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp63-stdlib.memset..Ltmp61                 // DW_AT_high_pc
	.byte	10                              // Abbrev [10] 0x59f:0x9 DW_TAG_variable
	.long	stdlib.memset..Ldebug_loc26                   // DW_AT_location
	.long	339                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	11                              // Abbrev [11] 0x5aa:0x32 DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp65                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp69-stdlib.memset..Ltmp65                 // DW_AT_high_pc
	.byte	9                               // Abbrev [9] 0x5b3:0x7 DW_TAG_variable
	.byte	1                               // DW_AT_location
	.byte	85
	.long	1037                            // DW_AT_abstract_origin
	.byte	28                              // Abbrev [28] 0x5ba:0x21 DW_TAG_inlined_subroutine
	.long	704                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ldebug_ranges2                 // DW_AT_ranges
	.byte	2                               // DW_AT_call_file
	.byte	94                              // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	8                               // Abbrev [8] 0x5c6:0x9 DW_TAG_formal_parameter
	.long	stdlib.memset..Ldebug_loc31                   // DW_AT_location
	.long	712                             // DW_AT_abstract_origin
	.byte	26                              // Abbrev [26] 0x5cf:0x5 DW_TAG_formal_parameter
	.long	723                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x5d4:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	734                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x5de:0x23 DW_TAG_inlined_subroutine
	.long	926                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp73                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp74-stdlib.memset..Ltmp73                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	135                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x5ee:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	934                             // DW_AT_abstract_origin
	.byte	26                              // Abbrev [26] 0x5f5:0x5 DW_TAG_formal_parameter
	.long	945                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x5fa:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	956                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x601:0x39 DW_TAG_inlined_subroutine
	.long	183                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp74                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp76-stdlib.memset..Ltmp74                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	136                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	7                               // Abbrev [7] 0x611:0x9 DW_TAG_formal_parameter
	.byte	3                               // DW_AT_location
	.byte	145
	.byte	8
	.byte	159
	.long	195                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x61a:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	206                             // DW_AT_abstract_origin
	.byte	9                               // Abbrev [9] 0x621:0x9 DW_TAG_variable
	.byte	3                               // DW_AT_location
	.byte	145
	.byte	8
	.byte	159
	.long	228                             // DW_AT_abstract_origin
	.byte	11                              // Abbrev [11] 0x62a:0xf DW_TAG_lexical_block
	.long	stdlib.memset..Ltmp74                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp76-stdlib.memset..Ltmp74                 // DW_AT_high_pc
	.byte	23                              // Abbrev [23] 0x633:0x5 DW_TAG_variable
	.long	240                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	22                              // Abbrev [22] 0x63a:0x23 DW_TAG_inlined_subroutine
	.long	704                             // DW_AT_abstract_origin
	.long	stdlib.memset..Ltmp77                         // DW_AT_low_pc
	.long	stdlib.memset..Ltmp78-stdlib.memset..Ltmp77                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	137                             // DW_AT_call_line
	.byte	9                               // DW_AT_call_column
	.byte	26                              // Abbrev [26] 0x64a:0x5 DW_TAG_formal_parameter
	.long	712                             // DW_AT_abstract_origin
	.byte	7                               // Abbrev [7] 0x64f:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	723                             // DW_AT_abstract_origin
	.byte	27                              // Abbrev [27] 0x656:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	734                             // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	34                              // Abbrev [34] 0x65e:0x5 DW_TAG_const_type
	.long	54                              // DW_AT_type
	.byte	0                               // End Of Children Mark
stdlib.memset..Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
stdlib.memset..Ldebug_ranges0:
	.long	stdlib.memset..Ltmp39
	.long	stdlib.memset..Ltmp40
	.long	stdlib.memset..Ltmp41
	.long	stdlib.memset..Ltmp42
	.long	0
	.long	0
stdlib.memset..Ldebug_ranges1:
	.long	stdlib.memset..Ltmp59
	.long	stdlib.memset..Ltmp63
	.long	stdlib.memset..Ltmp65
	.long	stdlib.memset..Ltmp69
	.long	0
	.long	0
stdlib.memset..Ldebug_ranges2:
	.long	stdlib.memset..Ltmp65
	.long	stdlib.memset..Ltmp66
	.long	stdlib.memset..Ltmp67
	.long	stdlib.memset..Ltmp68
	.long	0
	.long	0
stdlib.memset..Ldebug_ranges3:
	.long	stdlib.memset..Lfunc_begin0
	.long	stdlib.memset..Lfunc_end0
	.long	stdlib.memset..Lfunc_begin1
	.long	stdlib.memset..Lfunc_end1
	.long	stdlib.memset..Lfunc_begin2
	.long	stdlib.memset..Lfunc_end2
	.long	stdlib.memset..Lfunc_begin3
	.long	stdlib.memset..Lfunc_end3
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
stdlib.memset..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
stdlib.memset..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/stdlib/memset.c" // string offset=106
stdlib.memset..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=143
stdlib.memset..Linfo_string3:
	.asciz	"unsigned int"                  // string offset=170
stdlib.memset..Linfo_string4:
	.asciz	"uint32_t"                      // string offset=183
stdlib.memset..Linfo_string5:
	.asciz	"memset_wram_t"                 // string offset=192
stdlib.memset..Linfo_string6:
	.asciz	"uintptr_t"                     // string offset=206
stdlib.memset..Linfo_string7:
	.asciz	"unsigned char"                 // string offset=216
stdlib.memset..Linfo_string8:
	.asciz	"uint8_t"                       // string offset=230
stdlib.memset..Linfo_string9:
	.asciz	"__memset_wram_1align"          // string offset=238
stdlib.memset..Linfo_string10:
	.asciz	"dest"                          // string offset=259
stdlib.memset..Linfo_string11:
	.asciz	"c"                             // string offset=264
stdlib.memset..Linfo_string12:
	.asciz	"int"                           // string offset=266
stdlib.memset..Linfo_string13:
	.asciz	"len"                           // string offset=270
stdlib.memset..Linfo_string14:
	.asciz	"size_t"                        // string offset=274
stdlib.memset..Linfo_string15:
	.asciz	"dest8"                         // string offset=281
stdlib.memset..Linfo_string16:
	.asciz	"i"                             // string offset=287
stdlib.memset..Linfo_string17:
	.asciz	"__memset_wram_4align"          // string offset=289
stdlib.memset..Linfo_string18:
	.asciz	"dest32"                        // string offset=310
stdlib.memset..Linfo_string19:
	.asciz	"cccc"                          // string offset=317
stdlib.memset..Linfo_string20:
	.asciz	"mram_write"                    // string offset=322
stdlib.memset..Linfo_string21:
	.asciz	"from"                          // string offset=333
stdlib.memset..Linfo_string22:
	.asciz	"to"                            // string offset=338
stdlib.memset..Linfo_string23:
	.asciz	"nb_of_bytes"                   // string offset=341
stdlib.memset..Linfo_string24:
	.asciz	"mram_read"                     // string offset=353
stdlib.memset..Linfo_string25:
	.asciz	"__memset_mram_8align"          // string offset=363
stdlib.memset..Linfo_string26:
	.asciz	"cache64"                       // string offset=384
stdlib.memset..Linfo_string27:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=392
stdlib.memset..Linfo_string28:
	.asciz	"cache"                         // string offset=412
stdlib.memset..Linfo_string29:
	.asciz	"idx"                           // string offset=418
stdlib.memset..Linfo_string30:
	.asciz	"memset"                        // string offset=422
stdlib.memset..Linfo_string31:
	.asciz	"__memset_mram"                 // string offset=429
stdlib.memset..Linfo_string32:
	.asciz	"align"                         // string offset=443
stdlib.memset..Linfo_string33:
	.asciz	"align_off_mask"                // string offset=449
stdlib.memset..Linfo_string34:
	.asciz	"d"                             // string offset=464
stdlib.memset..Linfo_string35:
	.asciz	"align_offset"                  // string offset=466
stdlib.memset..Linfo_string36:
	.asciz	"head_len"                      // string offset=479
stdlib.memset..Linfo_string37:
	.asciz	"body_len"                      // string offset=488
	.addrsig
	.addrsig_sym __memset_wram_4align
	.addrsig_sym __memset_mram_8align
	.addrsig_sym __memset_mram
	.section	.debug_line,"",@progbits
stdlib.memset..Lline_table_start0:
	.text
	.file	"crt0.c"
	.file	1 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.file	2 "/root/uPIMulator/sdk" "misc/crt0.c"
	.file	3 "/root/uPIMulator/sdk" "syslib/dpuruntime.h"
	.section	.text.__bootstrap,"ax",@progbits
	.globl	__bootstrap                     // -- Begin function __bootstrap
	.type	__bootstrap,@function
__bootstrap:                            // @__bootstrap
misc.crt0..Lfunc_begin0:
	.loc	2 33 0                          // misc/crt0.c:33:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	.loc	2 35 5 prologue_end             // misc/crt0.c:35:5
	// inline asm
	jnz id, misc.crt0.__sys_start_thread

	sd zero, __stdout_buffer_state, 0
	move r23, __atomic_end_addr
misc.crt0.__sys_atomic_bit_clear:
	jeq r23, __atomic_used_addr, misc.crt0.__sys_start_thread
misc.crt0..Ltmp0:
	release r23, 0, nz, misc.crt0..Ltmp0+1
	add r23, r23, -1, true, misc.crt0.__sys_atomic_bit_clear
misc.crt0.__sys_start_thread:
misc.crt0..Ltmp1:
	jeq id, NR_TASKLETS-1, misc.crt0..Ltmp1+2
	boot id, 1
	ld d22, id8, __sys_thread_stack_table_ptr
	call r23, main
	.globl	__sys_end
__sys_end:

	stop true, __sys_end
	// inline asm
misc.crt0..Ltmp2:
misc.crt0..Lfunc_end0:
	.size	__bootstrap, misc.crt0..Lfunc_end0-__bootstrap
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__bootstrap
	.long	misc.crt0..Lfunc_begin0
	.byte	0
	.section	.text.__bootstrap,"ax",@progbits
                                        // -- End function
	.type	__sys_null_pointer,@object      // @__sys_null_pointer
	.section	.data.__sys_zero,"aw",@progbits
	.globl	__sys_null_pointer
	.p2align	3
__sys_null_pointer:
	.quad	0                               // 0x0
	.size	__sys_null_pointer, 8

	.type	__sys_thread_stack_table_ptr,@object // @__sys_thread_stack_table_ptr
	.section	.data.__sys_keep,"aw",@progbits
	.globl	__sys_thread_stack_table_ptr
	.p2align	3
__sys_thread_stack_table_ptr:
	.long	STACK_SIZE_TASKLET_0
	.long	__sys_stack_thread_0
	.long	STACK_SIZE_TASKLET_1
	.long	__sys_stack_thread_1
	.long	STACK_SIZE_TASKLET_2
	.long	__sys_stack_thread_2
	.long	STACK_SIZE_TASKLET_3
	.long	__sys_stack_thread_3
	.long	STACK_SIZE_TASKLET_4
	.long	__sys_stack_thread_4
	.long	STACK_SIZE_TASKLET_5
	.long	__sys_stack_thread_5
	.long	STACK_SIZE_TASKLET_6
	.long	__sys_stack_thread_6
	.long	STACK_SIZE_TASKLET_7
	.long	__sys_stack_thread_7
	.long	STACK_SIZE_TASKLET_8
	.long	__sys_stack_thread_8
	.long	STACK_SIZE_TASKLET_9
	.long	__sys_stack_thread_9
	.long	STACK_SIZE_TASKLET_10
	.long	__sys_stack_thread_10
	.long	STACK_SIZE_TASKLET_11
	.long	__sys_stack_thread_11
	.long	STACK_SIZE_TASKLET_12
	.long	__sys_stack_thread_12
	.long	STACK_SIZE_TASKLET_13
	.long	__sys_stack_thread_13
	.long	STACK_SIZE_TASKLET_14
	.long	__sys_stack_thread_14
	.long	STACK_SIZE_TASKLET_15
	.long	__sys_stack_thread_15
	.long	STACK_SIZE_TASKLET_16
	.long	__sys_stack_thread_16
	.long	STACK_SIZE_TASKLET_17
	.long	__sys_stack_thread_17
	.long	STACK_SIZE_TASKLET_18
	.long	__sys_stack_thread_18
	.long	STACK_SIZE_TASKLET_19
	.long	__sys_stack_thread_19
	.long	STACK_SIZE_TASKLET_20
	.long	__sys_stack_thread_20
	.long	STACK_SIZE_TASKLET_21
	.long	__sys_stack_thread_21
	.long	STACK_SIZE_TASKLET_22
	.long	__sys_stack_thread_22
	.long	STACK_SIZE_TASKLET_23
	.long	__sys_stack_thread_23
	.size	__sys_thread_stack_table_ptr, 192

	.type	__sys_used_mram_end,@object     // @__sys_used_mram_end
	.section	.mram.noinit,"aw",@progbits
	.globl	__sys_used_mram_end
	.p2align	3
__sys_used_mram_end:
	.size	__sys_used_mram_end, 0

	.type	thread_profiling,@object        // @thread_profiling
	.section	.data.immediate_memory.thread_profiling,"aw",@progbits
	.globl	thread_profiling
	.p2align	2
thread_profiling:
	.zero	96
	.size	thread_profiling, 96

	.type	perfcounter_end_value,@object   // @perfcounter_end_value
	.section	.bss.perfcounter_end_value,"aw",@nobits
	.globl	perfcounter_end_value
	.p2align	2
perfcounter_end_value:
	.long	0                               // 0x0
	.size	perfcounter_end_value, 4

	.type	CLOCKS_PER_SEC,@object          // @CLOCKS_PER_SEC
	.section	.dpu_host,"a",@progbits
	.globl	CLOCKS_PER_SEC
	.p2align	3
CLOCKS_PER_SEC:
	.long	0                               // 0x0
	.size	CLOCKS_PER_SEC, 4

	.type	error_storage,@object           // @error_storage
	.globl	error_storage
	.p2align	3
error_storage:
	.long	0                               // 0x0
	.size	error_storage, 4

	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	19                              // DW_TAG_structure_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	13                              // DW_TAG_member
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	56                              // DW_AT_data_member_location
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	53                              // DW_TAG_volatile_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	0                               // DW_CHILDREN_no
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
misc.crt0..Lcu_begin0:
	.long	misc.crt0..Ldebug_info_end0-misc.crt0..Ldebug_info_start0 // Length of Unit
misc.crt0..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x13b DW_TAG_compile_unit
	.long	misc.crt0..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	misc.crt0..Linfo_string1                  // DW_AT_name
	.long	misc.crt0..Lline_table_start0             // DW_AT_stmt_list
	.long	misc.crt0..Linfo_string2                  // DW_AT_comp_dir
	.long	misc.crt0..Lfunc_begin0                   // DW_AT_low_pc
	.long	misc.crt0..Lfunc_end0-misc.crt0..Lfunc_begin0       // DW_AT_high_pc
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	misc.crt0..Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	13                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__sys_null_pointer
	.byte	3                               // Abbrev [3] 0x37:0xb DW_TAG_typedef
	.long	66                              // DW_AT_type
	.long	misc.crt0..Linfo_string5                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	53                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x42:0x7 DW_TAG_base_type
	.long	misc.crt0..Linfo_string4                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	5                               // Abbrev [5] 0x49:0x12 DW_TAG_variable
	.long	misc.crt0..Linfo_string6                  // DW_AT_name
	.long	91                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__sys_thread_stack_table_ptr
	.byte	6                               // Abbrev [6] 0x5b:0xc DW_TAG_array_type
	.long	103                             // DW_AT_type
	.byte	7                               // Abbrev [7] 0x60:0x6 DW_TAG_subrange_type
	.long	161                             // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	3                               // Abbrev [3] 0x67:0xb DW_TAG_typedef
	.long	114                             // DW_AT_type
	.long	misc.crt0..Linfo_string11                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	8                               // Abbrev [8] 0x72:0x1d DW_TAG_structure_type
	.byte	8                               // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	24                              // DW_AT_decl_line
	.byte	9                               // Abbrev [9] 0x76:0xc DW_TAG_member
	.long	misc.crt0..Linfo_string7                  // DW_AT_name
	.long	143                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	25                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	9                               // Abbrev [9] 0x82:0xc DW_TAG_member
	.long	misc.crt0..Linfo_string10                 // DW_AT_name
	.long	143                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.byte	4                               // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	3                               // Abbrev [3] 0x8f:0xb DW_TAG_typedef
	.long	154                             // DW_AT_type
	.long	misc.crt0..Linfo_string9                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x9a:0x7 DW_TAG_base_type
	.long	misc.crt0..Linfo_string8                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	10                              // Abbrev [10] 0xa1:0x7 DW_TAG_base_type
	.long	misc.crt0..Linfo_string12                 // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	5                               // Abbrev [5] 0xa8:0x12 DW_TAG_variable
	.long	misc.crt0..Linfo_string13                 // DW_AT_name
	.long	186                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	11                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__sys_used_mram_end
	.byte	6                               // Abbrev [6] 0xba:0xc DW_TAG_array_type
	.long	198                             // DW_AT_type
	.byte	7                               // Abbrev [7] 0xbf:0x6 DW_TAG_subrange_type
	.long	161                             // DW_AT_type
	.byte	0                               // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	3                               // Abbrev [3] 0xc6:0xb DW_TAG_typedef
	.long	209                             // DW_AT_type
	.long	misc.crt0..Linfo_string15                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0xd1:0x7 DW_TAG_base_type
	.long	misc.crt0..Linfo_string14                 // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	2                               // Abbrev [2] 0xd8:0x11 DW_TAG_variable
	.long	misc.crt0..Linfo_string16                 // DW_AT_name
	.long	233                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	15                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	thread_profiling
	.byte	6                               // Abbrev [6] 0xe9:0xc DW_TAG_array_type
	.long	143                             // DW_AT_type
	.byte	7                               // Abbrev [7] 0xee:0x6 DW_TAG_subrange_type
	.long	161                             // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	2                               // Abbrev [2] 0xf5:0x11 DW_TAG_variable
	.long	misc.crt0..Linfo_string17                 // DW_AT_name
	.long	143                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	16                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	perfcounter_end_value
	.byte	5                               // Abbrev [5] 0x106:0x12 DW_TAG_variable
	.long	misc.crt0..Linfo_string18                 // DW_AT_name
	.long	280                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	28                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	CLOCKS_PER_SEC
	.byte	11                              // Abbrev [11] 0x118:0x5 DW_TAG_const_type
	.long	285                             // DW_AT_type
	.byte	12                              // Abbrev [12] 0x11d:0x5 DW_TAG_volatile_type
	.long	143                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x122:0x12 DW_TAG_variable
	.long	misc.crt0..Linfo_string19                 // DW_AT_name
	.long	280                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	30                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	error_storage
	.byte	13                              // Abbrev [13] 0x134:0x11 DW_TAG_subprogram
	.long	misc.crt0..Lfunc_begin0                   // DW_AT_low_pc
	.long	misc.crt0..Lfunc_end0-misc.crt0..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	misc.crt0..Linfo_string20                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	32                              // DW_AT_decl_line
                                        // DW_AT_external
	.byte	0                               // End Of Children Mark
misc.crt0..Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
misc.crt0..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
misc.crt0..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/misc/crt0.c" // string offset=106
misc.crt0..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=139
misc.crt0..Linfo_string3:
	.asciz	"__sys_null_pointer"            // string offset=166
misc.crt0..Linfo_string4:
	.asciz	"long unsigned int"             // string offset=185
misc.crt0..Linfo_string5:
	.asciz	"uint64_t"                      // string offset=203
misc.crt0..Linfo_string6:
	.asciz	"__sys_thread_stack_table_ptr"  // string offset=212
misc.crt0..Linfo_string7:
	.asciz	"stack_size"                    // string offset=241
misc.crt0..Linfo_string8:
	.asciz	"unsigned int"                  // string offset=252
misc.crt0..Linfo_string9:
	.asciz	"uint32_t"                      // string offset=265
misc.crt0..Linfo_string10:
	.asciz	"stack_ptr"                     // string offset=274
misc.crt0..Linfo_string11:
	.asciz	"thread_stack_t"                // string offset=284
misc.crt0..Linfo_string12:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=299
misc.crt0..Linfo_string13:
	.asciz	"__sys_used_mram_end"           // string offset=319
misc.crt0..Linfo_string14:
	.asciz	"unsigned char"                 // string offset=339
misc.crt0..Linfo_string15:
	.asciz	"uint8_t"                       // string offset=353
misc.crt0..Linfo_string16:
	.asciz	"thread_profiling"              // string offset=361
misc.crt0..Linfo_string17:
	.asciz	"perfcounter_end_value"         // string offset=378
misc.crt0..Linfo_string18:
	.asciz	"CLOCKS_PER_SEC"                // string offset=400
misc.crt0..Linfo_string19:
	.asciz	"error_storage"                 // string offset=415
misc.crt0..Linfo_string20:
	.asciz	"__bootstrap"                   // string offset=429
	.addrsig
	.addrsig_sym __bootstrap
	.addrsig_sym __sys_null_pointer
	.addrsig_sym STACK_SIZE_TASKLET_0
	.addrsig_sym __sys_stack_thread_0
	.addrsig_sym STACK_SIZE_TASKLET_1
	.addrsig_sym __sys_stack_thread_1
	.addrsig_sym STACK_SIZE_TASKLET_2
	.addrsig_sym __sys_stack_thread_2
	.addrsig_sym STACK_SIZE_TASKLET_3
	.addrsig_sym __sys_stack_thread_3
	.addrsig_sym STACK_SIZE_TASKLET_4
	.addrsig_sym __sys_stack_thread_4
	.addrsig_sym STACK_SIZE_TASKLET_5
	.addrsig_sym __sys_stack_thread_5
	.addrsig_sym STACK_SIZE_TASKLET_6
	.addrsig_sym __sys_stack_thread_6
	.addrsig_sym STACK_SIZE_TASKLET_7
	.addrsig_sym __sys_stack_thread_7
	.addrsig_sym STACK_SIZE_TASKLET_8
	.addrsig_sym __sys_stack_thread_8
	.addrsig_sym STACK_SIZE_TASKLET_9
	.addrsig_sym __sys_stack_thread_9
	.addrsig_sym STACK_SIZE_TASKLET_10
	.addrsig_sym __sys_stack_thread_10
	.addrsig_sym STACK_SIZE_TASKLET_11
	.addrsig_sym __sys_stack_thread_11
	.addrsig_sym STACK_SIZE_TASKLET_12
	.addrsig_sym __sys_stack_thread_12
	.addrsig_sym STACK_SIZE_TASKLET_13
	.addrsig_sym __sys_stack_thread_13
	.addrsig_sym STACK_SIZE_TASKLET_14
	.addrsig_sym __sys_stack_thread_14
	.addrsig_sym STACK_SIZE_TASKLET_15
	.addrsig_sym __sys_stack_thread_15
	.addrsig_sym STACK_SIZE_TASKLET_16
	.addrsig_sym __sys_stack_thread_16
	.addrsig_sym STACK_SIZE_TASKLET_17
	.addrsig_sym __sys_stack_thread_17
	.addrsig_sym STACK_SIZE_TASKLET_18
	.addrsig_sym __sys_stack_thread_18
	.addrsig_sym STACK_SIZE_TASKLET_19
	.addrsig_sym __sys_stack_thread_19
	.addrsig_sym STACK_SIZE_TASKLET_20
	.addrsig_sym __sys_stack_thread_20
	.addrsig_sym STACK_SIZE_TASKLET_21
	.addrsig_sym __sys_stack_thread_21
	.addrsig_sym STACK_SIZE_TASKLET_22
	.addrsig_sym __sys_stack_thread_22
	.addrsig_sym STACK_SIZE_TASKLET_23
	.addrsig_sym __sys_stack_thread_23
	.addrsig_sym __sys_thread_stack_table_ptr
	.addrsig_sym __sys_used_mram_end
	.addrsig_sym thread_profiling
	.addrsig_sym CLOCKS_PER_SEC
	.addrsig_sym error_storage
	.section	.debug_line,"",@progbits
misc.crt0..Lline_table_start0:
	.text
	.file	"barrier.c"
	.section	.text.barrier_wait,"ax",@progbits
	.globl	barrier_wait                    // -- Begin function barrier_wait
	.type	barrier_wait,@function
barrier_wait:                           // @barrier_wait
syslib.barrier..Lfunc_begin0:
	.file	1 "/root/uPIMulator/sdk" "syslib/barrier.c"
	.loc	1 13 0                          // syslib/barrier.c:13:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.cfi_def_cfa_offset 0
	.loc	1 14 35 prologue_end            // syslib/barrier.c:14:35
	lbs r1, r0, 3
syslib.barrier..Ltmp0:
	//DEBUG_VALUE: barrier_wait:lock <- undef
	.loc	1 15 5                          // syslib/barrier.c:15:5
	// inline asm
syslib.barrier..Ltmp1:
	acquire r1, 0, nz, syslib.barrier..Ltmp1+0
	// inline asm
	.loc	1 16 36                         // syslib/barrier.c:16:36
	lbu r3, r0, 1
syslib.barrier..Ltmp2:
	//DEBUG_VALUE: barrier_wait:count <- $r3
	.loc	1 17 35                         // syslib/barrier.c:17:35
	lbu r2, r0, 0
syslib.barrier..Ltmp3:
	//DEBUG_VALUE: barrier_wait:tid <- undef
	//DEBUG_VALUE: barrier_wait:last <- $r2
	.loc	1 23 9                          // syslib/barrier.c:23:9
	jeq r3, 1, syslib.barrier..LBB0_1
syslib.barrier..Ltmp4:
// %bb.6:
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 0 0 is_stmt 0                 // syslib/barrier.c:0:0
	move r4, id
syslib.barrier..Ltmp5:
	//DEBUG_VALUE: barrier_wait:tid <- $r4
	.loc	1 36 13 is_stmt 1               // syslib/barrier.c:36:13
	jeq r2, 255, syslib.barrier..LBB0_7
syslib.barrier..Ltmp6:
// %bb.8:
	//DEBUG_VALUE: barrier_wait:tid <- $r4
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 39 21                         // syslib/barrier.c:39:21
	lbs r5, r2, __sys_wq_table
syslib.barrier..Ltmp7:
	//DEBUG_VALUE: barrier_wait:first <- $r5
	.loc	1 40 37                         // syslib/barrier.c:40:37
	sb r4, __sys_wq_table, r5
	.loc	1 41 38                         // syslib/barrier.c:41:38
	sb r2, __sys_wq_table, r4
syslib.barrier..Ltmp8:
syslib.barrier..LBB0_9:
	//DEBUG_VALUE: barrier_wait:tid <- $r4
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 44 29                         // syslib/barrier.c:44:29
	sb r0, 0, r4
	.loc	1 45 26                         // syslib/barrier.c:45:26
	add r2, r3, -1
syslib.barrier..Ltmp9:
	//DEBUG_VALUE: barrier_wait:count <- $r2
	.loc	1 45 24 is_stmt 0               // syslib/barrier.c:45:24
	sb r0, 1, r2
	.loc	1 46 9 is_stmt 1                // syslib/barrier.c:46:9
	// inline asm
syslib.barrier..Ltmp10:
	release r1, 0, nz, syslib.barrier..Ltmp10+1
	// inline asm
	.loc	1 47 9                          // syslib/barrier.c:47:9
	// inline asm
	stop false, 0x0
	// inline asm
syslib.barrier..Ltmp11:
	.loc	1 49 1                          // syslib/barrier.c:49:1
	jump r23
syslib.barrier..Ltmp12:
syslib.barrier..LBB0_1:
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 24 13                         // syslib/barrier.c:24:13
	jeq r2, 255, syslib.barrier..LBB0_5
syslib.barrier..Ltmp13:
// %bb.2:
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 0 0 is_stmt 0                 // syslib/barrier.c:0:0
	lbu r3, r2, __sys_wq_table
syslib.barrier..Ltmp14:
	//DEBUG_VALUE: barrier_wait:first <- $r3
	.loc	1 26 13 is_stmt 1               // syslib/barrier.c:26:13
	jeq r3, r2, syslib.barrier..LBB0_4
syslib.barrier..Ltmp15:
syslib.barrier..LBB0_3:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: barrier_wait:first <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 27 17                         // syslib/barrier.c:27:17
	// inline asm
syslib.barrier..Ltmp16:
	resume r3, 0, nz, syslib.barrier..Ltmp16+0
	// inline asm
syslib.barrier..Ltmp17:
	//DEBUG_VALUE: barrier_wait:first <- undef
	.loc	1 0 0 is_stmt 0                 // syslib/barrier.c:0:0
	and r3, r3, 255
syslib.barrier..Ltmp18:
	lbu r3, r3, __sys_wq_table
syslib.barrier..Ltmp19:
	//DEBUG_VALUE: barrier_wait:first <- $r3
	.loc	1 26 13 is_stmt 1               // syslib/barrier.c:26:13
	jneq r3, r2, syslib.barrier..LBB0_3
syslib.barrier..Ltmp20:
syslib.barrier..LBB0_4:
	//DEBUG_VALUE: barrier_wait:first <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 30 13                         // syslib/barrier.c:30:13
	// inline asm
syslib.barrier..Ltmp21:
	resume r2, 0, nz, syslib.barrier..Ltmp21+0
	// inline asm
	.loc	1 31 33                         // syslib/barrier.c:31:33
	sb r0, 0, 255
	.loc	1 32 39                         // syslib/barrier.c:32:39
	lbs r2, r0, 2
syslib.barrier..Ltmp22:
	.loc	1 32 28 is_stmt 0               // syslib/barrier.c:32:28
	sb r0, 1, r2
syslib.barrier..Ltmp23:
syslib.barrier..LBB0_5:
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 34 9 is_stmt 1                // syslib/barrier.c:34:9
	// inline asm
syslib.barrier..Ltmp24:
	release r1, 0, nz, syslib.barrier..Ltmp24+1
	// inline asm
syslib.barrier..Ltmp25:
	.loc	1 49 1                          // syslib/barrier.c:49:1
	jump r23
syslib.barrier..Ltmp26:
syslib.barrier..LBB0_7:
	//DEBUG_VALUE: barrier_wait:tid <- $r4
	//DEBUG_VALUE: barrier_wait:count <- $r3
	//DEBUG_VALUE: barrier_wait:last <- $r2
	//DEBUG_VALUE: barrier_wait:barrier <- $r0
	.loc	1 37 37                         // syslib/barrier.c:37:37
	sb r4, __sys_wq_table, r4
	jump syslib.barrier..LBB0_9
syslib.barrier..Ltmp27:
syslib.barrier..Lfunc_end0:
	.size	barrier_wait, syslib.barrier..Lfunc_end0-barrier_wait
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.barrier_wait
	.long	syslib.barrier..Lfunc_begin0
	.byte	0
	.section	.text.barrier_wait,"ax",@progbits
                                        // -- End function
	.file	2 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.file	3 "/root/uPIMulator/sdk" "syslib/barrier.h"
	.file	4 "/root/uPIMulator/sdk" "syslib/sysdef.h"
	.section	.debug_loc,"",@progbits
syslib.barrier..Ldebug_loc0:
	.long	syslib.barrier..Ltmp2-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp9-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	syslib.barrier..Ltmp9-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp12-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	syslib.barrier..Ltmp12-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp14-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	syslib.barrier..Ltmp26-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Lfunc_end0-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
syslib.barrier..Ldebug_loc1:
	.long	syslib.barrier..Ltmp5-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp12-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	syslib.barrier..Ltmp26-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Lfunc_end0-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
syslib.barrier..Ldebug_loc2:
	.long	syslib.barrier..Ltmp3-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp9-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	syslib.barrier..Ltmp12-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp22-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	syslib.barrier..Ltmp26-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Lfunc_end0-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
syslib.barrier..Ldebug_loc3:
	.long	syslib.barrier..Ltmp7-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp8-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	85                              // DW_OP_reg5
	.long	syslib.barrier..Ltmp14-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp17-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	syslib.barrier..Ltmp19-syslib.barrier..Lfunc_begin0
	.long	syslib.barrier..Ltmp23-syslib.barrier..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	19                              // DW_TAG_structure_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	13                              // DW_TAG_member
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	56                              // DW_AT_data_member_location
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
syslib.barrier..Lcu_begin0:
	.long	syslib.barrier..Ldebug_info_end0-syslib.barrier..Ldebug_info_start0 // Length of Unit
syslib.barrier..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0xe4 DW_TAG_compile_unit
	.long	syslib.barrier..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.barrier..Linfo_string1                  // DW_AT_name
	.long	syslib.barrier..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.barrier..Linfo_string2                  // DW_AT_comp_dir
	.long	syslib.barrier..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.barrier..Lfunc_end0-syslib.barrier..Lfunc_begin0       // DW_AT_high_pc
	.byte	2                               // Abbrev [2] 0x26:0x66 DW_TAG_subprogram
	.long	syslib.barrier..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.barrier..Lfunc_end0-syslib.barrier..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.barrier..Linfo_string3                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	3                               // Abbrev [3] 0x37:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	syslib.barrier..Linfo_string4                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
	.long	140                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0x44:0xb DW_TAG_variable
	.long	syslib.barrier..Linfo_string10                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	14                              // DW_AT_decl_line
	.long	213                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x4f:0xf DW_TAG_variable
	.long	syslib.barrier..Ldebug_loc0                    // DW_AT_location
	.long	syslib.barrier..Linfo_string8                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	16                              // DW_AT_decl_line
	.long	213                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x5e:0xf DW_TAG_variable
	.long	syslib.barrier..Ldebug_loc1                    // DW_AT_location
	.long	syslib.barrier..Linfo_string12                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.long	220                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x6d:0xf DW_TAG_variable
	.long	syslib.barrier..Ldebug_loc2                    // DW_AT_location
	.long	syslib.barrier..Linfo_string15                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	17                              // DW_AT_decl_line
	.long	213                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x7c:0xf DW_TAG_variable
	.long	syslib.barrier..Ldebug_loc3                    // DW_AT_location
	.long	syslib.barrier..Linfo_string16                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.long	213                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	6                               // Abbrev [6] 0x8c:0x5 DW_TAG_pointer_type
	.long	145                             // DW_AT_type
	.byte	7                               // Abbrev [7] 0x91:0x39 DW_TAG_structure_type
	.long	syslib.barrier..Linfo_string11                 // DW_AT_name
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	8                               // Abbrev [8] 0x99:0xc DW_TAG_member
	.long	syslib.barrier..Linfo_string5                  // DW_AT_name
	.long	202                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	34                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	8                               // Abbrev [8] 0xa5:0xc DW_TAG_member
	.long	syslib.barrier..Linfo_string8                  // DW_AT_name
	.long	202                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	35                              // DW_AT_decl_line
	.byte	1                               // DW_AT_data_member_location
	.byte	8                               // Abbrev [8] 0xb1:0xc DW_TAG_member
	.long	syslib.barrier..Linfo_string9                  // DW_AT_name
	.long	202                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	36                              // DW_AT_decl_line
	.byte	2                               // DW_AT_data_member_location
	.byte	8                               // Abbrev [8] 0xbd:0xc DW_TAG_member
	.long	syslib.barrier..Linfo_string10                 // DW_AT_name
	.long	202                             // DW_AT_type
	.byte	3                               // DW_AT_decl_file
	.byte	37                              // DW_AT_decl_line
	.byte	3                               // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	9                               // Abbrev [9] 0xca:0xb DW_TAG_typedef
	.long	213                             // DW_AT_type
	.long	syslib.barrier..Linfo_string7                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	10                              // Abbrev [10] 0xd5:0x7 DW_TAG_base_type
	.long	syslib.barrier..Linfo_string6                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	9                               // Abbrev [9] 0xdc:0xb DW_TAG_typedef
	.long	231                             // DW_AT_type
	.long	syslib.barrier..Linfo_string14                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.byte	10                              // Abbrev [10] 0xe7:0x7 DW_TAG_base_type
	.long	syslib.barrier..Linfo_string13                 // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	0                               // End Of Children Mark
syslib.barrier..Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
syslib.barrier..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.barrier..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/barrier.c" // string offset=106
syslib.barrier..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=144
syslib.barrier..Linfo_string3:
	.asciz	"barrier_wait"                  // string offset=171
syslib.barrier..Linfo_string4:
	.asciz	"barrier"                       // string offset=184
syslib.barrier..Linfo_string5:
	.asciz	"wait_queue"                    // string offset=192
syslib.barrier..Linfo_string6:
	.asciz	"unsigned char"                 // string offset=203
syslib.barrier..Linfo_string7:
	.asciz	"uint8_t"                       // string offset=217
syslib.barrier..Linfo_string8:
	.asciz	"count"                         // string offset=225
syslib.barrier..Linfo_string9:
	.asciz	"initial_count"                 // string offset=231
syslib.barrier..Linfo_string10:
	.asciz	"lock"                          // string offset=245
syslib.barrier..Linfo_string11:
	.asciz	"barrier_t"                     // string offset=250
syslib.barrier..Linfo_string12:
	.asciz	"tid"                           // string offset=260
syslib.barrier..Linfo_string13:
	.asciz	"unsigned int"                  // string offset=264
syslib.barrier..Linfo_string14:
	.asciz	"thread_id_t"                   // string offset=277
syslib.barrier..Linfo_string15:
	.asciz	"last"                          // string offset=289
syslib.barrier..Linfo_string16:
	.asciz	"first"                         // string offset=294
	.addrsig
	.section	.debug_line,"",@progbits
syslib.barrier..Lline_table_start0:
	.text
	.file	"alloc.c"
	.file	1 "/root/uPIMulator/sdk" "syslib/alloc.c"
	.file	2 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.section	.text.mem_alloc_nolock,"ax",@progbits
	.globl	mem_alloc_nolock                // -- Begin function mem_alloc_nolock
	.type	mem_alloc_nolock,@function
mem_alloc_nolock:                       // @mem_alloc_nolock
syslib.alloc..Lfunc_begin0:
	.loc	1 20 0                          // syslib/alloc.c:20:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: mem_alloc_nolock:size <- $r0
	.cfi_def_cfa_offset 0
	.loc	1 21 28 prologue_end            // syslib/alloc.c:21:28
	lw r1, zero, __sys_heap_pointer
syslib.alloc..Ltmp0:
	//DEBUG_VALUE: mem_alloc_nolock:pointer <- $r1
	//DEBUG_VALUE: mem_alloc_nolock:size <- $r0
	.loc	1 23 9                          // syslib/alloc.c:23:9
	jeq r0, 0, syslib.alloc..LBB0_2
syslib.alloc..Ltmp1:
// %bb.1:
	//DEBUG_VALUE: mem_alloc_nolock:pointer <- $r1
	//DEBUG_VALUE: mem_alloc_nolock:size <- $r0
	.loc	1 24 28                         // syslib/alloc.c:24:28
	add r1, r1, 7
syslib.alloc..Ltmp2:
	.loc	1 24 33 is_stmt 0               // syslib/alloc.c:24:33
	and r1, r1, -8
syslib.alloc..Ltmp3:
	//DEBUG_VALUE: mem_alloc_nolock:pointer <- $r1
	.loc	1 28 9 is_stmt 1                // syslib/alloc.c:28:9
	// inline asm
syslib.alloc..Ltmp4:
	add r0, r1, r0, nc, syslib.alloc..Ltmp4+2
	fault 1
	lbu r2, r0, -1

	// inline asm
syslib.alloc..Ltmp5:
	//DEBUG_VALUE: dummy <- undef
	//DEBUG_VALUE: new_heap_pointer <- $r0
	.loc	1 34 24                         // syslib/alloc.c:34:24
	sw zero, __sys_heap_pointer, r0
syslib.alloc..Ltmp6:
syslib.alloc..LBB0_2:
	//DEBUG_VALUE: mem_alloc_nolock:pointer <- $r1
	//DEBUG_VALUE: mem_alloc_nolock:pointer <- $r1
	.loc	1 36 5                          // syslib/alloc.c:36:5
	move r0, r1
	jump r23
syslib.alloc..Ltmp7:
syslib.alloc..Lfunc_end0:
	.size	mem_alloc_nolock, syslib.alloc..Lfunc_end0-mem_alloc_nolock
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.mem_alloc_nolock
	.long	syslib.alloc..Lfunc_begin0
	.byte	0
	.section	.text.mem_alloc_nolock,"ax",@progbits
                                        // -- End function
	.section	.text.mem_alloc,"ax",@progbits
	.globl	mem_alloc                       // -- Begin function mem_alloc
	.type	mem_alloc,@function
mem_alloc:                              // @mem_alloc
syslib.alloc..Lfunc_begin1:
	.loc	1 41 0                          // syslib/alloc.c:41:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: mem_alloc:size <- $r0
	.cfi_def_cfa_offset -8
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 0, d22
	add r22, r22, 8
syslib.alloc..Ltmp8:
	.loc	1 42 5 prologue_end             // syslib/alloc.c:42:5
	// inline asm
syslib.alloc..Ltmp9:
	acquire zero, __atomic_bit___heap_pointer, nz, syslib.alloc..Ltmp9
	// inline asm
	//DEBUG_VALUE: mem_alloc:size <- $r0
	//DEBUG_VALUE: mem_alloc:size <- $r0
	.loc	1 43 21                         // syslib/alloc.c:43:21
	call r23, mem_alloc_nolock
syslib.alloc..Ltmp10:
	.loc	1 44 5                          // syslib/alloc.c:44:5
	// inline asm
syslib.alloc..Ltmp11:
	release zero, __atomic_bit___heap_pointer, nz, syslib.alloc..Ltmp11+1
	// inline asm
syslib.alloc..Ltmp12:
	//DEBUG_VALUE: mem_alloc:pointer <- $r0
	.loc	1 45 5                          // syslib/alloc.c:45:5
	ld d22, r22, -8
	jump r23
syslib.alloc..Ltmp13:
syslib.alloc..Lfunc_end1:
	.size	mem_alloc, syslib.alloc..Lfunc_end1-mem_alloc
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.mem_alloc
	.long	syslib.alloc..Lfunc_begin1
	.byte	8
	.section	.text.mem_alloc,"ax",@progbits
                                        // -- End function
	.section	.text.mem_reset,"ax",@progbits
	.globl	mem_reset                       // -- Begin function mem_reset
	.type	mem_reset,@function
mem_reset:                              // @mem_reset
syslib.alloc..Lfunc_begin2:
	.loc	1 50 0                          // syslib/alloc.c:50:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	1 51 5 prologue_end             // syslib/alloc.c:51:5
	// inline asm
syslib.alloc..Ltmp14:
	acquire zero, __atomic_bit___heap_pointer, nz, syslib.alloc..Ltmp14
	// inline asm
	.loc	1 55 24                         // syslib/alloc.c:55:24
	move r0, __sys_heap_pointer_reset
syslib.alloc..Ltmp15:
	//DEBUG_VALUE: mem_reset:initial <- $r0
	sw zero, __sys_heap_pointer, r0
	.loc	1 57 5                          // syslib/alloc.c:57:5
	// inline asm
syslib.alloc..Ltmp16:
	release zero, __atomic_bit___heap_pointer, nz, syslib.alloc..Ltmp16+1
	// inline asm
	.loc	1 59 5                          // syslib/alloc.c:59:5
	jump r23
syslib.alloc..Ltmp17:
syslib.alloc..Lfunc_end2:
	.size	mem_reset, syslib.alloc..Lfunc_end2-mem_reset
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.mem_reset
	.long	syslib.alloc..Lfunc_begin2
	.byte	0
	.section	.text.mem_reset,"ax",@progbits
                                        // -- End function
	.type	__sys_heap_pointer,@object      // @__sys_heap_pointer
	.section	.data.__sys_heap_pointer,"aw",@progbits
	.globl	__sys_heap_pointer
	.p2align	2
__sys_heap_pointer:
	.long	__sys_heap_pointer_reset
	.size	__sys_heap_pointer, 4

	.type	__atomic_bit___heap_pointer,@object // @__atomic_bit___heap_pointer
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit___heap_pointer
__atomic_bit___heap_pointer:
	.byte	0                               // 0x0
	.size	__atomic_bit___heap_pointer, 1

	.file	3 "/root/uPIMulator/sdk" "stdlib/stddef.h"
	.section	.debug_loc,"",@progbits
syslib.alloc..Ldebug_loc0:
	.long	-1
	.long	syslib.alloc..Lfunc_begin0                   //   base address
	.long	syslib.alloc..Lfunc_begin0-syslib.alloc..Lfunc_begin0
	.long	syslib.alloc..Ltmp5-syslib.alloc..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
syslib.alloc..Ldebug_loc1:
	.long	-1
	.long	syslib.alloc..Lfunc_begin0                   //   base address
	.long	syslib.alloc..Ltmp0-syslib.alloc..Lfunc_begin0
	.long	syslib.alloc..Ltmp2-syslib.alloc..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	syslib.alloc..Ltmp3-syslib.alloc..Lfunc_begin0
	.long	syslib.alloc..Lfunc_end0-syslib.alloc..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
syslib.alloc..Ldebug_loc2:
	.long	-1
	.long	syslib.alloc..Lfunc_begin0                   //   base address
	.long	syslib.alloc..Ltmp5-syslib.alloc..Lfunc_begin0
	.long	syslib.alloc..Ltmp6-syslib.alloc..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
syslib.alloc..Ldebug_loc3:
	.long	-1
	.long	syslib.alloc..Lfunc_begin1                   //   base address
	.long	syslib.alloc..Ltmp12-syslib.alloc..Lfunc_begin1
	.long	syslib.alloc..Lfunc_end1-syslib.alloc..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
syslib.alloc..Ldebug_loc4:
	.long	-1
	.long	syslib.alloc..Lfunc_begin2                   //   base address
	.long	syslib.alloc..Ltmp15-syslib.alloc..Lfunc_begin2
	.long	syslib.alloc..Lfunc_end2-syslib.alloc..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	53                              // DW_TAG_volatile_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.ascii	"\211\202\001"                  // DW_TAG_GNU_call_site
	.byte	0                               // DW_CHILDREN_no
	.ascii	"\223B"                         // DW_AT_GNU_call_site_target
	.byte	24                              // DW_FORM_exprloc
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
syslib.alloc..Lcu_begin0:
	.long	syslib.alloc..Ldebug_info_end0-syslib.alloc..Ldebug_info_start0 // Length of Unit
syslib.alloc..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x11e DW_TAG_compile_unit
	.long	syslib.alloc..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.alloc..Linfo_string1                  // DW_AT_name
	.long	syslib.alloc..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.alloc..Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	syslib.alloc..Ldebug_ranges0                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	syslib.alloc..Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	11                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__sys_heap_pointer
	.byte	3                               // Abbrev [3] 0x37:0x5 DW_TAG_volatile_type
	.long	60                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x3c:0x7 DW_TAG_base_type
	.long	syslib.alloc..Linfo_string4                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	2                               // Abbrev [2] 0x43:0x11 DW_TAG_variable
	.long	syslib.alloc..Linfo_string5                  // DW_AT_name
	.long	84                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	13                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit___heap_pointer
	.byte	5                               // Abbrev [5] 0x54:0xb DW_TAG_typedef
	.long	95                              // DW_AT_type
	.long	syslib.alloc..Linfo_string7                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x5f:0x7 DW_TAG_base_type
	.long	syslib.alloc..Linfo_string6                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	6                               // Abbrev [6] 0x66:0x1 DW_TAG_pointer_type
	.byte	7                               // Abbrev [7] 0x67:0x58 DW_TAG_subprogram
	.long	syslib.alloc..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.alloc..Lfunc_end0-syslib.alloc..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.alloc..Linfo_string8                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	102                             // DW_AT_type
                                        // DW_AT_external
	.byte	8                               // Abbrev [8] 0x7c:0xf DW_TAG_formal_parameter
	.long	syslib.alloc..Ldebug_loc0                    // DW_AT_location
	.long	syslib.alloc..Linfo_string11                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.long	285                             // DW_AT_type
	.byte	9                               // Abbrev [9] 0x8b:0xf DW_TAG_variable
	.long	syslib.alloc..Ldebug_loc1                    // DW_AT_location
	.long	syslib.alloc..Linfo_string13                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	21                              // DW_AT_decl_line
	.long	60                              // DW_AT_type
	.byte	10                              // Abbrev [10] 0x9a:0x24 DW_TAG_lexical_block
	.long	syslib.alloc..Ltmp1                          // DW_AT_low_pc
	.long	syslib.alloc..Ltmp6-syslib.alloc..Ltmp1                   // DW_AT_high_pc
	.byte	11                              // Abbrev [11] 0xa3:0xb DW_TAG_variable
	.long	syslib.alloc..Linfo_string14                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	60                              // DW_AT_type
	.byte	9                               // Abbrev [9] 0xae:0xf DW_TAG_variable
	.long	syslib.alloc..Ldebug_loc2                    // DW_AT_location
	.long	syslib.alloc..Linfo_string15                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	60                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	7                               // Abbrev [7] 0xbf:0x39 DW_TAG_subprogram
	.long	syslib.alloc..Lfunc_begin1                   // DW_AT_low_pc
	.long	syslib.alloc..Lfunc_end1-syslib.alloc..Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.alloc..Linfo_string9                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	102                             // DW_AT_type
                                        // DW_AT_external
	.byte	12                              // Abbrev [12] 0xd4:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	syslib.alloc..Linfo_string11                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.long	285                             // DW_AT_type
	.byte	9                               // Abbrev [9] 0xe1:0xf DW_TAG_variable
	.long	syslib.alloc..Ldebug_loc3                    // DW_AT_location
	.long	syslib.alloc..Linfo_string13                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.long	102                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0xf0:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	syslib.alloc..Ltmp10                         // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	14                              // Abbrev [14] 0xf8:0x25 DW_TAG_subprogram
	.long	syslib.alloc..Lfunc_begin2                   // DW_AT_low_pc
	.long	syslib.alloc..Lfunc_end2-syslib.alloc..Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.alloc..Linfo_string10                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	49                              // DW_AT_decl_line
	.long	102                             // DW_AT_type
                                        // DW_AT_external
	.byte	9                               // Abbrev [9] 0x10d:0xf DW_TAG_variable
	.long	syslib.alloc..Ldebug_loc4                    // DW_AT_location
	.long	syslib.alloc..Linfo_string16                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	53                              // DW_AT_decl_line
	.long	102                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x11d:0xb DW_TAG_typedef
	.long	60                              // DW_AT_type
	.long	syslib.alloc..Linfo_string12                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.byte	0                               // End Of Children Mark
syslib.alloc..Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
syslib.alloc..Ldebug_ranges0:
	.long	syslib.alloc..Lfunc_begin0
	.long	syslib.alloc..Lfunc_end0
	.long	syslib.alloc..Lfunc_begin1
	.long	syslib.alloc..Lfunc_end1
	.long	syslib.alloc..Lfunc_begin2
	.long	syslib.alloc..Lfunc_end2
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
syslib.alloc..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.alloc..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/alloc.c" // string offset=106
syslib.alloc..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=142
syslib.alloc..Linfo_string3:
	.asciz	"__sys_heap_pointer"            // string offset=169
syslib.alloc..Linfo_string4:
	.asciz	"unsigned int"                  // string offset=188
syslib.alloc..Linfo_string5:
	.asciz	"__atomic_bit___heap_pointer"   // string offset=201
syslib.alloc..Linfo_string6:
	.asciz	"unsigned char"                 // string offset=229
syslib.alloc..Linfo_string7:
	.asciz	"uint8_t"                       // string offset=243
syslib.alloc..Linfo_string8:
	.asciz	"mem_alloc_nolock"              // string offset=251
syslib.alloc..Linfo_string9:
	.asciz	"mem_alloc"                     // string offset=268
syslib.alloc..Linfo_string10:
	.asciz	"mem_reset"                     // string offset=278
syslib.alloc..Linfo_string11:
	.asciz	"size"                          // string offset=288
syslib.alloc..Linfo_string12:
	.asciz	"size_t"                        // string offset=293
syslib.alloc..Linfo_string13:
	.asciz	"pointer"                       // string offset=300
syslib.alloc..Linfo_string14:
	.asciz	"dummy"                         // string offset=308
syslib.alloc..Linfo_string15:
	.asciz	"new_heap_pointer"              // string offset=314
syslib.alloc..Linfo_string16:
	.asciz	"initial"                       // string offset=331
	.addrsig
	.addrsig_sym __sys_heap_pointer_reset
	.addrsig_sym __sys_heap_pointer
	.addrsig_sym __atomic_bit___heap_pointer
	.section	.debug_line,"",@progbits
syslib.alloc..Lline_table_start0:
	.text
	.file	"handshake.c"
	.file	1 "/root/uPIMulator/sdk" "syslib/handshake.c"
	.file	2 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.section	.text.handshake_notify,"ax",@progbits
	.globl	handshake_notify                // -- Begin function handshake_notify
	.type	handshake_notify,@function
handshake_notify:                       // @handshake_notify
syslib.handshake..Lfunc_begin0:
	.loc	1 21 0                          // syslib/handshake.c:21:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	1 24 5 prologue_end             // syslib/handshake.c:24:5
	move r0, __atomic_start_addr
	move r1, __atomic_bit___handshake
	sub r0, r1, r0
	add r0, id, r0
	// inline asm
syslib.handshake..Ltmp0:
	acquire r0, 0, nz, syslib.handshake..Ltmp0
	// inline asm
	.loc	1 25 12                         // syslib/handshake.c:25:12
	lbu r2, id, __handshake_array
syslib.handshake..Ltmp1:
	//DEBUG_VALUE: handshake_notify:info <- $r2
	.file	3 "/root/uPIMulator/sdk" "syslib/defs.h"
	.loc	3 35 12                         // syslib/defs.h:35:12
	move r1, id
syslib.handshake..Ltmp2:
	//DEBUG_VALUE: handshake_notify:tid <- $r1
	.loc	1 27 9                          // syslib/handshake.c:27:9
	jeq r2, 255, syslib.handshake..LBB0_1
syslib.handshake..Ltmp3:
// %bb.2:
	//DEBUG_VALUE: handshake_notify:info <- $r2
	//DEBUG_VALUE: handshake_notify:tid <- $r1
	.loc	1 32 9                          // syslib/handshake.c:32:9
	// inline asm
syslib.handshake..Ltmp4:
	resume r2, 0, nz, syslib.handshake..Ltmp4+0
	// inline asm
	move r2, 255
syslib.handshake..Ltmp5:
	.loc	1 33 32                         // syslib/handshake.c:33:32
	sb r1, __handshake_array, r2
	.loc	1 34 9                          // syslib/handshake.c:34:9
	// inline asm
syslib.handshake..Ltmp6:
	release r0, 0, nz, syslib.handshake..Ltmp6+1
	// inline asm
syslib.handshake..Ltmp7:
	.loc	1 36 1                          // syslib/handshake.c:36:1
	jump r23
syslib.handshake..Ltmp8:
syslib.handshake..LBB0_1:
	//DEBUG_VALUE: handshake_notify:info <- $r2
	//DEBUG_VALUE: handshake_notify:tid <- $r1
	.loc	1 28 32                         // syslib/handshake.c:28:32
	sb r1, __handshake_array, r1
	.loc	1 29 9                          // syslib/handshake.c:29:9
	// inline asm
syslib.handshake..Ltmp9:
	release r0, 0, nz, syslib.handshake..Ltmp9+1
	// inline asm
	.loc	1 30 9                          // syslib/handshake.c:30:9
	// inline asm
	stop false, 0x0
	// inline asm
syslib.handshake..Ltmp10:
	.loc	1 36 1                          // syslib/handshake.c:36:1
	jump r23
syslib.handshake..Ltmp11:
syslib.handshake..Lfunc_end0:
	.size	handshake_notify, syslib.handshake..Lfunc_end0-handshake_notify
	.cfi_endproc
	.file	4 "/root/uPIMulator/sdk" "syslib/sysdef.h"
	.section	.stack_sizes,"o",@progbits,.text.handshake_notify
	.long	syslib.handshake..Lfunc_begin0
	.byte	0
	.section	.text.handshake_notify,"ax",@progbits
                                        // -- End function
	.section	.text.handshake_wait_for,"ax",@progbits
	.globl	handshake_wait_for              // -- Begin function handshake_wait_for
	.type	handshake_wait_for,@function
handshake_wait_for:                     // @handshake_wait_for
syslib.handshake..Lfunc_begin1:
	.loc	1 40 0                          // syslib/handshake.c:40:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: handshake_wait_for:notifier <- $r0
	//DEBUG_VALUE: handshake_wait_for:notifier <- $r0
	.cfi_def_cfa_offset 0
	.loc	1 45 5 prologue_end             // syslib/handshake.c:45:5
	and r0, r0, 255
syslib.handshake..Ltmp12:
	move r1, __atomic_start_addr
	move r2, __atomic_bit___handshake
	sub r1, r2, r1
	add r1, r0, r1
	// inline asm
syslib.handshake..Ltmp13:
	acquire r1, 0, nz, syslib.handshake..Ltmp13
	// inline asm
	.loc	1 46 26                         // syslib/handshake.c:46:26
	lbu r3, r0, __handshake_array
syslib.handshake..Ltmp14:
	//DEBUG_VALUE: handshake_wait_for:info <- $r3
	.loc	3 35 12                         // syslib/defs.h:35:12
	move r2, id
syslib.handshake..Ltmp15:
	//DEBUG_VALUE: handshake_wait_for:thread <- undef
	//DEBUG_VALUE: handshake_wait_for:tid <- $r2
	.loc	1 48 9                          // syslib/handshake.c:48:9
	jeq r3, 255, syslib.handshake..LBB1_1
syslib.handshake..Ltmp16:
// %bb.2:
	//DEBUG_VALUE: handshake_wait_for:info <- $r3
	//DEBUG_VALUE: handshake_wait_for:tid <- $r2
	.loc	1 53 13                         // syslib/handshake.c:53:13
	jneq r3, r0, syslib.handshake..LBB1_3
syslib.handshake..Ltmp17:
// %bb.4:
	//DEBUG_VALUE: handshake_wait_for:info <- $r3
	//DEBUG_VALUE: handshake_wait_for:tid <- $r2
	.loc	1 58 13                         // syslib/handshake.c:58:13
	// inline asm
syslib.handshake..Ltmp18:
	resume r3, 0, nz, syslib.handshake..Ltmp18+0
	// inline asm
	move r2, 255
syslib.handshake..Ltmp19:
	.loc	1 59 39                         // syslib/handshake.c:59:39
	sb r0, __handshake_array, r2
syslib.handshake..Ltmp20:
	.loc	1 62 9                          // syslib/handshake.c:62:9
	// inline asm
syslib.handshake..Ltmp21:
	release r1, 0, nz, syslib.handshake..Ltmp21+1
	// inline asm
	move r0, 0
syslib.handshake..Ltmp22:
	.loc	1 66 1                          // syslib/handshake.c:66:1
	jump r23
syslib.handshake..Ltmp23:
syslib.handshake..LBB1_1:
	//DEBUG_VALUE: handshake_wait_for:info <- $r3
	//DEBUG_VALUE: handshake_wait_for:tid <- $r2
	.loc	1 49 35                         // syslib/handshake.c:49:35
	sb r0, __handshake_array, r2
	.loc	1 50 9                          // syslib/handshake.c:50:9
	// inline asm
syslib.handshake..Ltmp24:
	release r1, 0, nz, syslib.handshake..Ltmp24+1
	// inline asm
	.loc	1 51 9                          // syslib/handshake.c:51:9
	// inline asm
	stop false, 0x0
	// inline asm
	move r0, 0
syslib.handshake..Ltmp25:
	.loc	1 66 1                          // syslib/handshake.c:66:1
	jump r23
syslib.handshake..Ltmp26:
syslib.handshake..LBB1_3:
	//DEBUG_VALUE: handshake_wait_for:info <- $r3
	//DEBUG_VALUE: handshake_wait_for:tid <- $r2
	.loc	1 54 13                         // syslib/handshake.c:54:13
	lsl r2, r2, 2
syslib.handshake..Ltmp27:
	.loc	1 0 13 is_stmt 0                // syslib/handshake.c:0:13
	move r0, 7
	.loc	1 54 19                         // syslib/handshake.c:54:19
	sw r2, __errno, r0
	.loc	1 55 13 is_stmt 1               // syslib/handshake.c:55:13
	// inline asm
syslib.handshake..Ltmp28:
	release r1, 0, nz, syslib.handshake..Ltmp28+1
	// inline asm
syslib.handshake..Ltmp29:
	.loc	1 66 1                          // syslib/handshake.c:66:1
	jump r23
syslib.handshake..Ltmp30:
syslib.handshake..Lfunc_end1:
	.size	handshake_wait_for, syslib.handshake..Lfunc_end1-handshake_wait_for
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.handshake_wait_for
	.long	syslib.handshake..Lfunc_begin1
	.byte	0
	.section	.text.handshake_wait_for,"ax",@progbits
                                        // -- End function
	.type	__handshake_array,@object       // @__handshake_array
	.section	.data.__handshake_array,"aw",@progbits
	.globl	__handshake_array
__handshake_array:
	.zero	24,255
	.size	__handshake_array, 24

	.type	__atomic_bit___handshake,@object // @__atomic_bit___handshake
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit___handshake
__atomic_bit___handshake:
	.zero	24
	.size	__atomic_bit___handshake, 24

	.section	.debug_loc,"",@progbits
syslib.handshake..Ldebug_loc0:
	.long	-1
	.long	syslib.handshake..Lfunc_begin0                   //   base address
	.long	syslib.handshake..Ltmp1-syslib.handshake..Lfunc_begin0
	.long	syslib.handshake..Ltmp5-syslib.handshake..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	syslib.handshake..Ltmp8-syslib.handshake..Lfunc_begin0
	.long	syslib.handshake..Lfunc_end0-syslib.handshake..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
syslib.handshake..Ldebug_loc1:
	.long	-1
	.long	syslib.handshake..Lfunc_begin0                   //   base address
	.long	syslib.handshake..Ltmp2-syslib.handshake..Lfunc_begin0
	.long	syslib.handshake..Lfunc_end0-syslib.handshake..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
syslib.handshake..Ldebug_loc2:
	.long	-1
	.long	syslib.handshake..Lfunc_begin1                   //   base address
	.long	syslib.handshake..Lfunc_begin1-syslib.handshake..Lfunc_begin1
	.long	syslib.handshake..Ltmp12-syslib.handshake..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
syslib.handshake..Ldebug_loc3:
	.long	-1
	.long	syslib.handshake..Lfunc_begin1                   //   base address
	.long	syslib.handshake..Ltmp14-syslib.handshake..Lfunc_begin1
	.long	syslib.handshake..Lfunc_end1-syslib.handshake..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
syslib.handshake..Ldebug_loc4:
	.long	-1
	.long	syslib.handshake..Lfunc_begin1                   //   base address
	.long	syslib.handshake..Ltmp15-syslib.handshake..Lfunc_begin1
	.long	syslib.handshake..Ltmp19-syslib.handshake..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	syslib.handshake..Ltmp23-syslib.handshake..Lfunc_begin1
	.long	syslib.handshake..Ltmp27-syslib.handshake..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	0                               // DW_CHILDREN_no
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
syslib.handshake..Lcu_begin0:
	.long	syslib.handshake..Ldebug_info_end0-syslib.handshake..Ldebug_info_start0 // Length of Unit
syslib.handshake..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x13d DW_TAG_compile_unit
	.long	syslib.handshake..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.handshake..Linfo_string1                  // DW_AT_name
	.long	syslib.handshake..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.handshake..Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	syslib.handshake..Ldebug_ranges0                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	syslib.handshake..Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	12                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__handshake_array
	.byte	3                               // Abbrev [3] 0x37:0xc DW_TAG_array_type
	.long	67                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x3c:0x6 DW_TAG_subrange_type
	.long	74                              // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x43:0x7 DW_TAG_base_type
	.long	syslib.handshake..Linfo_string4                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	6                               // Abbrev [6] 0x4a:0x7 DW_TAG_base_type
	.long	syslib.handshake..Linfo_string5                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	2                               // Abbrev [2] 0x51:0x11 DW_TAG_variable
	.long	syslib.handshake..Linfo_string6                  // DW_AT_name
	.long	98                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	14                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit___handshake
	.byte	3                               // Abbrev [3] 0x62:0xc DW_TAG_array_type
	.long	110                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0x67:0x6 DW_TAG_subrange_type
	.long	74                              // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	7                               // Abbrev [7] 0x6e:0xb DW_TAG_typedef
	.long	67                              // DW_AT_type
	.long	syslib.handshake..Linfo_string7                  // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	8                               // Abbrev [8] 0x79:0xc DW_TAG_subprogram
	.long	syslib.handshake..Linfo_string8                  // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	133                             // DW_AT_type
	.byte	1                               // DW_AT_inline
	.byte	7                               // Abbrev [7] 0x85:0xb DW_TAG_typedef
	.long	144                             // DW_AT_type
	.long	syslib.handshake..Linfo_string10                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	5                               // Abbrev [5] 0x90:0x7 DW_TAG_base_type
	.long	syslib.handshake..Linfo_string9                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	9                               // Abbrev [9] 0x97:0x40 DW_TAG_subprogram
	.long	syslib.handshake..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.handshake..Lfunc_end0-syslib.handshake..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.handshake..Linfo_string11                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	20                              // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	10                              // Abbrev [10] 0xa8:0xf DW_TAG_variable
	.long	syslib.handshake..Ldebug_loc0                    // DW_AT_location
	.long	syslib.handshake..Linfo_string14                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	23                              // DW_AT_decl_line
	.long	67                              // DW_AT_type
	.byte	10                              // Abbrev [10] 0xb7:0xf DW_TAG_variable
	.long	syslib.handshake..Ldebug_loc1                    // DW_AT_location
	.long	syslib.handshake..Linfo_string15                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	22                              // DW_AT_decl_line
	.long	316                             // DW_AT_type
	.byte	11                              // Abbrev [11] 0xc6:0x10 DW_TAG_inlined_subroutine
	.long	121                             // DW_AT_abstract_origin
	.long	syslib.handshake..Ltmp1                          // DW_AT_low_pc
	.long	syslib.handshake..Ltmp2-syslib.handshake..Ltmp1                   // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	22                              // DW_AT_call_line
	.byte	23                              // DW_AT_call_column
	.byte	0                               // End Of Children Mark
	.byte	12                              // Abbrev [12] 0xd7:0x5e DW_TAG_subprogram
	.long	syslib.handshake..Lfunc_begin1                   // DW_AT_low_pc
	.long	syslib.handshake..Lfunc_end1-syslib.handshake..Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.handshake..Linfo_string12                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	39                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	309                             // DW_AT_type
                                        // DW_AT_external
	.byte	13                              // Abbrev [13] 0xec:0xf DW_TAG_formal_parameter
	.long	syslib.handshake..Ldebug_loc2                    // DW_AT_location
	.long	syslib.handshake..Linfo_string17                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	39                              // DW_AT_decl_line
	.long	144                             // DW_AT_type
	.byte	10                              // Abbrev [10] 0xfb:0xf DW_TAG_variable
	.long	syslib.handshake..Ldebug_loc3                    // DW_AT_location
	.long	syslib.handshake..Linfo_string14                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	46                              // DW_AT_decl_line
	.long	67                              // DW_AT_type
	.byte	14                              // Abbrev [14] 0x10a:0xb DW_TAG_variable
	.long	syslib.handshake..Linfo_string18                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.long	67                              // DW_AT_type
	.byte	10                              // Abbrev [10] 0x115:0xf DW_TAG_variable
	.long	syslib.handshake..Ldebug_loc4                    // DW_AT_location
	.long	syslib.handshake..Linfo_string15                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	41                              // DW_AT_decl_line
	.long	316                             // DW_AT_type
	.byte	11                              // Abbrev [11] 0x124:0x10 DW_TAG_inlined_subroutine
	.long	121                             // DW_AT_abstract_origin
	.long	syslib.handshake..Ltmp14                         // DW_AT_low_pc
	.long	syslib.handshake..Ltmp15-syslib.handshake..Ltmp14                 // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	41                              // DW_AT_call_line
	.byte	23                              // DW_AT_call_column
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x135:0x7 DW_TAG_base_type
	.long	syslib.handshake..Linfo_string13                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	7                               // Abbrev [7] 0x13c:0xb DW_TAG_typedef
	.long	144                             // DW_AT_type
	.long	syslib.handshake..Linfo_string16                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.byte	0                               // End Of Children Mark
syslib.handshake..Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
syslib.handshake..Ldebug_ranges0:
	.long	syslib.handshake..Lfunc_begin0
	.long	syslib.handshake..Lfunc_end0
	.long	syslib.handshake..Lfunc_begin1
	.long	syslib.handshake..Lfunc_end1
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
syslib.handshake..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.handshake..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/handshake.c" // string offset=106
syslib.handshake..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=146
syslib.handshake..Linfo_string3:
	.asciz	"__handshake_array"             // string offset=173
syslib.handshake..Linfo_string4:
	.asciz	"unsigned char"                 // string offset=191
syslib.handshake..Linfo_string5:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=205
syslib.handshake..Linfo_string6:
	.asciz	"__atomic_bit___handshake"      // string offset=225
syslib.handshake..Linfo_string7:
	.asciz	"uint8_t"                       // string offset=250
syslib.handshake..Linfo_string8:
	.asciz	"me"                            // string offset=258
syslib.handshake..Linfo_string9:
	.asciz	"unsigned int"                  // string offset=261
syslib.handshake..Linfo_string10:
	.asciz	"sysname_t"                     // string offset=274
syslib.handshake..Linfo_string11:
	.asciz	"handshake_notify"              // string offset=284
syslib.handshake..Linfo_string12:
	.asciz	"handshake_wait_for"            // string offset=301
syslib.handshake..Linfo_string13:
	.asciz	"int"                           // string offset=320
syslib.handshake..Linfo_string14:
	.asciz	"info"                          // string offset=324
syslib.handshake..Linfo_string15:
	.asciz	"tid"                           // string offset=329
syslib.handshake..Linfo_string16:
	.asciz	"thread_id_t"                   // string offset=333
syslib.handshake..Linfo_string17:
	.asciz	"notifier"                      // string offset=345
syslib.handshake..Linfo_string18:
	.asciz	"thread"                        // string offset=354
	.addrsig
	.addrsig_sym __atomic_bit___handshake
	.addrsig_sym __atomic_start_addr
	.section	.debug_line,"",@progbits
syslib.handshake..Lline_table_start0:
	.text
	.file	"stdio.c"
	.file	1 "/root/uPIMulator/sdk" "stdlib/stdio.c"
	.file	2 "/root/uPIMulator/sdk" "stdlib/stdint.h"
	.section	.text.printf,"ax",@progbits
	.globl	printf                          // -- Begin function printf
	.type	printf,@function
printf:                                 // @printf
stdlib.stdio..Lfunc_begin0:
	.loc	1 102 0                         // stdlib/stdio.c:102:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: printf:format <- $r0
	.cfi_def_cfa_offset -48
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 40, d22
	add r22, r22, 48
	.cfi_offset 15, -32
	.cfi_offset 14, -28
	sd r22, -32, d14
	.cfi_offset 17, -40
	.cfi_offset 16, -36
	sd r22, -40, d16
	.cfi_offset 19, -48
	.cfi_offset 18, -44
	sd r22, -48, d18
	move r14, r0
stdlib.stdio..Ltmp0:
	//DEBUG_VALUE: printf:current_format_char_ptr <- undef
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	//DEBUG_VALUE: printf:insert_string_arg <- 1
	//DEBUG_VALUE: printf:format <- $r14
	.loc	1 107 5 prologue_end            // stdlib/stdio.c:107:5
	call r23, stdlib.stdio.__open_print_sequence
stdlib.stdio..Ltmp1:
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	.loc	1 110 5                         // stdlib/stdio.c:110:5
	sub r0, r22, 56, false
	sw r22, -24, r0
	move r0, 1
	.loc	1 0 0 is_stmt 0                 // stdlib/stdio.c:0:0
	move r15, r14, true, stdlib.stdio..LBB0_1
stdlib.stdio..Ltmp2:
stdlib.stdio..LBB0_19:                               //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	//DEBUG_VALUE: printf:insert_string_arg <- undef
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	.loc	1 112 46 is_stmt 1              // stdlib/stdio.c:112:46
	add r15, r15, 1
stdlib.stdio..Ltmp3:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	.loc	1 0 46 is_stmt 0                // stdlib/stdio.c:0:46
	move r0, r16
stdlib.stdio..Ltmp4:
stdlib.stdio..LBB0_1:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_9 Depth 2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	//DEBUG_VALUE: printf:insert_string_arg <- undef
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	.loc	1 112 12                        // stdlib/stdio.c:112:12
	lbu r1, r15, 0
stdlib.stdio..Ltmp5:
	.loc	1 112 5                         // stdlib/stdio.c:112:5
	jeq r1, 37, stdlib.stdio..LBB0_6
stdlib.stdio..Ltmp6:
// %bb.2:                               //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 5                           // stdlib/stdio.c:0:5
	jneq r1, 0, stdlib.stdio..LBB0_3
	jump stdlib.stdio..LBB0_20
stdlib.stdio..Ltmp7:
stdlib.stdio..LBB0_6:                                //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 115 17 is_stmt 1              // stdlib/stdio.c:115:17
	lbu r1, r15, 1
stdlib.stdio..Ltmp8:
	.loc	1 114 13                        // stdlib/stdio.c:114:13
	add r15, r15, 1
stdlib.stdio..Ltmp9:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	.loc	1 115 17                        // stdlib/stdio.c:115:17
	jeq r1, 37, stdlib.stdio..LBB0_3
stdlib.stdio..Ltmp10:
// %bb.7:                               //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	jeq r1, 0, stdlib.stdio..LBB0_20
stdlib.stdio..Ltmp11:
// %bb.8:                               //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 17 is_stmt 0                // stdlib/stdio.c:0:17
	move r0, 37
	.loc	1 120 13 is_stmt 1              // stdlib/stdio.c:120:13
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp12:
	.loc	1 0 13 is_stmt 0                // stdlib/stdio.c:0:13
	jump stdlib.stdio..LBB0_9
stdlib.stdio..Ltmp13:
stdlib.stdio..LBB0_18:                               //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 136 17 is_stmt 1              // stdlib/stdio.c:136:17
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp14:
	.loc	1 138 23                        // stdlib/stdio.c:138:23
	lbu r0, r15, 0
	.loc	1 138 56 is_stmt 0              // stdlib/stdio.c:138:56
	and r0, r0, 223
	add r0, r0, -65
	and r0, r0, 255
	jltu r0, 26, stdlib.stdio..LBB0_19
stdlib.stdio..Ltmp15:
stdlib.stdio..LBB0_17:                               //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 0                           // stdlib/stdio.c:0:0
	add r15, r15, 1
stdlib.stdio..Ltmp16:
stdlib.stdio..LBB0_9:                                //   Parent Loop BB0_1 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	.loc	1 122 20 is_stmt 1              // stdlib/stdio.c:122:20
	lbu r0, r15, 0
	move r16, 1
	.loc	1 122 13 is_stmt 0              // stdlib/stdio.c:122:13
	jles r0, 107, stdlib.stdio..LBB0_10
stdlib.stdio..Ltmp17:
// %bb.14:                              //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	jeq r0, 122, stdlib.stdio..LBB0_17
stdlib.stdio..Ltmp18:
// %bb.15:                              //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	jneq r0, 108, stdlib.stdio..LBB0_18
stdlib.stdio..Ltmp19:
// %bb.16:                              //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 13                          // stdlib/stdio.c:0:13
	move r0, 108
stdlib.stdio..Ltmp20:
	.loc	1 124 21 is_stmt 1              // stdlib/stdio.c:124:21
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp21:
	//DEBUG_VALUE: printf:current_format_char_ptr <- [DW_OP_plus_uconst 1, DW_OP_stack_value] $r15
	.loc	1 0 21 is_stmt 0                // stdlib/stdio.c:0:21
	jump stdlib.stdio..LBB0_17
stdlib.stdio..Ltmp22:
stdlib.stdio..LBB0_10:                               //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 122 13 is_stmt 1              // stdlib/stdio.c:122:13
	jeq r0, 76, stdlib.stdio..LBB0_17
stdlib.stdio..Ltmp23:
// %bb.11:                              //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	jeq r0, 0, stdlib.stdio..LBB0_19
stdlib.stdio..Ltmp24:
// %bb.12:                              //   in Loop: Header=BB0_9 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	jneq r0, 105, stdlib.stdio..LBB0_18
stdlib.stdio..Ltmp25:
// %bb.13:                              //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 13 is_stmt 0                // stdlib/stdio.c:0:13
	move r0, 100
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp26:
	//DEBUG_VALUE: printf:insert_string_arg <- 0
	jump stdlib.stdio..LBB0_19
stdlib.stdio..Ltmp27:
stdlib.stdio..LBB0_3:                                //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_LABEL: standard_character_format_process
	move r16, 0
stdlib.stdio..Ltmp28:
	.loc	1 149 17 is_stmt 1              // stdlib/stdio.c:149:17
	and r0, r0, 1, z, stdlib.stdio..LBB0_19
stdlib.stdio..Ltmp29:
// %bb.4:                               //   in Loop: Header=BB0_1 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 17 is_stmt 0                // stdlib/stdio.c:0:17
	move r0, 37
stdlib.stdio..Ltmp30:
	.loc	1 150 17 is_stmt 1              // stdlib/stdio.c:150:17
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp31:
	.loc	1 0 17 is_stmt 0                // stdlib/stdio.c:0:17
	move r0, 115
stdlib.stdio..Ltmp32:
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp33:
	//DEBUG_VALUE: printf:insert_string_arg <- 0
	jump stdlib.stdio..LBB0_19
stdlib.stdio..Ltmp34:
stdlib.stdio..LBB0_20:
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r15
	//DEBUG_VALUE: printf:format <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	move r15, 0
stdlib.stdio..Ltmp35:
	.loc	1 157 5 is_stmt 1               // stdlib/stdio.c:157:5
	move r0, r15
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp36:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	add r0, r22, -16
stdlib.stdio..Ltmp37:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 160 5 is_stmt 1               // stdlib/stdio.c:160:5
	or r16, r0, 1, true, stdlib.stdio..LBB0_21
stdlib.stdio..Ltmp38:
stdlib.stdio..LBB0_22:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 160 5 is_stmt 0               // stdlib/stdio.c:160:5
	jeq r0, 0, stdlib.stdio..LBB0_52
stdlib.stdio..Ltmp39:
stdlib.stdio..LBB0_23:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_LABEL: standard_character_process
	.loc	1 243 13 is_stmt 1              // stdlib/stdio.c:243:13
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp40:
	.loc	1 0 13 is_stmt 0                // stdlib/stdio.c:0:13
	move r15, 1
stdlib.stdio..Ltmp41:
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- undef
	.loc	1 160 46 is_stmt 1              // stdlib/stdio.c:160:46
	add r14, r14, 1
stdlib.stdio..Ltmp42:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
stdlib.stdio..LBB0_21:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_30 Depth 2
                                        //     Child Loop BB0_41 Depth 2
                                        //     Child Loop BB0_50 Depth 2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- undef
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 160 12 is_stmt 0              // stdlib/stdio.c:160:12
	lbu r0, r14, 0
stdlib.stdio..Ltmp43:
	.loc	1 160 5                         // stdlib/stdio.c:160:5
	jneq r0, 37, stdlib.stdio..LBB0_22
stdlib.stdio..Ltmp44:
// %bb.24:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 164 17 is_stmt 1              // stdlib/stdio.c:164:17
	lbu r1, r14, 1
stdlib.stdio..Ltmp45:
	.loc	1 162 13                        // stdlib/stdio.c:162:13
	add r14, r14, 1
stdlib.stdio..Ltmp46:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 164 17                        // stdlib/stdio.c:164:17
	jeq r1, 37, stdlib.stdio..LBB0_23
stdlib.stdio..Ltmp47:
// %bb.25:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	jeq r1, 0, stdlib.stdio..LBB0_52
stdlib.stdio..Ltmp48:
// %bb.26:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 169 17                        // stdlib/stdio.c:169:17
	and r0, r15, 1, z, stdlib.stdio..LBB0_28
stdlib.stdio..Ltmp49:
// %bb.27:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- 0
	.loc	1 0 17 is_stmt 0                // stdlib/stdio.c:0:17
	move r0, 0
stdlib.stdio..Ltmp50:
	.loc	1 171 17 is_stmt 1              // stdlib/stdio.c:171:17
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp51:
stdlib.stdio..LBB0_28:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 17 is_stmt 0                // stdlib/stdio.c:0:17
	move r0, 0
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
stdlib.stdio..Ltmp52:
	//DEBUG_VALUE: arg_is_64_bits <- undef
	.loc	1 176 20 is_stmt 1              // stdlib/stdio.c:176:20
	lbu r1, r14, 0
	.loc	1 176 13 is_stmt 0              // stdlib/stdio.c:176:13
	jgts r1, 121, stdlib.stdio..LBB0_35
	jump stdlib.stdio..LBB0_30
stdlib.stdio..Ltmp53:
stdlib.stdio..LBB0_36:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 186 56 is_stmt 1              // stdlib/stdio.c:186:56
	and r2, r1, 223
	add r2, r2, -65
	and r2, r2, 255
	jleu r2, 25, stdlib.stdio..LBB0_37
stdlib.stdio..Ltmp54:
stdlib.stdio..LBB0_34:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 0 is_stmt 0                 // stdlib/stdio.c:0:0
	add r14, r14, 1
stdlib.stdio..Ltmp55:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: arg_is_64_bits <- undef
	.loc	1 176 20 is_stmt 1              // stdlib/stdio.c:176:20
	lbu r1, r14, 0
	.loc	1 176 13 is_stmt 0              // stdlib/stdio.c:176:13
	jles r1, 121, stdlib.stdio..LBB0_30
stdlib.stdio..Ltmp56:
stdlib.stdio..LBB0_35:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 13                          // stdlib/stdio.c:0:13
	jeq r1, 122, stdlib.stdio..LBB0_34
	jump stdlib.stdio..LBB0_36
stdlib.stdio..Ltmp57:
stdlib.stdio..LBB0_30:                               //   Parent Loop BB0_21 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 176 13                        // stdlib/stdio.c:176:13
	jeq r1, 0, stdlib.stdio..LBB0_46
stdlib.stdio..Ltmp58:
// %bb.31:                              //   in Loop: Header=BB0_30 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	jeq r1, 76, stdlib.stdio..LBB0_33
stdlib.stdio..Ltmp59:
// %bb.32:                              //   in Loop: Header=BB0_30 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	jneq r1, 108, stdlib.stdio..LBB0_36
stdlib.stdio..Ltmp60:
stdlib.stdio..LBB0_33:                               //   in Loop: Header=BB0_30 Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: printf:current_format_char_ptr <- [DW_OP_plus_uconst 1, DW_OP_stack_value] $r14
	//DEBUG_VALUE: arg_is_64_bits <- 1
	.loc	1 180 21 is_stmt 1              // stdlib/stdio.c:180:21
	add r14, r14, 1
stdlib.stdio..Ltmp61:
	.loc	1 0 21 is_stmt 0                // stdlib/stdio.c:0:21
	move r0, 1
stdlib.stdio..Ltmp62:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: arg_is_64_bits <- undef
	.loc	1 176 20 is_stmt 1              // stdlib/stdio.c:176:20
	lbu r1, r14, 0
	.loc	1 176 13 is_stmt 0              // stdlib/stdio.c:176:13
	jgts r1, 121, stdlib.stdio..LBB0_35
	jump stdlib.stdio..LBB0_30
stdlib.stdio..Ltmp63:
stdlib.stdio..LBB0_37:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 193 13 is_stmt 1              // stdlib/stdio.c:193:13
	add r1, r1, -69
	jgtu r1, 46, stdlib.stdio..LBB0_46
stdlib.stdio..Ltmp64:
// %bb.38:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 13 is_stmt 0                // stdlib/stdio.c:0:13
	lsl r1, r1, 2
	lw r1, r1, stdlib.stdio..LJTI0_0
	jump r1
stdlib.stdio..Ltmp65:
stdlib.stdio..LBB0_45:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 213 21 is_stmt 1              // stdlib/stdio.c:213:21
	// inline asm
	nop
	// inline asm
	.loc	1 214 34                        // stdlib/stdio.c:214:34
	lw r0, r22, -24
	add r0, r0, -8
	and r0, r0, -8
	sw r22, -24, r0
	ld d18, r0, 0
stdlib.stdio..Ltmp66:
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: arg <- undef
	//DEBUG_VALUE: val <- undef
	.loc	1 218 25                        // stdlib/stdio.c:218:25
	and r0, r19, 255
stdlib.stdio..Ltmp67:
	//DEBUG_VALUE: arg_byte <- $r0
	//DEBUG_VALUE: i <- 3
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp68:
	//DEBUG_VALUE: i <- 1
	lsr r0, r19, 8
stdlib.stdio..Ltmp69:
	and r0, r0, 255
stdlib.stdio..Ltmp70:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp71:
	//DEBUG_VALUE: i <- 2
	lsr r0, r19, 16
stdlib.stdio..Ltmp72:
	and r0, r0, 255
stdlib.stdio..Ltmp73:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp74:
	lsr r0, r19, 24
stdlib.stdio..Ltmp75:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp76:
	//DEBUG_VALUE: i <- 4
	and r0, r18, 255
stdlib.stdio..Ltmp77:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp78:
	//DEBUG_VALUE: i <- 5
	.loc	1 217 41                        // stdlib/stdio.c:217:41
	lsr.u d0, r18, 8
stdlib.stdio..Ltmp79:
	.loc	1 218 25                        // stdlib/stdio.c:218:25
	and r0, r1, 255
stdlib.stdio..Ltmp80:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp81:
	//DEBUG_VALUE: i <- 6
	.loc	1 217 41                        // stdlib/stdio.c:217:41
	lsr.u d0, r18, 16
stdlib.stdio..Ltmp82:
	.loc	1 218 25                        // stdlib/stdio.c:218:25
	and r0, r1, 255
stdlib.stdio..Ltmp83:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp84:
	//DEBUG_VALUE: i <- 7
	.loc	1 217 41                        // stdlib/stdio.c:217:41
	lsr.u d0, r18, 24
stdlib.stdio..Ltmp85:
	//DEBUG_VALUE: arg_byte <- undef
	.loc	1 218 25                        // stdlib/stdio.c:218:25
	move r0, r1
stdlib.stdio..Ltmp86:
	.loc	1 0 0 is_stmt 0                 // stdlib/stdio.c:0:0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp87:
	jump stdlib.stdio..LBB0_51
stdlib.stdio..Ltmp88:
stdlib.stdio..LBB0_46:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 226 25 is_stmt 1              // stdlib/stdio.c:226:25
	and r0, r0, 1, z, stdlib.stdio..LBB0_48
stdlib.stdio..Ltmp89:
// %bb.47:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 227 31                        // stdlib/stdio.c:227:31
	lw r0, r22, -24
	add r0, r0, -8
	and r0, r0, -8
	sw r22, -24, r0
	ld d0, r0, 0
stdlib.stdio..Ltmp90:
	//DEBUG_VALUE: val <- $d0
	//DEBUG_VALUE: arg_size_in_bytes <- 8
	.loc	1 0 31 is_stmt 0                // stdlib/stdio.c:0:31
	move r15, 8, true, stdlib.stdio..LBB0_49
stdlib.stdio..Ltmp91:
stdlib.stdio..LBB0_48:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 230 37 is_stmt 1              // stdlib/stdio.c:230:37
	lw r0, r22, -24
	add r1, r0, -4
	sw r22, -24, r1
	lw.s d0, r0, -4
stdlib.stdio..Ltmp92:
	//DEBUG_VALUE: val <- $d0
	.loc	1 0 37 is_stmt 0                // stdlib/stdio.c:0:37
	move r15, 4
stdlib.stdio..Ltmp93:
	//DEBUG_VALUE: arg_size_in_bytes <- 4
stdlib.stdio..LBB0_49:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: val <- $d0
	sd r22, -16, d0
stdlib.stdio..Ltmp94:
	//DEBUG_VALUE: i <- 0
	//DEBUG_VALUE: arg <- [DW_OP_constu 16, DW_OP_minus, DW_OP_stack_value] $r22
	//DEBUG_VALUE: arg_size_in_bytes <- $r15
	.loc	1 237 25 is_stmt 1              // stdlib/stdio.c:237:25
	and r0, r1, 255
stdlib.stdio..Ltmp95:
	//DEBUG_VALUE: arg_byte <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp96:
	//DEBUG_VALUE: i <- 1
	.loc	1 235 21                        // stdlib/stdio.c:235:21
	add r15, r15, -1
stdlib.stdio..Ltmp97:
	.loc	1 0 21 is_stmt 0                // stdlib/stdio.c:0:21
	move r17, r16
stdlib.stdio..Ltmp98:
stdlib.stdio..LBB0_50:                               //   Parent Loop BB0_21 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	//DEBUG_VALUE: arg <- [DW_OP_constu 16, DW_OP_minus, DW_OP_stack_value] $r22
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 236 41 is_stmt 1              // stdlib/stdio.c:236:41
	lbu r0, r17, 0
stdlib.stdio..Ltmp99:
	//DEBUG_VALUE: arg_byte <- undef
	//DEBUG_VALUE: i <- undef
	.loc	1 237 25                        // stdlib/stdio.c:237:25
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp100:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	1 235 48                        // stdlib/stdio.c:235:48
	add r17, r17, 1
	add r15, r15, -1, nz, stdlib.stdio..LBB0_50
stdlib.stdio..Ltmp101:
stdlib.stdio..LBB0_51:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 48 is_stmt 0                // stdlib/stdio.c:0:48
	move r15, 0
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
stdlib.stdio..Ltmp102:
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- undef
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 160 46 is_stmt 1              // stdlib/stdio.c:160:46
	add r14, r14, 1, true, stdlib.stdio..LBB0_21
stdlib.stdio..Ltmp103:
stdlib.stdio..LBB0_43:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 204 46                        // stdlib/stdio.c:204:46
	lw r0, r22, -24
	add r1, r0, -4
	sw r22, -24, r1
	lbu r0, r0, -4
stdlib.stdio..Ltmp104:
	//DEBUG_VALUE: arg_as_char <- $r0
	.loc	1 0 0 is_stmt 0                 // stdlib/stdio.c:0:0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp105:
	jump stdlib.stdio..LBB0_51
stdlib.stdio..Ltmp106:
stdlib.stdio..LBB0_39:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 195 41 is_stmt 1              // stdlib/stdio.c:195:41
	lw r0, r22, -24
	add r1, r0, -4
	sw r22, -24, r1
	lw r1, r0, -4
stdlib.stdio..Ltmp107:
	//DEBUG_VALUE: arg <- $r1
	.loc	1 196 28                        // stdlib/stdio.c:196:28
	lbu r0, r1, 0
	.loc	1 196 21 is_stmt 0              // stdlib/stdio.c:196:21
	jeq r0, 0, stdlib.stdio..LBB0_42
stdlib.stdio..Ltmp108:
// %bb.40:                              //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: arg <- $r1
	add r15, r1, 1
stdlib.stdio..Ltmp109:
stdlib.stdio..LBB0_41:                               //   Parent Loop BB0_21 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: arg <- [DW_OP_constu 1, DW_OP_minus, DW_OP_stack_value] $r15
	.loc	1 197 25 is_stmt 1              // stdlib/stdio.c:197:25
	and r0, r0, 255
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp110:
	//DEBUG_VALUE: arg <- $r15
	.loc	1 196 28                        // stdlib/stdio.c:196:28
	lbu r0, r15, 0
	.loc	1 196 21 is_stmt 0              // stdlib/stdio.c:196:21
	add r15, r15, 1
stdlib.stdio..Ltmp111:
	jneq r0, 0, stdlib.stdio..LBB0_41
stdlib.stdio..Ltmp112:
stdlib.stdio..LBB0_42:                               //   in Loop: Header=BB0_21 Depth=1
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 21                          // stdlib/stdio.c:0:21
	move r15, 0
	.loc	1 200 21 is_stmt 1              // stdlib/stdio.c:200:21
	move r0, r15
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp113:
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: printf:insert_string_arg_end_character <- undef
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 160 46                        // stdlib/stdio.c:160:46
	add r14, r14, 1, true, stdlib.stdio..LBB0_21
stdlib.stdio..Ltmp114:
stdlib.stdio..LBB0_52:
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 248 9                         // stdlib/stdio.c:248:9
	and r0, r15, 1, z, stdlib.stdio..LBB0_54
stdlib.stdio..Ltmp115:
// %bb.53:
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	.loc	1 0 9 is_stmt 0                 // stdlib/stdio.c:0:9
	move r0, 0
stdlib.stdio..Ltmp116:
	.loc	1 249 9 is_stmt 1               // stdlib/stdio.c:249:9
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp117:
stdlib.stdio..LBB0_54:
	//DEBUG_VALUE: printf:args <- [DW_OP_plus_uconst 24, DW_OP_deref] $r22
	//DEBUG_VALUE: printf:current_format_char_ptr <- $r14
	//DEBUG_VALUE: printf:args <- [DW_OP_constu 24, DW_OP_minus, DW_OP_deref] $r22
	.loc	1 254 5                         // stdlib/stdio.c:254:5
	call r23, stdlib.stdio.__finalized_print_sequence
stdlib.stdio..Ltmp118:
	.loc	1 255 5                         // stdlib/stdio.c:255:5
	call r23, stdlib.stdio.__close_print_sequence
stdlib.stdio..Ltmp119:
	.loc	1 256 1                         // stdlib/stdio.c:256:1
	ld d18, r22, -48
	ld d16, r22, -40
	ld d14, r22, -32
stdlib.stdio..Ltmp120:
	ld d22, r22, -8
stdlib.stdio..Ltmp121:
	jump r23
stdlib.stdio..Ltmp122:
stdlib.stdio..Lfunc_end0:
	.size	printf, stdlib.stdio..Lfunc_end0-printf
	.cfi_endproc
	.section	.rodata.printf,"a",@progbits
	.p2align	2
stdlib.stdio..LJTI0_0:
	.long	stdlib.stdio..LBB0_45
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_45
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_43
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_45
	.long	stdlib.stdio..LBB0_45
	.long	stdlib.stdio..LBB0_45
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_46
	.long	stdlib.stdio..LBB0_39
	.section	.stack_sizes,"o",@progbits,.rodata.printf
	.long	stdlib.stdio..Lfunc_begin0
	.byte	48
	.section	.rodata.printf,"a",@progbits
                                        // -- End function
	.section	.text.stdlib.stdio.__write_byte_and_flush_if_needed,"ax",@progbits
	.type	stdlib.stdio.__write_byte_and_flush_if_needed,@function // -- Begin function stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio.__write_byte_and_flush_if_needed:       // @stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Lfunc_begin1:
	.loc	1 64 0                          // stdlib/stdio.c:64:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: stdlib.stdio.__write_byte_and_flush_if_needed:byte <- $r0
	.cfi_def_cfa_offset -8
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 0, d22
	add r22, r22, 8
stdlib.stdio..Ltmp123:
	.loc	1 65 53 prologue_end            // stdlib/stdio.c:65:53
	lw r1, zero, stdlib.stdio.__stdout_cache_write_index
	//DEBUG_VALUE: stdlib.stdio.__write_byte_and_flush_if_needed:byte <- $r0
	.loc	1 65 57 is_stmt 0               // stdlib/stdio.c:65:57
	sb r1, stdlib.stdio.__stdout_cache_buffer, r0
	.loc	1 65 53                         // stdlib/stdio.c:65:53
	add r0, r1, 1
stdlib.stdio..Ltmp124:
	sw zero, stdlib.stdio.__stdout_cache_write_index, r0
	.loc	1 66 9 is_stmt 1                // stdlib/stdio.c:66:9
	jneq r0, 8, stdlib.stdio..LBB1_2
// %bb.1:
stdlib.stdio..Ltmp125:
	.loc	1 67 9                          // stdlib/stdio.c:67:9
	call r23, stdlib.stdio.__transfer_cache_to_mram
stdlib.stdio..Ltmp126:
	.loc	1 68 36                         // stdlib/stdio.c:68:36
	move r0, stdlib.stdio.__stdout_cache_write_index
	sw r0, 0, 0
stdlib.stdio..Ltmp127:
stdlib.stdio..LBB1_2:
	.loc	1 70 1                          // stdlib/stdio.c:70:1
	ld d22, r22, -8
	jump r23
stdlib.stdio..Ltmp128:
stdlib.stdio..Lfunc_end1:
	.size	stdlib.stdio.__write_byte_and_flush_if_needed, stdlib.stdio..Lfunc_end1-stdlib.stdio.__write_byte_and_flush_if_needed
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.stdlib.stdio.__write_byte_and_flush_if_needed
	.long	stdlib.stdio..Lfunc_begin1
	.byte	8
	.section	.text.stdlib.stdio.__write_byte_and_flush_if_needed,"ax",@progbits
                                        // -- End function
	.section	.text.puts,"ax",@progbits
	.globl	puts                            // -- Begin function puts
	.type	puts,@function
puts:                                   // @puts
stdlib.stdio..Lfunc_begin2:
	.loc	1 260 0                         // stdlib/stdio.c:260:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: puts:str <- $r0
	.cfi_def_cfa_offset -16
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 8, d22
	add r22, r22, 16
	.cfi_offset 15, -16
	.cfi_offset 14, -12
	sd r22, -16, d14
	move r14, r0
stdlib.stdio..Ltmp129:
	//DEBUG_VALUE: puts:str <- $r14
	.loc	1 261 5 prologue_end            // stdlib/stdio.c:261:5
	call r23, stdlib.stdio.__open_print_sequence
stdlib.stdio..Ltmp130:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 37
	.loc	1 263 5 is_stmt 1               // stdlib/stdio.c:263:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp131:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 115
	.loc	1 264 5 is_stmt 1               // stdlib/stdio.c:264:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp132:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 0
	.loc	1 265 5 is_stmt 1               // stdlib/stdio.c:265:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp133:
	//DEBUG_VALUE: current_char_ptr <- $r14
	.loc	1 267 48                        // stdlib/stdio.c:267:48
	lbu r0, r14, 0
stdlib.stdio..Ltmp134:
	.loc	1 267 5 is_stmt 0               // stdlib/stdio.c:267:5
	jeq r0, 0, stdlib.stdio..LBB2_3
stdlib.stdio..Ltmp135:
// %bb.1:
	//DEBUG_VALUE: current_char_ptr <- $r14
	//DEBUG_VALUE: puts:str <- $r14
	add r14, r14, 1
stdlib.stdio..Ltmp136:
stdlib.stdio..LBB2_2:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: current_char_ptr <- [DW_OP_constu 1, DW_OP_minus, DW_OP_stack_value] $r14
	.loc	1 268 9 is_stmt 1               // stdlib/stdio.c:268:9
	and r0, r0, 255
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp137:
	//DEBUG_VALUE: current_char_ptr <- $r14
	.loc	1 267 48                        // stdlib/stdio.c:267:48
	lbu r0, r14, 0
stdlib.stdio..Ltmp138:
	.loc	1 267 5 is_stmt 0               // stdlib/stdio.c:267:5
	add r14, r14, 1
stdlib.stdio..Ltmp139:
	jneq r0, 0, stdlib.stdio..LBB2_2
stdlib.stdio..Ltmp140:
stdlib.stdio..LBB2_3:
	.loc	1 0 5                           // stdlib/stdio.c:0:5
	move r0, 10
	.loc	1 271 5 is_stmt 1               // stdlib/stdio.c:271:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp141:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 0
	.loc	1 272 5 is_stmt 1               // stdlib/stdio.c:272:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp142:
	.loc	1 274 5                         // stdlib/stdio.c:274:5
	call r23, stdlib.stdio.__finalized_print_sequence
stdlib.stdio..Ltmp143:
	.loc	1 275 5                         // stdlib/stdio.c:275:5
	call r23, stdlib.stdio.__close_print_sequence
stdlib.stdio..Ltmp144:
	.loc	1 276 1                         // stdlib/stdio.c:276:1
	ld d14, r22, -16
	ld d22, r22, -8
	jump r23
stdlib.stdio..Ltmp145:
stdlib.stdio..Lfunc_end2:
	.size	puts, stdlib.stdio..Lfunc_end2-puts
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.puts
	.long	stdlib.stdio..Lfunc_begin2
	.byte	16
	.section	.text.puts,"ax",@progbits
                                        // -- End function
	.section	.text.putchar,"ax",@progbits
	.globl	putchar                         // -- Begin function putchar
	.type	putchar,@function
putchar:                                // @putchar
stdlib.stdio..Lfunc_begin3:
	.loc	1 280 0                         // stdlib/stdio.c:280:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: putchar:c <- $r0
	.cfi_def_cfa_offset -16
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 8, d22
	add r22, r22, 16
	.cfi_offset 15, -16
	.cfi_offset 14, -12
	sd r22, -16, d14
	move r14, r0
stdlib.stdio..Ltmp146:
	//DEBUG_VALUE: putchar:c <- $r14
	.loc	1 281 5 prologue_end            // stdlib/stdio.c:281:5
	call r23, stdlib.stdio.__open_print_sequence
stdlib.stdio..Ltmp147:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 37
	.loc	1 283 5 is_stmt 1               // stdlib/stdio.c:283:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp148:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 99
	.loc	1 284 5 is_stmt 1               // stdlib/stdio.c:284:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp149:
	.loc	1 0 5 is_stmt 0                 // stdlib/stdio.c:0:5
	move r0, 0
	.loc	1 285 5 is_stmt 1               // stdlib/stdio.c:285:5
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp150:
	.loc	1 288 5                         // stdlib/stdio.c:288:5
	and r0, r14, 255
stdlib.stdio..Ltmp151:
	//DEBUG_VALUE: putchar:arg_as_char <- $r0
	call r23, stdlib.stdio.__write_byte_and_flush_if_needed
stdlib.stdio..Ltmp152:
	.loc	1 290 5                         // stdlib/stdio.c:290:5
	call r23, stdlib.stdio.__finalized_print_sequence
stdlib.stdio..Ltmp153:
	.loc	1 291 5                         // stdlib/stdio.c:291:5
	call r23, stdlib.stdio.__close_print_sequence
stdlib.stdio..Ltmp154:
	.loc	1 292 1                         // stdlib/stdio.c:292:1
	ld d14, r22, -16
stdlib.stdio..Ltmp155:
	ld d22, r22, -8
	jump r23
stdlib.stdio..Ltmp156:
stdlib.stdio..Lfunc_end3:
	.size	putchar, stdlib.stdio..Lfunc_end3-putchar
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.putchar
	.long	stdlib.stdio..Lfunc_begin3
	.byte	16
	.section	.text.putchar,"ax",@progbits
                                        // -- End function
	.section	.text.stdlib.stdio.__open_print_sequence,"ax",@progbits
	.type	stdlib.stdio.__open_print_sequence,@function // -- Begin function stdlib.stdio.__open_print_sequence
stdlib.stdio.__open_print_sequence:                  // @stdlib.stdio.__open_print_sequence
stdlib.stdio..Lfunc_begin4:
	.loc	1 85 0                          // stdlib/stdio.c:85:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	1 86 5 prologue_end             // stdlib/stdio.c:86:5
	// inline asm
stdlib.stdio..Ltmp157:
	acquire zero, __atomic_bit___stdout_buffer_lock, nz, stdlib.stdio..Ltmp157
	// inline asm
	.loc	1 87 32                         // stdlib/stdio.c:87:32
	move r0, stdlib.stdio.__stdout_cache_write_index
	.loc	1 89 67                         // stdlib/stdio.c:89:67
	lw r1, zero, __stdout_buffer_state
	.loc	1 87 32                         // stdlib/stdio.c:87:32
	sw r0, 0, 0
	.loc	1 88 29                         // stdlib/stdio.c:88:29
	move r0, stdlib.stdio.__stdout_nr_of_wrapping
	sw r0, 0, 0
	.loc	1 89 43                         // stdlib/stdio.c:89:43
	sw zero, stdlib.stdio.__stdout_buffer_write_pointer_initial, r1
	.loc	1 90 1                          // stdlib/stdio.c:90:1
	jump r23
stdlib.stdio..Ltmp158:
stdlib.stdio..Lfunc_end4:
	.size	stdlib.stdio.__open_print_sequence, stdlib.stdio..Lfunc_end4-stdlib.stdio.__open_print_sequence
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.stdlib.stdio.__open_print_sequence
	.long	stdlib.stdio..Lfunc_begin4
	.byte	0
	.section	.text.stdlib.stdio.__open_print_sequence,"ax",@progbits
                                        // -- End function
	.section	.text.stdlib.stdio.__transfer_cache_to_mram,"ax",@progbits
	.type	stdlib.stdio.__transfer_cache_to_mram,@function // -- Begin function stdlib.stdio.__transfer_cache_to_mram
stdlib.stdio.__transfer_cache_to_mram:               // @stdlib.stdio.__transfer_cache_to_mram
stdlib.stdio..Lfunc_begin5:
	.loc	1 47 0                          // stdlib/stdio.c:47:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	1 48 81 prologue_end            // stdlib/stdio.c:48:81
	lw r0, zero, __stdout_buffer_state
stdlib.stdio..Ltmp159:
	//DEBUG_VALUE: stdlib.stdio.__transfer_cache_to_mram:offset_in_mram <- undef
	.loc	1 51 37                         // stdlib/stdio.c:51:37
	lw r1, zero, stdlib.stdio.__stdout_buffer_size
stdlib.stdio..Ltmp160:
	.loc	1 50 30                         // stdlib/stdio.c:50:30
	add r2, r0, 8
	sw zero, __stdout_buffer_state, r2
	.loc	1 51 9                          // stdlib/stdio.c:51:9
	jltu r2, r1, stdlib.stdio..LBB5_2
stdlib.stdio..Ltmp161:
// %bb.1:
	.loc	1 54 32                         // stdlib/stdio.c:54:32
	lw r1, zero, stdlib.stdio.__stdout_nr_of_wrapping
	move r3, 0
	move r2, 1
	.loc	1 52 34                         // stdlib/stdio.c:52:34
	sd zero, __stdout_buffer_state, d2
	.loc	1 54 32                         // stdlib/stdio.c:54:32
	add r1, r1, 1
	sw zero, stdlib.stdio.__stdout_nr_of_wrapping, r1
stdlib.stdio..Ltmp162:
stdlib.stdio..LBB5_2:
	.loc	1 48 84                         // stdlib/stdio.c:48:84
	move r1, stdlib.stdio.__stdout_buffer
	add r0, r0, r1
stdlib.stdio..Ltmp163:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_write:to <- $r0
	//DEBUG_VALUE: stdlib.stdio.__transfer_cache_to_mram:offset_in_mram <- $r0
	.file	3 "/root/uPIMulator/sdk" "syslib/mram.h"
	.loc	3 53 24                         // syslib/mram.h:53:24
	move r1, stdlib.stdio.__stdout_cache_buffer
stdlib.stdio..Ltmp164:
	//DEBUG_VALUE: mram_write:from <- $r1
	sdma r1, r0, 0
stdlib.stdio..Ltmp165:
	.loc	1 58 1                          // stdlib/stdio.c:58:1
	jump r23
stdlib.stdio..Ltmp166:
stdlib.stdio..Lfunc_end5:
	.size	stdlib.stdio.__transfer_cache_to_mram, stdlib.stdio..Lfunc_end5-stdlib.stdio.__transfer_cache_to_mram
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.stdlib.stdio.__transfer_cache_to_mram
	.long	stdlib.stdio..Lfunc_begin5
	.byte	0
	.section	.text.stdlib.stdio.__transfer_cache_to_mram,"ax",@progbits
                                        // -- End function
	.section	.text.stdlib.stdio.__finalized_print_sequence,"ax",@progbits
	.type	stdlib.stdio.__finalized_print_sequence,@function // -- Begin function stdlib.stdio.__finalized_print_sequence
stdlib.stdio.__finalized_print_sequence:             // @stdlib.stdio.__finalized_print_sequence
stdlib.stdio..Lfunc_begin6:
	.loc	1 74 0                          // stdlib/stdio.c:74:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -8
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 0, d22
	add r22, r22, 8
stdlib.stdio..Ltmp167:
	.loc	1 75 36 prologue_end            // stdlib/stdio.c:75:36
	lw r1, zero, stdlib.stdio.__stdout_cache_write_index
	.loc	1 75 34 is_stmt 0               // stdlib/stdio.c:75:34
	move r0, stdlib.stdio.__stdout_cache_buffer
	add r0, r0, r1
	.loc	1 75 92                         // stdlib/stdio.c:75:92
	sub r2, 8, r1
	move r1, 0
	.loc	1 75 5                          // stdlib/stdio.c:75:5
	call r23, memset
stdlib.stdio..Ltmp168:
	.loc	1 76 5 is_stmt 1                // stdlib/stdio.c:76:5
	call r23, stdlib.stdio.__transfer_cache_to_mram
stdlib.stdio..Ltmp169:
	.loc	1 78 9                          // stdlib/stdio.c:78:9
	lw r0, zero, stdlib.stdio.__stdout_nr_of_wrapping
	.loc	1 79 9                          // stdlib/stdio.c:79:9
	jgtu r0, 1, stdlib.stdio..LBB6_3
// %bb.1:
	.loc	1 79 42 is_stmt 0               // stdlib/stdio.c:79:42
	jneq r0, 1, stdlib.stdio..LBB6_4
// %bb.2:
	.loc	1 79 67                         // stdlib/stdio.c:79:67
	lw r0, zero, __stdout_buffer_state
	.loc	1 79 72                         // stdlib/stdio.c:79:72
	lw r1, zero, stdlib.stdio.__stdout_buffer_write_pointer_initial
stdlib.stdio..Ltmp170:
	.loc	1 78 9 is_stmt 1                // stdlib/stdio.c:78:9
	jleu r0, r1, stdlib.stdio..LBB6_4
stdlib.stdio..LBB6_3:
stdlib.stdio..Ltmp171:
	.loc	1 80 9                          // stdlib/stdio.c:80:9
	// inline asm
	fault 5
	// inline asm
stdlib.stdio..Ltmp172:
stdlib.stdio..LBB6_4:
	.loc	1 81 1                          // stdlib/stdio.c:81:1
	ld d22, r22, -8
	jump r23
stdlib.stdio..Ltmp173:
stdlib.stdio..Lfunc_end6:
	.size	stdlib.stdio.__finalized_print_sequence, stdlib.stdio..Lfunc_end6-stdlib.stdio.__finalized_print_sequence
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.stdlib.stdio.__finalized_print_sequence
	.long	stdlib.stdio..Lfunc_begin6
	.byte	8
	.section	.text.stdlib.stdio.__finalized_print_sequence,"ax",@progbits
                                        // -- End function
	.section	.text.stdlib.stdio.__close_print_sequence,"ax",@progbits
	.type	stdlib.stdio.__close_print_sequence,@function // -- Begin function stdlib.stdio.__close_print_sequence
stdlib.stdio.__close_print_sequence:                 // @stdlib.stdio.__close_print_sequence
stdlib.stdio..Lfunc_begin7:
	.loc	1 96 0                          // stdlib/stdio.c:96:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	1 97 5 prologue_end             // stdlib/stdio.c:97:5
	// inline asm
stdlib.stdio..Ltmp174:
	release zero, __atomic_bit___stdout_buffer_lock, nz, stdlib.stdio..Ltmp174+1
	// inline asm
	.loc	1 98 1                          // stdlib/stdio.c:98:1
	jump r23
stdlib.stdio..Ltmp175:
stdlib.stdio..Lfunc_end7:
	.size	stdlib.stdio.__close_print_sequence, stdlib.stdio..Lfunc_end7-stdlib.stdio.__close_print_sequence
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.stdlib.stdio.__close_print_sequence
	.long	stdlib.stdio..Lfunc_begin7
	.byte	0
	.section	.text.stdlib.stdio.__close_print_sequence,"ax",@progbits
                                        // -- End function
	.type	stdlib.stdio.__stdout_buffer_size,@object    // @stdlib.stdio.__stdout_buffer_size
	.section	.data.stdlib.stdio.__stdout_buffer_size,"aw",@progbits
	.weak	stdlib.stdio.__stdout_buffer_size
	.p2align	2
stdlib.stdio.__stdout_buffer_size:
	.long	1048576                         // 0x100000
	.size	stdlib.stdio.__stdout_buffer_size, 4

	.type	stdlib.stdio.__stdout_buffer,@object         // @stdlib.stdio.__stdout_buffer
	.section	.mram.noinit,"aw",@progbits
	.weak	stdlib.stdio.__stdout_buffer
	.p2align	3
stdlib.stdio.__stdout_buffer:
	.zero	1048576
	.size	stdlib.stdio.__stdout_buffer, 1048576

	.type	__stdout_buffer_state,@object   // @__stdout_buffer_state
	.section	.data.immediate_memory.__stdout_buffer_state,"aw",@progbits
	.globl	__stdout_buffer_state
	.p2align	3
__stdout_buffer_state:
	.zero	8
	.size	__stdout_buffer_state, 8

	.type	__atomic_bit___stdout_buffer_lock,@object // @__atomic_bit___stdout_buffer_lock
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit___stdout_buffer_lock
__atomic_bit___stdout_buffer_lock:
	.byte	0                               // 0x0
	.size	__atomic_bit___stdout_buffer_lock, 1

	.type	stdlib.stdio.__stdout_cache_write_index,@object // @stdlib.stdio.__stdout_cache_write_index
	.section	.bss.stdlib.stdio.__stdout_cache_write_index,"aw",@nobits
	.p2align	2
stdlib.stdio.__stdout_cache_write_index:
	.long	0                               // 0x0
	.size	stdlib.stdio.__stdout_cache_write_index, 4

	.type	stdlib.stdio.__stdout_nr_of_wrapping,@object // @stdlib.stdio.__stdout_nr_of_wrapping
	.section	.bss.stdlib.stdio.__stdout_nr_of_wrapping,"aw",@nobits
	.p2align	2
stdlib.stdio.__stdout_nr_of_wrapping:
	.long	0                               // 0x0
	.size	stdlib.stdio.__stdout_nr_of_wrapping, 4

	.type	stdlib.stdio.__stdout_buffer_write_pointer_initial,@object // @stdlib.stdio.__stdout_buffer_write_pointer_initial
	.section	.bss.stdlib.stdio.__stdout_buffer_write_pointer_initial,"aw",@nobits
	.p2align	2
stdlib.stdio.__stdout_buffer_write_pointer_initial:
	.long	0                               // 0x0
	.size	stdlib.stdio.__stdout_buffer_write_pointer_initial, 4

	.type	stdlib.stdio.__stdout_cache_buffer,@object   // @stdlib.stdio.__stdout_cache_buffer
	.section	.bss.stdlib.stdio.__stdout_cache_buffer,"aw",@nobits
	.p2align	3
stdlib.stdio.__stdout_cache_buffer:
	.zero	8
	.size	stdlib.stdio.__stdout_cache_buffer, 8

	.file	4 "/root/uPIMulator/sdk" "stdlib/stdarg.h"
	.section	.debug_loc,"",@progbits
stdlib.stdio..Ldebug_loc0:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Lfunc_begin0-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp0-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp0-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp38-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc1:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp2-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp15-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	stdlib.stdio..Ltmp16-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp21-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	stdlib.stdio..Ltmp21-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp22-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	127                             // DW_OP_breg15
	.byte	1                               // 1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp22-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp35-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	stdlib.stdio..Ltmp37-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp60-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	stdlib.stdio..Ltmp60-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp61-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	126                             // DW_OP_breg14
	.byte	1                               // 1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp62-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp120-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc2:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp0-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp38-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp49-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp51-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc3:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp0-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp2-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp26-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp27-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp33-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp34-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc4:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp1-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp117-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	24                              // 24
	.long	stdlib.stdio..Ltmp117-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp121-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	104                             // -24
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc5:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp60-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp62-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc6:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp66-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp67-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	0                               // 0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp67-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp68-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	3                               // 3
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp68-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp71-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	1                               // 1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp71-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp76-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	2                               // 2
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp76-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp78-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	4                               // 4
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp78-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp81-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	5                               // 5
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp81-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp84-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	6                               // 6
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp84-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp88-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	17                              // DW_OP_consts
	.byte	7                               // 7
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc7:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp67-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp69-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp70-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp72-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp73-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp79-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp80-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp82-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp83-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp85-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc8:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp90-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp91-stdlib.stdio..Lfunc_begin0
	.short	6                               // Loc expr size
	.byte	81                              // sub-register DW_OP_reg1
	.byte	147                             // DW_OP_piece
	.byte	4                               // 4
	.byte	80                              // sub-register DW_OP_reg0
	.byte	147                             // DW_OP_piece
	.byte	4                               // 4
	.long	stdlib.stdio..Ltmp92-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp95-stdlib.stdio..Lfunc_begin0
	.short	6                               // Loc expr size
	.byte	81                              // sub-register DW_OP_reg1
	.byte	147                             // DW_OP_piece
	.byte	4                               // 4
	.byte	80                              // sub-register DW_OP_reg0
	.byte	147                             // DW_OP_piece
	.byte	4                               // 4
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc9:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp90-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp91-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	56                              // DW_OP_lit8
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp94-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp97-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc10:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp94-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp96-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp96-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp98-stdlib.stdio..Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	49                              // DW_OP_lit1
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc11:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp94-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp101-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	112                             // -16
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc12:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp95-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp98-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc13:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin0                   //   base address
	.long	stdlib.stdio..Ltmp107-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp109-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	stdlib.stdio..Ltmp109-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp110-stdlib.stdio..Lfunc_begin0
	.short	3                               // Loc expr size
	.byte	127                             // DW_OP_breg15
	.byte	127                             // -1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp110-stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Ltmp111-stdlib.stdio..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc14:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin1                   //   base address
	.long	stdlib.stdio..Lfunc_begin1-stdlib.stdio..Lfunc_begin1
	.long	stdlib.stdio..Ltmp124-stdlib.stdio..Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc15:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin2                   //   base address
	.long	stdlib.stdio..Lfunc_begin2-stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Ltmp129-stdlib.stdio..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp129-stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Ltmp136-stdlib.stdio..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc16:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin2                   //   base address
	.long	stdlib.stdio..Ltmp133-stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Ltmp136-stdlib.stdio..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	stdlib.stdio..Ltmp136-stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Ltmp137-stdlib.stdio..Lfunc_begin2
	.short	3                               // Loc expr size
	.byte	126                             // DW_OP_breg14
	.byte	127                             // -1
	.byte	159                             // DW_OP_stack_value
	.long	stdlib.stdio..Ltmp137-stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Ltmp139-stdlib.stdio..Lfunc_begin2
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc17:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin3                   //   base address
	.long	stdlib.stdio..Lfunc_begin3-stdlib.stdio..Lfunc_begin3
	.long	stdlib.stdio..Ltmp146-stdlib.stdio..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	stdlib.stdio..Ltmp146-stdlib.stdio..Lfunc_begin3
	.long	stdlib.stdio..Ltmp155-stdlib.stdio..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc18:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin3                   //   base address
	.long	stdlib.stdio..Ltmp151-stdlib.stdio..Lfunc_begin3
	.long	stdlib.stdio..Lfunc_end3-stdlib.stdio..Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc19:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin5                   //   base address
	.long	stdlib.stdio..Ltmp163-stdlib.stdio..Lfunc_begin5
	.long	stdlib.stdio..Lfunc_end5-stdlib.stdio..Lfunc_begin5
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
stdlib.stdio..Ldebug_loc20:
	.long	-1
	.long	stdlib.stdio..Lfunc_begin5                   //   base address
	.long	stdlib.stdio..Ltmp164-stdlib.stdio..Lfunc_begin5
	.long	stdlib.stdio..Lfunc_end5-stdlib.stdio..Lfunc_begin5
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	19                              // DW_TAG_structure_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	13                              // DW_TAG_member
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	56                              // DW_AT_data_member_location
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	15                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	16                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	17                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	18                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	19                              // Abbreviation Code
	.byte	10                              // DW_TAG_label
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	20                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	21                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	22                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	23                              // Abbreviation Code
	.byte	24                              // DW_TAG_unspecified_parameters
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	24                              // Abbreviation Code
	.ascii	"\211\202\001"                  // DW_TAG_GNU_call_site
	.byte	0                               // DW_CHILDREN_no
	.ascii	"\223B"                         // DW_AT_GNU_call_site_target
	.byte	24                              // DW_FORM_exprloc
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	25                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	26                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	5                               // DW_FORM_data2
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	27                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	5                               // DW_FORM_data2
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	28                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	5                               // DW_FORM_data2
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	29                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	0                               // DW_CHILDREN_no
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	30                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	32                              // DW_AT_inline
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	31                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	32                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	33                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.ascii	"\227B"                         // DW_AT_GNU_all_call_sites
	.byte	25                              // DW_FORM_flag_present
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	34                              // Abbreviation Code
	.byte	29                              // DW_TAG_inlined_subroutine
	.byte	1                               // DW_CHILDREN_yes
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	88                              // DW_AT_call_file
	.byte	11                              // DW_FORM_data1
	.byte	89                              // DW_AT_call_line
	.byte	11                              // DW_FORM_data1
	.byte	87                              // DW_AT_call_column
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	35                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	23                              // DW_FORM_sec_offset
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	36                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	37                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	38                              // Abbreviation Code
	.byte	55                              // DW_TAG_restrict_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	39                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	40                              // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
stdlib.stdio..Lcu_begin0:
	.long	stdlib.stdio..Ldebug_info_end0-stdlib.stdio..Ldebug_info_start0 // Length of Unit
stdlib.stdio..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x547 DW_TAG_compile_unit
	.long	stdlib.stdio..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	stdlib.stdio..Linfo_string1                  // DW_AT_name
	.long	stdlib.stdio..Lline_table_start0             // DW_AT_stmt_list
	.long	stdlib.stdio..Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	stdlib.stdio..Ldebug_ranges2                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_buffer_size
	.byte	3                               // Abbrev [3] 0x37:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string4                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	4                               // Abbrev [4] 0x3e:0x12 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string5                  // DW_AT_name
	.long	80                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_buffer
	.byte	5                               // Abbrev [5] 0x50:0xf DW_TAG_array_type
	.long	95                              // DW_AT_type
	.byte	6                               // Abbrev [6] 0x55:0x9 DW_TAG_subrange_type
	.long	102                             // DW_AT_type
	.long	1048576                         // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	3                               // Abbrev [3] 0x5f:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string6                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	7                               // Abbrev [7] 0x66:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string7                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	4                               // Abbrev [4] 0x6d:0x12 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string8                  // DW_AT_name
	.long	127                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	31                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__stdout_buffer_state
	.byte	8                               // Abbrev [8] 0x7f:0x1d DW_TAG_structure_type
	.byte	8                               // DW_AT_byte_size
	.byte	1                               // DW_AT_decl_file
	.byte	28                              // DW_AT_decl_line
	.byte	9                               // Abbrev [9] 0x83:0xc DW_TAG_member
	.long	stdlib.stdio..Linfo_string9                  // DW_AT_name
	.long	156                             // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	29                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	9                               // Abbrev [9] 0x8f:0xc DW_TAG_member
	.long	stdlib.stdio..Linfo_string11                 // DW_AT_name
	.long	156                             // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	30                              // DW_AT_decl_line
	.byte	4                               // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	10                              // Abbrev [10] 0x9c:0xb DW_TAG_typedef
	.long	55                              // DW_AT_type
	.long	stdlib.stdio..Linfo_string10                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	2                               // Abbrev [2] 0xa7:0x11 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string12                 // DW_AT_name
	.long	184                             // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	43                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit___stdout_buffer_lock
	.byte	10                              // Abbrev [10] 0xb8:0xb DW_TAG_typedef
	.long	95                              // DW_AT_type
	.long	stdlib.stdio..Linfo_string13                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	11                              // Abbrev [11] 0xc3:0x11 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string14                 // DW_AT_name
	.long	55                              // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	41                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_cache_write_index
	.byte	11                              // Abbrev [11] 0xd4:0x11 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string15                 // DW_AT_name
	.long	156                             // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	34                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_nr_of_wrapping
	.byte	11                              // Abbrev [11] 0xe5:0x11 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string16                 // DW_AT_name
	.long	156                             // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_buffer_write_pointer_initial
	.byte	12                              // Abbrev [12] 0xf6:0x12 DW_TAG_variable
	.long	stdlib.stdio..Linfo_string17                 // DW_AT_name
	.long	264                             // DW_AT_type
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	stdlib.stdio.__stdout_cache_buffer
	.byte	5                               // Abbrev [5] 0x108:0xc DW_TAG_array_type
	.long	276                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x10d:0x6 DW_TAG_subrange_type
	.long	102                             // DW_AT_type
	.byte	8                               // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	3                               // Abbrev [3] 0x114:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string18                 // DW_AT_name
	.byte	6                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	14                              // Abbrev [14] 0x11b:0x5 DW_TAG_pointer_type
	.long	276                             // DW_AT_type
	.byte	3                               // Abbrev [3] 0x120:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string19                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	15                              // Abbrev [15] 0x127:0x1 DW_TAG_pointer_type
	.byte	10                              // Abbrev [10] 0x128:0xb DW_TAG_typedef
	.long	55                              // DW_AT_type
	.long	stdlib.stdio..Linfo_string20                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	144                             // DW_AT_decl_line
	.byte	16                              // Abbrev [16] 0x133:0x224 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin0                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end0-stdlib.stdio..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string25                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	17                              // Abbrev [17] 0x144:0xf DW_TAG_formal_parameter
	.long	stdlib.stdio..Ldebug_loc0                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string33                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	1305                            // DW_AT_type
	.byte	18                              // Abbrev [18] 0x153:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc1                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string34                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	105                             // DW_AT_decl_line
	.long	283                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x162:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc2                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string35                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	104                             // DW_AT_decl_line
	.long	1320                            // DW_AT_type
	.byte	18                              // Abbrev [18] 0x171:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc3                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string37                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	103                             // DW_AT_decl_line
	.long	1320                            // DW_AT_type
	.byte	18                              // Abbrev [18] 0x180:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc4                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string38                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	109                             // DW_AT_decl_line
	.long	1327                            // DW_AT_type
	.byte	19                              // Abbrev [19] 0x18f:0xb DW_TAG_label
	.long	stdlib.stdio..Linfo_string49                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	148                             // DW_AT_decl_line
	.long	stdlib.stdio..Ltmp27                         // DW_AT_low_pc
	.byte	19                              // Abbrev [19] 0x19a:0xb DW_TAG_label
	.long	stdlib.stdio..Linfo_string50                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	242                             // DW_AT_decl_line
	.long	stdlib.stdio..Ltmp39                         // DW_AT_low_pc
	.byte	20                              // Abbrev [20] 0x1a5:0xfa DW_TAG_lexical_block
	.long	stdlib.stdio..Ldebug_ranges1                 // DW_AT_ranges
	.byte	18                              // Abbrev [18] 0x1aa:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc5                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string41                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	174                             // DW_AT_decl_line
	.long	1320                            // DW_AT_type
	.byte	21                              // Abbrev [21] 0x1b9:0x52 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp65                         // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp86-stdlib.stdio..Ltmp65                 // DW_AT_high_pc
	.byte	22                              // Abbrev [22] 0x1c2:0xb DW_TAG_variable
	.long	stdlib.stdio..Linfo_string44                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	215                             // DW_AT_decl_line
	.long	283                             // DW_AT_type
	.byte	22                              // Abbrev [22] 0x1cd:0xb DW_TAG_variable
	.long	stdlib.stdio..Linfo_string45                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	214                             // DW_AT_decl_line
	.long	1354                            // DW_AT_type
	.byte	21                              // Abbrev [21] 0x1d8:0x32 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp66                         // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp86-stdlib.stdio..Ltmp66                 // DW_AT_high_pc
	.byte	18                              // Abbrev [18] 0x1e1:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc6                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string42                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	216                             // DW_AT_decl_line
	.long	1347                            // DW_AT_type
	.byte	21                              // Abbrev [21] 0x1f0:0x19 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp66                         // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp86-stdlib.stdio..Ltmp66                 // DW_AT_high_pc
	.byte	18                              // Abbrev [18] 0x1f9:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc7                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string47                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	217                             // DW_AT_decl_line
	.long	276                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	21                              // Abbrev [21] 0x20b:0x65 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp88                         // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp101-stdlib.stdio..Ltmp88                // DW_AT_high_pc
	.byte	18                              // Abbrev [18] 0x214:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc8                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string45                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	224                             // DW_AT_decl_line
	.long	288                             // DW_AT_type
	.byte	18                              // Abbrev [18] 0x223:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc9                    // DW_AT_location
	.long	stdlib.stdio..Linfo_string48                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	223                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	18                              // Abbrev [18] 0x232:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc11                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string44                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	234                             // DW_AT_decl_line
	.long	283                             // DW_AT_type
	.byte	21                              // Abbrev [21] 0x241:0x2e DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp94                         // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp101-stdlib.stdio..Ltmp94                // DW_AT_high_pc
	.byte	18                              // Abbrev [18] 0x24a:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc10                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string42                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	235                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	20                              // Abbrev [20] 0x259:0x15 DW_TAG_lexical_block
	.long	stdlib.stdio..Ldebug_ranges0                 // DW_AT_ranges
	.byte	18                              // Abbrev [18] 0x25e:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc12                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string47                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	236                             // DW_AT_decl_line
	.long	276                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	21                              // Abbrev [21] 0x270:0x15 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp103                        // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp104-stdlib.stdio..Ltmp103               // DW_AT_high_pc
	.byte	22                              // Abbrev [22] 0x279:0xb DW_TAG_variable
	.long	stdlib.stdio..Linfo_string51                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	204                             // DW_AT_decl_line
	.long	276                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	21                              // Abbrev [21] 0x285:0x19 DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp106                        // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp113-stdlib.stdio..Ltmp106               // DW_AT_high_pc
	.byte	18                              // Abbrev [18] 0x28e:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc13                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string44                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	195                             // DW_AT_decl_line
	.long	283                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x29f:0x1 DW_TAG_unspecified_parameters
	.byte	24                              // Abbrev [24] 0x2a0:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp1                          // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2a7:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp12                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2ae:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp14                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2b5:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp21                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2bc:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp26                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2c3:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp31                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2ca:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp33                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2d1:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp36                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2d8:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp40                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2df:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp51                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2e6:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp68                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2ed:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp71                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2f4:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp74                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x2fb:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp76                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x302:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp78                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x309:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp81                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x310:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp84                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x317:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp87                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x31e:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp96                         // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x325:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp100                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x32c:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp105                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x333:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp110                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x33a:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp113                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x341:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp117                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x348:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp118                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x34f:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp119                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	25                              // Abbrev [25] 0x357:0x28 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin1                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end1-stdlib.stdio..Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string26                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	63                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	17                              // Abbrev [17] 0x368:0xf DW_TAG_formal_parameter
	.long	stdlib.stdio..Ldebug_loc14                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string52                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	63                              // DW_AT_decl_line
	.long	184                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x377:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp126                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	26                              // Abbrev [26] 0x37f:0x7c DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin2                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end2-stdlib.stdio..Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string27                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	259                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	27                              // Abbrev [27] 0x391:0x10 DW_TAG_formal_parameter
	.long	stdlib.stdio..Ldebug_loc15                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string53                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	259                             // DW_AT_decl_line
	.long	1310                            // DW_AT_type
	.byte	21                              // Abbrev [21] 0x3a1:0x1a DW_TAG_lexical_block
	.long	stdlib.stdio..Ltmp133                        // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp140-stdlib.stdio..Ltmp133               // DW_AT_high_pc
	.byte	28                              // Abbrev [28] 0x3aa:0x10 DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc16                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string54                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	267                             // DW_AT_decl_line
	.long	283                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	24                              // Abbrev [24] 0x3bb:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp130                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3c2:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp131                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3c9:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp132                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3d0:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp133                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3d7:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp137                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3de:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp141                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3e5:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp142                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3ec:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp143                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x3f3:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp144                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	26                              // Abbrev [26] 0x3fb:0x64 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin3                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end3-stdlib.stdio..Lfunc_begin3       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string28                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	279                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	27                              // Abbrev [27] 0x40d:0x10 DW_TAG_formal_parameter
	.long	stdlib.stdio..Ldebug_loc17                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string55                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	279                             // DW_AT_decl_line
	.long	1347                            // DW_AT_type
	.byte	28                              // Abbrev [28] 0x41d:0x10 DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc18                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string51                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.short	287                             // DW_AT_decl_line
	.long	276                             // DW_AT_type
	.byte	24                              // Abbrev [24] 0x42d:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp147                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x434:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp148                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x43b:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp149                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x442:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp150                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x449:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp152                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x450:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp153                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x457:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp154                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	29                              // Abbrev [29] 0x45f:0x11 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin4                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end4-stdlib.stdio..Lfunc_begin4       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string29                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	84                              // DW_AT_decl_line
	.byte	30                              // Abbrev [30] 0x470:0x2a DW_TAG_subprogram
	.long	stdlib.stdio..Linfo_string21                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	31                              // Abbrev [31] 0x478:0xb DW_TAG_formal_parameter
	.long	stdlib.stdio..Linfo_string22                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	1178                            // DW_AT_type
	.byte	31                              // Abbrev [31] 0x483:0xb DW_TAG_formal_parameter
	.long	stdlib.stdio..Linfo_string23                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	295                             // DW_AT_type
	.byte	31                              // Abbrev [31] 0x48e:0xb DW_TAG_formal_parameter
	.long	stdlib.stdio..Linfo_string24                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	51                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	14                              // Abbrev [14] 0x49a:0x5 DW_TAG_pointer_type
	.long	1183                            // DW_AT_type
	.byte	32                              // Abbrev [32] 0x49f:0x1 DW_TAG_const_type
	.byte	33                              // Abbrev [33] 0x4a0:0x48 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin5                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end5-stdlib.stdio..Lfunc_begin5       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string30                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	46                              // DW_AT_decl_line
	.byte	18                              // Abbrev [18] 0x4b1:0xf DW_TAG_variable
	.long	stdlib.stdio..Ldebug_loc19                   // DW_AT_location
	.long	stdlib.stdio..Linfo_string56                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.long	295                             // DW_AT_type
	.byte	34                              // Abbrev [34] 0x4c0:0x27 DW_TAG_inlined_subroutine
	.long	1136                            // DW_AT_abstract_origin
	.long	stdlib.stdio..Ltmp163                        // DW_AT_low_pc
	.long	stdlib.stdio..Ltmp165-stdlib.stdio..Ltmp163               // DW_AT_high_pc
	.byte	1                               // DW_AT_call_file
	.byte	57                              // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	35                              // Abbrev [35] 0x4d0:0x9 DW_TAG_formal_parameter
	.long	stdlib.stdio..Ldebug_loc20                   // DW_AT_location
	.long	1144                            // DW_AT_abstract_origin
	.byte	36                              // Abbrev [36] 0x4d9:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	1155                            // DW_AT_abstract_origin
	.byte	37                              // Abbrev [37] 0x4e0:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	1166                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	33                              // Abbrev [33] 0x4e8:0x20 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin6                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end6-stdlib.stdio..Lfunc_begin6       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string31                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	73                              // DW_AT_decl_line
	.byte	24                              // Abbrev [24] 0x4f9:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp168                        // DW_AT_low_pc
	.byte	24                              // Abbrev [24] 0x500:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	stdlib.stdio..Ltmp169                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	29                              // Abbrev [29] 0x508:0x11 DW_TAG_subprogram
	.long	stdlib.stdio..Lfunc_begin7                   // DW_AT_low_pc
	.long	stdlib.stdio..Lfunc_end7-stdlib.stdio..Lfunc_begin7       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	stdlib.stdio..Linfo_string32                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	95                              // DW_AT_decl_line
	.byte	38                              // Abbrev [38] 0x519:0x5 DW_TAG_restrict_type
	.long	1310                            // DW_AT_type
	.byte	14                              // Abbrev [14] 0x51e:0x5 DW_TAG_pointer_type
	.long	1315                            // DW_AT_type
	.byte	39                              // Abbrev [39] 0x523:0x5 DW_TAG_const_type
	.long	276                             // DW_AT_type
	.byte	3                               // Abbrev [3] 0x528:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string36                 // DW_AT_name
	.byte	2                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	10                              // Abbrev [10] 0x52f:0xb DW_TAG_typedef
	.long	1338                            // DW_AT_type
	.long	stdlib.stdio..Linfo_string40                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	30                              // DW_AT_decl_line
	.byte	40                              // Abbrev [40] 0x53a:0x9 DW_TAG_typedef
	.long	295                             // DW_AT_type
	.long	stdlib.stdio..Linfo_string39                 // DW_AT_name
	.byte	3                               // Abbrev [3] 0x543:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string43                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // Abbrev [3] 0x54a:0x7 DW_TAG_base_type
	.long	stdlib.stdio..Linfo_string46                 // DW_AT_name
	.byte	4                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	0                               // End Of Children Mark
stdlib.stdio..Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
stdlib.stdio..Ldebug_ranges0:
	.long	stdlib.stdio..Ltmp94
	.long	stdlib.stdio..Ltmp96
	.long	stdlib.stdio..Ltmp98
	.long	stdlib.stdio..Ltmp100
	.long	0
	.long	0
stdlib.stdio..Ldebug_ranges1:
	.long	stdlib.stdio..Ltmp44
	.long	stdlib.stdio..Ltmp101
	.long	stdlib.stdio..Ltmp103
	.long	stdlib.stdio..Ltmp113
	.long	0
	.long	0
stdlib.stdio..Ldebug_ranges2:
	.long	stdlib.stdio..Lfunc_begin0
	.long	stdlib.stdio..Lfunc_end0
	.long	stdlib.stdio..Lfunc_begin1
	.long	stdlib.stdio..Lfunc_end1
	.long	stdlib.stdio..Lfunc_begin2
	.long	stdlib.stdio..Lfunc_end2
	.long	stdlib.stdio..Lfunc_begin3
	.long	stdlib.stdio..Lfunc_end3
	.long	stdlib.stdio..Lfunc_begin4
	.long	stdlib.stdio..Lfunc_end4
	.long	stdlib.stdio..Lfunc_begin5
	.long	stdlib.stdio..Lfunc_end5
	.long	stdlib.stdio..Lfunc_begin6
	.long	stdlib.stdio..Lfunc_end6
	.long	stdlib.stdio..Lfunc_begin7
	.long	stdlib.stdio..Lfunc_end7
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
stdlib.stdio..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
stdlib.stdio..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/stdlib/stdio.c" // string offset=106
stdlib.stdio..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=142
stdlib.stdio..Linfo_string3:
	.asciz	"__stdout_buffer_size"          // string offset=169
stdlib.stdio..Linfo_string4:
	.asciz	"unsigned int"                  // string offset=190
stdlib.stdio..Linfo_string5:
	.asciz	"__stdout_buffer"               // string offset=203
stdlib.stdio..Linfo_string6:
	.asciz	"unsigned char"                 // string offset=219
stdlib.stdio..Linfo_string7:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=233
stdlib.stdio..Linfo_string8:
	.asciz	"__stdout_buffer_state"         // string offset=253
stdlib.stdio..Linfo_string9:
	.asciz	"wp"                            // string offset=275
stdlib.stdio..Linfo_string10:
	.asciz	"uint32_t"                      // string offset=278
stdlib.stdio..Linfo_string11:
	.asciz	"has_wrapped"                   // string offset=287
stdlib.stdio..Linfo_string12:
	.asciz	"__atomic_bit___stdout_buffer_lock" // string offset=299
stdlib.stdio..Linfo_string13:
	.asciz	"uint8_t"                       // string offset=333
stdlib.stdio..Linfo_string14:
	.asciz	"__stdout_cache_write_index"    // string offset=341
stdlib.stdio..Linfo_string15:
	.asciz	"__stdout_nr_of_wrapping"       // string offset=368
stdlib.stdio..Linfo_string16:
	.asciz	"__stdout_buffer_write_pointer_initial" // string offset=392
stdlib.stdio..Linfo_string17:
	.asciz	"__stdout_cache_buffer"         // string offset=430
stdlib.stdio..Linfo_string18:
	.asciz	"char"                          // string offset=452
stdlib.stdio..Linfo_string19:
	.asciz	"long int"                      // string offset=457
stdlib.stdio..Linfo_string20:
	.asciz	"uintptr_t"                     // string offset=466
stdlib.stdio..Linfo_string21:
	.asciz	"mram_write"                    // string offset=476
stdlib.stdio..Linfo_string22:
	.asciz	"from"                          // string offset=487
stdlib.stdio..Linfo_string23:
	.asciz	"to"                            // string offset=492
stdlib.stdio..Linfo_string24:
	.asciz	"nb_of_bytes"                   // string offset=495
stdlib.stdio..Linfo_string25:
	.asciz	"printf"                        // string offset=507
stdlib.stdio..Linfo_string26:
	.asciz	"__write_byte_and_flush_if_needed" // string offset=514
stdlib.stdio..Linfo_string27:
	.asciz	"puts"                          // string offset=547
stdlib.stdio..Linfo_string28:
	.asciz	"putchar"                       // string offset=552
stdlib.stdio..Linfo_string29:
	.asciz	"__open_print_sequence"         // string offset=560
stdlib.stdio..Linfo_string30:
	.asciz	"__transfer_cache_to_mram"      // string offset=582
stdlib.stdio..Linfo_string31:
	.asciz	"__finalized_print_sequence"    // string offset=607
stdlib.stdio..Linfo_string32:
	.asciz	"__close_print_sequence"        // string offset=634
stdlib.stdio..Linfo_string33:
	.asciz	"format"                        // string offset=657
stdlib.stdio..Linfo_string34:
	.asciz	"current_format_char_ptr"       // string offset=664
stdlib.stdio..Linfo_string35:
	.asciz	"insert_string_arg_end_character" // string offset=688
stdlib.stdio..Linfo_string36:
	.asciz	"_Bool"                         // string offset=720
stdlib.stdio..Linfo_string37:
	.asciz	"insert_string_arg"             // string offset=726
stdlib.stdio..Linfo_string38:
	.asciz	"args"                          // string offset=744
stdlib.stdio..Linfo_string39:
	.asciz	"__builtin_va_list"             // string offset=749
stdlib.stdio..Linfo_string40:
	.asciz	"va_list"                       // string offset=767
stdlib.stdio..Linfo_string41:
	.asciz	"arg_is_64_bits"                // string offset=775
stdlib.stdio..Linfo_string42:
	.asciz	"i"                             // string offset=790
stdlib.stdio..Linfo_string43:
	.asciz	"int"                           // string offset=792
stdlib.stdio..Linfo_string44:
	.asciz	"arg"                           // string offset=796
stdlib.stdio..Linfo_string45:
	.asciz	"val"                           // string offset=800
stdlib.stdio..Linfo_string46:
	.asciz	"double"                        // string offset=804
stdlib.stdio..Linfo_string47:
	.asciz	"arg_byte"                      // string offset=811
stdlib.stdio..Linfo_string48:
	.asciz	"arg_size_in_bytes"             // string offset=820
stdlib.stdio..Linfo_string49:
	.asciz	"standard_character_format_process" // string offset=838
stdlib.stdio..Linfo_string50:
	.asciz	"standard_character_process"    // string offset=872
stdlib.stdio..Linfo_string51:
	.asciz	"arg_as_char"                   // string offset=899
stdlib.stdio..Linfo_string52:
	.asciz	"byte"                          // string offset=911
stdlib.stdio..Linfo_string53:
	.asciz	"str"                           // string offset=916
stdlib.stdio..Linfo_string54:
	.asciz	"current_char_ptr"              // string offset=920
stdlib.stdio..Linfo_string55:
	.asciz	"c"                             // string offset=937
stdlib.stdio..Linfo_string56:
	.asciz	"offset_in_mram"                // string offset=939
	.addrsig
	.addrsig_sym stdlib.stdio.__stdout_buffer
	.addrsig_sym __stdout_buffer_state
	.addrsig_sym __atomic_bit___stdout_buffer_lock
	.addrsig_sym stdlib.stdio.__stdout_cache_buffer
	.section	.debug_line,"",@progbits
stdlib.stdio..Lline_table_start0:
	.text
	.file	"errno.c"
	.file	1 "/root/uPIMulator/sdk" "stdlib/errno.c"
	.type	__errno,@object                 // @__errno
	.section	.bss.__errno,"aw",@nobits
	.globl	__errno
	.p2align	2
__errno:
	.zero	96
	.size	__errno, 96

	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
stdlib.errno..Lcu_begin0:
	.long	stdlib.errno..Ldebug_info_end0-stdlib.errno..Ldebug_info_start0 // Length of Unit
stdlib.errno..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x3f DW_TAG_compile_unit
	.long	stdlib.errno..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	stdlib.errno..Linfo_string1                  // DW_AT_name
	.long	stdlib.errno..Lline_table_start0             // DW_AT_stmt_list
	.long	stdlib.errno..Linfo_string2                  // DW_AT_comp_dir
	.byte	2                               // Abbrev [2] 0x1e:0x11 DW_TAG_variable
	.long	stdlib.errno..Linfo_string3                  // DW_AT_name
	.long	47                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	6                               // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__errno
	.byte	3                               // Abbrev [3] 0x2f:0xc DW_TAG_array_type
	.long	59                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x34:0x6 DW_TAG_subrange_type
	.long	66                              // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x3b:0x7 DW_TAG_base_type
	.long	stdlib.errno..Linfo_string4                  // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	6                               // Abbrev [6] 0x42:0x7 DW_TAG_base_type
	.long	stdlib.errno..Linfo_string5                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	0                               // End Of Children Mark
stdlib.errno..Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
stdlib.errno..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
stdlib.errno..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/stdlib/errno.c" // string offset=106
stdlib.errno..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=142
stdlib.errno..Linfo_string3:
	.asciz	"__errno"                       // string offset=169
stdlib.errno..Linfo_string4:
	.asciz	"int"                           // string offset=177
stdlib.errno..Linfo_string5:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=181
	.addrsig
	.section	.debug_line,"",@progbits
stdlib.errno..Lline_table_start0:
	.text
	.file	"waitqueue.c"
	.file	1 "/root/uPIMulator/sdk" "syslib/waitqueue.c"
	.type	__sys_wq_table,@object          // @__sys_wq_table
	.section	.data.__sys_wq_table,"aw",@progbits
	.globl	__sys_wq_table
__sys_wq_table:
	.zero	24,255
	.size	__sys_wq_table, 24

	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
syslib.waitqueue..Lcu_begin0:
	.long	syslib.waitqueue..Ldebug_info_end0-syslib.waitqueue..Ldebug_info_start0 // Length of Unit
syslib.waitqueue..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x3f DW_TAG_compile_unit
	.long	syslib.waitqueue..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.waitqueue..Linfo_string1                  // DW_AT_name
	.long	syslib.waitqueue..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.waitqueue..Linfo_string2                  // DW_AT_comp_dir
	.byte	2                               // Abbrev [2] 0x1e:0x11 DW_TAG_variable
	.long	syslib.waitqueue..Linfo_string3                  // DW_AT_name
	.long	47                              // DW_AT_type
                                        // DW_AT_external
	.byte	1                               // DW_AT_decl_file
	.byte	8                               // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__sys_wq_table
	.byte	3                               // Abbrev [3] 0x2f:0xc DW_TAG_array_type
	.long	59                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x34:0x6 DW_TAG_subrange_type
	.long	66                              // DW_AT_type
	.byte	24                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x3b:0x7 DW_TAG_base_type
	.long	syslib.waitqueue..Linfo_string4                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	6                               // Abbrev [6] 0x42:0x7 DW_TAG_base_type
	.long	syslib.waitqueue..Linfo_string5                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	0                               // End Of Children Mark
syslib.waitqueue..Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
syslib.waitqueue..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.waitqueue..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/waitqueue.c" // string offset=106
syslib.waitqueue..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=146
syslib.waitqueue..Linfo_string3:
	.asciz	"__sys_wq_table"                // string offset=173
syslib.waitqueue..Linfo_string4:
	.asciz	"unsigned char"                 // string offset=188
syslib.waitqueue..Linfo_string5:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=202
	.addrsig
	.addrsig_sym __sys_wq_table
	.section	.debug_line,"",@progbits
syslib.waitqueue..Lline_table_start0:
