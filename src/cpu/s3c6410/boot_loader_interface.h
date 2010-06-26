#ifndef BOOT_LOADER_IF_H
#define BOOT_LOADER_IF_H

#define LCD_color_white		0xFFFF	
#define LCD_color_yellow	0xFFE0	
#define LCD_color_red		0xF800	

void jump_Baseband_Init (void);

void enable_SD_LDO (void);
void disable_SD_LDO (void);

void wait_5s (void);
void wait_10s (void);

int LCD_print_col (char *string, int color, int line_number );
int LCD_print (char *string, int line_number );
int LCD_print_newline_col (char *string, int color);
int LCD_print_newline (char *string);
int LCD_print_multiline(char *string);
int LCD_print_String_Int(char *string, int number);
void concat(char a[], char b[], char con[]);
void itoa(int n, char s[]);
void reverse(char s[]);
size_t strlen2(const char * str);

void JetDroid_mode_MSG(void);
#endif

