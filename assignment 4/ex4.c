#include<stdio.h>
#include<string.h>
#include<stdlib.h>

char input[20];
int length=0;

void E();
void T();
void Edash();
void Tdash();
void F();


void main(){
	int strlength;
	printf("\nEnter the Input String:");
	scanf("%s",input);
	strlength=strlen(input);
	E();
	if(strlength==length)
		printf("\nThe given string is accepted");
	else
		printf("\nError in the given string");

}

void E(){
	printf("\nE()");
	T();
	Edash();
	return;

}

void T(){
	printf("\nT()");
	F();
	Tdash();
	return;
}

void Edash(){
	printf("\nEdash()");
	if(input[length]=='+'){
		length++;
		T();
		Edash();
	}
	return;

}

void Tdash(){
	printf("\nTdash()");
	if(input[length]=='*'){
		length++;
		F();
		Tdash();
	}
	return;
}

void F(){
	printf("\nF()");
	if((input[length]=='i') && (input[length+1]=='d')){
		length+=2;
	}
	else if(input[length]=='('){
		length++;
		E();
		if(input[length]==')'){
			length++;
			return;
		}
	else{
			printf("\nError in the given string");
			exit(1);
		}

	}
	return;
}
