
#include <stdio.h>

char *msg = "Hello world!\n";

main()
{
        printf(msg);
        msg[10] = 'X';
        printf(msg);
}
