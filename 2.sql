CREATE TABLE employee (
    emp_id INT,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT, -- FK
    branch_id INT, -- FK
    PRIMARY KEY ( emp_id )
    
    -- FOREIGN KEY (super_id) REFERENCES
    -- FOREIGN KEY (branch_id) REFERENCES
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_start_date DATE,
    mgr_id INT, -- FK
    FOREIGN KEY (mgr_id) REFERENCES employee (emp_id) ON DELETE SET NULL
);

CREATE TABLE client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(20),
    branch_id INT, -- FK
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

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);








