DROP TABLE trabalha;
DROP TABLE gratificacao;
DROP TABLE departamento;
DROP TABLE participa;
DROP TABLE atividade;
DROP TABLE projeto;
DROP TABLE titulacao_empregado;
DROP TABLE ies;
DROP TABLE grau;
DROP TABLE tecnico;
DROP TABLE graduado;
DROP TABLE fone;
DROP TABLE empregado;
DROP TABLE endereco;

CREATE TABLE endereco (
	cep NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT endereco_pk PRIMARY KEY (cep)
);
CREATE TABLE empregado (
	cpf NUMBER,
	cpf_lider NUMBER,
	nome VARCHAR2(50) NOT NULL,
	dt_nasc DATE NOT NULL,
	sexo CHAR(1) NOT NULL,
	salario DECIMAL(6,2) NOT NULL,
	cep NUMBER NOT NULL,
	CONSTRAINT empregado_pk PRIMARY KEY (cpf),
	CONSTRAINT empregado_fk2 FOREIGN KEY (cep) REFERENCES endereco(cep),
	CONSTRAINT empregado_fk FOREIGN KEY (cpf_lider) REFERENCES empregado (cpf),
	CONSTRAINT empregado_check CHECK (sexo = 'M' OR sexo = 'F')
);
CREATE TABLE fone (
	cpf NUMBER, 
	fone VARCHAR2(9),
	CONSTRAINT fone_pk PRIMARY KEY (cpf, fone),
	CONSTRAINT fone_fk FOREIGN KEY (cpf) REFERENCES empregado (cpf)
);
CREATE TABLE graduado (
	cpf NUMBER,
	CONSTRAINT graduado_pk PRIMARY KEY (cpf),
	CONSTRAINT graduado_empregado_fk FOREIGN KEY (CPF) REFERENCES empregado (cpf)
);
CREATE TABLE tecnico (
	cpf NUMBER,
	ultima_serie NUMBER NOT NULL,
	CONSTRAINT tecnico_pk PRIMARY KEY (cpf),
	CONSTRAINT tecnico_empregado_fk FOREIGN KEY (CPF) REFERENCES empregado (cpf)
);
CREATE TABLE grau(
	codigo NUMBER,
	tipo VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_grau_pk PRIMARY KEY (codigo)
);
CREATE TABLE ies (
	codigo NUMBER,
	nome VARCHAR2(30) NOT NULL,
	sigla VARCHAR2(5) NOT NULL,
	CONSTRAINT ies_pk PRIMARY KEY (codigo)
);
CREATE TABLE titulacao_empregado (
	cpf NUMBER, 
	codigo_grau NUMBER NOT NULL,
	data_titulacao DATE NOT NULL,
	codigo_ies NUMBER NOT NULL,
	CONSTRAINT titulacao_pk PRIMARY KEY (cpf, data_titulacao),
	CONSTRAINT titulacao_empregado_fk FOREIGN KEY (cpf) REFERENCES graduado (cpf),
	CONSTRAINT titulacao_grau_fk FOREIGN KEY (codigo_grau) REFERENCES grau (codigo),
	CONSTRAINT titulacao_ies_fk FOREIGN KEY (codigo_ies) REFERENCES ies (codigo)
);
CREATE TABLE projeto (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	valor DECIMAL(8,2) NOT NULL,
	CONSTRAINT codigo_projeto_pk PRIMARY KEY (codigo)
);

CREATE TABLE atividade (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_atividade_pk PRIMARY KEY (codigo)
);
CREATE TABLE participa (
	codigo_projeto NUMBER,
	codigo_atividade NUMBER,
	cpf NUMBER,
	CONSTRAINT participa_pk PRIMARY KEY (codigo_projeto,codigo_atividade,cpf),
	CONSTRAINT participa_codigo_projeto_fk FOREIGN KEY (codigo_projeto) REFERENCES projeto (codigo),
	CONSTRAINT participa_codigo_atividade_fk FOREIGN KEY (codigo_atividade) REFERENCES atividade (codigo),
	CONSTRAINT participa_CPF_fk FOREIGN KEY (cpf) REFERENCES Empregado (cpf)
);
CREATE TABLE departamento (
	cpf_chefe NUMBER UNIQUE NOT NULL, 
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY (codigo),
	CONSTRAINT departamento_fk FOREIGN KEY (cpf_chefe) REFERENCES empregado (cpf)
);
CREATE TABLE gratificacao (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_gratificacao_pk PRIMARY KEY (codigo)
);
CREATE TABLE trabalha (
	cpf NUMBER, 
	codigo_depto NUMBER NOT NULL,
	data_trabalha DATE NOT NULL,
	codigo_gratif NUMBER,
	CONSTRAINT trabalha_pk PRIMARY KEY (cpf, codigo_depto,data_trabalha),
	CONSTRAINT trabalha_empregado_fk FOREIGN KEY (CPF) REFERENCES Empregado (CPF),
	CONSTRAINT trabalha_departamento_fk FOREIGN KEY (codigo_depto) REFERENCES departamento (codigo),
	CONSTRAINT trabalha_gratificacao_fk FOREIGN KEY (codigo_gratif) REFERENCES gratificacao (codigo)
);

-- POVOAMENTO ---

 --inserindo Projetos (7 no total)
INSERT INTO Projeto (codigo, descricao, valor) VALUES (1, 'Projeto 1', 5000.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (2, 'Projeto 2', 9600.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (3, 'Projeto 3', 7500.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (4, 'Projeto 4', 15000.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (5, 'Projeto 5', 3200.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (6, 'Projeto 6', 4800.00);
INSERT INTO Projeto (codigo, descricao, valor) VALUES (7, 'Projeto 7', 10000.00);

--inserindo Atividades (5 no total)
INSERT INTO atividade (codigo, descricao) VALUES (1, 'Monitoramento');
INSERT INTO atividade (codigo, descricao) VALUES (2, 'Gestão');
INSERT INTO atividade (codigo, descricao) VALUES (3, 'Desenvolvimento');
INSERT INTO atividade (codigo, descricao) VALUES (4, 'Pesquisa');
INSERT INTO atividade (codigo, descricao) VALUES (5, 'Marketing');


--inserindo endereco (12 endereços)

INSERT INTO endereco (cep, descricao) VALUES (111111, 'Rua 01');
INSERT INTO endereco (cep, descricao) VALUES (654781, 'Rua 02');
INSERT INTO endereco (cep, descricao) VALUES (133313, 'Rua 03');
INSERT INTO endereco (cep, descricao) VALUES (156873, 'Rua 04');
INSERT INTO endereco (cep, descricao) VALUES (555313, 'Rua 05');
INSERT INTO endereco (cep, descricao) VALUES (138893, 'Rua do Coqueiral');
INSERT INTO endereco (cep, descricao) VALUES (401000, 'Rua Tigres');
INSERT INTO endereco (cep, descricao) VALUES (354789, 'Rua Antonio de Melo');
INSERT INTO endereco (cep, descricao) VALUES (999987, 'Rua General Severiano');
INSERT INTO endereco (cep, descricao) VALUES (254785, 'Rua Constatino Aguiar');
INSERT INTO endereco (cep, descricao) VALUES (774100, 'Rua Euclides Paiva');
INSERT INTO endereco (cep, descricao) VALUES (200312, 'Rua Palomino Cavalcante');


--inserindo Empregados (12 no total)
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (1111, NULL, 'Joao da Silva', to_date ('21/02/1980', 'dd/mm/yyyy'), 'M', 5000.00, 111111);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (2222, 1111, 'Marco Aurelio', to_date ('15/05/1987', 'dd/mm/yyyy'), 'M', 3500.00, 654781);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (3333, 1111, 'Josefa Paes', to_date ('23/11/1990', 'dd/mm/yyyy'), 'F', 4000.00, 133313);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (4444, 3333, 'Dario Marques', to_date ('05/06/1992', 'dd/mm/yyyy'), 'M', 2000.00, 156873);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (5555, 3333, 'Lidia Gomes', to_date ('13/07/1989', 'dd/mm/yyyy'), 'F', 2500.00, 555313);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (6666, 1111, 'Joaquim Carvalho', to_date ('28/04/1983', 'dd/mm/yyyy'), 'M', 4500.00, 138893);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (7777, 6666, 'Paloma Morais', to_date ('05/12/1990', 'dd/mm/yyyy'), 'F', 3500.00, 401000);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (8888, 3333, 'Gustavo Marques', to_date ('21/12/1985', 'dd/mm/yyyy'), 'M', 3500.00, 354789);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (9999, 1111, 'Carol Albuquerque', to_date ('17/10/1994', 'dd/mm/yyyy'), 'F', 3500.00, 999987);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (0000, NULL, 'Leticia Gouveia', to_date ('08/05/1990', 'dd/mm/yyyy'), 'F', 3500.00, 254785);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (9875, 0000, 'Ricardo Teodoro', to_date ('15/01/1988', 'dd/mm/yyyy'), 'M', 3500.00, 774100);
INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (6542, 6666, 'Giovane Siqueira', to_date ('07/08/1982', 'dd/mm/yyyy'), 'M', 3500.00, 200312);

--inserindo Telefones (17 no total)
INSERT INTO fone (cpf, fone) VALUES (1111, '9487-0975');
INSERT INTO fone (cpf, fone) VALUES (1111, '3785-0946');
INSERT INTO fone (cpf, fone) VALUES (2222, '3245-0536');
INSERT INTO fone (cpf, fone) VALUES (3333, '3333-6554');
INSERT INTO fone (cpf, fone) VALUES (4444, '7928-4543');
INSERT INTO fone (cpf, fone) VALUES (5555, '9840-4362');
INSERT INTO fone (cpf, fone) VALUES (6666, '2235-1124');
INSERT INTO fone (cpf, fone) VALUES (7777, '9938-0003');
INSERT INTO fone (cpf, fone) VALUES (7777, '7930-6476');
INSERT INTO fone (cpf, fone) VALUES (7777, '3485-9888');
INSERT INTO fone (cpf, fone) VALUES (8888, '3778-1122');
INSERT INTO fone (cpf, fone) VALUES (8888, '3035-4777');
INSERT INTO fone (cpf, fone) VALUES (9999, '8586-9999');
INSERT INTO fone (cpf, fone) VALUES (0000, '9322-4702');
INSERT INTO fone (cpf, fone) VALUES (9875, '3492-5600');
INSERT INTO fone (cpf, fone) VALUES (9875, '3432-9110');
INSERT INTO fone (cpf, fone) VALUES (6542, '9958-0432');

--inserindo Participações (25 no total)
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (1, 1, 1111);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (1, 1, 2222);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (1, 2, 4444);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (2, 1, 1111);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (2, 3, 7777);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (2, 5, 6666);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (2, 4, 5555);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (2, 4, 6666);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (3, 2, 4444);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (3, 3, 8888);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (3, 5, 6666);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (3, 4, 7777);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (4, 2, 0000);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (4, 3, 9999);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (4, 1, 2222);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (5, 1, 0000);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (5, 4, 9875);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (5, 2, 6542);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (6, 3, 3333);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (6, 5, 2222);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (6, 1, 1111);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (7, 3, 7777);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (7, 1, 0000);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (7, 2, 8888);
INSERT INTO participa (codigo_projeto, codigo_atividade, cpf) VALUES (7, 4, 9999);

--inserindo Departamentos (5 no total)
INSERT INTO departamento (cpf_chefe, codigo, descricao) VALUES (1111, 1, 'Vendas');
INSERT INTO departamento (cpf_chefe, codigo, descricao) VALUES (3333, 2, 'Producao');
INSERT INTO departamento (cpf_chefe, codigo, descricao) VALUES (6666, 3, 'RH');
INSERT INTO departamento (cpf_chefe, codigo, descricao) VALUES (0000, 4, 'Financeiro');
INSERT INTO departamento (cpf_chefe, codigo, descricao) VALUES (6542, 5, 'Estoque');


--inserindo Gratificações (3 no total)
INSERT INTO gratificacao (codigo, descricao) VALUES (1, 'Bonus de 50%');
INSERT INTO gratificacao (codigo, descricao) VALUES (2, 'Bonus de 30%');
INSERT INTO gratificacao (codigo, descricao) VALUES (3, 'Folga remunerada');

--inserindo Trabalhos (16 no total)
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (1111, 1, to_date ('01/02/1999', 'dd/mm/yyyy'), 3);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (2222, 1, to_date ('04/07/2001', 'dd/mm/yyyy'), 1);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (2222, 2, to_date ('01/09/2005', 'dd/mm/yyyy'), 3);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (3333, 2, to_date ('26/12/2009', 'dd/mm/yyyy'), NULL);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (4444, 4, to_date ('13/05/2010', 'dd/mm/yyyy'), 2);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (5555, 3, to_date ('28/05/2011', 'dd/mm/yyyy'), NULL);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (6666, 1, to_date ('09/02/2005', 'dd/mm/yyyy'), NULL);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (6666, 2, to_date ('01/02/2009', 'dd/mm/yyyy'), 3);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (6666, 4, to_date ('18/11/2013', 'dd/mm/yyyy'), 1);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (7777, 5, to_date ('08/06/2014', 'dd/mm/yyyy'), 2);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (8888, 2, to_date ('20/06/2011', 'dd/mm/yyyy'), NULL);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (9999, 1, to_date ('05/05/2005', 'dd/mm/yyyy'), NULL);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (9875, 4, to_date ('17/01/2013', 'dd/mm/yyyy'), 1);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (0000, 4, to_date ('01/04/2007', 'dd/mm/yyyy'), 3);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (6542, 5, to_date ('23/11/2014', 'dd/mm/yyyy'), 2);
INSERT INTO trabalha (cpf, codigo_depto, data_trabalha, codigo_gratif) VALUES (6542, 3, to_date ('15/09/2010', 'dd/mm/yyyy'), NULL);

--inserindo Técnicos (6 ao todo)
INSERT INTO tecnico (cpf, ultima_serie) VALUES (3333, 12);
INSERT INTO tecnico (cpf, ultima_serie) VALUES (4444, 8);
INSERT INTO tecnico (cpf, ultima_serie) VALUES (5555, 6);
INSERT INTO tecnico (cpf, ultima_serie) VALUES (7777, 9);
INSERT INTO tecnico (cpf, ultima_serie) VALUES (9999, 7);
INSERT INTO tecnico (cpf, ultima_serie) VALUES (6542, 8);


--inserindo Graduados (6 ao todo)
INSERT INTO graduado (cpf) VALUES (1111);
INSERT INTO graduado (cpf) VALUES (2222);
INSERT INTO graduado (cpf) VALUES (6666);
INSERT INTO graduado (cpf) VALUES (8888);
INSERT INTO graduado (cpf) VALUES (0000);
INSERT INTO graduado (cpf) VALUES (9875);


--inserindo Graus (4 ao todo)
INSERT INTO grau (codigo, tipo) VALUES (1, 'GRADUACAO');
INSERT INTO grau (codigo, tipo) VALUES (2, 'ESPECIALIZACAO');
INSERT INTO grau (codigo, tipo) VALUES (3, 'MESTRADO');
INSERT INTO grau (codigo, tipo) VALUES (4, 'DOUTORADO');

--inserindo IES (4 ao todo)
INSERT INTO ies (codigo, nome, sigla) VALUES (1, 'Universidade Santana Braga', 'USB');
INSERT INTO ies (codigo, nome, sigla) VALUES (2, 'Faculdade Indiana F. Antunes', 'FIFA');
INSERT INTO ies (codigo, nome, sigla) VALUES (3, 'Intituto Regional Vieirinha', 'IRV');
INSERT INTO ies (codigo, nome, sigla) VALUES (4, 'Faculdade Mendel Guimaraes', 'FMG');


--inserindo Titulações (7 ao todo)
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (1111, 1, to_date ('1979', 'yyyy'), 1);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (2222, 1, to_date ('1999', 'yyyy'), 2);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (6666, 1, to_date ('2005', 'yyyy'), 2);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (8888, 1, to_date ('2007', 'yyyy'), 3);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (0000, 1, to_date ('2008', 'yyyy'), 4);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (0000, 1, to_date ('2005', 'yyyy'), 1);
INSERT INTO titulacao_empregado (cpf, codigo_grau, data_titulacao, codigo_ies) VALUES (9875, 1, to_date ('1995', 'yyyy'), 3);

