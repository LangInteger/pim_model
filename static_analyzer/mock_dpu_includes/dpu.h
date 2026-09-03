
#ifndef DPU_H
#define DPU_H
#include <stdint.h>
#include <stdbool.h>
typedef struct dpu_set_t { void* dpu; } dpu_set_t;
typedef void* dpu_t;
#define DPU_ASSERT(expr) expr
#define DPU_FOREACH(set, iter, idx) for(idx=0; idx<NR_DPUS; idx++)
#define DPU_FOREACH_DPU(set, iter) for(int _idx=0; _idx<NR_DPUS; _idx++) // Approximate for two-arg version
#define DPU_XFER_TO_DPU 1
#define DPU_XFER_FROM_DPU 2
#define DPU_MRAM_HEAP_POINTER_NAME "mram"
#define DPU_XFER_DEFAULT 0
#define DPU_SYNCHRONOUS 1
int dpu_alloc(int, void*, dpu_set_t*);
int dpu_load(dpu_set_t, const char*, void*);
int dpu_get_nr_dpus(dpu_set_t, uint32_t*);
int dpu_prepare_xfer(dpu_set_t, void*);
int dpu_push_xfer(dpu_set_t, int, const char*, int, int, int);
int dpu_launch(dpu_set_t, int);
int dpu_free(dpu_set_t);
// Logging mock
#endif

