unsigned int i;

int main(void)
{
	i = 0;
start:
	i += 2;
	goto start;
	i += 6;
}
