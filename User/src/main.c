#include "stm32f10x.h"
#include "bsp_tty.h"

int main(void)
{
    TTY_Config();

    while ( 1 )
    {
        // TTY demo
        putstr("Enter an integer here: ");
        tty_scan("%d", &time);
        tty_print("It's %d\r\n", time);
    }

}


/* ------------------------------------------end of file---------------------------------------- */

