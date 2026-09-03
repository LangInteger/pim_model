#ifndef MRAM_H
#define MRAM_H
void mram_read(const void *src, void *dst, unsigned int size);
void mram_write(const void *src, void *dst, unsigned int size);
#endif
