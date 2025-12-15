DROP TABLE IF EXISTS ITENS_PEDIDO, PEDIDOS, PRODUTOS, CLIENTES, FORNECEDORES CASCADE;

CREATE TABLE FORNECEDORES
(
  fornecedor_id SERIAL PRIMARY KEY,
  nome_fornecedor VARCHAR(100) NOT NULL,
  telefone VARCHAR(15) 
);

CREATE TABLE CLIENTES
(
  clientes_id SERIAL PRIMARY KEY,
  nome_cliente VARCHAR(100) NOT NULL,
  endereco VARCHAR(200)
);

CREATE TABLE PRODUTOS
(
  produto_id SERIAL PRIMARY KEY,
  nome_produto VARCHAR(100) NOT NULL,
  preco_venda NUMERIC(10, 2) NOT NULL,
  estoque_quantidade INTEGER DEFAULT 0,
  fornecedor_id INTEGER,

    CONSTRAINT fk_fornecedor
      FOREIGN KEY(fornecedor_id)
      REFERENCES FORNECEDORES(fornecedor_id)
);

CREATE TABLE PEDIDOS
(
  pedidos_id SERIAL PRIMARY KEY,
  data_pedido DATE NOT NULL,
  clientes_id INTEGER NOT NULL, 
  valor_total NUMERIC(10, 2),

    CONSTRAINT fk_clientes
      FOREIGN KEY(clientes_id)
      REFERENCES CLIENTES(clientes_id)
);

CREATE TABLE ITENS_PEDIDO
(
  item_pedido_id SERIAL PRIMARY KEY,
  pedidos_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL CHECK(quantidade > 0),
  preco_unitario_venda NUMERIC(10, 2) NOT NULL,

    CONSTRAINT fk_pedido
      FOREIGN KEY(pedidos_id)
      REFERENCES PEDIDOS(pedidos_id),

    CONSTRAINT fk_produto
      FOREIGN KEY(produto_id)
      REFERENCES PRODUTOS(produto_id)
);

INSERT INTO FORNECEDORES (nome_fornecedor, telefone) VALUES
('Distribuidora Alimentos Premium', '67980010001'),
('Laticínios da Fazenda LTDA', '67980010002'),
('Doces e Cia', '67980010003'),
('Produtos de Limpeza BR', '67980010004'),
('Embalagens Plásticas', '67980010005');

INSERT INTO CLIENTES (nome_cliente, endereco) VALUES
('Ana Clara Souza', 'Rua das Flores, 123'),
('Bruno Eduardo Lima', 'Av. Principal, 456'),
('Carla Denise Oliveira', 'Travessa da Paz, 789'),
('Daniel Felipe Santos', 'Estrada Velha, 101'),
('Erika Gabriela Rocha', 'Rua Nova, 202');

INSERT INTO PRODUTOS (nome_produto, preco_venda, estoque_quantidade, fornecedor_id) VALUES
('Arroz 5kg', 25.50, 50, 1), ('Feijão Preto 1kg', 8.99, 45, 1), ('Macarrão Spaguetti', 5.20, 60, 1), 
('Açúcar Refinado 1kg', 4.10, 70, 1), ('Óleo de Soja 900ml', 7.99, 55, 1), ('Café Tradicional 500g', 12.50, 40, 1),
('Farinha de Trigo 1kg', 6.00, 35, 1), ('Sal Refinado 1kg', 2.50, 80, 1), ('Azeite Extra Virgem 500ml', 35.00, 20, 1),
('Milho de Pipoca 500g', 3.50, 50, 1),
('Leite Integral 1L', 5.90, 80, 2), ('Manteiga 200g', 15.00, 30, 2), ('Queijo Muçarela 500g', 28.90, 25, 2),
('Iogurte Natural 170g', 3.20, 100, 2), ('Requeijão Cremoso 250g', 11.50, 35, 2), ('Creme de Leite 200g', 4.50, 60, 2),
('Ovo Branco DZ', 18.00, 40, 2),
('Chocolate ao Leite 100g', 8.90, 90, 3), ('Bala Sortida 500g', 12.00, 45, 3), ('Biscoito Maizena', 4.00, 75, 3),
('Gelatina Sabores', 2.10, 120, 3), ('Refrigerante Cola 2L', 9.90, 60, 3), ('Suco de Laranja 1L', 6.50, 50, 3),
('Água Mineral 500ml', 2.00, 150, 3),
('Sabão em Pó 1kg', 14.90, 30, 4), ('Detergente 500ml', 3.00, 90, 4), ('Água Sanitária 1L', 5.50, 40, 4),
('Esponja de Limpeza', 1.50, 100, 4),
('Saco Plástico P 100un', 10.00, 50, 5), ('Saco Plástico M 100un', 15.00, 40, 5), ('Embalagem P/ Bolo', 2.50, 60, 5);

INSERT INTO PEDIDOS (data_pedido, clientes_id, valor_total) VALUES
(current_date, 1, 40.70),
(current_date, 3, 79.79),
(current_date, 1, 15.00),
(current_date, 4, 18.00),
(current_date, 2, 45.90),
(current_date, 5, 22.00);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(1, 1, 1, 25.50),
(1, 2, 1, 8.99),
(1, 4, 1, 7.99);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(2, 13, 1, 28.90),
(2, 6, 1, 12.50),
(2, 18, 2, 8.90),
(2, 19, 1, 12.59);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(3, 12, 1, 15.00);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(4, 17, 1, 18.00);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(5, 11, 2, 5.90),
(5, 27, 1, 3.00),
(5, 24, 10, 3.00);

INSERT INTO ITENS_PEDIDO (pedidos_id, produto_id, quantidade, preco_unitario_venda) VALUES
(6, 14, 2, 3.20),
(6, 20, 4, 4.00);

SELECT
    P.data_pedido AS "Data da Venda",
    C.nome_cliente AS "Cliente",
    PR.nome_produto AS "Produto Comprado",
    IP.quantidade AS "Qtd Comprada",
    F.nome_fornecedor AS "Fornecedor",
    PR.estoque_quantidade AS "Estoque Atual"
FROM
    PEDIDOS P
INNER JOIN
    CLIENTES C ON P.clientes_id = C.clientes_id
INNER JOIN
    ITENS_PEDIDO IP ON P.pedidos_id = IP.pedidos_id
INNER JOIN
    PRODUTOS PR ON IP.produto_id = PR.produto_id
INNER JOIN
    FORNECEDORES F ON PR.fornecedor_id = F.fornecedor_id
ORDER BY
    P.data_pedido, C.nome_cliente;

SELECT
    C.nome_cliente AS "Cliente",
    F.nome_fornecedor AS "Fornecedor",
    SUM(IP.quantidade * IP.preco_unitario_venda) AS "Total Gasto"
FROM
    CLIENTES C
INNER JOIN
    PEDIDOS P ON C.clientes_id = P.clientes_id
INNER JOIN
    ITENS_PEDIDO IP ON P.pedidos_id = IP.pedidos_id
INNER JOIN
    PRODUTOS PR ON IP.produto_id = PR.produto_id
INNER JOIN
    FORNECEDORES F ON PR.fornecedor_id = F.fornecedor_id
WHERE
    EXTRACT(MONTH FROM P.data_pedido) = 12
    AND
    F.nome_fornecedor = 'Distribuidora Alimentos Premium'
GROUP BY
    C.nome_cliente, F.nome_fornecedor
ORDER BY
    "Total Gasto" DESC;
