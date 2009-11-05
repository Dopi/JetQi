/*
 * (C) Copyright 2008 Openmoko, Inc.
 * Author: Andy Green <andy@openmoko.org>
 *
 * Little utils for print and strings
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <qi.h>
#include <stddef.h>

extern void (*putc_func)(char);

/*
 * malloc pool needs to be in phase 2 bss section, we have phase 1 bss in
 * steppingstone to allow full memory range testing in C
 */
u8 malloc_pool[MALLOC_POOL_EXTENT];
void * malloc_pointer = &malloc_pool[0];


/* improbably simple malloc and free for small and non-intense allocation
 * just moves the allocation ptr forward each time and ignores free
 */

void *malloc(size_t size)
{
	void *p = malloc_pointer;

	malloc_pointer += (size & ~3) + 4;

	if (((u8 *)malloc_pointer - &malloc_pool[0]) > sizeof(malloc_pool)) {
		puts("Ran out of malloc pool\n");
		while (1)
			;
	}

	return p;
}

void free(void *ptr)
{
}

char *strncpy(char *dest, const char *src, size_t n)
{
	char * dest_orig = dest;

	while (*src && n--)
		*dest++ = *src++;

	if (n)
		*dest = '\0';

	return dest_orig;
}


int strcmp(const char *s1, const char *s2)
{
	while (1) {
		if (*s1 != *s2)
			return *s1 - *s2;
		if (!*s1)
			return 0;
		s1++;
		s2++;
	}
}

char *strchr(const char *s, int c)
{
	while ((*s) && (*s != c))
		s++;

	if (*s == c)
		return (char *)s;

	return NULL;
}

void hexdump(unsigned char *start, int len)
{
	int n;

	while (len > 0) {
		print32((int)start);
		(putc_func)(':');
		(putc_func)(' ');
		for (n = 0; n < 16; n++) {
			print8(*start++);
			(putc_func)(' ');
		}
		(putc_func)('\n');
		len -= 16;
	}
}

void setnybble(char *p, unsigned char n)
{
	if (n < 10)
		*p = '0' + n;
	else
		*p = 'a' + n - 10;
}

void set8(char *p, unsigned char n)
{
	setnybble(p, (n >> 4) & 15);
	setnybble(p + 1, n & 15);
}

void set32(char *p, unsigned int u)
{
	set8(p, u >> 24);
	set8(p + 2, u >> 16);
	set8(p + 4, u >> 8);
	set8(p + 6, u);
}
