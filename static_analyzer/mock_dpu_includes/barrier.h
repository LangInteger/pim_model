#ifndef BARRIER_H
#define BARRIER_H
#include <stdint.h>
typedef struct barrier_t {
    uint8_t wait_queue;
    uint8_t count;
    uint8_t initial_count;
    uint8_t lock;
} barrier_t;
#define BARRIER_INIT(name, count) barrier_t name;
void barrier_wait(barrier_t *b);
#endif
