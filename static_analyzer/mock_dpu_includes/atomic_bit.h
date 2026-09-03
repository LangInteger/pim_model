#ifndef MOCK_DPU_ATOMIC_BIT_H
#define MOCK_DPU_ATOMIC_BIT_H

#include <stdint.h>

#define MOCK_DPU_CONCAT_INNER(left, right) left##right
#define MOCK_DPU_CONCAT(left, right) MOCK_DPU_CONCAT_INNER(left, right)
#define ATOMIC_BIT_GET(name) MOCK_DPU_CONCAT(__atomic_bit_, name)
#define ATOMIC_BIT_INIT(name) uint8_t ATOMIC_BIT_GET(name)

#endif
