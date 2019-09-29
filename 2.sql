CREATE TABLE employee (
    emp_id INT PRIMARY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT, -- FK
    branch_id INT -- FK
    -- FOREIGN KEY (super_id) REFERENCES
    -- FOREIGN KEY (branch_id) REFERENCES
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_start_date DATE,
    mgr_id INT -- FK
    FOREIGN KEY (mgr_id) REFERENCES employee (emp_id) ON DELETE SET NULL
);

CREATE TABLE client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(20),
    branch_id INT -- FK
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
    
);

CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id)
    
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(20),
    supply_type VARCHAR(20),
    PRIMARY KEY (branch_id, supplier_name)
);




DESCRIBE employee;








