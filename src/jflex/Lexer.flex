
package codigo;
import static codigo.Tokens.*;

%%
%class Lexer
%type Tokens
%ignorecase
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r]+
%{
    public String lexeme;
%}
%%
/* comentarios */
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}

/* Palabras reservadas */
REVOKE |
ON |
TABLE |
FROM | 
USER |
GROUP |
ROLE {lexeme=yytext(); return Reservada;}

/* Privilegios*/
SELECT | 
INSERT | 
UPDATE | 
DELETE | 
ALL { lexeme=yytext(); return Privilegio;}

/* Simbolos */
"\n" { lexeme=yytext(); return Linea;}
";" { lexeme=yytext(); return Delimitador;}
"," { lexeme=yytext(); return Separador;}
"." { lexeme=yytext(); return Accesador;}
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}
: {return ERROR;}