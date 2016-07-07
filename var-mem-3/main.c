#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define TOTAL_BYTE 512000000
#define PAGE_BYTE 4096

int main(int argc, char* argv[]){
	sleep(3);
	char *test_ptr;
	int i = 0;
    int num_pages = TOTAL_BYTE / PAGE_BYTE;
    int page_index = 0;
    setbuf(stdout, NULL);

//    printf("NOW: %llu\n", NOW());

    test_ptr = (char *)malloc(TOTAL_BYTE*sizeof(char));
    if(test_ptr == NULL)
    {
        printf("err malloc ...\n");
        return -1;
    }

	for (i = 0; i < num_pages; i++){
		fflush(stdout);
        test_ptr[i * PAGE_BYTE] = 0x0;
	
    }
        printf(" The final page index is: %d / %d\n", i , num_pages);
        free(test_ptr);

        sleep(5);
    
 //       printf("NOW: %llu", NOW());

        return 0;
}



