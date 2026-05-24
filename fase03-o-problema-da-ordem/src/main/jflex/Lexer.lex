package br.maua.cic303;

%%

%class Lexer
%public
%unicode
%type Token
%line
%column

%{
    private Token token(Tag tag, String lexeme) {
        return new Token(tag, lexeme);
    }
%}

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]

Number = [0-9]+(\.[0-9]+)?([Ee][+-]?[0-9]+)?

Letter = [a-zA-Z]
Digit  = [0-9]
Identifier = {Letter}({Letter}|{Digit}|_)*

%%

<YYINITIAL> {

    {WhiteSpace}    { }

    "if"            { return token(Tag.IF, yytext()); }
    "then"          { return token(Tag.THEN, yytext()); }
    "else"          { return token(Tag.ELSE, yytext()); }
    "while"         { return token(Tag.WHILE, yytext()); }

    "("             { return token(Tag.LPAREN, yytext()); }
    ")"             { return token(Tag.RPAREN, yytext()); }
    "{"             { return token(Tag.LBRACE, yytext()); }
    "}"             { return token(Tag.RBRACE, yytext()); }
    ";"             { return token(Tag.SEMI, yytext()); }

    "==" | "!=" | "<=" | ">=" { return token(Tag.REL_OP, yytext()); }
    "<"  | ">"                { return token(Tag.REL_OP, yytext()); }
    "="                       { return token(Tag.ASSIGN, yytext()); }

    "+" | "-"                 { return token(Tag.ADD_OP, yytext()); }
    "*" | "/" | "%"           { return token(Tag.MUL_OP, yytext()); }

    {Letter}({Letter}|{Digit}|_){32} {
        return token(Tag.ERROR,
            "Erro Léxico: Identificador ultrapassou 32 caracteres -> " + yytext());
    }

    {Identifier}              { return token(Tag.ID, yytext()); }
    {Number}                  { return token(Tag.NUMBER, yytext()); }

    . {
        return token(Tag.ERROR,
            "Erro Léxico: Caractere Ilegal -> " + yytext());
    }
}

<<EOF>> { return token(Tag.EOF, ""); }