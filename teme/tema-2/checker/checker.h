#define OTP_TESTS           5
#define CAESAR_TESTS        5
#define BIN_TO_HEX_TESTS    5
#define STRSTR_TESTS        5
#define VIGENERE_TESTS      5

#define OTP_SCORE           2
#define CAESAR_SCORE        3
#define VIGENERE_SCORE      5
#define BIN_TO_HEX_SCORE    3
#define STRSTR_SCORE        5

#define MAX_SCORE           100

void otp(char *ciphertext, char *plaintext, char *key, int len);

void caesar(char *ciphertext, char *plaintext, int key, int len);

void vigenere(char *ciphertext, char *plaintext, int plaintext_len, char *key, int key_len);

void bin_to_hex(char *ret_value, char *bin_sequence, int len);

void my_strstr(int *ret_value, char *haystack, char *needle, int haystack_len, int needle_len);
