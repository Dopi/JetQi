#ifndef UTILS_H
#define UTILS_H

#include <stddef.h>

size_t strlen(const char*);
char *strcpy(char*, const char*);
int puts(const char*);
void printnybble(unsigned char);
void print8(unsigned char);
void print32(unsigned int);
void printdec(int);
void *memcpy(void*, const void*, size_t);
void *memset(void*, int, size_t);
void delay(unsigned long);
void udelay(unsigned long);

/* phase 2 */
void *malloc(size_t);
void free(void*);
char *strncpy(char*, const char*, size_t);
int strcmp(const char*, const char*);
char *strchr(const char*, int);
void hexdump(unsigned char*, int);
void setnybble(char*, unsigned char);
void set8(char*, unsigned char);
void set32(char*, unsigned int);

#endif
