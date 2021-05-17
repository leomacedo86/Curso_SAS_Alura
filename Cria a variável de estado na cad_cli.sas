* Declaração da biblioteca do AluraPlay ;
LIBNAME alura '/folders/myfolders/AluraPlay';

/*
 * CRIAR UMA VARIÁVEL DE ESTADO
 * 
 * Relação Estado para CEP
 * -Grande SP: 01000-000 a 09999-999
 * -Interior de SP: 10000-000 a 19999-999
 * -Rio de Janeiro: 20000-000 a 28999-999
 * -Minas Gerais: 30000-000 a 39999-999
 * -Paraná: 80000-000 a 87999-999
 */

* Checa a base de cadastro cliente ;
PROC CONTENTS data=alura.cadastro_cliente;RUN;

/*
 *  Testando criar a variável como um texto
 */

* Para observar apenas as 15 primeiras linhas ;
OPTIONS obs=15;

* Formato de número para texto ;
PROC FORMAT;
	VALUE estados_
		low - 09  = "Grande SP"
		10 - 19   = "Interior SP"
		19 <-< 29 = "Rio de Janeiro"
		30 - 39   = "Minas Gerais"
		80 - high = "Região sul"
		OTHER     = "Demais estados";
RUN;

* Crio a variável estado como texto ;
DATA teste1;
set alura.cadastro_cliente (obs=15 keep=CPF CEP);

Estado = put(input(substr(cep,1,2),best.),estados_.);

RUN;

/*
 * Crio minha variável como um número, 
 * sobre ele aplico um formato com o nome do estado
 */

* Trabalhar com a base completa ;
OPTIONS obs=max;

* Carrego meu formatos ;
PROC FORMAT;
	* Inínio do CEP => lista numérica ordenada ; 
	INVALUE estadosnum_
		low  - "09" = 1
		"10" - "19" = 2
		"20" - "28" = 3
		"30" - "39" = 4
		"80" - "87" = 5
		OTHER		= 6;
	* Lista numérica => Nome do estado ;
	VALUE estadotxt_
		1 = "Grande SP"
		2 = "Interior SP"
		3 = "Rio de Janeiro"
		4 = "Minas Gerais"
		5 = "Paraná"
		OTHER = "Demais estados";
RUN;

* Crio uma base com minha variável Estado criada ;
DATA alura.cadastro_cliente_v2;
set alura.cadastro_cliente;

Estado = input(substr(cep,1,2),estadosnum_.);
format Estado estadotxt_.;

RUN;

* Checo minha variável Estado ;
PROC FREQ
	data=alura.cadastro_cliente_v2;
	table Estado;
RUN;













