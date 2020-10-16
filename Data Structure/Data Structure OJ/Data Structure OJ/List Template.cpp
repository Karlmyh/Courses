#include <iostream>
using namespace std;
typedef int DataType;


typedef struct ListNode{
    int data;
    ListNode *next;
}link;

class List {
public:
    link* head;
    int size;
    List(){
        head=(link*)malloc(sizeof(link));
        head->next=NULL;
        size=0;
    };
    ~List(){
        link *temp=NULL;
        while(head->next!=NULL){
            temp=head->next;
            free(head);
            head=temp;
        }
        free(head);
    };
    void insertPostion(int i,const DataType& x);
    void insertElem(const DataType& x,const DataType& y);
    void delPosition(int i);
    void delElem(const DataType& x);
    int searchElem(const DataType& x);
    link * getpointer(int i);
    DataType getData(int i);
    void changeData(int i,const DataType& x);
    int getLength();
    void Print();
private:

};

void List::insertPostion(int j,const DataType& data){
    size++;
    link * temp=head;
    for (int i=1; i<j; i++) {
        if (temp==NULL) {
            printf("Invalid Position\n");
        }
        temp=temp->next;
    }
    link * c=(link*)malloc(sizeof(link));
    c->data=data;
    c->next=temp->next;
    temp->next=c;
}

void List::insertElem(const DataType& x,const DataType& y){
    size++;
    int ins=searchElem(x);
    if (ins!=0){
    insertPostion(ins, y);
    }
}

void List::delPosition(int j){
    size--;
    link * temp=head;
    //遍历到被删除结点的上一个结点
    for (int i=1; i<j; i++) {
        temp=temp->next;
    }
    link * del=temp->next;
    temp->next=temp->next->next;
    free(del);
}

void List::delElem(const DataType& x){
    size--;
    int del=searchElem(x);
    delPosition(del);
}


int List::searchElem(const DataType& data){
    link *temp =head->next;
    int count=1;
    while (temp!=NULL&& temp->data!=data) {
        temp=temp->next;
        count++;
    }
    if(temp==NULL){return 0;}
    else{return count;}
}

link * List::getpointer(int i){
    link *temp =head;
    for (int j=0; j<i; j++) {
        temp=temp->next;
    }
    return temp;
}
DataType List::getData(int i){
    link *temp =head;
    for (int j=0; j<i; j++) {
        temp=temp->next;
    }
    return temp->data;
}

void List::changeData(int i,const DataType& x){
    link *temp =head;
    for (int j=0; j<i; j++) {
        temp=temp->next;
    }
    temp->data=x;
}
int List::getLength(){
    return size;
}

void List::Print(){
    link *temp =head->next;
    while (temp!=NULL) {
        cout<<temp->data<<" ";
        temp=temp->next;
    }
    cout<<"\n";
}
