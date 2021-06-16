%{ 
  
  #include<stdio.h>
  #include<stdlib.h> 
  #include<math.h>
  #include"calc.tab.h" 
  int yylex(void);
  void yyerror(char *);
  int flag=0;

%} 
  
%token INTEGER AND OR LSHIFT RSHIFT
  
%% 

prg : line prg
    | line

line : expr '\n' {printf("%d\n",$1);}

expr : expr LSHIFT expr { $$ = $1 << $3; }
     | expr RSHIFT expr { $$ = $1 >> $3; }

expr : expr OR andex{ $$ = $1 || $3; }
     | andex {$$ = $1;}

andex : andex AND notex {$$ = $1 && $3;}
      | notex {$$=$1;}

notex : '!'addex {$$ = !($1);}
      | addex {$$=$1;}

addex : addex'+'mulex { $$ = $1 + $3;}
     | addex'-'mulex { $$ = $1 - $3;}
     | mulex {$$ = $1;}

mulex : mulex'*'powex { $$ = $1 * $3;}
      | mulex'/'powex { $$ = $1 / $3;}
      | mulex'%'powex { $$ = $1 % $3;}
      | powex { $$ = $1;}

powex : powex'^'term {$$ = pow($1, $3);}
      | term {$$=$1;}
  
term : '('addex')' {$$=$2;}
     | INTEGER {$$=$1;}

%%

//driver code s
int main() 
{ 
   yyparse(); 
   return 0;
}
void yyerror(char *s) 
{ 
   fprintf(stderr,"%s\n",s); 
   return;
}
int yywrap(){
  return 1;
}