* Declaração da biblioteca do AluraPlay ;
LIBNAME alura '/folders/myfolders/AluraPlay';

/*
 * CRIAR UMA VARIÁVEL DE ESTADO
 */

/*
 * Relação Estado para CEP
 * -Grande SP: 01000-000 a 09999-999
 * -Interior de SP: 10000-000 a 19999-999
 * -Rio de Janeiro: 20000-000 a 28999-999
 * -Minas Gerais: 30000-000 a 39999-999
 * -Paraná: 80000-000 a 87999-999
 */

PROC CONTENTS data=alura.cadastro_cliente;RUN;

DATA teste1;
set alura.cadastro_cliente;
format Estado $14.;

	if "01000-000" <= cep <="09000-000" then
		Estado="Grande SP";
	else if "10000-000" <= cep <="19999-999" then
		Estado="Interior SP";
	else if "20000-000" <= cep <="28999-999" then
		Estado="Rio de Janeiro";
	else if "30000-000" <= cep <="39999-999" then
		Estado="Minas Gerais";
	else if "80000-000" <= cep <="87999-999" then
		Estado="Paraná";
	else
		Estado="Demais estados";

RUN;

PROC FREQ
	data=teste1;
	tables estado
	/missing;
RUN;

PROC CONTENTS data=teste1 varnum;RUN;

DATA teste1;
set alura.cadastro_cliente;

precep = input(substr(cep,1,2),best.);

RUN;








