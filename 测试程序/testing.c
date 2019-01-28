#include <stdlib.h>
#include <stdio.h>


int main()
{
    char t;
    int i = 0x12345678;

    t = *(char *)&i;
    printf("i to char %x\r\n", t);    

     union{
        int i;
        char s[2];
    }c;

    c.i = 0x0102;

    return 0;
}