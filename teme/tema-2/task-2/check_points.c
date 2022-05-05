#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct point{
    short x;
    short y; 
} __attribute__((packed));

void points_distance(struct point *p, int *rez);
void road(struct point* points, int len, int* distances);
void is_square(int *dist, int n, int *rez);

void readInput(char *filename, int *nr, struct point *pointArr) {
    int i, j;

    FILE *f = fopen(filename, "r");

    /* read points */
    fscanf(f, "%d", nr);
    for(int i = 0 ; i < *nr ; i++)
        fscanf(f, "%hd%hd", &pointArr[i].x, &pointArr[i].y);
    fclose(f);
}

void readRef(char *filename, int *nr, int *d1_ref, int *dist_ref, int *sq_ref) {
    FILE *f = fopen(filename, "r");

    /* read the encrypted text */
    fscanf(f, "%d", d1_ref);
    for(int i = 0 ; i < *nr - 1 ; i++)
        fscanf(f, "%d", &dist_ref[i]);
    for(int i = 0 ; i < *nr - 1 ; i++)
        fscanf(f, "%d", &sq_ref[i]);
    fclose(f);
}

void printOutput(char *filename, int *nr, int *d1, int *dist, int *sq, int okay1, int okay2) {
    FILE *f = fopen(filename, "w");

    fprintf(f, "%d\n", *d1);
    
    if(okay1)
        for(int i = 0 ; i < *nr - 1 ; i++)
            fprintf(f, "%d ", dist[i]);
    fprintf(f, "\n");
    
    if(okay2)
        for(int i = 0 ; i < *nr - 1; i++)
            fprintf(f, "%d ", sq[i]);

    fclose(f);
}

int main(int argc, char **argv) {
    int i = 0;
    int nr; 
    float score = 0;

    struct point p[10];
    int dist_ref[10], dist[10];
    int sq_ref[10], sq[10];
    int *d1 = malloc(1 * sizeof(int));
    int *d1_ref = malloc(1 * sizeof(int));
    char input_file[30], output_file[30], ref_file[30];

    printf("--------------TASK 2--------------\n");
    for (i = 0; i < 10; i++) {
        printf("--TEST %d--------------------------\n", i);
        /* read input */
        sprintf(input_file, "input/points-%d.in", i);
        readInput(input_file, &nr, p);

        /* read ref */
        sprintf(ref_file, "ref/points-%d.ref", i);
        readRef(ref_file, &nr, d1_ref, dist_ref, sq_ref);

        /* do task 1 */
        int *task1 = malloc(1 * sizeof(int));
        points_distance(p, d1);
        

        int okay1 = 1;
        int okay2 = 0;
        if(*d1 != *d1_ref){
            okay1 = 0;
            printf("TEST %d_1................FAILED: 0.00p\n", i);
            printf("TEST %d_2................FAILED: 0.00p\n", i);
            printf("TEST %d_3................FAILED: 0.00p\n", i);
        } else {
            score += 0.5;
            printf("TEST %d_1................PASSED: 0.50p\n", i);
        }

        if(okay1){
            /* do task 2 */
            road(p, nr, dist);

            okay2 = 1;
            for(int j = 0 ; j < nr - 1; j++)
                if(dist[j] != dist_ref[j])
                        okay2 = 0;
                      

            if(okay2){
                score += 0.75;
                printf("TEST %d_2................PASSED: 0.75p\n", i);
            } else {
                printf("TEST %d_2................FAILED: 0.00p\n", i);
                printf("TEST %d_3................FAILED: 0.00p\n", i);
            }
            
            if(okay2){
                /* do task 3*/
                is_square(dist, nr-1, sq);
                int okay3 = 1;
                for(int j = 0 ; j < nr - 1; j++)
                    if(sq[j] != sq_ref[j])
                        okay3 = 0;
                if(okay3){
                    score += 1.25;
                    printf("TEST %d_3................PASSED: 1.25p\n", i);
                } else {
                    printf("TEST %d_3................FAILED: 0.00p\n", i);
                }
            }
        }

        sprintf(output_file, "output/points-%d.out", i);
        printOutput(output_file, &nr, d1, dist, sq, okay1, okay2);
    }
    printf("TASK 2 SCORE: %.2f\n\n", score);

    return 0;
}
