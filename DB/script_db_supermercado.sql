SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `db_supermercado` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `db_supermercado` ;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_nivel_fidelidade` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_nivel_fidelidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nivel` ENUM("BRONZE", "PRATA", "OURO", "PLATINA", "DIAMANTE") NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
SHOW WARNINGS;
DELIMITER $$
CREATE TRIGGER before_insert_nivel_fidelidade
BEFORE INSERT ON tbl_nivel_fidelidade
FOR EACH ROW
BEGIN
    IF NEW.nivel NOT IN ('BRONZE', 'PRATA', 'OURO', 'PLATINA', 'DIAMANTE') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor inválido para ENUM nivel_fidelidade. Insira "BRONZE", "PRATA", "OURO", "PLATINA" ou "DIAMANTE" ';
    END IF;
END$$
DELIMITER ;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_clientes` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL UNIQUE,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(150) NOT NULL,
  `endereco` VARCHAR(300) NULL,
  `fidelidade` ENUM("Participa", "Não Participa") NOT NULL,
  `fk_nivel_fidelidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_nivel_fidelidade`
    FOREIGN KEY (`fk_nivel_fidelidade`)
    REFERENCES `db_supermercado`.`tbl_nivel_fidelidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_nivel_fidelidade` ON `db_supermercado`.`tbl_clientes` (`fk_nivel_fidelidade` ASC) VISIBLE;
SHOW WARNINGS;
DELIMITER $$
CREATE TRIGGER before_insert_clientes
BEFORE INSERT ON tbl_clientes
FOR EACH ROW
BEGIN
    IF NEW.fidelidade NOT IN ('Participa', 'Não Participa') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor inválido para ENUM fidelidade. Insira "Participa" ou "Não Participa"';
    END IF;
END$$
DELIMITER ;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_movimentacao_pontos` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_movimentacao_pontos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_movimentacao` VARCHAR(45) NOT NULL,
  `data_movimentacao` DATE NOT NULL,
  `pontos` INT NOT NULL,
  `fk_cliente` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_movimentacao_cliente`
    FOREIGN KEY (`fk_cliente`)
    REFERENCES `db_supermercado`.`tbl_clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_cliente` ON `db_supermercado`.`tbl_movimentacao_pontos` (`fk_cliente` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_colaborador` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_colaborador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL UNIQUE,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(250) NOT NULL,
  `cargo` VARCHAR(100) NOT NULL,
  `setor` VARCHAR(100) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `data_admissao` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_forma_pagamento` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_forma_pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` ENUM("DÉBITO", "CRÉDITO", "PIX", "DINHEIRO") NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
SHOW WARNINGS;
DELIMITER $$
CREATE TRIGGER before_insert_forma_pagamento
BEFORE INSERT ON tbl_forma_pagamento
FOR EACH ROW
BEGIN
    IF NEW.nome NOT IN ('DÉBITO', 'CRÉDITO', 'PIX', 'DINHEIRO') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor inválido para ENUM forma_pagamento. Insira "DÉBITO", "CRÉDITO", "PIX" ou "DINHEIRO"';
    END IF;
END$$
DELIMITER ;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_cupons_fiscais` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_cupons_fiscais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_emissao` DATE NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `fk_venda` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cupom_venda`
    FOREIGN KEY (`fk_venda`)
    REFERENCES `db_supermercado`.`tbl_vendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_cupom_venda` ON `db_supermercado`.`tbl_cupons_fiscais` (`fk_venda` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_vendas` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `valor_total` DECIMAL(6,2) NOT NULL,
  `fk_cliente` INT NULL,
  `fk_colaborador` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`fk_cliente`)
    REFERENCES `db_supermercado`.`tbl_clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_colaborador`
    FOREIGN KEY (`fk_colaborador`)
    REFERENCES `db_supermercado`.`tbl_colaborador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_cliente` ON `db_supermercado`.`tbl_vendas` (`fk_cliente` ASC) VISIBLE;
SHOW WARNINGS;
CREATE INDEX `idx_fk_colaborador` ON `db_supermercado`.`tbl_vendas` (`fk_colaborador` ASC) VISIBLE;
SHOW WARNINGS;

ALTER TABLE tbl_pagamentos CHANGE valor_pago valor_pago DECIMAL(10,2) NOT NULL;
DROP TABLE IF EXISTS `db_supermercado`.`tbl_pagamentos` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_pagamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor_pago` DECIMAL(10,2) NOT NULL,
  `fk_forma_pagamento` INT NOT NULL,
  `fk_venda` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_forma_pagamento`
    FOREIGN KEY (`fk_forma_pagamento`)
    REFERENCES `db_supermercado`.`tbl_forma_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda`
    FOREIGN KEY (`fk_venda`)
    REFERENCES `db_supermercado`.`tbl_vendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_forma_pagamento` ON `db_supermercado`.`tbl_pagamentos` (`fk_forma_pagamento` ASC) VISIBLE;
SHOW WARNINGS;
CREATE INDEX `idx_fk_venda` ON `db_supermercado`.`tbl_pagamentos` (`fk_venda` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_fornecedores` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_fornecedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL UNIQUE,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE UNIQUE INDEX `idx_unique_cnpj` ON `db_supermercado`.`tbl_fornecedores` (`cnpj` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_produtos` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(150) NULL,
  `categoria` VARCHAR(50) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `estoque` INT NOT NULL,
  `validade` DATE NOT NULL,
  `fk_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_fornecedor`
    FOREIGN KEY (`fk_fornecedor`)
    REFERENCES `db_supermercado`.`tbl_fornecedores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_fornecedor` ON `db_supermercado`.`tbl_produtos` (`fk_fornecedor` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_promocoes` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_promocoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(300) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `tipo` ENUM("Desconto Percentual", "Desconto Fixo", "Compre e Ganhe", "Frete Grátis", "Cashback", "Brinde", "Programa de Fidelidade") NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
SHOW WARNINGS;
DELIMITER $$
CREATE TRIGGER before_insert_promocoes
BEFORE INSERT ON tbl_promocoes
FOR EACH ROW
BEGIN
    IF NEW.tipo NOT IN ('Desconto Percentual', 'Desconto Fixo', 'Compre e Ganhe', 'Frete Grátis', 'Cashback', 'Brinde', 'Programa de Fidelidade') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor inválido para ENUM tipo de promoção. Insira "Desconto Percentual", "Desconto Fixo", "Compre e Ganhe", "Frete Grátis", "Cashback", "Brinde" ou "Programa de Fidelidade"';
    END IF;
END$$
DELIMITER ;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_produtos_venda` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_produtos_venda` (
  `id_venda` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(6,2) NOT NULL,
  `subtotal` DECIMAL(6,2) NOT NULL,
  `fk_promocao` INT NULL,
  PRIMARY KEY (`id_venda`, `id_produto`),
  CONSTRAINT `fk_produto`
    FOREIGN KEY (`id_produto`)
    REFERENCES `db_supermercado`.`tbl_produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_produtos`
    FOREIGN KEY (`id_venda`)
    REFERENCES `db_supermercado`.`tbl_vendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_promocao`
    FOREIGN KEY (`fk_promocao`)
    REFERENCES `db_supermercado`.`tbl_promocoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_venda` ON `db_supermercado`.`tbl_produtos_venda` (`id_venda` ASC) VISIBLE;
SHOW WARNINGS;
CREATE INDEX `idx_fk_produto` ON `db_supermercado`.`tbl_produtos_venda` (`id_produto` ASC) VISIBLE;
SHOW WARNINGS;
CREATE INDEX `idx_fk_promocao` ON `db_supermercado`.`tbl_produtos_venda` (`fk_promocao` ASC) VISIBLE;
SHOW WARNINGS;


DROP TABLE IF EXISTS `db_supermercado`.`tbl_promocoes_produtos` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_supermercado`.`tbl_promocoes_produtos` (
  `id_promocao` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id_promocao`, `id_produto`),
  CONSTRAINT `fk_promocao_produto`
    FOREIGN KEY (`id_promocao`)
    REFERENCES `db_supermercado`.`tbl_promocoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_promocao`
    FOREIGN KEY (`id_produto`)
    REFERENCES `db_supermercado`.`tbl_produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SHOW WARNINGS;
CREATE INDEX `idx_fk_promocao` ON `db_supermercado`.`tbl_promocoes_produtos` (`id_promocao` ASC) VISIBLE;
SHOW WARNINGS;
CREATE INDEX `idx_fk_produto` ON `db_supermercado`.`tbl_promocoes_produtos` (`id_produto` ASC) VISIBLE;
SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;