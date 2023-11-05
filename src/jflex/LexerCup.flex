package codigo;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r,\n]+
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Coma */
( "," ) {return new Symbol(sym.Coma, yychar, yyline, yytext());}

/* Espacios en blanco */
{espacio} {/*Ignore*/}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}

/* Resto de las reglas */
/* Reservadas */
( REVOKE ) {return new Symbol(sym.Revoke, yychar, yyline, yytext());}
( ON ) {return new Symbol(sym.T_On, yychar, yyline, yytext());}
( FROM ) {return new Symbol(sym.From, yychar, yyline, yytext());}
( USER | GROUP | ROLE ) {return new Symbol(sym.ReservadaG, yychar, yyline, yytext());}

/* Privilegios */
( SELECT | INSERT | UPDATE | DELETE | ALL ) {return new Symbol(sym.Privilegio, yychar, yyline, yytext());}

/* Punto y coma */
( ";" ) {return new Symbol(sym.P_coma, yychar, yyline, yytext());}

/* Punto */
( "." ) {return new Symbol(sym.Punto, yychar, yyline, yytext());}

/* Identificador */
{L}({L}|{D})* {return new Symbol(sym.Identificador, yychar, yyline, yytext());}

/* Error de análisis */
: {return new Symbol(sym.ERROR, yychar, yyline, yytext());}
