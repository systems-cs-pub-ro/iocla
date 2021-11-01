#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_INPUT_LINE_SIZE 300

struct Dir;
struct File;

typedef struct Dir{
	char *name;
	struct Dir* parent;
	struct File* head_children_files;
	struct Dir* head_children_dirs;
	struct Dir* next;
} Dir;

typedef struct File {
	char *name;
	struct Dir* parent;
	struct File* next;
} File;

void touch (Dir* parent, char* name) {}

void mkdir (Dir* parent, char* name) {}

void ls (Dir* parent) {}

void rm (Dir* parent, char* name) {}

void rmdir (Dir* parent, char* name) {}

void cd(Dir** target, char *name) {}

char *pwd (Dir* target) {}

void stop (Dir* target) {}

void tree (Dir* target, int level) {}

void mv(Dir* parent, char *oldname, char *newname) {}

int main () {
	do
	{
		/*
		Summary:
			Reads from stdin a string and breaks it down into command and in
			case it needs into a name.
		*/
	} while (/*condition*/);
	
	return 0;
}
