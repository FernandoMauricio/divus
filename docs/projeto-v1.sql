
CREATE SEQUENCE situacao_seq_1;

CREATE TABLE situacao (
                situ_codigo INTEGER NOT NULL DEFAULT nextval('situacao_seq_1'),
                situ_nome VARCHAR(60) NOT NULL,
                CONSTRAINT situacao_pk PRIMARY KEY (situ_codigo)
);
COMMENT ON TABLE situacao IS '1 - Aberto
2 - Separação
3 - Disponivel para entrega
4 - Enviado para o cliente
5 - Entregue
6 - Fechado
7 - Cancelado';


ALTER SEQUENCE situacao_seq_1 OWNED BY situacao.situ_codigo;

CREATE SEQUENCE usuario_seq_1;

CREATE TABLE usuario (
                usua_codigo INTEGER NOT NULL DEFAULT nextval('usuario_seq_1'),
                usua_nome VARCHAR(60) NOT NULL,
                usua_email VARCHAR(120) NOT NULL,
                usua_senha VARCHAR(240) NOT NULL,
                usua_habilitado BOOLEAN DEFAULT true NOT NULL,
                usua_tipo INTEGER DEFAULT 2 NOT NULL,
                usua_data_criacao TIMESTAMP NOT NULL,
                usua_data_alteracao TIMESTAMP NOT NULL,
                usua_auth_key VARCHAR(240) NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (usua_codigo)
);
COMMENT ON COLUMN usuario.usua_tipo IS '1 = Administrador
2 = Vendedor';


ALTER SEQUENCE usuario_seq_1 OWNED BY usuario.usua_codigo;

CREATE SEQUENCE cliente_seq;

CREATE TABLE cliente (
                clie_codigo INTEGER NOT NULL DEFAULT nextval('cliente_seq'),
                clie_nome VARCHAR(120) NOT NULL,
                clie_telefone VARCHAR(11) NOT NULL,
                clie_email VARCHAR(60) NOT NULL,
                clie_endereco_cep VARCHAR(9) NOT NULL,
                clie_endereco_logradouro VARCHAR(120) NOT NULL,
                clie_complemento VARCHAR(240),
                clie_endereco_bairro VARCHAR(60) NOT NULL,
                clie_endereco_cidade VARCHAR(40) NOT NULL,
                clie_endereco_estado VARCHAR(40) NOT NULL,
                clie_endereco_numero VARCHAR(5),
                CONSTRAINT cliente_pk PRIMARY KEY (clie_codigo)
);
COMMENT ON COLUMN cliente.clie_endereco_cep IS '69028-222';


ALTER SEQUENCE cliente_seq OWNED BY cliente.clie_codigo;

CREATE SEQUENCE pedido_seq;

CREATE TABLE pedido (
                pedi_codigo INTEGER NOT NULL DEFAULT nextval('pedido_seq'),
                clie_codigo INTEGER NOT NULL,
                pedi_data_criacao TIMESTAMP NOT NULL,
                usua_data_alteracao TIMESTAMP NOT NULL,
                usua_codigo INTEGER NOT NULL,
                situ_codigo INTEGER NOT NULL,
                CONSTRAINT pedido_pk PRIMARY KEY (pedi_codigo)
);


ALTER SEQUENCE pedido_seq OWNED BY pedido.pedi_codigo;

CREATE SEQUENCE categoria_seq;

CREATE TABLE categoria (
                cate_codigo INTEGER NOT NULL DEFAULT nextval('categoria_seq'),
                cate_nome VARCHAR(40) NOT NULL,
                CONSTRAINT categoria_pk PRIMARY KEY (cate_codigo)
);


ALTER SEQUENCE categoria_seq OWNED BY categoria.cate_codigo;

CREATE SEQUENCE marca_seq;

CREATE TABLE marca (
                marc_codigo INTEGER NOT NULL DEFAULT nextval('marca_seq'),
                marc_nome VARCHAR(40) NOT NULL,
                CONSTRAINT marca_pk PRIMARY KEY (marc_codigo)
);


ALTER SEQUENCE marca_seq OWNED BY marca.marc_codigo;

CREATE SEQUENCE produto_prod_codigo_seq;

CREATE TABLE produto (
                prod_codigo INTEGER NOT NULL DEFAULT nextval('produto_prod_codigo_seq'),
                prod_nome VARCHAR(120) NOT NULL,
                prod_valor REAL NOT NULL,
                prod_estoque INTEGER DEFAULT 0 NOT NULL,
                marc_codigo INTEGER NOT NULL,
                cate_codigo INTEGER NOT NULL,
                CONSTRAINT produto_pk PRIMARY KEY (prod_codigo)
);


ALTER SEQUENCE produto_prod_codigo_seq OWNED BY produto.prod_codigo;

CREATE SEQUENCE pedido_produto_seq;

CREATE TABLE pedido_produto (
                pepr_codigo INTEGER NOT NULL DEFAULT nextval('pedido_produto_seq'),
                pedi_codigo INTEGER NOT NULL,
                pepr_data_criacao TIMESTAMP NOT NULL,
                pepr_quantidade INTEGER NOT NULL,
                pepr_valor REAL NOT NULL,
                prod_codigo INTEGER NOT NULL,
                CONSTRAINT pedido_produto_pk PRIMARY KEY (pepr_codigo)
);


ALTER SEQUENCE pedido_produto_seq OWNED BY pedido_produto.pepr_codigo;

ALTER TABLE pedido ADD CONSTRAINT situacao_pedido_fk
FOREIGN KEY (situ_codigo)
REFERENCES situacao (situ_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido ADD CONSTRAINT usuario_pedido_fk
FOREIGN KEY (usua_codigo)
REFERENCES usuario (usua_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido ADD CONSTRAINT cliente_pedido_fk
FOREIGN KEY (clie_codigo)
REFERENCES cliente (clie_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_produto ADD CONSTRAINT pedido_pedido_produto_fk
FOREIGN KEY (pedi_codigo)
REFERENCES pedido (pedi_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE produto ADD CONSTRAINT categoria_produto_fk
FOREIGN KEY (cate_codigo)
REFERENCES categoria (cate_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE produto ADD CONSTRAINT marca_produto_fk
FOREIGN KEY (marc_codigo)
REFERENCES marca (marc_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_produto ADD CONSTRAINT produto_pedido_produto_fk
FOREIGN KEY (prod_codigo)
REFERENCES produto (prod_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
