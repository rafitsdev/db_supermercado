# 🛒 db_supermercado

Este repositório contém os scripts SQL necessários para a criação e população de um banco de dados para um sistema de gerenciamento de supermercado, desenvolvido para um projeto acadêmico.

## 📌 Estrutura do Repositório

- `structuring_db_supermercado.sql` → Criação das tabelas do banco de dados.
- `populating_db_supermercado.sql` → Inserção de dados fictícios nas tabelas.

---

## 🚀 Como Utilizar os Scripts

### 🔹 1. Configuração do Banco de Dados
Antes de executar os scripts, certifique-se de ter um **SGBD compatível** instalado, como MySQL ou MariaDB.

1. Abra seu terminal ou client SQL (como MySQL Workbench, DBeaver ou phpMyAdmin).
2. **Não é necessário criar o banco manualmente**, pois ele já será criado pelo script de estruturação.
3. Apenas execute o seguinte comando para rodar o script que cria o banco e suas tabelas:
   ```sh
   mysql -u seu_usuario -p < structuring_db_supermercado.sql
   ```
4. Caso queira garantir que o banco foi criado corretamente, utilize:
   ```sql
   SHOW DATABASES;
   USE db_supermercado;
   SHOW TABLES;
   ```

---

### 🔹 2. Populando o Banco de Dados
Após a estruturação, preencha o banco com dados fictícios:
   ```sh
   mysql -u seu_usuario -p db_supermercado < populating_db_supermercado.sql
   ```


---

## 🛠 Tecnologias Utilizadas
- **DRAW.IO** - Modelagem Conceitual de Banco de Dados
- **MySQL** – Sistema de Gerenciamento de Banco de Dados
- **SQL** – Linguagem para manipulação de dados
- **GitHub** – Controle de versão e compartilhamento

---

## 📌 Contribuições
Se desejar sugerir melhorias ou reportar problemas, fique à vontade para abrir uma _issue_ ou enviar um _pull request_.

---

## 📜 Licença
Este projeto está sob a licença MIT.

---

📬 **Contato:**
📧 Email: [rafaelrodrigues.contatoo@gmail.com](mailto:rafaelrodrigues.contatoo@gmail.com)

🔗 LinkedIn: [Rafael Martins Rodrigues](https://www.linkedin.com/in/rafaelmartinsrodrigues/)
