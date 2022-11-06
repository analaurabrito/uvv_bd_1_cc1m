
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave prim�ria que indica o c�digo de um determinado cargo.';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'Sal�rio m�nimo mensal que um funcion�rio em determinado cargo recebe.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'Sal�rio m�ximo mensal que um funcion�rio em determinado cargo recebe.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes COMMENT 'tabela1';

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave prim�ria que indica o c�digo da regi�o onde se encontra determinada facilidade da empresa.';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nome da regi�o.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INT NOT NULL,
                PRIMARY KEY (id_pais)
);

ALTER TABLE paises MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave prim�ria que indica o c�digo do pa�s onde se encontra determinada facilidade da empresa.';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do pa�s.';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira que indica o c�digo da regi�o (referente � tabela regi�es) onde se encontra determinada facilidade da empresa.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave prim�ria que indica o c�digo de uma localiza��o onde existe um departamento da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endere�o (logradouro, n�mero) de determinada localiza��o da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP referente � determinada localiza��o da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Cidade onde se encontra determinada facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Cidade onde se encontra determinada facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira que indica o c�digo do pa�s (referente � tabela pa�ses) onde se encontra determinada facilidade da empresa.';


CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INT NOT NULL,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave prim�ria que indica o c�digo de um departamento.';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do departamento.';

ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira para a tabela localiza��es, que especif�ca em qual local fica determinado departamento.';


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(4,2) NOT NULL,
                id_departamento INT,
                id_supervisor INT,
                PRIMARY KEY (id_empregado)
);

ALTER TABLE empregados COMMENT 'Tabela que lista os funcion�rios da empresa e suas informa��es.';

ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave prim�ria que indica o c�digo �nico de cadastro do funcion�rio (chave prim�ria da tabela empregados).';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome completo do funcion�rio.';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Endere�o de e-mail dos funcion�rios (antes do @)';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Telefone do funcion�rio, identificando pa�s e regi�o.';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data que o funcion�rio iniciou seus servi�os na empresa.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeira que especifica o c�digo do cargo atual exercido pelo funcion�rio (referente � tabela cargos)';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Sal�rio mensal recebido por cada funcion�rio.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4, 2) COMMENT 'Comiss�o recebida pelos funcion�rios do departamento de vendas, atrav�s da porcentagem de vendas realizadas por eles.';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira que indica (atrav�s do relacionamento referente � tabela departamentos), a qual departamento pertende cada funcion�rio.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Chave estrangeira que indica relacionamento dentro da pr�pria tabela empregados, indicando o supervisor de cada funcion�rio (que tamb�m � identificado por um id_funcion�rio e pode ser o gerente do departamento ou n�o).';


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE UNIQUE INDEX empregados_idx1
 ON empregados
 ( email );

CREATE TABLE gerentes (
                id_gerente INT NOT NULL,
                id_departamento INT NOT NULL,
                PRIMARY KEY (id_gerente, id_departamento)
);

ALTER TABLE gerentes MODIFY COLUMN id_gerente INTEGER COMMENT 'Chave prim�ria estrangeira que indica o c�digo do funcion�rio (referente � tabela empregados), que se direciona � essa tabela quando possui o cargo de gerente.';

ALTER TABLE gerentes MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave prim�ria estrangeira que indica o c�digo do departamento (referente � tabela departamentos) � qual cada gerente pertence.';


CREATE TABLE historico_cargos (
                id_empregado INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DECIMAL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                PRIMARY KEY (id_empregado, data_inicial)
);

ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave prim�ria estrangeira que indica o c�digo de um determinado funcion�rio (referente � tabela empregados).';

ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Data de �nicio de um funcion�rio em determinado cargo. Deve ser menor do que o valor da data_final.';

ALTER TABLE historico_cargos MODIFY COLUMN data_final DECIMAL COMMENT 'Data do �ltimo dia de um funcion�rio em determinado cargo. Deve ser maior do que o valor da data_inicial.';

ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave estrangeira correspondente ao c�digo do cargo (referente � tabela cargos) que o estava sendo exercido.';

ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave estrangeira correspondente ao c�digo do departamento (referente � tabela departamentos) em que aquele funcion�rio estava atuando em tal cargo.';


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk1
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE gerentes ADD CONSTRAINT departamentos_gerentes_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*
Warning: MySQL does not support this relationship's deferrability policy (INITIALLY_DEFERRED).
*/
ALTER TABLE gerentes ADD CONSTRAINT empregados_gerentes_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
