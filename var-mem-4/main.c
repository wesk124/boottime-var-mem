#include <stdio.h>
#include <unistd.h>

int main(void) {
        sleep(3);
        while(1)
            sleep(1);
            printf("Hello\n");
        return 0;
}
