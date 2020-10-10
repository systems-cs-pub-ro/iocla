#include <stdio.h>

int main() {
	unsigned int a = 4127;
	int b = -27714;
	short c = 1475;
	int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};

	unsigned int *int_ptr = (unsigned int *) &v;

	for (int i = 0 ; i < sizeof(v) / sizeof(*int_ptr) ; ++i) {
		++int_ptr;
	}

	return 0;
}
