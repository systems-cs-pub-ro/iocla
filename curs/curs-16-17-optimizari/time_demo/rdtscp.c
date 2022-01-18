#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#ifndef CLASS
#define CLASS 'B'
#endif


/*************/
/*  CLASS S  */
/*************/
#if CLASS == 'S'
#define  TOTAL_KEYS_LOG_2    16
#define  MAX_KEY_LOG_2       11
#define  NUM_BUCKETS_LOG_2   9
#endif


/*************/
/*  CLASS W  */
/*************/
#if CLASS == 'W'
#define  TOTAL_KEYS_LOG_2    20
#define  MAX_KEY_LOG_2       16
#define  NUM_BUCKETS_LOG_2   10
#endif

/*************/
/*  CLASS A  */
/*************/
#if CLASS == 'A'
#define  TOTAL_KEYS_LOG_2    23
#define  MAX_KEY_LOG_2       19
#define  NUM_BUCKETS_LOG_2   10
#endif


/*************/
/*  CLASS B  */
/*************/
#if CLASS == 'B'
#define  TOTAL_KEYS_LOG_2    25
#define  MAX_KEY_LOG_2       21
#define  NUM_BUCKETS_LOG_2   10
#endif


/*************/
/*  CLASS C  */
/*************/
#if CLASS == 'C'
#define  TOTAL_KEYS_LOG_2    27
#define  MAX_KEY_LOG_2       23
#define  NUM_BUCKETS_LOG_2   10
#endif


/*************/
/*  CLASS D  */
/*************/
#if CLASS == 'D'
#define  TOTAL_KEYS_LOG_2    31
#define  MAX_KEY_LOG_2       27
#define  NUM_BUCKETS_LOG_2   10
#endif


#if CLASS == 'D'
#define  TOTAL_KEYS          (1L << TOTAL_KEYS_LOG_2)
#else
#define  TOTAL_KEYS          (1 << TOTAL_KEYS_LOG_2)
#endif
#define  MAX_KEY             (1 << MAX_KEY_LOG_2)
#define  NUM_BUCKETS         (1 << NUM_BUCKETS_LOG_2)
#define  NUM_KEYS            TOTAL_KEYS
#define  SIZE_OF_BUFFERS     NUM_KEYS


#define  MAX_ITERATIONS      10
#define  TEST_ARRAY_SIZE     5


/*************************************/
/* Typedef: if necessary, change the */
/* size of int here by changing the  */
/* int type to, say, long            */
/*************************************/
#if CLASS == 'D'
typedef  long INT_TYPE;
#else
typedef  int  INT_TYPE;
#endif


/********************/
/* Some global info */
/********************/
INT_TYPE *key_buff_ptr_global;         /* used by full_verify to get */
/* copies of rank info        */

int      passed_verification;


/************************************/
/* These are the three main arrays. */
/* See SIZE_OF_BUFFERS def above    */
/************************************/
INT_TYPE key_array[SIZE_OF_BUFFERS],
         key_buff1[MAX_KEY],
         key_buff2[SIZE_OF_BUFFERS],
         partial_verify_vals[TEST_ARRAY_SIZE],
         **key_buff1_aptr = NULL;


/**********************/
/* Partial verif info */
/**********************/
INT_TYPE test_index_array[TEST_ARRAY_SIZE],
         test_rank_array[TEST_ARRAY_SIZE],

         S_test_index_array[TEST_ARRAY_SIZE] =
{48427,17148,23627,62548,4431},
S_test_rank_array[TEST_ARRAY_SIZE] =
{0,18,346,64917,65463},

W_test_index_array[TEST_ARRAY_SIZE] =
{357773,934767,875723,898999,404505},
W_test_rank_array[TEST_ARRAY_SIZE] =
{1249,11698,1039987,1043896,1048018},

A_test_index_array[TEST_ARRAY_SIZE] =
{2112377,662041,5336171,3642833,4250760},
A_test_rank_array[TEST_ARRAY_SIZE] =
{104,17523,123928,8288932,8388264},

B_test_index_array[TEST_ARRAY_SIZE] =
{41869,812306,5102857,18232239,26860214},
B_test_rank_array[TEST_ARRAY_SIZE] =
{33422937,10244,59149,33135281,99},

C_test_index_array[TEST_ARRAY_SIZE] =
{44172927,72999161,74326391,129606274,21736814},
C_test_rank_array[TEST_ARRAY_SIZE] =
{61147,882988,266290,133997595,133525895},

D_test_index_array[TEST_ARRAY_SIZE] =
{1317351170,995930646,1157283250,1503301535,1453734525},
D_test_rank_array[TEST_ARRAY_SIZE] =
{1,36538729,1978098519,2145192618,2147425337};


/***********************/
/* function prototypes */
/***********************/
double	randlc( double *X, double *A );

void full_verify( void );

static int      KS=0;
static double	R23, R46, T23, T46;

double	randlc( double *X, double *A )
{
    double		T1, T2, T3, T4;
    double		A1;
    double		A2;
    double		X1;
    double		X2;
    double		Z;
    int     		i, j;

    if (KS == 0)
    {
        R23 = 1.0;
        R46 = 1.0;
        T23 = 1.0;
        T46 = 1.0;

        for (i=1; i<=23; i++)
        {
            R23 = 0.50 * R23;
            T23 = 2.0 * T23;
        }
        for (i=1; i<=46; i++)
        {
            R46 = 0.50 * R46;
            T46 = 2.0 * T46;
        }
        KS = 1;
    }

    /*  Break A into two parts such that A = 2^23 * A1 + A2 and set X = N.  */

    T1 = R23 * *A;
    j  = T1;
    A1 = j;
    A2 = *A - T23 * A1;

    /*  Break X into two parts such that X = 2^23 * X1 + X2, compute
    Z = A1 * X2 + A2 * X1  (mod 2^23), and then
    X = 2^23 * Z + A2 * X2  (mod 2^46).                            */

    T1 = R23 * *X;
    j  = T1;
    X1 = j;
    X2 = *X - T23 * X1;
    T1 = A1 * X2 + A2 * X1;

    j  = R23 * T1;
    T2 = j;
    Z = T1 - T23 * T2;
    T3 = T23 * Z + A2 * X2;
    j  = R46 * T3;
    T4 = j;
    *X = T3 - T46 * T4;
    return(R46 * *X);
}
double   find_my_seed( int kn,        /* my processor rank, 0<=kn<=num procs */
                       int np,        /* np = num procs                      */
                       long nn,       /* total num of ran numbers, all procs */
                       double s,      /* Ran num seed, for ex.: 314159265.00 */
                       double a )     /* Ran num gen mult, try 1220703125.00 */
{

    double t1,t2;
    long   mq,nq,kk,ik;

    if ( kn == 0 ) return s;

    mq = (nn/4 + np - 1) / np;
    nq = mq * 4 * kn;               /* number of rans to be skipped */

    t1 = s;
    t2 = a;
    kk = nq;
    while ( kk > 1 ) {
        ik = kk / 2;
        if( 2 * ik ==  kk ) {
            (void)randlc( &t2, &t2 );
            kk = ik;
        }
        else {
            (void)randlc( &t1, &t2 );
            kk = kk - 1;
        }
    }
    (void)randlc( &t1, &t2 );

    return( t1 );

}
void	create_seq( double seed, double a )
{
    double x, s;
    INT_TYPE i, k;

    INT_TYPE k1, k2;
    double an = a;
    int myid, num_procs;
    INT_TYPE mq;

    myid = 0;
    num_procs = 1;

    mq = (NUM_KEYS + num_procs - 1) / num_procs;
    k1 = mq * myid;
    k2 = k1 + mq;
    if ( k2 > NUM_KEYS ) k2 = NUM_KEYS;

    KS = 0;
    s = find_my_seed( myid, num_procs,
                      (long)4*NUM_KEYS, seed, an );

    k = MAX_KEY/4;

    for (i=k1; i<k2; i++) {
        x = randlc(&s, &an);
        x += randlc(&s, &an);
        x += randlc(&s, &an);
        x += randlc(&s, &an);

        key_array[i] = k*x;
    }
}
void *alloc_mem( size_t size )
{
    void *p;

    p = (void *)malloc(size);
    if (!p) {
        perror("Memory allocation error");
        exit(1);
    }
    return p;
}
void alloc_key_buff( void )
{
    INT_TYPE i;
    int      num_procs;

    num_procs = 1;

    key_buff1_aptr = (INT_TYPE **)alloc_mem(sizeof(INT_TYPE *) * num_procs);

    key_buff1_aptr[0] = key_buff1;
    for (i = 1; i < num_procs; i++) {
        key_buff1_aptr[i] = (INT_TYPE *)alloc_mem(sizeof(INT_TYPE) * MAX_KEY);
    }
}
void full_verify( void )
{
    INT_TYPE   i, j;
    INT_TYPE   k, k1;


    /*  Now, finally, sort the keys:  */

    /*  Copy keys into work array; keys in key_array will be reassigned. */

    for( i=0; i<NUM_KEYS; i++ )
        key_buff2[i] = key_array[i];

    /* This is actual sorting. Each thread is responsible for a subset of key values */
    j = MAX_KEY;
    k1 = 0;
    INT_TYPE k2 = k1 + j;

    if (k2 > MAX_KEY) k2 = MAX_KEY;

    for( i=0; i<NUM_KEYS; i++ ) {
        if (key_buff2[i] >= k1 && key_buff2[i] < k2) {
            k = --key_buff_ptr_global[key_buff2[i]];
            key_array[k] = key_buff2[i];
        }
    }

    /*  Confirm keys correctly sorted: count incorrectly sorted keys, if any */

    j = 0;
    for( i=1; i<NUM_KEYS; i++ ) {
        if( key_array[i-1] > key_array[i] )
            j++;
    }

    if( j != 0 )
        printf( "Full_verify: number of keys out of sort: %ld\n", (long)j );
    else
        passed_verification++;

}
static inline uint64_t rdtscp(void)
{
    uint32_t low, high;
    asm volatile("rdtscp":"=a"(low),"=d"(high)::"ecx");
    return ((uint64_t)high << 32) | low;
}
void rank( int iteration )
{

    INT_TYPE    i, k;
    INT_TYPE    *key_buff_ptr, *key_buff_ptr2;

    key_array[iteration] = iteration;
    key_array[iteration+MAX_ITERATIONS] = MAX_KEY - iteration;

    /*  Determine where the partial verify test keys are, load into  */
    /*  top of array bucket_size                                     */
    uint64_t start, end;
    start = rdtscp();
    for( i=0; i<TEST_ARRAY_SIZE; i++ )
        partial_verify_vals[i] = key_array[test_index_array[i]];
    end = rdtscp();
    printf("\nClock cycles loop1 are: %llu - %llu = %llu\n", start, end, end - start);

    /*  Setup pointers to key buffers  */

    key_buff_ptr2 = key_array;
    key_buff_ptr = key_buff1;

    INT_TYPE *work_buff;
    int myid = 0, num_procs = 1;

    work_buff = key_buff1_aptr[myid];

    /*  Clear the work array */
    start = rdtscp();
    for( i=0; i<MAX_KEY; i++ )
        work_buff[i] = 0;
    end = rdtscp();
    printf("\nClock cycles loop2 are: %llu - %llu = %llu\n", start, end, end - start);

    /*  Ranking of all keys occurs in this section:                 */

    /*  In this section, the keys themselves are used as their
    own indexes to determine how many of each there are: their
    individual population                                       */

    start = rdtscp();
    for( i=0; i<NUM_KEYS; i++ )
        work_buff[key_buff_ptr2[i]]++;  /* Now they have individual key   */
    end = rdtscp();
    printf("\nClock cycles loop3 are: %llu - %llu = %llu\n", start, end, end - start);

    /*  To obtain ranks of each key, successively add the individual key
    population                                          */

    start = rdtscp();
    for( i=0; i<MAX_KEY-1; i++ )
        work_buff[i+1] += work_buff[i];
    end = rdtscp();
    printf("\nClock cycles loop4 are: %llu - %llu = %llu\n", start, end, end - start);
    /*  Accumulate the global key population */

    start = rdtscp();
    for( k=1; k<num_procs; k++ ) {
        for( i=0; i<MAX_KEY; i++ )
            key_buff_ptr[i] += key_buff1_aptr[k][i];
    }
    end = rdtscp();
    printf("\nClock cycles loop5 are: %llu - %llu = %llu\n", start, end, end - start);

    /*  Make copies of rank info for use by full_verify: these variables
    in rank are local; making them global slows down the code, probably
    since they cannot be made register by compiler                        */

    if( iteration == MAX_ITERATIONS )
        key_buff_ptr_global = key_buff_ptr;

}


/*****************************************************************/
/*************             M  A  I  N             ****************/
/*****************************************************************/
int main()
{
    int   i;

    /*  Initialize the verification arrays if a valid class */
    for( i=0; i<TEST_ARRAY_SIZE; i++ )
        switch( CLASS )
        {
        case 'S':
            test_index_array[i] = S_test_index_array[i];
            test_rank_array[i]  = S_test_rank_array[i];
            break;
        case 'A':
            test_index_array[i] = A_test_index_array[i];
            test_rank_array[i]  = A_test_rank_array[i];
            break;
        case 'W':
            test_index_array[i] = W_test_index_array[i];
            test_rank_array[i]  = W_test_rank_array[i];
            break;
        case 'B':
            test_index_array[i] = B_test_index_array[i];
            test_rank_array[i]  = B_test_rank_array[i];
            break;
        case 'C':
            test_index_array[i] = C_test_index_array[i];
            test_rank_array[i]  = C_test_rank_array[i];
            break;
        case 'D':
            test_index_array[i] = D_test_index_array[i];
            test_rank_array[i]  = D_test_rank_array[i];
            break;
        };



    /*  Printout initial NPB info */
    printf("NAS Parallel Benchmarks 4.0 OpenMP C++ version - IS Benchmark\n" );
    printf("Developed by: Dalvan Griebler <dalvan.griebler@acad.pucrs.br> & Júnior Löff <loffjh@gmail.com>\n\n");
    printf( " Size:  %ld  (class %c)\n", (long)TOTAL_KEYS, CLASS );
    printf( " Iterations:  %d\n", MAX_ITERATIONS );
    printf( "\n" );

    /*  Generate random number sequence and subsequent keys on all procs */
    create_seq( 314159265.00,                    /* Random number gen seed */
                1220703125.00 );                 /* Random number gen mult */

    alloc_key_buff();

    /*  Do one interation for free (i.e., untimed) to guarantee initialization of
    all data and code pages and respective tables */
    rank( 1 );
    //printf("after warmup\n");

    /*  Start verification counter */
    passed_verification = 0;

    /* Initialization ends here. Timing should start here. */
//    for( iteration=1; iteration<=MAX_ITERATIONS; iteration++ )
//    {
//        if( CLASS != 'S' ) printf( "        %d\n", iteration );
//        rank( iteration );
//    }
    /* Timing should end here  */

    return 0;
}
