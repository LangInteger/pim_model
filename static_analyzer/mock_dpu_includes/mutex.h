#ifndef MUTEX_H
#define MUTEX_H

typedef unsigned int mutex_id_t;

#define MUTEX_INIT(name) mutex_id_t name;
#define MUTEX_GET(mutex) (mutex)

void mutex_lock(mutex_id_t mutex);
void mutex_unlock(mutex_id_t mutex);

#endif
