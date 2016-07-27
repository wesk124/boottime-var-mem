#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint16_t domid_t;

#include <xenbus.h>

#define READ_PATH	"/test/read_access"

int main(void) {
    char *val, *err;
    struct timespec ts;
    int i;

    val = (char *)malloc(128 * sizeof(char));
    err = (char *)malloc(128 * sizeof(char));
    
    sleep(3);

	err = xenbus_read(XBT_NIL, READ_PATH, &val);
	if(err != NULL)
	{
		printf("Error reading in %s: %s\n", READ_PATH, err);
		goto out_free;
	}

    ts.tv_sec = 0;
    ts.tv_nsec = atol(val);

    while(1) {
        i = rand()%0xFFFFFFFF;
        nanosleep(&ts, NULL);
    }

out_free:
	free(val);
	free(err);

    return 0;
      

}
