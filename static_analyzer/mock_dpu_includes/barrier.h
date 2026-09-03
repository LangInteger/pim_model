#ifndef BARRIER_H
#define BARRIER_H
typedef struct barrier_t {} barrier_t;
#define BARRIER_INIT(name, count) barrier_t name;
void barrier_wait(barrier_t *b);
#endif
