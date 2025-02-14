-- Inserindo dados na tabela tbl_nivel_fidelidade
INSERT INTO tbl_nivel_fidelidade (nivel) VALUES 
('BRONZE'), ('PRATA'), ('OURO'), ('PLATINA'), ('DIAMANTE');

-- Inserindo dados na tabela tbl_clientes
INSERT INTO tbl_clientes (nome, cpf, telefone, email, endereco, fidelidade, fk_nivel_fidelidade) VALUES 
('João Silva', '123.456.789-00', '11999999999', 'joao@email.com', 'Rua A, 123', 'Participa', 1),
('Maria Souza', '987.654.321-00', '11888888888', 'maria@email.com', 'Rua B, 456', 'Não Participa', 2);

-- Inserindo dados na tabela tbl_colaborador
INSERT INTO tbl_colaborador (nome, cpf, telefone, email, cargo, setor, salario, data_admissao) VALUES 
('Carlos Mendes', '111.222.333-44', '11777777777', 'carlos@email.com', 'Atendente', 'Vendas', 2500.00, '2023-01-10');

-- Inserindo dados na tabela tbl_forma_pagamento
INSERT INTO tbl_forma_pagamento (nome) VALUES 
('DÉBITO'), ('CRÉDITO'), ('PIX'), ('DINHEIRO');

-- Inserindo dados na tabela tbl_vendas
INSERT INTO tbl_vendas (data_hora, valor_total, fk_cliente, fk_colaborador) VALUES 
('2024-02-10 14:30:00', 120.50, 1, 1);

-- Inserindo dados na tabela tbl_pagamentos
INSERT INTO tbl_pagamentos (valor_pago, fk_forma_pagamento, fk_venda) VALUES
(120.50, 1, 1);

-- Inserindo dados na tabela tbl_cupons_fiscais
INSERT INTO tbl_cupons_fiscais (data_emissao, valor_total, fk_venda) VALUES 
('2024-02-10', 120.50, 1);

-- Inserindo dados na tabela tbl_fornecedores
INSERT INTO tbl_fornecedores (nome, cnpj, telefone, email) VALUES 
('Fornecedor A', '12345678000199', '1144444444', 'fornecedorA@email.com');

-- Inserindo dados na tabela tbl_produtos
INSERT INTO tbl_produtos (nome, descricao, categoria, preco, estoque, validade, fk_fornecedor) VALUES 
('Arroz', 'Pacote de 5kg', 'Alimentos', 25.90, 100, '2025-12-31', 1),
('Feijão', 'Pacote de 1kg', 'Alimentos', 8.50, 200, '2025-11-30', 1);

-- Inserindo dados na tabela tbl_promocoes
INSERT INTO tbl_promocoes (nome, descricao, valor, tipo, data_inicio, data_fim) VALUES 
('Promoção Percentual', 'Desconto de 10%', 10.00, 'Desconto Percentual', '2024-02-01', '2024-02-28'),
('Promoção Fixa', 'Desconto de 5 reais', 5.00, 'Desconto Fixo', '2024-02-01', '2024-02-28'),
('Promoção Compre e Ganhe', 'Ganhe um brinde na compra', 0.00, 'Compre e Ganhe', '2024-02-01', '2024-02-28'),
('Frete Grátis', 'Frete grátis para compras acima de 100 reais', 0.00, 'Frete Grátis', '2024-02-01', '2024-02-28'),
('Cashback', 'Receba 5% do valor da compra de volta', 5.00, 'Cashback', '2024-02-01', '2024-02-28'),
('Brinde', 'Brinde especial para clientes VIP', 0.00, 'Brinde', '2024-02-01', '2024-02-28'),
('Programa de Fidelidade', 'Acumule pontos para trocar por descontos', 0.00, 'Programa de Fidelidade', '2024-02-01', '2024-02-28');

-- Inserindo dados na tabela tbl_produtos_venda
INSERT INTO tbl_produtos_venda (id_venda, id_produto, quantidade, preco_unitario, subtotal, fk_promocao) VALUES 
(1, 1, 2, 25.90, 51.80, 1),
(1, 2, 1, 8.50, 8.50, NULL);

-- Inserindo dados na tabela tbl_promocoes_produtos
INSERT INTO tbl_promocoes_produtos (id_promocao, id_produto) VALUES 
(1, 1);
