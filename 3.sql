CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


-- Queries

-- Seleciona a tabela inteira de empregados
SELECT * FROM employee;
-- Seleciona o primeiro e segundo nome dos empregados femininos e com branch_id = 3 ordenados pelo salario 
SELECT first_name, last_name FROM employee WHERE sex = 'M' AND branch_id = 3 ORDER BY salary;
-- COUNT retorna a quantidade
SELECT COUNT(emp_id) FROM employee WHERE sex = 'F' AND birth_date > '1971-01-01';
-- AVG eh a média dos salarios
SELECT AVG(salary) FROM employee;
-- SUM soma
-- Group by mostra o resultado da funcao pra cada grupo
SELECT COUNT(sex)  FROM employee GROUP BY sex;
-- Mostra o total de vendas para cada vendedor
SELECT COUNT(total_sales), emp_id FROM works_with GROUP BY emp_id;


-- Wilcards procura padroes
-- Procura na tabela branch_supplier pelas instancias cujo nome terminam com "Mill"
SELECT * FROM branch_supplier WHERE supplier_name LIKE '%Mill';
-- % -> Qualquer ccoisa
-- # -> Caracteres
-- _ -> Um caractere
-- A query abaix seleciona todos os empregados nascidos em outubro
SELECT * FROM employee WHERE birth_date LIKE '____-02%';

-- Union faz a uniao de colunas, é simples

-- Join liga uma tabela a outra tabela através de uma chave estrangeira
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee 
JOIN branch
ON employee.emp_id = branch.mgr_id;
-- Esse join cria uma tabela com as duas tabelas. Nessa nova tabela, elas compartilham uma mesma coluna ( aquela que era chave estrangeira em uma )


-- Nested Queries

-- Retorna busca dentro de outra querie. Usa uma querie pra fazer outra
-- Ex a queri
SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales > 30000;
-- Retorna a lista id dos empregados que venderam mais que 30k
-- A queri abaixo aproveita ela e faz outra busca em cima dela 
SELECT employee.first_name, employee.last_name 
FROM employee 
WHERE employee.emp_id IN (
    SELECT works_with.emp_id 
    FROM works_with 
    WHERE works_with.total_sales > 30000
);


-- ON DELETE CASCATE deleta a linha quando o que ta conectado a ela eh deletado
-- On DELETE SET NULL bota null quando uma chave estrangeira referencia algo que foi deletado 






































