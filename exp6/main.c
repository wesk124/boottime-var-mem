#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint16_t domid_t;

#include <xenbus.h>

#define READ_PATH	"/test/read_access"
#define WRITE_PATH	"/test/write_access"
//#define WRITE_DATA	"abcdefg"

int main(void) {
    //char write_data [128];
    char *val, *err;
    int i;

    val = (char *)malloc(128 * sizeof(char));
    err = (char *)malloc(128 * sizeof(char));


    //sprintf(write_data, "%llu", ull2 - ull1);    
    //printf("%s\n", write_data);// check if the string is what we want

    printf("read data begin \n");
	// READ test: reading in READ_PATH and printing the value 
	err = xenbus_read(XBT_NIL, READ_PATH, &val);
	if(err != NULL)
	{
		printf("Error reading in %s: %s\n", READ_PATH, err);
		goto out_free;
	}
	printf("Read '%s': %s\n", READ_PATH, val);

//	// WRITE test: writing in WRITE_PATH, then reading it and printing the value
//	err = xenbus_write(XBT_NIL, WRITE_PATH, val);
//	if(err != NULL)
//	{
//		printf("Error writing in %s: %s\n", WRITE_PATH, err);
//		goto out_free;
//	}
//	printf("Written in '%s': %s\n", WRITE_PATH, val);
//
//	err = xenbus_read(XBT_NIL, WRITE_PATH, &val);
//	if(err != NULL)
//	{
//		printf("Error reading in '%s': %s\n", WRITE_PATH, err);
//		goto out_free;
//	}

    
    i = atoi(val);
    printf("Read  val in integer: %d\n: ", i );

    sleep(2);
   
    while(1) {
        usleep(i);
    }

//	printf("Read '%s': %s\n", WRITE_PATH, val);

out_free:
	free(val);
	free(err);

    return 0;
      

}
