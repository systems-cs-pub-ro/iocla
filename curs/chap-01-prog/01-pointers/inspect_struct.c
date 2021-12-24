#include <stdio.h>

struct my_struct {
	unsigned int salary;  /* offset: 0 */
	unsigned char sex; /* 3 bytes padding */ /* offset: 4 */
	unsigned int passport_number; /* aligned to 4 */ /* offset: 8 */
	unsigned char age;  /* 3 bytes padding */ /* offset: 12 */
};

static struct my_struct ben = {
	5691,
	1,
	839291123,
	42,
};

int main(void)
{
	printf("sizeof(strut my_struct): %zu\n", sizeof(struct my_struct));

	printf("ben.salary: %u, ben.sex: %u, ben.passport_number: %u, ben.age: %u\n",
			ben.salary, ben.sex, ben.passport_number, ben.age);
	printf("&ben.salary: %p, &ben.sex: %p, &ben.passport_number: %p, &ben.age: %p\n",
			&ben.salary, &ben.sex, &ben.passport_number, &ben.age);
	printf("offset(salary): %u, offset(sex): %u, offset(passport_number): %u, offset(age): %u\n",
			(char *) &ben.salary - (char *) &ben,
			(char *) &ben.sex - (char *) &ben,
			(char *) &ben.passport_number - (char *) &ben,
			(char *) &ben.age - (char *) &ben);

	return 0;
}
