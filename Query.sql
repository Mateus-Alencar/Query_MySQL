CREATE DATABASE IF NOT EXISTS sistema_vendas;
USE sistema_vendas;

-- Tabela de Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE DEFAULT (CURRENT_DATE)
);

-- Tabela de Produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE DEFAULT (current_date),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de Itens do Pedido (relacionamento N para N entre pedidos e produtos)
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserção de dados de exemplo
INSERT INTO clientes (nome, email, telefone) VALUES
('Ana Paula', 'ana@email.com', '11911112222'),
('Carlos Lima', 'carlos@email.com', '11933334444');

INSERT INTO produtos (nome, preco, estoque) VALUES
('Notebook', 3500.00, 10),
('Mouse', 80.00, 100),
('Teclado', 120.00, 50);

-- Criar pedido para Ana
INSERT INTO pedidos (cliente_id) VALUES (1);

-- Adicionar itens ao pedido de Ana
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 3500.00), 
(1, 2, 2, 80.00);  



SELECT * FROM itens_pedido;

-- Consulta: pedidos com nome do cliente e total por pedido
SELECT 
    p.id AS pedido_id,
    c.nome AS cliente,
    p.data_pedido,
    SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido i ON p.id = i.pedido_id
GROUP BY p.id, c.nome, p.data_pedido;
