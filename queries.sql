select * from transaction
 transaction;


SELECT column_name, data_type, character_maximum_length FROM information_schema.columns WHERE table_name = 'transaction';

INSERT INTO Customer (first_name, last_name, email, phone_number, address, date_of_birth)
VALUES 
('John', 'Doe', 'johndoe@example.com', '123-456-7890', '123 Maple St, Springfield, IL', '1985-07-15'),
('Jane', 'Smith', 'janesmith@example.com', '098-765-4321', '456 Oak St, Springfield, IL', '1990-02-20'),
('Michael', 'Johnson', 'michaelj@example.com', '321-654-9870', '789 Pine St, Springfield, IL', '1978-10-05');

INSERT INTO Account (customer_id, account_number, account_type, balance, currency_code, status)
VALUES 
(1, 'CHK123456789', 'Checking', 1500.75, 'USD', 'ACTIVE'),
(1, 'SAV987654321', 'Savings', 5000.00, 'USD', 'ACTIVE'),
(2, 'CHK112233445', 'Checking', 750.50, 'USD', 'ACTIVE'),
(3, 'CRD556677889', 'Credit', 0.00, 'USD', 'ACTIVE');

INSERT INTO Transaction (account_id, transaction_type, amount, description, balance_after_transaction)
VALUES 
(1, 'DEPOSIT', 500.00, 'Salary Deposit', 2000.75),
(1, 'WITHDRAWAL', 100.00, 'ATM Withdrawal', 1900.75),
(2, 'DEPOSIT', 200.00, 'Transfer from Checking', 5200.00),
(3, 'PAYMENT', 50.00, 'Credit Card Payment', 700.50);


select * from transaction
select * from statement
commit

INSERT INTO Statement (account_id, statement_date, opening_balance, closing_balance, total_credits, total_debits)
VALUES 
    (1, '2024-01-31', 1000.00, 1200.00, 300.00, 100.00),
    (2, '2024-01-31', 1500.00, 1800.00, 400.00, 100.00),
    (3, '2024-01-31', 2000.00, 2500.00, 700.00, 200.00),
    (1, '2024-02-29', 1200.00, 900.00, 100.00, 400.00),
    (2, '2024-02-29', 1800.00, 1600.00, 200.00, 400.00),
    (3, '2024-02-29', 2500.00, 2700.00, 300.00, 100.00);


drop table batch_job_instance;
drop table batch_job_execution;
commit;
CREATE TABLE batch_job_instance (
    instance_id SERIAL PRIMARY KEY,
    version INTEGER NOT NULL,
    job_name VARCHAR(100) NOT NULL,
    job_key VARCHAR(32) NOT NULL,
    UNIQUE (job_name, job_key)
);

CREATE TABLE batch_job_execution (
    execution_id SERIAL PRIMARY KEY,
    version INTEGER NOT NULL,
    job_instance_id INTEGER NOT NULL,
    create_time TIMESTAMP NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    status VARCHAR(10) NOT NULL,
    exit_code VARCHAR(2500) NOT NULL,
    exit_message VARCHAR(2500),
    last_updated TIMESTAMP NOT NULL,
       FOREIGN KEY (job_instance_id) REFERENCES batch_job_instance(instance_id)
);

CREATE TABLE batch_step_execution (
    id SERIAL PRIMARY KEY,
    version INTEGER NOT NULL,
    step_name VARCHAR(100) NOT NULL,
    job_execution_id INTEGER NOT NULL,
    version INTEGER NOT NULL,
    read_count INTEGER NOT NULL,
    filter_count INTEGER NOT NULL,
    write_count INTEGER NOT NULL,
    read_skip_count INTEGER NOT NULL,
    write_skip_count INTEGER NOT NULL,
    process_skip_count INTEGER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status VARCHAR(10) NOT NULL,
    commit_count INTEGER NOT NULL,
    exit_code VARCHAR(2500) NOT NULL,
    exit_message VARCHAR(2500),
    last_updated TIMESTAMP NOT NULL,
    FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(execution_id)
);

CREATE TABLE batch_job_execution_params (
    id SERIAL PRIMARY KEY,
    job_execution_id INTEGER NOT NULL,
    type VARCHAR(10) NOT NULL,
    key_name VARCHAR(2500) NOT NULL,
    string_val VARCHAR(2500),
    date_val TIMESTAMP,
    long_val BIGINT,
    double_val DOUBLE PRECISION,
    FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(execution_id)
);

CREATE TABLE batch_job_execution_context (
    job_execution_id INTEGER PRIMARY KEY,
    context BYTEA NOT NULL,
    FOREIGN KEY (job_execution_id) REFERENCES batch_job_execution(execution_id)
);

CREATE TABLE batch_step_execution_context (
    step_execution_id INTEGER PRIMARY KEY,
    context BYTEA NOT NULL,
    FOREIGN KEY (step_execution_id) REFERENCES batch_step_execution(id)
);
