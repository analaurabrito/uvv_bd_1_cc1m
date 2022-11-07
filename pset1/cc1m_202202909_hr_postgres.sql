CREATE USER analaura WITH
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	REPLICATION
	BYPASSRLS
	ENCRYPTED PASSWORD 'computacao@raiz'
;

CREATE DATABASE uvv
	WITH OWNER = analaura
	TEMPLATE = template0
	ENCODING = 'UTF8'
	LC_COLLATE = 'pt_BR.UTF-8'
	LC_CTYPE = 'pt_BR.UTF-8'
	ALLOW_CONNECTIONS = true
;

\c uvv analaura;
computacao@raiz

CREATE SCHEMA IF NOT EXISTS hr AUTHORIZATION analaura;

ALTER USER analaura
SET SEARCH_PATH TO hr, analaura, public;

CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON COLUMN cargos.id_cargo IS 'Chave primária que indica o código de um determinado cargo.';
COMMENT ON COLUMN cargos.cargo IS 'Nome do cargo.';
COMMENT ON COLUMN cargos.salario_minimo IS 'Salário mínimo mensal que um funcionário em determinado cargo recebe.';
COMMENT ON COLUMN cargos.salario_maximo IS 'Salário máximo mensal que um funcionário em determinado cargo recebe.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE regioes IS 'tabela1';
COMMENT ON COLUMN regioes.id_regiao IS 'Chave primária que indica o código da região onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN regioes.nome IS 'Nome da região.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT id_pais PRIMARY KEY (id_pais)
);
COMMENT ON COLUMN paises.id_pais IS 'Chave primária que indica o código do país onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN paises.nome IS 'Nome do país.';
COMMENT ON COLUMN paises.id_regiao IS 'Chave estrangeira que indica o código da região (referente à tabela regiões) onde se encontra determinada facilidade da empresa.';


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
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Chave primária que indica o código de uma localização onde existe um departamento da empresa.';
COMMENT ON COLUMN localizacoes.endereco IS 'Endereço (logradouro, número) de determinada localização da empresa.';
COMMENT ON COLUMN localizacoes.cep IS 'CEP referente à determinada localização da empresa.';
COMMENT ON COLUMN localizacoes.cidade IS 'Cidade onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN localizacoes.uf IS 'Cidade onde se encontra determinada facilidade da empresa.';
COMMENT ON COLUMN localizacoes.id_pais IS 'Chave estrangeira que indica o código do país (referente à tabela países) onde se encontra determinada facilidade da empresa.';


CREATE TABLE departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INTEGER NOT NULL,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);
COMMENT ON COLUMN departamentos.id_departamento IS 'Chave primária que indica o código de um departamento.';
COMMENT ON COLUMN departamentos.nome IS 'Nome do departamento.';
COMMENT ON COLUMN departamentos.id_localizacao IS 'Chave estrangeira para a tabela localizações, que especifíca em qual local fica determinado departamento.';


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
COMMENT ON TABLE empregados IS 'Tabela que lista os funcionários da empresa e suas informações.';
COMMENT ON COLUMN empregados.id_empregado IS 'Chave primária que indica o código único de cadastro do funcionário (chave primária da tabela empregados).';
COMMENT ON COLUMN empregados.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN empregados.email IS 'Endereço de e-mail dos funcionários (antes do @)';
COMMENT ON COLUMN empregados.telefone IS 'Telefone do funcionário, identificando país e região.';
COMMENT ON COLUMN empregados.data_contratacao IS 'Data que o funcionário iniciou seus serviços na empresa.';
COMMENT ON COLUMN empregados.id_cargo IS 'Chave estrangeira que especifica o código do cargo atual exercido pelo funcionário (referente à tabela cargos)';
COMMENT ON COLUMN empregados.salario IS 'Salário mensal recebido por cada funcionário.';
COMMENT ON COLUMN empregados.comissao IS 'Comissão recebida pelos funcionários do departamento de vendas, através da porcentagem de vendas realizadas por eles.';
COMMENT ON COLUMN empregados.id_departamento IS 'Chave estrangeira que indica (através do relacionamento referente à tabela departamentos), a qual departamento pertende cada funcionário.';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira que indica relacionamento dentro da própria tabela empregados, indicando o supervisor de cada funcionário (que também é identificado por um id_funcionário e pode ser o gerente do departamento ou não).';


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
COMMENT ON COLUMN gerentes.id_gerente IS 'Chave primária estrangeira que indica o código do funcionário (referente à tabela empregados), que se direciona à essa tabela quando possui o cargo de gerente.';
COMMENT ON COLUMN gerentes.id_departamento IS 'Chave primária estrangeira que indica o código do departamento (referente à tabela departamentos) à qual cada gerente pertence.';


CREATE TABLE historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final NUMERIC,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT data_inicial PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Chave primária estrangeira que indica o código de um determinado funcionário (referente à tabela empregados).';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'Data de ínicio de um funcionário em determinado cargo. Deve ser menor do que o valor da data_final.';
COMMENT ON COLUMN historico_cargos.data_final IS 'Data do último dia de um funcionário em determinado cargo. Deve ser maior do que o valor da data_inicial.';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'Chave estrangeira correspondente ao código do cargo (referente à tabela cargos) que o estava sendo exercido.';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'Chave estrangeira correspondente ao código do departamento (referente à tabela departamentos) em que aquele funcionário estava atuando em tal cargo.';


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
