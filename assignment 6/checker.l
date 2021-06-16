%{
#include <stdlib.h>
#include <stdio.h>
#include "checker.tab.h"
extern int yylval;
int lno = 0;
void yyerror(char *s);
char* t = "sample.c";
%}
%%
[ \t]+	 					;
\n						{lno++;}
int|float|char|double				{return DATATYPE;}
while						{return WHILE;}
if                                              {return IF;}
else						{return ELSE;}
for						{return FOR;}														
[0-9]+						{yylval = atoi(yytext); return NUMBER;}
[0-9]+\.*[0-9]*					{yylval = atoi(yytext); return NUMBER;}
["].+["]					{return STRING;}
[a-zA-Z_]+[0-9]*? 				{return VARIABLE;}
[,=;]   			             	{return yytext[0];}
"<"|"<="|">"|">="|"=="|"!="			{return RELATIONAL;}
"+"|"-"|"*"|"/" 				{return ARITH;}
"++"|"--"					{return UNARY;}
"(" 						{return *yytext;}
")" 						{return *yytext;}
"{" 						{return *yytext;}
"}" 						{return *yytext;}
.						{yyerror(yytext);}
%%
int yywrap (void) {
	return 1;
}

void yyerror(char *s)
{
	printf("%s:line:%d:syntax error\n",t,lno);
	exit(1);
}
 
int main()
{
	FILE *fp; 
	fp = fopen(t,"r"); 
	if (fp == NULL)
	{
		printf("File not found error\n");
		exit(0);
	}
	yyin = fp;
	yyparse();
	printf("Syntax Correct!\n");
	fclose(fp);
	return 0;
}
