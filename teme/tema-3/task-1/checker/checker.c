#include <stdio.h>

// DO NOT MODIFY THIS FILE

struct node {
    int val;
    struct node* next;
};

struct node* sort(int n, struct node* node);

int main() {
    int n;
    scanf("%d", &n);

    struct node nodes[n];

    for (int i = 0; i < n; i++) {
        scanf("%d", &(nodes[i].val));
        nodes[i].next = NULL;
    }

    struct node* head = sort(n, nodes);
    
    while (head != NULL) {
        printf("%d ", head->val);
        head = head->next;
    }
    
    printf("\n");
    return 0;
}
