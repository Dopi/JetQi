#ifndef JETQ_H
#define JETQ_H

#include <qi.h>

extern const struct board_api board_api_jet;

void led_set(int);
void led_blink(int, int);
void poweroff(void);
void set_lcd_backlight(int);
int sd_card_block_read_jet(unsigned char*, unsigned long, int);

#endif
