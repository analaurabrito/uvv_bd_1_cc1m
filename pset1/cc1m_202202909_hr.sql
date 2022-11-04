
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON COLUMN cargos.id_cargo IS 'Chave prim�ria que indica o c�digo de um determinado cargo.';
COMMENT ON COLUMN cargos.cargo IS 'Nome do cargo.';
COMMENT ON COLUMN cargos.salario_minimo IS 'Sal�rio m�nimo mensal que um funcion�rio em determinado cargo recebe.';
COMMENT ON COLUMN cargos.salario_maximo IS 'Sal�rio m�ximo mensal que um funcion�rio em determinado cargo recebe.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE regioes IS 'tabela1';
COMMENT ON COLUMN regioes.id_regiao IS 'Chave prim�ria que indica o c�digo da regi�o onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN regioes.nome IS 'Nome da regi�o.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT id_pais PRIMARY KEY (id_pais)
);
COMMENT ON COLUMN paises.id_pais IS 'Chave prim�ria que indica o c�digo do pa�s onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN paises.nome IS 'Nome do pa�s.';
COMMENT ON COLUMN paises.id_regiao IS 'Chave estrangeira que indica o c�digo da regi�o (referente � tabela regi�es) onde se encontra determinada facilidade da empresa.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Chave prim�ria que indica o c�digo de uma localiza��o onde existe um departamento da empresa.';
COMMENT ON COLUMN localizacoes.endereco IS 'Endere�o (logradouro, n�mero) de determinada localiza��o da empresa.';
COMMENT ON COLUMN localizacoes.cep IS 'CEP referente � determinada localiza��o da empresa.';
COMMENT ON COLUMN localizacoes.cidade IS 'Cidade onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN localizacoes.uf IS 'Cidade onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN localizacoes.id_pais IS 'Chave estrangeira que indica o c�digo do pa�s (referente � tabela pa�ses) onde se encontra determinada facilidade da empresa.';


CREATE TABLE departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INTEGER NOT NULL,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);
COMMENT ON COLUMN departamentos.id_departamento IS 'Chave prim�ria que indica o c�digo de um departamento.';
COMMENT ON COLUMN departamentos.nome IS 'Nome do departamento.';
COMMENT ON COLUMN departamentos.id_localizacao IS 'Chave estrangeira para a tabela localiza��es, que especif�ca em qual local fica determinado departamento.';


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2) NOT NULL,
                id_departamento INTEGER,
                id_supervisor INTEGER,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE empregados IS 'Tabela que lista os funcion�rios da empresa e suas informa��es.';
COMMENT ON COLUMN empregados.id_empregado IS 'Chave prim�ria que indica o c�digo �nico de cadastro do funcion�rio (chave prim�ria da tabela empregados).';
COMMENT ON COLUMN empregados.nome IS 'Nome completo do funcion�rio.';
COMMENT ON COLUMN empregados.email IS 'Endere�o de e-mail dos funcion�rios (antes do @)';
COMMENT ON COLUMN empregados.telefone IS 'Telefone do funcion�rio, identificando pa�s e regi�o.';
COMMENT ON COLUMN empregados.data_contratacao IS 'Data que o funcion�rio iniciou seus servi�os na empresa.';
COMMENT ON COLUMN empregados.id_cargo IS 'Chave estrangeira que especifica o c�digo do cargo atual exercido pelo funcion�rio (referente � tabela cargos)';
COMMENT ON COLUMN empregados.salario IS 'Sal�rio mensal recebido por cada funcion�rio.';
COMMENT ON COLUMN empregados.comissao IS 'Comiss�o recebida pelos funcion�rios do departamento de vendas, atrav�s da porcentagem de vendas realizadas por eles.';
COMMENT ON COLUMN empregados.id_departamento IS 'Chave estrangeira que indica (atrav�s do relacionamento referente � tabela departamentos), a qual departamento pertende cada funcion�rio.';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira que indica relacionamento dentro da pr�pria tabela empregados, indicando o supervisor de cada funcion�rio (que tamb�m � identificado por um id_funcion�rio e pode ser o gerente do departamento ou n�o).';


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE UNIQUE INDEX empregados_idx1
 ON empregados
 ( email );

CREATE TABLE gerentes (
                id_gerente INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT id_gerentes PRIMARY KEY (id_gerente, id_departamento)
);
COMMENT ON COLUMN gerentes.id_gerente IS 'Chave prim�ria estrangeira que indica o c�digo do funcion�rio (referente � tabela empregados), que se direciona � essa tabela quando possui o cargo de gerente.';
COMMENT ON COLUMN gerentes.id_departamento IS 'Chave prim�ria estrangeira que indica o c�digo do departamento (referente � tabela departamentos) � qual cada gerente pertence.';


CREATE TABLE historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final NUMERIC,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT data_inicial PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Chave prim�ria estrangeira que indica o c�digo de um determinado funcion�rio (referente � tabela empregados).';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'Data de �nicio de um funcion�rio em determinado cargo. Deve ser menor do que o valor da data_final.';
COMMENT ON COLUMN historico_cargos.data_final IS 'Data do �ltimo dia de um funcion�rio em determinado cargo. Deve ser maior do que o valor da data_inicial.';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'Chave estrangeira correspondente ao c�digo do cargo (referente � tabela cargos) que o estava sendo exercido.';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'Chave estrangeira correspondente ao c�digo do departamento (referente � tabela departamentos) em que aquele funcion�rio estava atuando em tal cargo.';


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk1
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE gerentes ADD CONSTRAINT departamentos_gerentes_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE gerentes ADD CONSTRAINT empregados_gerentes_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;
