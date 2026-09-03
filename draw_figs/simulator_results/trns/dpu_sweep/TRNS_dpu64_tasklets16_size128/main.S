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
	.file	1 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/stdlib/stdint.h"
	.file	2 "/root/uPIMulator/benchmark" "TRNS/dpu/task.c"
	.file	3 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h"
	.file	4 "/root/uPIMulator/benchmark" "TRNS/dpu/../support/common.h"
	.section	.text.main_kernel1,"ax",@progbits
	.globl	main_kernel1                    // -- Begin function main_kernel1
	.type	main_kernel1,@function
main_kernel1:                           // @main_kernel1
.Lfunc_begin0:
	.loc	2 46 0                          // TRNS/dpu/task.c:46:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -64
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 56, d22
	add r22, r22, 64
	.cfi_offset 15, -40
	.cfi_offset 14, -36
.Ltmp0:
	sd r22, -40, d14
	.cfi_offset 17, -48
	.cfi_offset 16, -44
	sd r22, -48, d16
	.cfi_offset 19, -56
	.cfi_offset 18, -52
	sd r22, -56, d18
	.cfi_offset 21, -64
	.cfi_offset 20, -60
	sd r22, -64, d20
.Ltmp1:
	//DEBUG_VALUE: main_kernel1:tasklet_id <- $r14
	.file	5 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/defs.h"
	.loc	5 35 12 prologue_end            // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/defs.h:35:12
	move r14, id, nz, .LBB0_2
.Ltmp2:
// %bb.1:
	.loc	2 52 9                          // TRNS/dpu/task.c:52:9
	call r23, mem_reset
.Ltmp3:
.LBB0_2:
	.loc	2 55 5                          // TRNS/dpu/task.c:55:5
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp4:
	.loc	2 58 39                         // TRNS/dpu/task.c:58:39
	move r0, DPU_INPUT_ARGUMENTS
	.loc	2 59 38                         // TRNS/dpu/task.c:59:38
	lw r15, zero, DPU_INPUT_ARGUMENTS
.Ltmp5:
	//DEBUG_VALUE: main_kernel1:m <- $r15
	.loc	2 60 38                         // TRNS/dpu/task.c:60:38
	lw r18, r0, 4
.Ltmp6:
	//DEBUG_VALUE: main_kernel1:n <- $r18
	.loc	2 58 39                         // TRNS/dpu/task.c:58:39
	lw r16, r0, 8
.Ltmp7:
	//DEBUG_VALUE: main_kernel1:M_ <- $r16
	.loc	2 62 32                         // TRNS/dpu/task.c:62:32
	move r0, r18
	move r1, r15
	call r23, __mulsi3
.Ltmp8:
	move r17, r0
	.loc	2 62 36 is_stmt 0               // TRNS/dpu/task.c:62:36
	lsl r19, r17, 3
	.loc	2 62 20                         // TRNS/dpu/task.c:62:20
	move r0, r19
	call r23, mem_alloc
.Ltmp9:
	move r1, r0
.Ltmp10:
	//DEBUG_VALUE: main_kernel1:data <- $r1
	.loc	2 63 22 is_stmt 1               // TRNS/dpu/task.c:63:22
	move r0, r19
	move r19, r1
.Ltmp11:
	//DEBUG_VALUE: main_kernel1:data <- $r19
	call r23, mem_alloc
.Ltmp12:
	move r20, r0
.Ltmp13:
	//DEBUG_VALUE: main_kernel1:A <- undef
	//DEBUG_VALUE: main_kernel1:backup <- $r20
	sw r22, -16, r16
.Ltmp14:
	//DEBUG_VALUE: tile <- $r14
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	.loc	2 65 5                          // TRNS/dpu/task.c:65:5
	jgeu r14, r16, .LBB0_8
.Ltmp15:
// %bb.3:
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:backup <- $r20
	//DEBUG_VALUE: main_kernel1:data <- $r19
	//DEBUG_VALUE: main_kernel1:n <- $r18
	//DEBUG_VALUE: main_kernel1:m <- $r15
	//DEBUG_VALUE: tile <- $r14
	.loc	2 0 5 is_stmt 0                 // TRNS/dpu/task.c:0:5
	add r0, r17, -1
	sw r22, -32, r0
	sw r22, -28, r18
	jump .LBB0_4
.Ltmp16:
.LBB0_7:                                //   in Loop: Header=BB0_4 Depth=1
	//DEBUG_VALUE: tile <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:m <- $r15
	.loc	2 70 9 is_stmt 1                // TRNS/dpu/task.c:70:9
	move r0, __sys_used_mram_end
	lw r1, r22, -20
	move r20, r18
	move r2, r20
	move r3, r15
	lw r18, r22, -28
	move r4, r18
	call r23, write_tile_step2
.Ltmp17:
	.loc	2 0 9 is_stmt 0                 // TRNS/dpu/task.c:0:9
	lw r14, r22, -24
.Ltmp18:
	.loc	2 65 57 is_stmt 1               // TRNS/dpu/task.c:65:57
	add r14, r14, 16
.Ltmp19:
	//DEBUG_VALUE: tile <- $r14
	.loc	2 65 5 is_stmt 0                // TRNS/dpu/task.c:65:5
	lw r0, r22, -16
	jgeu r14, r0, .LBB0_8
.Ltmp20:
.LBB0_4:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_6 Depth 2
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:m <- $r15
	//DEBUG_VALUE: tile <- $r14
	//DEBUG_VALUE: tile <- $r14
	.loc	2 66 37 is_stmt 1               // TRNS/dpu/task.c:66:37
	move r0, r17
	sw r22, -24, r14
.Ltmp21:
	//DEBUG_VALUE: tile <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	move r1, r14
	call r23, __mulsi3
.Ltmp22:
	move r1, r0
	.loc	2 66 9 is_stmt 0                // TRNS/dpu/task.c:66:9
	move r0, __sys_used_mram_end
	sw r22, -20, r1
	move r2, r19
	move r3, r15
	move r4, r18
	call r23, read_tile_step2
.Ltmp23:
	.loc	2 0 9                           // TRNS/dpu/task.c:0:9
	move r18, r20
	lw r0, r22, -32
.Ltmp24:
	//DEBUG_VALUE: i <- 0
	.loc	2 67 9 is_stmt 1                // TRNS/dpu/task.c:67:9
	jeq r17, 0, .LBB0_7
.Ltmp25:
// %bb.5:                               //   in Loop: Header=BB0_4 Depth=1
	//DEBUG_VALUE: tile <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:m <- $r15
	//DEBUG_VALUE: i <- 0
	.loc	2 0 9 is_stmt 0                 // TRNS/dpu/task.c:0:9
	move r21, 0
.Ltmp26:
.LBB0_6:                                //   Parent Loop BB0_4 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	//DEBUG_VALUE: tile <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:m <- $r15
	//DEBUG_VALUE: i <- $r21
	.loc	2 68 55 is_stmt 1               // TRNS/dpu/task.c:68:55
	lsl_add r0, r19, r21, 3
	move r20, r19
	move r19, r17
	ld d16, r0, 0
	.loc	2 68 23 is_stmt 0               // TRNS/dpu/task.c:68:23
	move r0, r21
	move r1, r15
	call r23, __mulsi3
.Ltmp27:
	move r14, r0
	.loc	2 68 47                         // TRNS/dpu/task.c:68:47
	move r0, r21
	lw r1, r22, -28
	call r23, __udiv32
.Ltmp28:
	.loc	2 68 42                         // TRNS/dpu/task.c:68:42
	lw r1, r22, -32
	call r23, __mulsi3
.Ltmp29:
	.loc	2 68 28                         // TRNS/dpu/task.c:68:28
	sub r0, r14, r0
	.loc	2 68 13                         // TRNS/dpu/task.c:68:13
	lsl_add r0, r18, r0, 3
.Ltmp30:
	.loc	2 67 46 is_stmt 1               // TRNS/dpu/task.c:67:46
	add r21, r21, 1
.Ltmp31:
	//DEBUG_VALUE: i <- $r21
	.loc	2 68 53                         // TRNS/dpu/task.c:68:53
	sd r0, 0, d16
	move r17, r19
	move r19, r20
.Ltmp32:
	.loc	2 67 9                          // TRNS/dpu/task.c:67:9
	jneq r17, r21, .LBB0_6
	jump .LBB0_7
.Ltmp33:
.LBB0_8:
	//DEBUG_VALUE: main_kernel1:M_ <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel1:m <- $r15
	.loc	2 0 9 is_stmt 0                 // TRNS/dpu/task.c:0:9
	move r0, 0
	.loc	2 73 5 is_stmt 1                // TRNS/dpu/task.c:73:5
	ld d20, r22, -64
	ld d18, r22, -56
	ld d16, r22, -48
	ld d14, r22, -40
.Ltmp34:
	ld d22, r22, -8
.Ltmp35:
	jump r23
.Ltmp36:
.Lfunc_end0:
	.size	main_kernel1, .Lfunc_end0-main_kernel1
	.cfi_endproc
	.file	6 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/sysdef.h"
	.section	.stack_sizes,"o",@progbits,.text.main_kernel1
	.long	.Lfunc_begin0
	.byte	64
	.section	.text.main_kernel1,"ax",@progbits
                                        // -- End function
	.section	.text.main_kernel2,"ax",@progbits
	.globl	main_kernel2                    // -- Begin function main_kernel2
	.type	main_kernel2,@function
main_kernel2:                           // @main_kernel2
.Lfunc_begin1:
	.loc	2 77 0                          // TRNS/dpu/task.c:77:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -56
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 48, d22
	add r22, r22, 56
	.cfi_offset 15, -32
	.cfi_offset 14, -28
.Ltmp37:
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
.Ltmp38:
	//DEBUG_VALUE: main_kernel2:tasklet_id <- $r0
	.loc	5 35 12 prologue_end            // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/defs.h:35:12
	move r0, id, nz, .LBB1_2
.Ltmp39:
// %bb.1:
	.loc	2 83 9                          // TRNS/dpu/task.c:83:9
	call r23, mem_reset
.Ltmp40:
.LBB1_2:
	.loc	2 86 5                          // TRNS/dpu/task.c:86:5
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp41:
	.loc	2 89 38                         // TRNS/dpu/task.c:89:38
	move r0, DPU_INPUT_ARGUMENTS
	.loc	2 90 38                         // TRNS/dpu/task.c:90:38
	lw r1, r0, 4
.Ltmp42:
	//DEBUG_VALUE: main_kernel2:n <- $r1
	.loc	2 91 39                         // TRNS/dpu/task.c:91:39
	lw r0, r0, 8
.Ltmp43:
	//DEBUG_VALUE: main_kernel2:M_ <- $r0
	.loc	2 89 38                         // TRNS/dpu/task.c:89:38
	lw r16, zero, DPU_INPUT_ARGUMENTS
.Ltmp44:
	//DEBUG_VALUE: main_kernel2:m <- $r16
	sw r22, -20, r0
.Ltmp45:
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	sw r22, -24, r1
.Ltmp46:
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	.loc	2 92 65                         // TRNS/dpu/task.c:92:65
	call r23, __mulsi3
.Ltmp47:
	move r15, r0
	.loc	2 92 73 is_stmt 0               // TRNS/dpu/task.c:92:73
	move r1, r16
	call r23, __mulsi3
.Ltmp48:
	move r14, r0
.Ltmp49:
	//DEBUG_VALUE: main_kernel2:done_array <- undef
	.loc	2 94 38 is_stmt 1               // TRNS/dpu/task.c:94:38
	add r17, r15, -1
.Ltmp50:
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	.loc	2 96 39                         // TRNS/dpu/task.c:96:39
	lsl r15, r16, 3
	.loc	2 96 19 is_stmt 0               // TRNS/dpu/task.c:96:19
	move r0, r15
	call r23, mem_alloc
.Ltmp51:
	move r18, r0
.Ltmp52:
	//DEBUG_VALUE: main_kernel2:data <- $r18
	.loc	2 97 21 is_stmt 1               // TRNS/dpu/task.c:97:21
	move r0, r15
	call r23, mem_alloc
.Ltmp53:
	move r19, r0
.Ltmp54:
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	.loc	2 0 21 is_stmt 0                // TRNS/dpu/task.c:0:21
	move r0, 8
	.loc	2 98 24 is_stmt 1               // TRNS/dpu/task.c:98:24
	call r23, mem_alloc
.Ltmp55:
	sw r22, -16, r0
.Ltmp56:
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	.loc	2 103 12                        // TRNS/dpu/task.c:103:12
	call r23, get_tile
.Ltmp57:
	move r15, r0
.Ltmp58:
	//DEBUG_VALUE: main_kernel2:A <- undef
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	.loc	2 105 5                         // TRNS/dpu/task.c:105:5
	jgeu r15, r17, .LBB1_11
.Ltmp59:
// %bb.3:
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	.loc	2 0 5 is_stmt 0                 // TRNS/dpu/task.c:0:5
	move r0, __sys_used_mram_end
.Ltmp60:
	//DEBUG_VALUE: main_kernel2:done_array <- $r21
	lsl_add r21, r0, r14, 3, true, .LBB1_4
.Ltmp61:
.LBB1_10:                               //   in Loop: Header=BB1_4 Depth=1
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: next_in_cycle <- $r14
	call r23, get_tile
.Ltmp62:
	move r15, r0
.Ltmp63:
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	.loc	2 105 5                         // TRNS/dpu/task.c:105:5
	jgeu r15, r17, .LBB1_11
.Ltmp64:
.LBB1_4:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB1_6 Depth 2
                                        //       Child Loop BB1_12 Depth 3
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	.loc	2 106 41 is_stmt 1              // TRNS/dpu/task.c:106:41
	move r0, r15
	lw r1, r22, -20
	call r23, __mulsi3
.Ltmp65:
	move r14, r0
	.loc	2 106 66 is_stmt 0              // TRNS/dpu/task.c:106:66
	move r0, r15
	lw r1, r22, -24
	call r23, __udiv32
.Ltmp66:
	.loc	2 106 58                        // TRNS/dpu/task.c:106:58
	move r1, r17
	call r23, __mulsi3
.Ltmp67:
	.loc	2 106 47                        // TRNS/dpu/task.c:106:47
	sub r14, r14, r0
.Ltmp68:
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 107 13 is_stmt 1              // TRNS/dpu/task.c:107:13
	jeq r14, r15, .LBB1_10
.Ltmp69:
// %bb.5:                               //   in Loop: Header=BB1_4 Depth=1
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 111 33                        // TRNS/dpu/task.c:111:33
	move r0, r15
	move r1, r16
	call r23, __mulsi3
.Ltmp70:
	move r1, r0
	.loc	2 111 9 is_stmt 0               // TRNS/dpu/task.c:111:9
	move r0, __sys_used_mram_end
	move r2, r18
	move r3, r16
	call r23, read_tile_step3
.Ltmp71:
	.loc	2 113 16 is_stmt 1              // TRNS/dpu/task.c:113:16
	move r0, r21
	move r1, r15
	lw r2, r22, -16
	call r23, get_done
.Ltmp72:
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r0
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 114 9                         // TRNS/dpu/task.c:114:9
	jz r0, .LBB1_6
	jump .LBB1_10
.Ltmp73:
.LBB1_9:                                //   in Loop: Header=BB1_6 Depth=2
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 114 58 is_stmt 0              // TRNS/dpu/task.c:114:58
	move r0, r14
	lw r1, r22, -20
	call r23, __mulsi3
.Ltmp74:
	move r20, r0
	.loc	2 114 92                        // TRNS/dpu/task.c:114:92
	move r0, r14
	lw r1, r22, -24
	call r23, __udiv32
.Ltmp75:
	.loc	2 114 75                        // TRNS/dpu/task.c:114:75
	move r1, r17
	call r23, __mulsi3
.Ltmp76:
	.loc	2 114 64                        // TRNS/dpu/task.c:114:64
	sub r14, r20, r0
.Ltmp77:
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 114 9                         // TRNS/dpu/task.c:114:9
	jnz r15, .LBB1_10
.Ltmp78:
.LBB1_6:                                //   Parent Loop BB1_4 Depth=1
                                        // =>  This Loop Header: Depth=2
                                        //       Child Loop BB1_12 Depth 3
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: next_in_cycle <- $r14
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 115 46 is_stmt 1              // TRNS/dpu/task.c:115:46
	move r0, r14
	move r1, r16
	call r23, __mulsi3
.Ltmp79:
	move r20, r0
	.loc	2 115 13 is_stmt 0              // TRNS/dpu/task.c:115:13
	move r0, __sys_used_mram_end
	move r1, r20
	move r2, r19
	move r3, r16
	call r23, read_tile_step3
.Ltmp80:
	.loc	2 117 20 is_stmt 1              // TRNS/dpu/task.c:117:20
	move r0, r21
	move r1, r14
	lw r2, r22, -16
	call r23, get_and_set_done
.Ltmp81:
	move r15, r0
.Ltmp82:
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	.loc	2 119 16                        // TRNS/dpu/task.c:119:16
	jnz r15, .LBB1_8
.Ltmp83:
// %bb.7:                               //   in Loop: Header=BB1_6 Depth=2
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 120 17                        // TRNS/dpu/task.c:120:17
	move r0, __sys_used_mram_end
	move r1, r20
	move r2, r18
	move r3, r16
	call r23, write_tile_step3
.Ltmp84:
.LBB1_8:                                //   in Loop: Header=BB1_6 Depth=2
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	.loc	2 0 17 is_stmt 0                // TRNS/dpu/task.c:0:17
	move r0, r19
	move r1, r18
	//DEBUG_VALUE: i <- 0
	move r2, r16, sz, .LBB1_9
.Ltmp85:
.LBB1_12:                               //   Parent Loop BB1_4 Depth=1
                                        //     Parent Loop BB1_6 Depth=2
                                        // =>    This Inner Loop Header: Depth=3
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:done <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 8 7, DW_OP_stack_value] $r15
	//DEBUG_VALUE: next_in_cycle <- $r14
	//DEBUG_VALUE: i <- undef
	.loc	2 123 27 is_stmt 1              // TRNS/dpu/task.c:123:27
	ld d4, r0, 0
	.loc	2 123 25 is_stmt 0              // TRNS/dpu/task.c:123:25
	sd r1, 0, d4
.Ltmp86:
	//DEBUG_VALUE: i <- [DW_OP_plus_uconst 1, DW_OP_stack_value] undef
	.loc	2 122 35 is_stmt 1              // TRNS/dpu/task.c:122:35
	add r1, r1, 8
	add r0, r0, 8
	add r2, r2, -1
.Ltmp87:
	.loc	2 122 13 is_stmt 0              // TRNS/dpu/task.c:122:13
	jneq r2, 0, .LBB1_12
	jump .LBB1_9
.Ltmp88:
.LBB1_11:
	//DEBUG_VALUE: main_kernel2:read_done <- [DW_OP_constu 16, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:n <- [DW_OP_constu 24, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:M_ <- [DW_OP_constu 20, DW_OP_minus] [$r22+0]
	//DEBUG_VALUE: main_kernel2:backup <- $r19
	//DEBUG_VALUE: main_kernel2:data <- $r18
	//DEBUG_VALUE: main_kernel2:tile_max <- $r17
	//DEBUG_VALUE: main_kernel2:m <- $r16
	//DEBUG_VALUE: main_kernel2:tile <- $r15
	.loc	2 0 13                          // TRNS/dpu/task.c:0:13
	move r0, 0
	.loc	2 129 5 is_stmt 1               // TRNS/dpu/task.c:129:5
	ld d20, r22, -56
	ld d18, r22, -48
.Ltmp89:
	ld d16, r22, -40
.Ltmp90:
	ld d14, r22, -32
.Ltmp91:
	ld d22, r22, -8
.Ltmp92:
	jump r23
.Ltmp93:
.Lfunc_end1:
	.size	main_kernel2, .Lfunc_end1-main_kernel2
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.main_kernel2
	.long	.Lfunc_begin1
	.byte	56
	.section	.text.main_kernel2,"ax",@progbits
                                        // -- End function
	.section	.text.main,"ax",@progbits
	.globl	main                            // -- Begin function main
	.type	main,@function
main:                                   // @main
.Lfunc_begin2:
	.loc	2 40 0                          // TRNS/dpu/task.c:40:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -8
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 0, d22
	add r22, r22, 8
.Ltmp94:
	.loc	2 42 40 prologue_end            // TRNS/dpu/task.c:42:40
	move r0, DPU_INPUT_ARGUMENTS
	lw r0, r0, 12
	.loc	2 42 12 is_stmt 0               // TRNS/dpu/task.c:42:12
	lsl r0, r0, 2
	lw r0, r0, kernels
	call r23, r0
.Ltmp95:
	.loc	2 42 5                          // TRNS/dpu/task.c:42:5
	ld d22, r22, -8
	jump r23
.Ltmp96:
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.main
	.long	.Lfunc_begin2
	.byte	8
	.section	.text.main,"ax",@progbits
                                        // -- End function
	.section	.text.read_tile_step2,"ax",@progbits
	.globl	read_tile_step2                 // -- Begin function read_tile_step2
	.type	read_tile_step2,@function
read_tile_step2:                        // @read_tile_step2
.Lfunc_begin3:
	.loc	2 141 0 is_stmt 1               // TRNS/dpu/task.c:141:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: read_tile_step2:A <- $r0
	//DEBUG_VALUE: read_tile_step2:offset <- $r1
	//DEBUG_VALUE: read_tile_step2:variable <- $r2
	//DEBUG_VALUE: read_tile_step2:m <- $r3
	//DEBUG_VALUE: read_tile_step2:n <- $r4
	.cfi_def_cfa_offset -24
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 16, d22
	add r22, r22, 24
	.cfi_offset 15, -16
	.cfi_offset 14, -12
	sd r22, -16, d14
	.cfi_offset 17, -24
	.cfi_offset 16, -20
	sd r22, -24, d16
	move r14, r2
	move r16, r1
	move r15, r0
	//DEBUG_VALUE: read_tile_step2:n <- $r4
	//DEBUG_VALUE: read_tile_step2:m <- $r3
.Ltmp97:
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	.loc	2 142 18 prologue_end           // TRNS/dpu/task.c:142:18
	move r0, r4
.Ltmp98:
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	move r1, r3
.Ltmp99:
	//DEBUG_VALUE: read_tile_step2:m <- $r1
	call r23, __mulsi3
.Ltmp100:
	//DEBUG_VALUE: read_tile_step2:rest <- $r0
	.loc	2 144 5                         // TRNS/dpu/task.c:144:5
	jlts r0, 1, .LBB3_5
.Ltmp101:
// %bb.1:
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:m <- $r1
	//DEBUG_VALUE: read_tile_step2:rest <- $r0
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	.loc	2 0 5 is_stmt 0                 // TRNS/dpu/task.c:0:5
	add r1, r0, r16
.Ltmp102:
	move r2, r0, true, .LBB3_2
.Ltmp103:
.LBB3_4:                                //   in Loop: Header=BB3_2 Depth=1
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:rest <- $r2
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	//DEBUG_VALUE: read_tile_step2:transfer <- $r3
	.loc	2 150 56 is_stmt 1              // TRNS/dpu/task.c:150:56
	sub r4, r1, r2
	.loc	2 150 38 is_stmt 0              // TRNS/dpu/task.c:150:38
	lsl_add r4, r15, r4, 3
	.loc	2 150 96                        // TRNS/dpu/task.c:150:96
	sub r5, r0, r2
	.loc	2 150 87                        // TRNS/dpu/task.c:150:87
	lsl_add r5, r14, r5, 6
.Ltmp104:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- [DW_OP_constu 3, DW_OP_shl, DW_OP_stack_value] $r3
	//DEBUG_VALUE: mram_read:to <- $r5
	//DEBUG_VALUE: mram_read:from <- $r4
	.file	7 "/root" "upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h"
	.loc	7 39 24 is_stmt 1               // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:39:24
	and r6, r3, 536870911
	add r6, r6, -1
	lsl_add r5, r5, r6, 24
.Ltmp105:
	ldma r5, r4, 0
.Ltmp106:
	//DEBUG_VALUE: read_tile_step2:rest <- $r2
	.loc	2 151 12                        // TRNS/dpu/task.c:151:12
	sub r2, r2, r3, les, .LBB3_5
.Ltmp107:
.LBB3_2:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	//DEBUG_VALUE: read_tile_step2:rest <- $r2
	.loc	2 145 17                        // TRNS/dpu/task.c:145:17
	lsl r4, r2, 3
	move r5, 2048
	move r3, 256
.Ltmp108:
	.loc	2 145 12 is_stmt 0              // TRNS/dpu/task.c:145:12
	jgtu r4, r5, .LBB3_4
.Ltmp109:
// %bb.3:                               //   in Loop: Header=BB3_2 Depth=1
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:rest <- $r2
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	move r3, r2, true, .LBB3_4
.Ltmp110:
.LBB3_5:
	//DEBUG_VALUE: read_tile_step2:offset <- $r16
	//DEBUG_VALUE: read_tile_step2:A <- $r15
	//DEBUG_VALUE: read_tile_step2:variable <- $r14
	//DEBUG_VALUE: read_tile_step2:n <- $r0
	.loc	2 153 1 is_stmt 1               // TRNS/dpu/task.c:153:1
	ld d16, r22, -24
.Ltmp111:
	ld d14, r22, -16
.Ltmp112:
	ld d22, r22, -8
	jump r23
.Ltmp113:
.Lfunc_end3:
	.size	read_tile_step2, .Lfunc_end3-read_tile_step2
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.read_tile_step2
	.long	.Lfunc_begin3
	.byte	24
	.section	.text.read_tile_step2,"ax",@progbits
                                        // -- End function
	.section	.text.write_tile_step2,"ax",@progbits
	.globl	write_tile_step2                // -- Begin function write_tile_step2
	.type	write_tile_step2,@function
write_tile_step2:                       // @write_tile_step2
.Lfunc_begin4:
	.loc	2 155 0                         // TRNS/dpu/task.c:155:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: write_tile_step2:A <- $r0
	//DEBUG_VALUE: write_tile_step2:offset <- $r1
	//DEBUG_VALUE: write_tile_step2:variable <- $r2
	//DEBUG_VALUE: write_tile_step2:m <- $r3
	//DEBUG_VALUE: write_tile_step2:n <- $r4
	.cfi_def_cfa_offset -24
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 16, d22
	add r22, r22, 24
	.cfi_offset 15, -16
	.cfi_offset 14, -12
	sd r22, -16, d14
	.cfi_offset 17, -24
	.cfi_offset 16, -20
	sd r22, -24, d16
	move r14, r2
	move r16, r1
	move r15, r0
	//DEBUG_VALUE: write_tile_step2:n <- $r4
	//DEBUG_VALUE: write_tile_step2:m <- $r3
.Ltmp114:
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	.loc	2 156 18 prologue_end           // TRNS/dpu/task.c:156:18
	move r0, r4
.Ltmp115:
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	move r1, r3
.Ltmp116:
	//DEBUG_VALUE: write_tile_step2:m <- $r1
	call r23, __mulsi3
.Ltmp117:
	//DEBUG_VALUE: write_tile_step2:rest <- $r0
	.loc	2 158 5                         // TRNS/dpu/task.c:158:5
	jlts r0, 1, .LBB4_5
.Ltmp118:
// %bb.1:
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:m <- $r1
	//DEBUG_VALUE: write_tile_step2:rest <- $r0
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	.loc	2 0 5 is_stmt 0                 // TRNS/dpu/task.c:0:5
	add r1, r0, r16
.Ltmp119:
	move r2, r0, true, .LBB4_2
.Ltmp120:
.LBB4_4:                                //   in Loop: Header=BB4_2 Depth=1
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:rest <- $r2
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	//DEBUG_VALUE: write_tile_step2:transfer <- $r3
	.loc	2 164 36 is_stmt 1              // TRNS/dpu/task.c:164:36
	sub r4, r0, r2
	.loc	2 164 27 is_stmt 0              // TRNS/dpu/task.c:164:27
	lsl_add r4, r14, r4, 6
	.loc	2 164 96                        // TRNS/dpu/task.c:164:96
	sub r5, r1, r2
	.loc	2 164 78                        // TRNS/dpu/task.c:164:78
	lsl_add r5, r15, r5, 3
.Ltmp121:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- [DW_OP_constu 3, DW_OP_shl, DW_OP_stack_value] $r3
	//DEBUG_VALUE: mram_write:to <- $r5
	//DEBUG_VALUE: mram_write:from <- $r4
	.loc	7 61 24 is_stmt 1               // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:61:24
	and r6, r3, 536870911
	add r6, r6, -1
	lsl_add r4, r4, r6, 24
.Ltmp122:
	sdma r4, r5, 0
.Ltmp123:
	//DEBUG_VALUE: write_tile_step2:rest <- $r2
	.loc	2 165 12                        // TRNS/dpu/task.c:165:12
	sub r2, r2, r3, les, .LBB4_5
.Ltmp124:
.LBB4_2:                                // =>This Inner Loop Header: Depth=1
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	//DEBUG_VALUE: write_tile_step2:rest <- $r2
	.loc	2 159 17                        // TRNS/dpu/task.c:159:17
	lsl r4, r2, 3
	move r5, 2048
	move r3, 256
.Ltmp125:
	.loc	2 159 12 is_stmt 0              // TRNS/dpu/task.c:159:12
	jgtu r4, r5, .LBB4_4
.Ltmp126:
// %bb.3:                               //   in Loop: Header=BB4_2 Depth=1
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:rest <- $r2
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	move r3, r2, true, .LBB4_4
.Ltmp127:
.LBB4_5:
	//DEBUG_VALUE: write_tile_step2:offset <- $r16
	//DEBUG_VALUE: write_tile_step2:A <- $r15
	//DEBUG_VALUE: write_tile_step2:variable <- $r14
	//DEBUG_VALUE: write_tile_step2:n <- $r0
	.loc	2 167 1 is_stmt 1               // TRNS/dpu/task.c:167:1
	ld d16, r22, -24
.Ltmp128:
	ld d14, r22, -16
.Ltmp129:
	ld d22, r22, -8
	jump r23
.Ltmp130:
.Lfunc_end4:
	.size	write_tile_step2, .Lfunc_end4-write_tile_step2
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.write_tile_step2
	.long	.Lfunc_begin4
	.byte	24
	.section	.text.write_tile_step2,"ax",@progbits
                                        // -- End function
	.section	.text.read_tile_step3,"ax",@progbits
	.globl	read_tile_step3                 // -- Begin function read_tile_step3
	.type	read_tile_step3,@function
read_tile_step3:                        // @read_tile_step3
.Lfunc_begin5:
	.loc	2 169 0                         // TRNS/dpu/task.c:169:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: read_tile_step3:A <- $r0
	//DEBUG_VALUE: read_tile_step3:A <- $r0
	//DEBUG_VALUE: read_tile_step3:offset <- $r1
	//DEBUG_VALUE: read_tile_step3:offset <- $r1
	//DEBUG_VALUE: read_tile_step3:variable <- $r2
	//DEBUG_VALUE: read_tile_step3:variable <- $r2
	//DEBUG_VALUE: read_tile_step3:m <- $r3
	//DEBUG_VALUE: read_tile_step3:m <- $r3
	.cfi_def_cfa_offset 0
	.loc	2 170 36 prologue_end           // TRNS/dpu/task.c:170:36
	lsl_add r0, r0, r1, 3
.Ltmp131:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- [DW_OP_constu 3, DW_OP_shl, DW_OP_stack_value] $r3
	//DEBUG_VALUE: mram_read:to <- $r2
	//DEBUG_VALUE: mram_read:from <- $r0
	.loc	7 39 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:39:24
	and r1, r3, 536870911
.Ltmp132:
	add r1, r1, -1
	lsl_add r1, r2, r1, 24
	ldma r1, r0, 0
.Ltmp133:
	.loc	2 171 1                         // TRNS/dpu/task.c:171:1
	jump r23
.Ltmp134:
.Lfunc_end5:
	.size	read_tile_step3, .Lfunc_end5-read_tile_step3
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.read_tile_step3
	.long	.Lfunc_begin5
	.byte	0
	.section	.text.read_tile_step3,"ax",@progbits
                                        // -- End function
	.section	.text.get_done,"ax",@progbits
	.globl	get_done                        // -- Begin function get_done
	.type	get_done,@function
get_done:                               // @get_done
.Lfunc_begin6:
	.loc	2 177 0                         // TRNS/dpu/task.c:177:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: get_done:done_array_step3 <- $r0
	//DEBUG_VALUE: get_done:done_array_step3 <- $r0
	//DEBUG_VALUE: get_done:address <- $r1
	//DEBUG_VALUE: get_done:address <- $r1
	//DEBUG_VALUE: get_done:read_done <- $r2
	//DEBUG_VALUE: get_done:read_done <- $r2
	.cfi_def_cfa_offset 0
	.loc	3 61 5 prologue_end             // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:61:5
	move r3, __atomic_bit_mutex_done_mutex
.Ltmp135:
	//DEBUG_VALUE: mutex_lock:mutex <- $r3
	// inline asm
.Ltmp136:
	acquire r3, 0, nz, .Ltmp136
	// inline asm
.Ltmp137:
	.loc	2 181 51                        // TRNS/dpu/task.c:181:51
	add r0, r1, r0
.Ltmp138:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_read:to <- $r2
	//DEBUG_VALUE: mram_read:from <- $r0
	.loc	7 39 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:39:24
	ldma r2, r0, 0
.Ltmp139:
	.loc	2 182 16                        // TRNS/dpu/task.c:182:16
	ld d4, r2, 0
	.loc	2 182 47 is_stmt 0              // TRNS/dpu/task.c:182:47
	and r0, r1, 7
.Ltmp140:
	.loc	2 182 35                        // TRNS/dpu/task.c:182:35
	lsl r0, one, r0
	move.u d0, r0
.Ltmp141:
	.loc	2 182 27                        // TRNS/dpu/task.c:182:27
	and r1, r5, r1
	and r0, r4, r0
	move.s d4, 0
	.loc	2 182 62                        // TRNS/dpu/task.c:182:62
	sub zero, r1, r5
	subc r0, r0, r4, xnz
.Ltmp142:
	//DEBUG_VALUE: mutex_unlock:mutex <- $r3
	//DEBUG_VALUE: get_done:result <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r0
	.loc	3 86 5 is_stmt 1                // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:86:5
	// inline asm
.Ltmp143:
	release r3, 0, nz, .Ltmp143+1
	// inline asm
.Ltmp144:
	.loc	2 185 5                         // TRNS/dpu/task.c:185:5
	jump r23
.Ltmp145:
.Lfunc_end6:
	.size	get_done, .Lfunc_end6-get_done
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.get_done
	.long	.Lfunc_begin6
	.byte	0
	.section	.text.get_done,"ax",@progbits
                                        // -- End function
	.section	.text.get_and_set_done,"ax",@progbits
	.globl	get_and_set_done                // -- Begin function get_and_set_done
	.type	get_and_set_done,@function
get_and_set_done:                       // @get_and_set_done
.Lfunc_begin7:
	.loc	2 188 0                         // TRNS/dpu/task.c:188:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: get_and_set_done:done_array_step3 <- $r0
	//DEBUG_VALUE: get_and_set_done:done_array_step3 <- $r0
	//DEBUG_VALUE: get_and_set_done:address <- $r1
	//DEBUG_VALUE: get_and_set_done:address <- $r1
	//DEBUG_VALUE: get_and_set_done:read_done <- $r2
	//DEBUG_VALUE: get_and_set_done:read_done <- $r2
	.cfi_def_cfa_offset 0
	.loc	3 61 5 prologue_end             // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:61:5
	move r3, __atomic_bit_mutex_done_mutex
.Ltmp146:
	//DEBUG_VALUE: mutex_lock:mutex <- $r3
	// inline asm
.Ltmp147:
	acquire r3, 0, nz, .Ltmp147
	// inline asm
.Ltmp148:
	.loc	2 192 51                        // TRNS/dpu/task.c:192:51
	add r4, r1, r0
.Ltmp149:
	//DEBUG_VALUE: mram_read:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_read:to <- $r2
	//DEBUG_VALUE: mram_read:from <- $r4
	.loc	7 39 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:39:24
	ldma r2, r4, 0
.Ltmp150:
	.loc	2 193 16                        // TRNS/dpu/task.c:193:16
	ld d6, r2, 0
	.loc	2 193 47 is_stmt 0              // TRNS/dpu/task.c:193:47
	and r0, r1, 7
.Ltmp151:
	.loc	2 193 35                        // TRNS/dpu/task.c:193:35
	lsl r0, one, r0
	move.u d8, r0
	.loc	2 193 27                        // TRNS/dpu/task.c:193:27
	and r1, r7, r9
.Ltmp152:
	and r0, r6, r8
	move.s d10, 0
	.loc	2 193 62                        // TRNS/dpu/task.c:193:62
	sub zero, r1, r11
	subc r0, r0, r10, xnz
.Ltmp153:
	//DEBUG_VALUE: get_and_set_done:result <- [DW_OP_LLVM_convert 1 7, DW_OP_LLVM_convert 32 7, DW_OP_stack_value] $r0
	.loc	2 194 16 is_stmt 1              // TRNS/dpu/task.c:194:16
	or r7, r7, r9
	or r6, r6, r8
	sd r2, 0, d6
.Ltmp154:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- 8
	//DEBUG_VALUE: mram_write:to <- $r4
	//DEBUG_VALUE: mram_write:from <- $r2
	.loc	7 61 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:61:24
	sdma r2, r4, 0
.Ltmp155:
	//DEBUG_VALUE: mutex_unlock:mutex <- $r3
	.loc	3 86 5                          // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:86:5
	// inline asm
.Ltmp156:
	release r3, 0, nz, .Ltmp156+1
	// inline asm
.Ltmp157:
	.loc	2 198 5                         // TRNS/dpu/task.c:198:5
	jump r23
.Ltmp158:
.Lfunc_end7:
	.size	get_and_set_done, .Lfunc_end7-get_and_set_done
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.get_and_set_done
	.long	.Lfunc_begin7
	.byte	0
	.section	.text.get_and_set_done,"ax",@progbits
                                        // -- End function
	.section	.text.write_tile_step3,"ax",@progbits
	.globl	write_tile_step3                // -- Begin function write_tile_step3
	.type	write_tile_step3,@function
write_tile_step3:                       // @write_tile_step3
.Lfunc_begin8:
	.loc	2 173 0                         // TRNS/dpu/task.c:173:0
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: write_tile_step3:A <- $r0
	//DEBUG_VALUE: write_tile_step3:A <- $r0
	//DEBUG_VALUE: write_tile_step3:offset <- $r1
	//DEBUG_VALUE: write_tile_step3:offset <- $r1
	//DEBUG_VALUE: write_tile_step3:variable <- $r2
	//DEBUG_VALUE: write_tile_step3:variable <- $r2
	//DEBUG_VALUE: write_tile_step3:m <- $r3
	//DEBUG_VALUE: write_tile_step3:m <- $r3
	.cfi_def_cfa_offset 0
	.loc	2 174 47 prologue_end           // TRNS/dpu/task.c:174:47
	lsl_add r0, r0, r1, 3
.Ltmp159:
	//DEBUG_VALUE: mram_write:nb_of_bytes <- [DW_OP_constu 3, DW_OP_shl, DW_OP_stack_value] $r3
	//DEBUG_VALUE: mram_write:to <- $r0
	//DEBUG_VALUE: mram_write:from <- $r2
	.loc	7 61 24                         // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mram.h:61:24
	and r1, r3, 536870911
.Ltmp160:
	add r1, r1, -1
	lsl_add r1, r2, r1, 24
	sdma r1, r0, 0
.Ltmp161:
	.loc	2 175 1                         // TRNS/dpu/task.c:175:1
	jump r23
.Ltmp162:
.Lfunc_end8:
	.size	write_tile_step3, .Lfunc_end8-write_tile_step3
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.write_tile_step3
	.long	.Lfunc_begin8
	.byte	0
	.section	.text.write_tile_step3,"ax",@progbits
                                        // -- End function
	.section	.text.get_tile,"ax",@progbits
	.globl	get_tile                        // -- Begin function get_tile
	.type	get_tile,@function
get_tile:                               // @get_tile
.Lfunc_begin9:
	.loc	2 133 0                         // TRNS/dpu/task.c:133:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	3 61 5 prologue_end             // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:61:5
	move r1, __atomic_bit_mutex_tile_mutex
.Ltmp163:
	//DEBUG_VALUE: mutex_lock:mutex <- $r1
	// inline asm
.Ltmp164:
	acquire r1, 0, nz, .Ltmp164
	// inline asm
.Ltmp165:
	.loc	2 135 22                        // TRNS/dpu/task.c:135:22
	lw r0, zero, curr_tile
.Ltmp166:
	//DEBUG_VALUE: get_tile:value <- $r0
	.loc	2 136 14                        // TRNS/dpu/task.c:136:14
	add r2, r0, 1
	sw zero, curr_tile, r2
.Ltmp167:
	//DEBUG_VALUE: mutex_unlock:mutex <- $r1
	.loc	3 86 5                          // upmem-2023.2.0-Linux-x86_64/bin/../share/upmem/include/syslib/mutex.h:86:5
	// inline asm
.Ltmp168:
	release r1, 0, nz, .Ltmp168+1
	// inline asm
.Ltmp169:
	.loc	2 138 5                         // TRNS/dpu/task.c:138:5
	jump r23
.Ltmp170:
.Lfunc_end9:
	.size	get_tile, .Lfunc_end9-get_tile
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.get_tile
	.long	.Lfunc_begin9
	.byte	0
	.section	.text.get_tile,"ax",@progbits
                                        // -- End function
	.type	curr_tile,@object               // @curr_tile
	.section	.bss.curr_tile,"aw",@nobits
	.globl	curr_tile
	.p2align	2
curr_tile:
	.long	0                               // 0x0
	.size	curr_tile, 4

	.type	__atomic_bit_mutex_tile_mutex,@object // @__atomic_bit_mutex_tile_mutex
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit_mutex_tile_mutex
__atomic_bit_mutex_tile_mutex:
	.byte	0                               // 0x0
	.size	__atomic_bit_mutex_tile_mutex, 1

	.type	tile_mutex,@object              // @tile_mutex
	.section	.rodata.tile_mutex,"a",@progbits
	.globl	tile_mutex
	.p2align	2
tile_mutex:
	.long	__atomic_bit_mutex_tile_mutex
	.size	tile_mutex, 4

	.type	__atomic_bit_mutex_done_mutex,@object // @__atomic_bit_mutex_done_mutex
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit_mutex_done_mutex
__atomic_bit_mutex_done_mutex:
	.byte	0                               // 0x0
	.size	__atomic_bit_mutex_done_mutex, 1

	.type	done_mutex,@object              // @done_mutex
	.section	.rodata.done_mutex,"a",@progbits
	.globl	done_mutex
	.p2align	2
done_mutex:
	.long	__atomic_bit_mutex_done_mutex
	.size	done_mutex, 4

	.type	kernels,@object                 // @kernels
	.section	.data.kernels,"aw",@progbits
	.globl	kernels
	.p2align	2
kernels:
	.long	main_kernel1
	.long	main_kernel2
	.size	kernels, 8

	.type	DPU_INPUT_ARGUMENTS,@object     // @DPU_INPUT_ARGUMENTS
	.section	.dpu_host,"aw",@progbits
	.globl	DPU_INPUT_ARGUMENTS
	.p2align	3
DPU_INPUT_ARGUMENTS:
	.zero	16
	.size	DPU_INPUT_ARGUMENTS, 16

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
	.long	.Ltmp1-.Lfunc_begin0
	.long	.Ltmp2-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
.Ldebug_loc1:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp5-.Lfunc_begin0
	.long	.Ltmp34-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc2:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp6-.Lfunc_begin0
	.long	.Ltmp16-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	98                              // DW_OP_reg18
	.long	0
	.long	0
.Ldebug_loc3:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp7-.Lfunc_begin0
	.long	.Ltmp14-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	.Ltmp14-.Lfunc_begin0
	.long	.Ltmp35-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	112                             // -16
	.long	0
	.long	0
.Ldebug_loc4:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp10-.Lfunc_begin0
	.long	.Ltmp11-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp11-.Lfunc_begin0
	.long	.Ltmp16-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	99                              // DW_OP_reg19
	.long	0
	.long	0
.Ldebug_loc5:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp13-.Lfunc_begin0
	.long	.Ltmp16-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	100                             // DW_OP_reg20
	.long	0
	.long	0
.Ldebug_loc6:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp14-.Lfunc_begin0
	.long	.Ltmp16-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	.Ltmp16-.Lfunc_begin0
	.long	.Ltmp19-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	104                             // -24
	.long	.Ltmp19-.Lfunc_begin0
	.long	.Ltmp21-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	.Ltmp21-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	104                             // -24
	.long	0
	.long	0
.Ldebug_loc7:
	.long	-1
	.long	.Lfunc_begin0                   //   base address
	.long	.Ltmp24-.Lfunc_begin0
	.long	.Ltmp26-.Lfunc_begin0
	.short	2                               // Loc expr size
	.byte	48                              // DW_OP_lit0
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp26-.Lfunc_begin0
	.long	.Ltmp33-.Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	101                             // DW_OP_reg21
	.long	0
	.long	0
.Ldebug_loc8:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp38-.Lfunc_begin1
	.long	.Ltmp39-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc9:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp42-.Lfunc_begin1
	.long	.Ltmp46-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp46-.Lfunc_begin1
	.long	.Ltmp92-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	104                             // -24
	.long	0
	.long	0
.Ldebug_loc10:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp43-.Lfunc_begin1
	.long	.Ltmp45-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp45-.Lfunc_begin1
	.long	.Ltmp92-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	108                             // -20
	.long	0
	.long	0
.Ldebug_loc11:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp44-.Lfunc_begin1
	.long	.Ltmp90-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	0
	.long	0
.Ldebug_loc12:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp60-.Lfunc_begin1
	.long	.Ltmp61-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	101                             // DW_OP_reg21
	.long	0
	.long	0
.Ldebug_loc13:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp50-.Lfunc_begin1
	.long	.Ltmp90-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	97                              // DW_OP_reg17
	.long	0
	.long	0
.Ldebug_loc14:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp52-.Lfunc_begin1
	.long	.Ltmp89-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	98                              // DW_OP_reg18
	.long	0
	.long	0
.Ldebug_loc15:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp54-.Lfunc_begin1
	.long	.Ltmp89-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	99                              // DW_OP_reg19
	.long	0
	.long	0
.Ldebug_loc16:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp56-.Lfunc_begin1
	.long	.Ltmp92-.Lfunc_begin1
	.short	2                               // Loc expr size
	.byte	134                             // DW_OP_breg22
	.byte	112                             // -16
	.long	0
	.long	0
.Ldebug_loc17:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp58-.Lfunc_begin1
	.long	.Ltmp61-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	.Ltmp63-.Lfunc_begin1
	.long	.Ltmp73-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	.Ltmp88-.Lfunc_begin1
	.long	.Ltmp91-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc18:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp61-.Lfunc_begin1
	.long	.Ltmp64-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	.Ltmp68-.Lfunc_begin1
	.long	.Ltmp88-.Lfunc_begin1
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
.Ldebug_loc19:
	.long	-1
	.long	.Lfunc_begin1                   //   base address
	.long	.Ltmp72-.Lfunc_begin1
	.long	.Ltmp73-.Lfunc_begin1
	.short	6                               // Loc expr size
	.byte	112                             // DW_OP_breg0
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp73-.Lfunc_begin1
	.long	.Ltmp78-.Lfunc_begin1
	.short	6                               // Loc expr size
	.byte	127                             // DW_OP_breg15
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	.Ltmp82-.Lfunc_begin1
	.long	.Ltmp88-.Lfunc_begin1
	.short	6                               // Loc expr size
	.byte	127                             // DW_OP_breg15
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc20:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Lfunc_begin3-.Lfunc_begin3
	.long	.Ltmp97-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp97-.Lfunc_begin3
	.long	.Ltmp112-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc21:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Lfunc_begin3-.Lfunc_begin3
	.long	.Ltmp97-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp97-.Lfunc_begin3
	.long	.Ltmp111-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	0
	.long	0
.Ldebug_loc22:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Lfunc_begin3-.Lfunc_begin3
	.long	.Ltmp97-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp97-.Lfunc_begin3
	.long	.Ltmp112-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
.Ldebug_loc23:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Lfunc_begin3-.Lfunc_begin3
	.long	.Ltmp99-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	.Ltmp99-.Lfunc_begin3
	.long	.Ltmp102-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc24:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Lfunc_begin3-.Lfunc_begin3
	.long	.Ltmp98-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	.Ltmp98-.Lfunc_begin3
	.long	.Lfunc_end3-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc25:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Ltmp100-.Lfunc_begin3
	.long	.Ltmp103-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp103-.Lfunc_begin3
	.long	.Ltmp110-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
.Ldebug_loc26:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Ltmp103-.Lfunc_begin3
	.long	.Ltmp107-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
.Ldebug_loc27:
	.long	-1
	.long	.Lfunc_begin3                   //   base address
	.long	.Ltmp104-.Lfunc_begin3
	.long	.Ltmp105-.Lfunc_begin3
	.short	1                               // Loc expr size
	.byte	85                              // DW_OP_reg5
	.long	0
	.long	0
.Ldebug_loc28:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Lfunc_begin4-.Lfunc_begin4
	.long	.Ltmp114-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp114-.Lfunc_begin4
	.long	.Ltmp129-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	95                              // DW_OP_reg15
	.long	0
	.long	0
.Ldebug_loc29:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Lfunc_begin4-.Lfunc_begin4
	.long	.Ltmp114-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	.Ltmp114-.Lfunc_begin4
	.long	.Ltmp128-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	96                              // DW_OP_reg16
	.long	0
	.long	0
.Ldebug_loc30:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Lfunc_begin4-.Lfunc_begin4
	.long	.Ltmp114-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	.Ltmp114-.Lfunc_begin4
	.long	.Ltmp129-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	94                              // DW_OP_reg14
	.long	0
	.long	0
.Ldebug_loc31:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Lfunc_begin4-.Lfunc_begin4
	.long	.Ltmp116-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	.Ltmp116-.Lfunc_begin4
	.long	.Ltmp119-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc32:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Lfunc_begin4-.Lfunc_begin4
	.long	.Ltmp115-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	.Ltmp115-.Lfunc_begin4
	.long	.Lfunc_end4-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc33:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Ltmp117-.Lfunc_begin4
	.long	.Ltmp120-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	.Ltmp120-.Lfunc_begin4
	.long	.Ltmp127-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	82                              // DW_OP_reg2
	.long	0
	.long	0
.Ldebug_loc34:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Ltmp120-.Lfunc_begin4
	.long	.Ltmp124-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
.Ldebug_loc35:
	.long	-1
	.long	.Lfunc_begin4                   //   base address
	.long	.Ltmp121-.Lfunc_begin4
	.long	.Ltmp122-.Lfunc_begin4
	.short	1                               // Loc expr size
	.byte	84                              // DW_OP_reg4
	.long	0
	.long	0
.Ldebug_loc36:
	.long	-1
	.long	.Lfunc_begin5                   //   base address
	.long	.Lfunc_begin5-.Lfunc_begin5
	.long	.Ltmp131-.Lfunc_begin5
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc37:
	.long	-1
	.long	.Lfunc_begin5                   //   base address
	.long	.Lfunc_begin5-.Lfunc_begin5
	.long	.Ltmp132-.Lfunc_begin5
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc38:
	.long	-1
	.long	.Lfunc_begin6                   //   base address
	.long	.Lfunc_begin6-.Lfunc_begin6
	.long	.Ltmp138-.Lfunc_begin6
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc39:
	.long	-1
	.long	.Lfunc_begin6                   //   base address
	.long	.Lfunc_begin6-.Lfunc_begin6
	.long	.Ltmp141-.Lfunc_begin6
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc40:
	.long	-1
	.long	.Lfunc_begin6                   //   base address
	.long	.Ltmp135-.Lfunc_begin6
	.long	.Lfunc_end6-.Lfunc_begin6
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
.Ldebug_loc41:
	.long	-1
	.long	.Lfunc_begin6                   //   base address
	.long	.Ltmp142-.Lfunc_begin6
	.long	.Lfunc_end6-.Lfunc_begin6
	.short	6                               // Loc expr size
	.byte	112                             // DW_OP_breg0
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc42:
	.long	-1
	.long	.Lfunc_begin7                   //   base address
	.long	.Lfunc_begin7-.Lfunc_begin7
	.long	.Ltmp151-.Lfunc_begin7
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc43:
	.long	-1
	.long	.Lfunc_begin7                   //   base address
	.long	.Lfunc_begin7-.Lfunc_begin7
	.long	.Ltmp152-.Lfunc_begin7
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc44:
	.long	-1
	.long	.Lfunc_begin7                   //   base address
	.long	.Ltmp146-.Lfunc_begin7
	.long	.Lfunc_end7-.Lfunc_begin7
	.short	1                               // Loc expr size
	.byte	83                              // DW_OP_reg3
	.long	0
	.long	0
.Ldebug_loc45:
	.long	-1
	.long	.Lfunc_begin7                   //   base address
	.long	.Ltmp153-.Lfunc_begin7
	.long	.Lfunc_end7-.Lfunc_begin7
	.short	6                               // Loc expr size
	.byte	112                             // DW_OP_breg0
	.byte	0                               // 0
	.byte	16                              // DW_OP_constu
	.byte	1                               // 1
	.byte	26                              // DW_OP_and
	.byte	159                             // DW_OP_stack_value
	.long	0
	.long	0
.Ldebug_loc46:
	.long	-1
	.long	.Lfunc_begin8                   //   base address
	.long	.Lfunc_begin8-.Lfunc_begin8
	.long	.Ltmp159-.Lfunc_begin8
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
.Ldebug_loc47:
	.long	-1
	.long	.Lfunc_begin8                   //   base address
	.long	.Lfunc_begin8-.Lfunc_begin8
	.long	.Ltmp160-.Lfunc_begin8
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc48:
	.long	-1
	.long	.Lfunc_begin9                   //   base address
	.long	.Ltmp163-.Lfunc_begin9
	.long	.Lfunc_end9-.Lfunc_begin9
	.short	1                               // Loc expr size
	.byte	81                              // DW_OP_reg1
	.long	0
	.long	0
.Ldebug_loc49:
	.long	-1
	.long	.Lfunc_begin9                   //   base address
	.long	.Ltmp166-.Lfunc_begin9
	.long	.Lfunc_end9-.Lfunc_begin9
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
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
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
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	21                              // DW_TAG_subroutine_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
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
	.byte	12                              // Abbreviation Code
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
	.byte	13                              // Abbreviation Code
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
	.byte	14                              // Abbreviation Code
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
	.byte	15                              // Abbreviation Code
	.byte	40                              // DW_TAG_enumerator
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	16                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	17                              // Abbreviation Code
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
	.byte	18                              // Abbreviation Code
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
	.byte	21                              // Abbreviation Code
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
	.byte	22                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	23                              // Abbreviation Code
	.ascii	"\211\202\001"                  // DW_TAG_GNU_call_site
	.byte	0                               // DW_CHILDREN_no
	.ascii	"\223B"                         // DW_AT_GNU_call_site_target
	.byte	24                              // DW_FORM_exprloc
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	24                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	25                              // Abbreviation Code
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
	.byte	26                              // Abbreviation Code
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
	.byte	27                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	28                              // Abbreviation Code
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
	.byte	29                              // Abbreviation Code
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
	.byte	30                              // Abbreviation Code
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
	.byte	31                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
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
	.byte	33                              // Abbreviation Code
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
	.byte	34                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	49                              // DW_AT_abstract_origin
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	35                              // Abbreviation Code
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
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 // Length of Unit
.Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x8ed DW_TAG_compile_unit
	.long	.Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	.Linfo_string1                  // DW_AT_name
	.long	.Lline_table_start0             // DW_AT_stmt_list
	.long	.Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	.Ldebug_ranges1                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_variable
	.long	.Linfo_string3                  // DW_AT_name
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	curr_tile
	.byte	3                               // Abbrev [3] 0x37:0xb DW_TAG_typedef
	.long	66                              // DW_AT_type
	.long	.Linfo_string5                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x42:0x7 DW_TAG_base_type
	.long	.Linfo_string4                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	2                               // Abbrev [2] 0x49:0x11 DW_TAG_variable
	.long	.Linfo_string6                  // DW_AT_name
	.long	90                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	32                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	tile_mutex
	.byte	5                               // Abbrev [5] 0x5a:0x5 DW_TAG_const_type
	.long	95                              // DW_AT_type
	.byte	3                               // Abbrev [3] 0x5f:0xb DW_TAG_typedef
	.long	106                             // DW_AT_type
	.long	.Linfo_string9                  // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	35                              // DW_AT_decl_line
	.byte	6                               // Abbrev [6] 0x6a:0x5 DW_TAG_pointer_type
	.long	111                             // DW_AT_type
	.byte	3                               // Abbrev [3] 0x6f:0xb DW_TAG_typedef
	.long	122                             // DW_AT_type
	.long	.Linfo_string8                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x7a:0x7 DW_TAG_base_type
	.long	.Linfo_string7                  // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	2                               // Abbrev [2] 0x81:0x11 DW_TAG_variable
	.long	.Linfo_string10                 // DW_AT_name
	.long	90                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	done_mutex
	.byte	2                               // Abbrev [2] 0x92:0x11 DW_TAG_variable
	.long	.Linfo_string11                 // DW_AT_name
	.long	163                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	38                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	kernels
	.byte	7                               // Abbrev [7] 0xa3:0xc DW_TAG_array_type
	.long	175                             // DW_AT_type
	.byte	8                               // Abbrev [8] 0xa8:0x6 DW_TAG_subrange_type
	.long	192                             // DW_AT_type
	.byte	2                               // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	6                               // Abbrev [6] 0xaf:0x5 DW_TAG_pointer_type
	.long	180                             // DW_AT_type
	.byte	9                               // Abbrev [9] 0xb4:0x5 DW_TAG_subroutine_type
	.long	185                             // DW_AT_type
                                        // DW_AT_prototyped
	.byte	4                               // Abbrev [4] 0xb9:0x7 DW_TAG_base_type
	.long	.Linfo_string12                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	10                              // Abbrev [10] 0xc0:0x7 DW_TAG_base_type
	.long	.Linfo_string13                 // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	11                              // Abbrev [11] 0xc7:0x12 DW_TAG_variable
	.long	.Linfo_string14                 // DW_AT_name
	.long	217                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	17                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	DPU_INPUT_ARGUMENTS
	.byte	3                               // Abbrev [3] 0xd9:0xb DW_TAG_typedef
	.long	228                             // DW_AT_type
	.long	.Linfo_string22                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	12                              // Abbrev [12] 0xe4:0x35 DW_TAG_structure_type
	.byte	16                              // DW_AT_byte_size
	.byte	4                               // DW_AT_decl_file
	.byte	18                              // DW_AT_decl_line
	.byte	13                              // Abbrev [13] 0xe8:0xc DW_TAG_member
	.long	.Linfo_string15                 // DW_AT_name
	.long	55                              // DW_AT_type
	.byte	4                               // DW_AT_decl_file
	.byte	19                              // DW_AT_decl_line
	.byte	0                               // DW_AT_data_member_location
	.byte	13                              // Abbrev [13] 0xf4:0xc DW_TAG_member
	.long	.Linfo_string16                 // DW_AT_name
	.long	55                              // DW_AT_type
	.byte	4                               // DW_AT_decl_file
	.byte	20                              // DW_AT_decl_line
	.byte	4                               // DW_AT_data_member_location
	.byte	13                              // Abbrev [13] 0x100:0xc DW_TAG_member
	.long	.Linfo_string17                 // DW_AT_name
	.long	55                              // DW_AT_type
	.byte	4                               // DW_AT_decl_file
	.byte	21                              // DW_AT_decl_line
	.byte	8                               // DW_AT_data_member_location
	.byte	13                              // Abbrev [13] 0x10c:0xc DW_TAG_member
	.long	.Linfo_string18                 // DW_AT_name
	.long	281                             // DW_AT_type
	.byte	4                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.byte	12                              // DW_AT_data_member_location
	.byte	0                               // End Of Children Mark
	.byte	14                              // Abbrev [14] 0x119:0x1f DW_TAG_enumeration_type
	.long	66                              // DW_AT_type
	.long	.Linfo_string11                 // DW_AT_name
	.byte	4                               // DW_AT_byte_size
	.byte	4                               // DW_AT_decl_file
	.byte	22                              // DW_AT_decl_line
	.byte	15                              // Abbrev [15] 0x125:0x6 DW_TAG_enumerator
	.long	.Linfo_string19                 // DW_AT_name
	.byte	0                               // DW_AT_const_value
	.byte	15                              // Abbrev [15] 0x12b:0x6 DW_TAG_enumerator
	.long	.Linfo_string20                 // DW_AT_name
	.byte	1                               // DW_AT_const_value
	.byte	15                              // Abbrev [15] 0x131:0x6 DW_TAG_enumerator
	.long	.Linfo_string21                 // DW_AT_name
	.byte	2                               // DW_AT_const_value
	.byte	0                               // End Of Children Mark
	.byte	2                               // Abbrev [2] 0x138:0x11 DW_TAG_variable
	.long	.Linfo_string23                 // DW_AT_name
	.long	111                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	29                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit_barrier_my_barrier
	.byte	2                               // Abbrev [2] 0x149:0x11 DW_TAG_variable
	.long	.Linfo_string24                 // DW_AT_name
	.long	111                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	32                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit_mutex_tile_mutex
	.byte	2                               // Abbrev [2] 0x15a:0x11 DW_TAG_variable
	.long	.Linfo_string25                 // DW_AT_name
	.long	111                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit_mutex_done_mutex
	.byte	16                              // Abbrev [16] 0x16b:0x1 DW_TAG_pointer_type
	.byte	6                               // Abbrev [6] 0x16c:0x5 DW_TAG_pointer_type
	.long	369                             // DW_AT_type
	.byte	3                               // Abbrev [3] 0x171:0xb DW_TAG_typedef
	.long	380                             // DW_AT_type
	.long	.Linfo_string27                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	4                               // Abbrev [4] 0x17c:0x7 DW_TAG_base_type
	.long	.Linfo_string26                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	4                               // Abbrev [4] 0x183:0x7 DW_TAG_base_type
	.long	.Linfo_string28                 // DW_AT_name
	.byte	2                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	17                              // Abbrev [17] 0x18a:0xc DW_TAG_subprogram
	.long	.Linfo_string29                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	406                             // DW_AT_type
	.byte	1                               // DW_AT_inline
	.byte	3                               // Abbrev [3] 0x196:0xb DW_TAG_typedef
	.long	66                              // DW_AT_type
	.long	.Linfo_string30                 // DW_AT_name
	.byte	6                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	18                              // Abbrev [18] 0x1a1:0x10a DW_TAG_subprogram
	.long	.Lfunc_begin0                   // DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string39                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	46                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	185                             // DW_AT_type
                                        // DW_AT_external
	.byte	19                              // Abbrev [19] 0x1b6:0xf DW_TAG_variable
	.long	.Ldebug_loc0                    // DW_AT_location
	.long	.Linfo_string49                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	47                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1c5:0xf DW_TAG_variable
	.long	.Ldebug_loc1                    // DW_AT_location
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	59                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1d4:0xf DW_TAG_variable
	.long	.Ldebug_loc2                    // DW_AT_location
	.long	.Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	60                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1e3:0xf DW_TAG_variable
	.long	.Ldebug_loc3                    // DW_AT_location
	.long	.Linfo_string17                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	58                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1f2:0xf DW_TAG_variable
	.long	.Ldebug_loc4                    // DW_AT_location
	.long	.Linfo_string50                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	62                              // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	20                              // Abbrev [20] 0x201:0xb DW_TAG_variable
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	57                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x20c:0xf DW_TAG_variable
	.long	.Ldebug_loc5                    // DW_AT_location
	.long	.Linfo_string52                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	63                              // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	21                              // Abbrev [21] 0x21b:0x10 DW_TAG_inlined_subroutine
	.long	394                             // DW_AT_abstract_origin
	.long	.Ltmp0                          // DW_AT_low_pc
	.long	.Ltmp2-.Ltmp0                   // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	47                              // DW_AT_call_line
	.byte	31                              // DW_AT_call_column
	.byte	22                              // Abbrev [22] 0x22b:0x32 DW_TAG_lexical_block
	.long	.Ltmp14                         // DW_AT_low_pc
	.long	.Ltmp33-.Ltmp14                 // DW_AT_high_pc
	.byte	19                              // Abbrev [19] 0x234:0xf DW_TAG_variable
	.long	.Ldebug_loc6                    // DW_AT_location
	.long	.Linfo_string53                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	65                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	22                              // Abbrev [22] 0x243:0x19 DW_TAG_lexical_block
	.long	.Ltmp24                         // DW_AT_low_pc
	.long	.Ltmp33-.Ltmp24                 // DW_AT_high_pc
	.byte	19                              // Abbrev [19] 0x24c:0xf DW_TAG_variable
	.long	.Ldebug_loc7                    // DW_AT_location
	.long	.Linfo_string54                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	67                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x25d:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp3                          // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x264:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp4                          // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x26b:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp8                          // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x272:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp9                          // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x279:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp12                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x280:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp17                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x287:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp22                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x28e:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp23                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x295:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp27                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x29c:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp28                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x2a3:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp29                         // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	18                              // Abbrev [18] 0x2ab:0x19a DW_TAG_subprogram
	.long	.Lfunc_begin1                   // DW_AT_low_pc
	.long	.Lfunc_end1-.Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string40                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	77                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	185                             // DW_AT_type
                                        // DW_AT_external
	.byte	19                              // Abbrev [19] 0x2c0:0xf DW_TAG_variable
	.long	.Ldebug_loc8                    // DW_AT_location
	.long	.Linfo_string49                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	78                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x2cf:0xf DW_TAG_variable
	.long	.Ldebug_loc9                    // DW_AT_location
	.long	.Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	90                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x2de:0xf DW_TAG_variable
	.long	.Ldebug_loc10                   // DW_AT_location
	.long	.Linfo_string17                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	91                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x2ed:0xf DW_TAG_variable
	.long	.Ldebug_loc11                   // DW_AT_location
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	89                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x2fc:0xf DW_TAG_variable
	.long	.Ldebug_loc12                   // DW_AT_location
	.long	.Linfo_string55                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	92                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x30b:0xf DW_TAG_variable
	.long	.Ldebug_loc13                   // DW_AT_location
	.long	.Linfo_string56                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	94                              // DW_AT_decl_line
	.long	2290                            // DW_AT_type
	.byte	19                              // Abbrev [19] 0x31a:0xf DW_TAG_variable
	.long	.Ldebug_loc14                   // DW_AT_location
	.long	.Linfo_string50                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	96                              // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x329:0xf DW_TAG_variable
	.long	.Ldebug_loc15                   // DW_AT_location
	.long	.Linfo_string52                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	97                              // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x338:0xf DW_TAG_variable
	.long	.Ldebug_loc16                   // DW_AT_location
	.long	.Linfo_string57                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	98                              // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	20                              // Abbrev [20] 0x347:0xb DW_TAG_variable
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	88                              // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x352:0xf DW_TAG_variable
	.long	.Ldebug_loc17                   // DW_AT_location
	.long	.Linfo_string53                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	100                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x361:0xf DW_TAG_variable
	.long	.Ldebug_loc19                   // DW_AT_location
	.long	.Linfo_string59                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	101                             // DW_AT_decl_line
	.long	387                             // DW_AT_type
	.byte	21                              // Abbrev [21] 0x370:0x10 DW_TAG_inlined_subroutine
	.long	394                             // DW_AT_abstract_origin
	.long	.Ltmp37                         // DW_AT_low_pc
	.long	.Ltmp39-.Ltmp37                 // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	78                              // DW_AT_call_line
	.byte	31                              // DW_AT_call_column
	.byte	24                              // Abbrev [24] 0x380:0x2a DW_TAG_lexical_block
	.long	.Ldebug_ranges0                 // DW_AT_ranges
	.byte	19                              // Abbrev [19] 0x385:0xf DW_TAG_variable
	.long	.Ldebug_loc18                   // DW_AT_location
	.long	.Linfo_string58                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	106                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	22                              // Abbrev [22] 0x394:0x15 DW_TAG_lexical_block
	.long	.Ltmp85                         // DW_AT_low_pc
	.long	.Ltmp88-.Ltmp85                 // DW_AT_high_pc
	.byte	20                              // Abbrev [20] 0x39d:0xb DW_TAG_variable
	.long	.Linfo_string54                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	122                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x3aa:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp40                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3b1:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp41                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3b8:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp47                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3bf:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp48                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3c6:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp51                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3cd:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp53                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3d4:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp55                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3db:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp57                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3e2:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp62                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3e9:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp65                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3f0:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp66                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3f7:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp67                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x3fe:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp70                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x405:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp71                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x40c:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp72                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x413:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp74                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x41a:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp75                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x421:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp76                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x428:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp79                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x42f:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp80                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x436:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp81                         // DW_AT_low_pc
	.byte	23                              // Abbrev [23] 0x43d:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp84                         // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	18                              // Abbrev [18] 0x445:0x1d DW_TAG_subprogram
	.long	.Lfunc_begin2                   // DW_AT_low_pc
	.long	.Lfunc_end2-.Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string41                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	185                             // DW_AT_type
                                        // DW_AT_external
	.byte	23                              // Abbrev [23] 0x45a:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp95                         // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	25                              // Abbrev [25] 0x462:0x2a DW_TAG_subprogram
	.long	.Linfo_string31                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	26                              // Abbrev [26] 0x46a:0xb DW_TAG_formal_parameter
	.long	.Linfo_string32                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	1164                            // DW_AT_type
	.byte	26                              // Abbrev [26] 0x475:0xb DW_TAG_formal_parameter
	.long	.Linfo_string33                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	363                             // DW_AT_type
	.byte	26                              // Abbrev [26] 0x480:0xb DW_TAG_formal_parameter
	.long	.Linfo_string34                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	6                               // Abbrev [6] 0x48c:0x5 DW_TAG_pointer_type
	.long	1169                            // DW_AT_type
	.byte	27                              // Abbrev [27] 0x491:0x1 DW_TAG_const_type
	.byte	28                              // Abbrev [28] 0x492:0xae DW_TAG_subprogram
	.long	.Lfunc_begin3                   // DW_AT_low_pc
	.long	.Lfunc_end3-.Lfunc_begin3       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string42                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x4a3:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc20                   // DW_AT_location
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x4b2:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc21                   // DW_AT_location
	.long	.Linfo_string60                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x4c1:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc22                   // DW_AT_location
	.long	.Linfo_string61                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	29                              // Abbrev [29] 0x4d0:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc23                   // DW_AT_location
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x4df:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc24                   // DW_AT_location
	.long	.Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	141                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x4ee:0xf DW_TAG_variable
	.long	.Ldebug_loc25                   // DW_AT_location
	.long	.Linfo_string62                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	142                             // DW_AT_decl_line
	.long	185                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x4fd:0xf DW_TAG_variable
	.long	.Ldebug_loc26                   // DW_AT_location
	.long	.Linfo_string63                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	143                             // DW_AT_decl_line
	.long	185                             // DW_AT_type
	.byte	30                              // Abbrev [30] 0x50c:0x2c DW_TAG_inlined_subroutine
	.long	1122                            // DW_AT_abstract_origin
	.long	.Ltmp104                        // DW_AT_low_pc
	.long	.Ltmp106-.Ltmp104               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	150                             // DW_AT_call_line
	.byte	7                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x51c:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	84
	.long	1130                            // DW_AT_abstract_origin
	.byte	32                              // Abbrev [32] 0x523:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc27                   // DW_AT_location
	.long	1141                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x52c:0xb DW_TAG_formal_parameter
	.byte	5                               // DW_AT_location
	.byte	115
	.byte	0
	.byte	51
	.byte	36
	.byte	159
	.long	1152                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x538:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp100                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	25                              // Abbrev [25] 0x540:0x2a DW_TAG_subprogram
	.long	.Linfo_string35                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	26                              // Abbrev [26] 0x548:0xb DW_TAG_formal_parameter
	.long	.Linfo_string32                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	1164                            // DW_AT_type
	.byte	26                              // Abbrev [26] 0x553:0xb DW_TAG_formal_parameter
	.long	.Linfo_string33                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	363                             // DW_AT_type
	.byte	26                              // Abbrev [26] 0x55e:0xb DW_TAG_formal_parameter
	.long	.Linfo_string34                 // DW_AT_name
	.byte	7                               // DW_AT_decl_file
	.byte	55                              // DW_AT_decl_line
	.long	66                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	28                              // Abbrev [28] 0x56a:0xae DW_TAG_subprogram
	.long	.Lfunc_begin4                   // DW_AT_low_pc
	.long	.Lfunc_end4-.Lfunc_begin4       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string43                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x57b:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc28                   // DW_AT_location
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x58a:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc29                   // DW_AT_location
	.long	.Linfo_string60                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x599:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc30                   // DW_AT_location
	.long	.Linfo_string61                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	29                              // Abbrev [29] 0x5a8:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc31                   // DW_AT_location
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x5b7:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc32                   // DW_AT_location
	.long	.Linfo_string16                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	155                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	19                              // Abbrev [19] 0x5c6:0xf DW_TAG_variable
	.long	.Ldebug_loc33                   // DW_AT_location
	.long	.Linfo_string62                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	156                             // DW_AT_decl_line
	.long	185                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x5d5:0xf DW_TAG_variable
	.long	.Ldebug_loc34                   // DW_AT_location
	.long	.Linfo_string63                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	157                             // DW_AT_decl_line
	.long	185                             // DW_AT_type
	.byte	30                              // Abbrev [30] 0x5e4:0x2c DW_TAG_inlined_subroutine
	.long	1344                            // DW_AT_abstract_origin
	.long	.Ltmp121                        // DW_AT_low_pc
	.long	.Ltmp123-.Ltmp121               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	164                             // DW_AT_call_line
	.byte	7                               // DW_AT_call_column
	.byte	32                              // Abbrev [32] 0x5f4:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc35                   // DW_AT_location
	.long	1352                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x5fd:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	85
	.long	1363                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x604:0xb DW_TAG_formal_parameter
	.byte	5                               // DW_AT_location
	.byte	115
	.byte	0
	.byte	51
	.byte	36
	.byte	159
	.long	1374                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	23                              // Abbrev [23] 0x610:0x7 DW_TAG_GNU_call_site
	.byte	1                               // DW_AT_GNU_call_site_target
	.byte	103
	.long	.Ltmp117                        // DW_AT_low_pc
	.byte	0                               // End Of Children Mark
	.byte	28                              // Abbrev [28] 0x618:0x74 DW_TAG_subprogram
	.long	.Lfunc_begin5                   // DW_AT_low_pc
	.long	.Lfunc_end5-.Lfunc_begin5       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string44                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	169                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x629:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc36                   // DW_AT_location
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	169                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x638:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc37                   // DW_AT_location
	.long	.Linfo_string60                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	169                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	33                              // Abbrev [33] 0x647:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	.Linfo_string61                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	169                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	33                              // Abbrev [33] 0x654:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	169                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	30                              // Abbrev [30] 0x661:0x2a DW_TAG_inlined_subroutine
	.long	1122                            // DW_AT_abstract_origin
	.long	.Ltmp131                        // DW_AT_low_pc
	.long	.Ltmp133-.Ltmp131               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	170                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x671:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	1130                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x678:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1141                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x67f:0xb DW_TAG_formal_parameter
	.byte	5                               // DW_AT_location
	.byte	115
	.byte	0
	.byte	51
	.byte	36
	.byte	159
	.long	1152                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	25                              // Abbrev [25] 0x68c:0x14 DW_TAG_subprogram
	.long	.Linfo_string36                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	59                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	26                              // Abbrev [26] 0x694:0xb DW_TAG_formal_parameter
	.long	.Linfo_string37                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	59                              // DW_AT_decl_line
	.long	95                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	25                              // Abbrev [25] 0x6a0:0x14 DW_TAG_subprogram
	.long	.Linfo_string38                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	84                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	1                               // DW_AT_inline
	.byte	26                              // Abbrev [26] 0x6a8:0xb DW_TAG_formal_parameter
	.long	.Linfo_string37                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	84                              // DW_AT_decl_line
	.long	95                              // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	18                              // Abbrev [18] 0x6b4:0xa7 DW_TAG_subprogram
	.long	.Lfunc_begin6                   // DW_AT_low_pc
	.long	.Lfunc_end6-.Lfunc_begin6       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string45                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	177                             // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	387                             // DW_AT_type
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x6c9:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc38                   // DW_AT_location
	.long	.Linfo_string64                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	177                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x6d8:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc39                   // DW_AT_location
	.long	.Linfo_string65                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	177                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	33                              // Abbrev [33] 0x6e7:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	.Linfo_string57                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	177                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x6f4:0xf DW_TAG_variable
	.long	.Ldebug_loc41                   // DW_AT_location
	.long	.Linfo_string66                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	178                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	30                              // Abbrev [30] 0x703:0x1a DW_TAG_inlined_subroutine
	.long	1676                            // DW_AT_abstract_origin
	.long	.Lfunc_begin6                   // DW_AT_low_pc
	.long	.Ltmp137-.Lfunc_begin6          // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	180                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	32                              // Abbrev [32] 0x713:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc40                   // DW_AT_location
	.long	1684                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x71d:0x25 DW_TAG_inlined_subroutine
	.long	1122                            // DW_AT_abstract_origin
	.long	.Ltmp138                        // DW_AT_low_pc
	.long	.Ltmp139-.Ltmp138               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	181                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x72d:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	1130                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x734:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1141                            // DW_AT_abstract_origin
	.byte	34                              // Abbrev [34] 0x73b:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	1152                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x742:0x18 DW_TAG_inlined_subroutine
	.long	1696                            // DW_AT_abstract_origin
	.long	.Ltmp142                        // DW_AT_low_pc
	.long	.Ltmp144-.Ltmp142               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	183                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x752:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	1704                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	18                              // Abbrev [18] 0x75b:0xcc DW_TAG_subprogram
	.long	.Lfunc_begin7                   // DW_AT_low_pc
	.long	.Lfunc_end7-.Lfunc_begin7       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string46                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	188                             // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	387                             // DW_AT_type
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x770:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc42                   // DW_AT_location
	.long	.Linfo_string64                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	188                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x77f:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc43                   // DW_AT_location
	.long	.Linfo_string65                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	188                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	33                              // Abbrev [33] 0x78e:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	.Linfo_string57                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	188                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x79b:0xf DW_TAG_variable
	.long	.Ldebug_loc45                   // DW_AT_location
	.long	.Linfo_string66                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	189                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	30                              // Abbrev [30] 0x7aa:0x1a DW_TAG_inlined_subroutine
	.long	1676                            // DW_AT_abstract_origin
	.long	.Lfunc_begin7                   // DW_AT_low_pc
	.long	.Ltmp148-.Lfunc_begin7          // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	191                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	32                              // Abbrev [32] 0x7ba:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc44                   // DW_AT_location
	.long	1684                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x7c4:0x25 DW_TAG_inlined_subroutine
	.long	1122                            // DW_AT_abstract_origin
	.long	.Ltmp149                        // DW_AT_low_pc
	.long	.Ltmp150-.Ltmp149               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	192                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x7d4:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	84
	.long	1130                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x7db:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1141                            // DW_AT_abstract_origin
	.byte	34                              // Abbrev [34] 0x7e2:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	1152                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x7e9:0x25 DW_TAG_inlined_subroutine
	.long	1344                            // DW_AT_abstract_origin
	.long	.Ltmp154                        // DW_AT_low_pc
	.long	.Ltmp155-.Ltmp154               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	195                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x7f9:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1352                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x800:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	84
	.long	1363                            // DW_AT_abstract_origin
	.byte	34                              // Abbrev [34] 0x807:0x6 DW_TAG_formal_parameter
	.byte	8                               // DW_AT_const_value
	.long	1374                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x80e:0x18 DW_TAG_inlined_subroutine
	.long	1696                            // DW_AT_abstract_origin
	.long	.Ltmp155                        // DW_AT_low_pc
	.long	.Ltmp157-.Ltmp155               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	196                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x81e:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	1704                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	28                              // Abbrev [28] 0x827:0x74 DW_TAG_subprogram
	.long	.Lfunc_begin8                   // DW_AT_low_pc
	.long	.Lfunc_end8-.Lfunc_begin8       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string47                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	173                             // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	29                              // Abbrev [29] 0x838:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc46                   // DW_AT_location
	.long	.Linfo_string51                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	173                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	29                              // Abbrev [29] 0x847:0xf DW_TAG_formal_parameter
	.long	.Ldebug_loc47                   // DW_AT_location
	.long	.Linfo_string60                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	173                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	33                              // Abbrev [33] 0x856:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	.Linfo_string61                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	173                             // DW_AT_decl_line
	.long	364                             // DW_AT_type
	.byte	33                              // Abbrev [33] 0x863:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	83
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	173                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	30                              // Abbrev [30] 0x870:0x2a DW_TAG_inlined_subroutine
	.long	1344                            // DW_AT_abstract_origin
	.long	.Ltmp159                        // DW_AT_low_pc
	.long	.Ltmp161-.Ltmp159               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	174                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x880:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	82
	.long	1352                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x887:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	80
	.long	1363                            // DW_AT_abstract_origin
	.byte	31                              // Abbrev [31] 0x88e:0xb DW_TAG_formal_parameter
	.byte	5                               // DW_AT_location
	.byte	115
	.byte	0
	.byte	51
	.byte	36
	.byte	159
	.long	1374                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	35                              // Abbrev [35] 0x89b:0x57 DW_TAG_subprogram
	.long	.Lfunc_begin9                   // DW_AT_low_pc
	.long	.Lfunc_end9-.Lfunc_begin9       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	.Linfo_string48                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	133                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
                                        // DW_AT_external
	.byte	19                              // Abbrev [19] 0x8b0:0xf DW_TAG_variable
	.long	.Ldebug_loc49                   // DW_AT_location
	.long	.Linfo_string67                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	135                             // DW_AT_decl_line
	.long	55                              // DW_AT_type
	.byte	30                              // Abbrev [30] 0x8bf:0x1a DW_TAG_inlined_subroutine
	.long	1676                            // DW_AT_abstract_origin
	.long	.Lfunc_begin9                   // DW_AT_low_pc
	.long	.Ltmp165-.Lfunc_begin9          // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	134                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	32                              // Abbrev [32] 0x8cf:0x9 DW_TAG_formal_parameter
	.long	.Ldebug_loc48                   // DW_AT_location
	.long	1684                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	30                              // Abbrev [30] 0x8d9:0x18 DW_TAG_inlined_subroutine
	.long	1696                            // DW_AT_abstract_origin
	.long	.Ltmp167                        // DW_AT_low_pc
	.long	.Ltmp169-.Ltmp167               // DW_AT_high_pc
	.byte	2                               // DW_AT_call_file
	.byte	137                             // DW_AT_call_line
	.byte	5                               // DW_AT_call_column
	.byte	31                              // Abbrev [31] 0x8e9:0x7 DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	1704                            // DW_AT_abstract_origin
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x8f2:0x5 DW_TAG_const_type
	.long	55                              // DW_AT_type
	.byte	0                               // End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.Ltmp61
	.long	.Ltmp63
	.long	.Ltmp64
	.long	.Ltmp88
	.long	0
	.long	0
.Ldebug_ranges1:
	.long	.Lfunc_begin0
	.long	.Lfunc_end0
	.long	.Lfunc_begin1
	.long	.Lfunc_end1
	.long	.Lfunc_begin2
	.long	.Lfunc_end2
	.long	.Lfunc_begin3
	.long	.Lfunc_end3
	.long	.Lfunc_begin4
	.long	.Lfunc_end4
	.long	.Lfunc_begin5
	.long	.Lfunc_end5
	.long	.Lfunc_begin6
	.long	.Lfunc_end6
	.long	.Lfunc_begin7
	.long	.Lfunc_end7
	.long	.Lfunc_begin8
	.long	.Lfunc_end8
	.long	.Lfunc_begin9
	.long	.Lfunc_end9
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
.Linfo_string1:
	.asciz	"/root/uPIMulator/benchmark/TRNS/dpu/task.c" // string offset=106
.Linfo_string2:
	.asciz	"/root/uPIMulator/benchmark/build" // string offset=149
.Linfo_string3:
	.asciz	"curr_tile"                     // string offset=182
.Linfo_string4:
	.asciz	"unsigned int"                  // string offset=192
.Linfo_string5:
	.asciz	"uint32_t"                      // string offset=205
.Linfo_string6:
	.asciz	"tile_mutex"                    // string offset=214
.Linfo_string7:
	.asciz	"unsigned char"                 // string offset=225
.Linfo_string8:
	.asciz	"uint8_t"                       // string offset=239
.Linfo_string9:
	.asciz	"mutex_id_t"                    // string offset=247
.Linfo_string10:
	.asciz	"done_mutex"                    // string offset=258
.Linfo_string11:
	.asciz	"kernels"                       // string offset=269
.Linfo_string12:
	.asciz	"int"                           // string offset=277
.Linfo_string13:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=281
.Linfo_string14:
	.asciz	"DPU_INPUT_ARGUMENTS"           // string offset=301
.Linfo_string15:
	.asciz	"m"                             // string offset=321
.Linfo_string16:
	.asciz	"n"                             // string offset=323
.Linfo_string17:
	.asciz	"M_"                            // string offset=325
.Linfo_string18:
	.asciz	"kernel"                        // string offset=328
.Linfo_string19:
	.asciz	"kernel1"                       // string offset=335
.Linfo_string20:
	.asciz	"kernel2"                       // string offset=343
.Linfo_string21:
	.asciz	"nr_kernels"                    // string offset=351
.Linfo_string22:
	.asciz	"dpu_arguments_t"               // string offset=362
.Linfo_string23:
	.asciz	"__atomic_bit_barrier_my_barrier" // string offset=378
.Linfo_string24:
	.asciz	"__atomic_bit_mutex_tile_mutex" // string offset=410
.Linfo_string25:
	.asciz	"__atomic_bit_mutex_done_mutex" // string offset=440
.Linfo_string26:
	.asciz	"long long int"                 // string offset=470
.Linfo_string27:
	.asciz	"int64_t"                       // string offset=484
.Linfo_string28:
	.asciz	"_Bool"                         // string offset=492
.Linfo_string29:
	.asciz	"me"                            // string offset=498
.Linfo_string30:
	.asciz	"sysname_t"                     // string offset=501
.Linfo_string31:
	.asciz	"mram_read"                     // string offset=511
.Linfo_string32:
	.asciz	"from"                          // string offset=521
.Linfo_string33:
	.asciz	"to"                            // string offset=526
.Linfo_string34:
	.asciz	"nb_of_bytes"                   // string offset=529
.Linfo_string35:
	.asciz	"mram_write"                    // string offset=541
.Linfo_string36:
	.asciz	"mutex_lock"                    // string offset=552
.Linfo_string37:
	.asciz	"mutex"                         // string offset=563
.Linfo_string38:
	.asciz	"mutex_unlock"                  // string offset=569
.Linfo_string39:
	.asciz	"main_kernel1"                  // string offset=582
.Linfo_string40:
	.asciz	"main_kernel2"                  // string offset=595
.Linfo_string41:
	.asciz	"main"                          // string offset=608
.Linfo_string42:
	.asciz	"read_tile_step2"               // string offset=613
.Linfo_string43:
	.asciz	"write_tile_step2"              // string offset=629
.Linfo_string44:
	.asciz	"read_tile_step3"               // string offset=646
.Linfo_string45:
	.asciz	"get_done"                      // string offset=662
.Linfo_string46:
	.asciz	"get_and_set_done"              // string offset=671
.Linfo_string47:
	.asciz	"write_tile_step3"              // string offset=688
.Linfo_string48:
	.asciz	"get_tile"                      // string offset=705
.Linfo_string49:
	.asciz	"tasklet_id"                    // string offset=714
.Linfo_string50:
	.asciz	"data"                          // string offset=725
.Linfo_string51:
	.asciz	"A"                             // string offset=730
.Linfo_string52:
	.asciz	"backup"                        // string offset=732
.Linfo_string53:
	.asciz	"tile"                          // string offset=739
.Linfo_string54:
	.asciz	"i"                             // string offset=744
.Linfo_string55:
	.asciz	"done_array"                    // string offset=746
.Linfo_string56:
	.asciz	"tile_max"                      // string offset=757
.Linfo_string57:
	.asciz	"read_done"                     // string offset=766
.Linfo_string58:
	.asciz	"next_in_cycle"                 // string offset=776
.Linfo_string59:
	.asciz	"done"                          // string offset=790
.Linfo_string60:
	.asciz	"offset"                        // string offset=795
.Linfo_string61:
	.asciz	"variable"                      // string offset=802
.Linfo_string62:
	.asciz	"rest"                          // string offset=811
.Linfo_string63:
	.asciz	"transfer"                      // string offset=816
.Linfo_string64:
	.asciz	"done_array_step3"              // string offset=825
.Linfo_string65:
	.asciz	"address"                       // string offset=842
.Linfo_string66:
	.asciz	"result"                        // string offset=850
.Linfo_string67:
	.asciz	"value"                         // string offset=857
	.addrsig
	.addrsig_sym main_kernel1
	.addrsig_sym main_kernel2
	.addrsig_sym __atomic_bit_mutex_tile_mutex
	.addrsig_sym __atomic_bit_mutex_done_mutex
	.addrsig_sym DPU_INPUT_ARGUMENTS
	.addrsig_sym my_barrier
	.addrsig_sym __sys_used_mram_end
	.section	.debug_line,"",@progbits
.Lline_table_start0:
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
	.file	"div32.c"
	.section	.text.__udiv32,"ax",@progbits
	.globl	__udiv32                        // -- Begin function __udiv32
	.type	__udiv32,@function
__udiv32:                               // @__udiv32
syslib.div32..Lfunc_begin0:
	.file	1 "/root/uPIMulator/sdk" "syslib/div32.c"
	.loc	1 9 0                           // syslib/div32.c:9:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	.loc	1 10 5 prologue_end             // syslib/div32.c:10:5
	// inline asm

	clz r3, r1, max, syslib.div32.__udiv32_division_by_zero
	clz r4, r0
	sub r3, r4, r3, gtu, syslib.div32.__udiv32_result_0
	move r4, r1
	move.u d0, r0
	jump r3, syslib.div32.__udiv32_base
	div_step d0, r4, d0, 31
	div_step d0, r4, d0, 30
	div_step d0, r4, d0, 29
	div_step d0, r4, d0, 28
	div_step d0, r4, d0, 27
	div_step d0, r4, d0, 26
	div_step d0, r4, d0, 25
	div_step d0, r4, d0, 24
	div_step d0, r4, d0, 23
	div_step d0, r4, d0, 22
	div_step d0, r4, d0, 21
	div_step d0, r4, d0, 20
	div_step d0, r4, d0, 19
	div_step d0, r4, d0, 18
	div_step d0, r4, d0, 17
	div_step d0, r4, d0, 16
	div_step d0, r4, d0, 15
	div_step d0, r4, d0, 14
	div_step d0, r4, d0, 13
	div_step d0, r4, d0, 12
	div_step d0, r4, d0, 11
	div_step d0, r4, d0, 10
	div_step d0, r4, d0, 9
	div_step d0, r4, d0, 8
	div_step d0, r4, d0, 7
	div_step d0, r4, d0, 6
	div_step d0, r4, d0, 5
	div_step d0, r4, d0, 4
	div_step d0, r4, d0, 3
	div_step d0, r4, d0, 2
	div_step d0, r4, d0, 1
syslib.div32.__udiv32_base:
	div_step d0, r4, d0, 0
syslib.div32.__udiv32_exit:
	jump r23
syslib.div32.__udiv32_result_0:
	move.u d0, r0, true, syslib.div32.__udiv32_exit
syslib.div32.__udiv32_division_by_zero:
	fault 2
	// inline asm
syslib.div32..Ltmp0:
syslib.div32..Lfunc_end0:
	.size	__udiv32, syslib.div32..Lfunc_end0-__udiv32
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__udiv32
	.long	syslib.div32..Lfunc_begin0
	.byte	0
	.section	.text.__udiv32,"ax",@progbits
                                        // -- End function
	.section	.text.__div32,"ax",@progbits
	.globl	__div32                         // -- Begin function __div32
	.type	__div32,@function
__div32:                                // @__div32
syslib.div32..Lfunc_begin1:
	.loc	1 59 0                          // syslib/div32.c:59:0
	.cfi_startproc
// %bb.0:
	.loc	1 60 5 prologue_end             // syslib/div32.c:60:5
	// inline asm

	sd r22, 0, d22
	add r22, r22, 8
	clo r3, r0, z, syslib.div32.__div32_pos_dividend
	clo r3, r1, z, syslib.div32.__div32_neg_dividend_pos_divider
syslib.div32.__div32_neg_dividend_neg_divider:
	neg r0, r0
	neg r1, r1
	call r23, __udiv32
	neg r1, r1, true, syslib.div32.__div32_exit
syslib.div32.__div32_neg_dividend_pos_divider:
	neg r0, r0
	call r23, __udiv32
	neg r1, r1
	neg r0, r0, true, syslib.div32.__div32_exit
syslib.div32.__div32_pos_dividend:
	clo r3, r1, z, syslib.div32.__div32_pos_dividend_pos_divider
	neg r1, r1
	call r23, __udiv32
	neg r0, r0, true, syslib.div32.__div32_exit
syslib.div32.__div32_pos_dividend_pos_divider:
	call r23, __udiv32
syslib.div32.__div32_exit:
	ld d22, r22, -8
	jump r23

	// inline asm
syslib.div32..Ltmp1:
syslib.div32..Lfunc_end1:
	.size	__div32, syslib.div32..Lfunc_end1-__div32
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__div32
	.long	syslib.div32..Lfunc_begin1
	.byte	0
	.section	.text.__div32,"ax",@progbits
                                        // -- End function
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
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
syslib.div32..Lcu_begin0:
	.long	syslib.div32..Ldebug_info_end0-syslib.div32..Ldebug_info_start0 // Length of Unit
syslib.div32..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x3e DW_TAG_compile_unit
	.long	syslib.div32..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.div32..Linfo_string1                  // DW_AT_name
	.long	syslib.div32..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.div32..Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	syslib.div32..Ldebug_ranges0                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x11 DW_TAG_subprogram
	.long	syslib.div32..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.div32..Lfunc_end0-syslib.div32..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.div32..Linfo_string3                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	8                               // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	2                               // Abbrev [2] 0x37:0x11 DW_TAG_subprogram
	.long	syslib.div32..Lfunc_begin1                   // DW_AT_low_pc
	.long	syslib.div32..Lfunc_end1-syslib.div32..Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.div32..Linfo_string4                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	58                              // DW_AT_decl_line
                                        // DW_AT_prototyped
                                        // DW_AT_external
	.byte	0                               // End Of Children Mark
syslib.div32..Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
syslib.div32..Ldebug_ranges0:
	.long	syslib.div32..Lfunc_begin0
	.long	syslib.div32..Lfunc_end0
	.long	syslib.div32..Lfunc_begin1
	.long	syslib.div32..Lfunc_end1
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
syslib.div32..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.div32..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/div32.c" // string offset=106
syslib.div32..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=142
syslib.div32..Linfo_string3:
	.asciz	"__udiv32"                      // string offset=169
syslib.div32..Linfo_string4:
	.asciz	"__div32"                       // string offset=178
	.addrsig
	.section	.debug_line,"",@progbits
syslib.div32..Lline_table_start0:
	.text
	.file	"mul32.c"
	.section	.text.__mulsi3,"ax",@progbits
	.globl	__mulsi3                        // -- Begin function __mulsi3
	.type	__mulsi3,@function
__mulsi3:                               // @__mulsi3
syslib.mul32..Lfunc_begin0:
	.file	1 "/root/uPIMulator/sdk" "syslib/mul32.c"
	.loc	1 9 0                           // syslib/mul32.c:9:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	//DEBUG_VALUE: __mulsi3:a <- $r0
	//DEBUG_VALUE: __mulsi3:a <- $r0
	//DEBUG_VALUE: __mulsi3:b <- $r1
	//DEBUG_VALUE: __mulsi3:b <- $r1
	.cfi_def_cfa_offset 0
	.loc	1 11 5 prologue_end             // syslib/mul32.c:11:5
	// inline asm
	jgtu r1, r0, syslib.mul32.__mulsi3_swap
	move r2, r0
	move r0, r1, true, syslib.mul32.__mulsi3_start
syslib.mul32.__mulsi3_swap:
	move r2, r1
	move r0, r0
syslib.mul32.__mulsi3_start:
	move r1, zero
	mul_step d0, r2, d0, 0, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 1, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 2, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 3, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 4, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 5, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 6, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 7, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 8, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 9, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 10, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 11, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 12, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 13, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 14, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 15, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 16, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 17, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 18, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 19, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 20, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 21, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 22, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 23, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 24, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 25, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 26, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 27, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 28, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 29, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 30, z, syslib.mul32.__mulsi3_exit
	mul_step d0, r2, d0, 31, z, syslib.mul32.__mulsi3_exit
syslib.mul32.__mulsi3_exit:
	move r0, r1

	// inline asm
syslib.mul32..Ltmp0:
	//DEBUG_VALUE: __mulsi3:dest <- $r0
	.loc	1 55 5                          // syslib/mul32.c:55:5
	jump r23
syslib.mul32..Ltmp1:
syslib.mul32..Lfunc_end0:
	.size	__mulsi3, syslib.mul32..Lfunc_end0-__mulsi3
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.__mulsi3
	.long	syslib.mul32..Lfunc_begin0
	.byte	0
	.section	.text.__mulsi3,"ax",@progbits
                                        // -- End function
	.section	.debug_loc,"",@progbits
syslib.mul32..Ldebug_loc0:
	.long	syslib.mul32..Lfunc_begin0-syslib.mul32..Lfunc_begin0
	.long	syslib.mul32..Ltmp0-syslib.mul32..Lfunc_begin0
	.short	1                               // Loc expr size
	.byte	80                              // DW_OP_reg0
	.long	0
	.long	0
syslib.mul32..Ldebug_loc1:
	.long	syslib.mul32..Ltmp0-syslib.mul32..Lfunc_begin0
	.long	syslib.mul32..Lfunc_end0-syslib.mul32..Lfunc_begin0
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
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
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
	.byte	4                               // Abbreviation Code
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
syslib.mul32..Lcu_begin0:
	.long	syslib.mul32..Ldebug_info_end0-syslib.mul32..Ldebug_info_start0 // Length of Unit
syslib.mul32..Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x64 DW_TAG_compile_unit
	.long	syslib.mul32..Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	syslib.mul32..Linfo_string1                  // DW_AT_name
	.long	syslib.mul32..Lline_table_start0             // DW_AT_stmt_list
	.long	syslib.mul32..Linfo_string2                  // DW_AT_comp_dir
	.long	syslib.mul32..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.mul32..Lfunc_end0-syslib.mul32..Lfunc_begin0       // DW_AT_high_pc
	.byte	2                               // Abbrev [2] 0x26:0x41 DW_TAG_subprogram
	.long	syslib.mul32..Lfunc_begin0                   // DW_AT_low_pc
	.long	syslib.mul32..Lfunc_end0-syslib.mul32..Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
                                        // DW_AT_GNU_all_call_sites
	.long	syslib.mul32..Linfo_string3                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	8                               // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	103                             // DW_AT_type
                                        // DW_AT_external
	.byte	3                               // Abbrev [3] 0x3b:0xf DW_TAG_formal_parameter
	.long	syslib.mul32..Ldebug_loc0                    // DW_AT_location
	.long	syslib.mul32..Linfo_string5                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	8                               // DW_AT_decl_line
	.long	103                             // DW_AT_type
	.byte	4                               // Abbrev [4] 0x4a:0xd DW_TAG_formal_parameter
	.byte	1                               // DW_AT_location
	.byte	81
	.long	syslib.mul32..Linfo_string6                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	8                               // DW_AT_decl_line
	.long	103                             // DW_AT_type
	.byte	5                               // Abbrev [5] 0x57:0xf DW_TAG_variable
	.long	syslib.mul32..Ldebug_loc1                    // DW_AT_location
	.long	syslib.mul32..Linfo_string7                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	10                              // DW_AT_decl_line
	.long	103                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	6                               // Abbrev [6] 0x67:0x7 DW_TAG_base_type
	.long	syslib.mul32..Linfo_string4                  // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	0                               // End Of Children Mark
syslib.mul32..Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
syslib.mul32..Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git 846fdda8285dcc9b20ee5d2fec9e54dfea6a8928)" // string offset=0
syslib.mul32..Linfo_string1:
	.asciz	"/root/uPIMulator/sdk/syslib/mul32.c" // string offset=106
syslib.mul32..Linfo_string2:
	.asciz	"/root/uPIMulator/sdk/build"    // string offset=142
syslib.mul32..Linfo_string3:
	.asciz	"__mulsi3"                      // string offset=169
syslib.mul32..Linfo_string4:
	.asciz	"int"                           // string offset=178
syslib.mul32..Linfo_string5:
	.asciz	"a"                             // string offset=182
syslib.mul32..Linfo_string6:
	.asciz	"b"                             // string offset=184
syslib.mul32..Linfo_string7:
	.asciz	"dest"                          // string offset=186
	.addrsig
	.section	.debug_line,"",@progbits
syslib.mul32..Lline_table_start0:
