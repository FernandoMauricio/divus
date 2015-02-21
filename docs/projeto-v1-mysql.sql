
CREATE TABLE situacao (
                situ_codigo INT AUTO_INCREMENT NOT NULL,
                situ_nome VARCHAR(60) NOT NULL,
                PRIMARY KEY (situ_codigo)
);

ALTER TABLE situacao COMMENT '1 - Aberto
2 - Separação
3 - Disponivel para entrega
4 - Enviado para o cliente
5 - Entregue
6 - Fechado
7 - Cancelado';


CREATE TABLE usuario (
                usua_codigo INT AUTO_INCREMENT NOT NULL,
                usua_nome VARCHAR(60) NOT NULL,
                usua_email VARCHAR(120) NOT NULL,
                usua_senha VARCHAR(240) NOT NULL,
                usua_habilitado BOOLEAN DEFAULT true NOT NULL,
                usua_tipo INT DEFAULT 2 NOT NULL,
                usua_data_criacao DATETIME NOT NULL,
                usua_data_alteracao DATETIME NOT NULL,
                usua_auth_key VARCHAR(240) NOT NULL,
                PRIMARY KEY (usua_codigo)
);

ALTER TABLE usuario MODIFY COLUMN usua_tipo INTEGER COMMENT '1 = Administrador
2 = Vendedor';


CREATE TABLE cliente (
                clie_codigo INT AUTO_INCREMENT NOT NULL,
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
                PRIMARY KEY (clie_codigo)
);

ALTER TABLE cliente MODIFY COLUMN clie_endereco_cep VARCHAR(9) COMMENT '69028-222';


CREATE TABLE pedido (
                pedi_codigo INT AUTO_INCREMENT NOT NULL,
                clie_codigo INT NOT NULL,
                pedi_data_criacao DATETIME NOT NULL,
                usua_data_alteracao DATETIME NOT NULL,
                usua_codigo INT NOT NULL,
                situ_codigo INT NOT NULL,
                PRIMARY KEY (pedi_codigo)
);


CREATE TABLE categoria (
                cate_codigo INT AUTO_INCREMENT NOT NULL,
                cate_nome VARCHAR(40) NOT NULL,
                PRIMARY KEY (cate_codigo)
);


CREATE TABLE marca (
                marc_codigo INT AUTO_INCREMENT NOT NULL,
                marc_nome VARCHAR(40) NOT NULL,
                PRIMARY KEY (marc_codigo)
);


CREATE TABLE produto (
                prod_codigo INT AUTO_INCREMENT NOT NULL,
                prod_nome VARCHAR(120) NOT NULL,
                prod_valor DOUBLE PRECISIONS NOT NULL,
                prod_estoque INT DEFAULT 0 NOT NULL,
                marc_codigo INT NOT NULL,
                cate_codigo INT NOT NULL,
                PRIMARY KEY (prod_codigo)
);


CREATE TABLE pedido_produto (
                pepr_codigo INT AUTO_INCREMENT NOT NULL,
                pedi_codigo INT NOT NULL,
                pepr_data_criacao DATETIME NOT NULL,
                pepr_quantidade INT NOT NULL,
                pepr_valor DOUBLE PRECISIONS NOT NULL,
                prod_codigo INT NOT NULL,
                PRIMARY KEY (pepr_codigo)
);


ALTER TABLE pedido ADD CONSTRAINT situacao_pedido_fk
FOREIGN KEY (situ_codigo)
REFERENCES situacao (situ_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedido ADD CONSTRAINT usuario_pedido_fk
FOREIGN KEY (usua_codigo)
REFERENCES usuario (usua_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedido ADD CONSTRAINT cliente_pedido_fk
FOREIGN KEY (clie_codigo)
REFERENCES cliente (clie_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedido_produto ADD CONSTRAINT pedido_pedido_produto_fk
FOREIGN KEY (pedi_codigo)
REFERENCES pedido (pedi_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE produto ADD CONSTRAINT categoria_produto_fk
FOREIGN KEY (cate_codigo)
REFERENCES categoria (cate_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE produto ADD CONSTRAINT marca_produto_fk
FOREIGN KEY (marc_codigo)
REFERENCES marca (marc_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedido_produto ADD CONSTRAINT produto_pedido_produto_fk
FOREIGN KEY (prod_codigo)
REFERENCES produto (prod_codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
