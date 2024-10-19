CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,          -- Unique customer identifier
    first_name VARCHAR(50) NOT NULL,         -- Customer first name
    last_name VARCHAR(50) NOT NULL,          -- Customer last name
    email VARCHAR(100) UNIQUE NOT NULL,      -- Customer email (for login)
    phone_number VARCHAR(15),                -- Customer phone number
    address VARCHAR(255),                    -- Customer address
    date_of_birth DATE,                      -- Customer date of birth
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Record creation time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE Account (
    account_id SERIAL PRIMARY KEY,           -- Unique account identifier
    customer_id INT REFERENCES Customer(customer_id) ON DELETE CASCADE,  -- Linked to customer
    account_number VARCHAR(20) UNIQUE NOT NULL,  -- Unique account number
    account_type VARCHAR(20) NOT NULL,       -- Type of account ('Checking', 'Savings', 'Credit', 'Loan')
    balance DECIMAL(15, 2) DEFAULT 0.00,     -- Account balance
    currency_code VARCHAR(3) DEFAULT 'USD',  -- Currency code (USD, EUR, etc.)
    status VARCHAR(20) DEFAULT 'ACTIVE',     -- Account status ('ACTIVE', 'INACTIVE', 'CLOSED')
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Record creation time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE Transaction (
    transaction_id SERIAL PRIMARY KEY,        -- Unique transaction identifier
    account_id INT REFERENCES Account(account_id) ON DELETE CASCADE,  -- Linked to account
    transaction_type VARCHAR(20) NOT NULL,    -- Type of transaction ('DEPOSIT', 'WITHDRAWAL', 'PAYMENT')
    amount DECIMAL(15, 2) NOT NULL,           -- Transaction amount
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Transaction date and time
    description VARCHAR(255),                 -- Optional description (e.g., "ATM Withdrawal")
    transaction_status VARCHAR(20) DEFAULT 'SUCCESS',  -- Transaction status ('SUCCESS', 'FAILED', etc.)
    balance_after_transaction DECIMAL(15, 2), -- Account balance after this transaction
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Card (
    card_id SERIAL PRIMARY KEY,               -- Unique card identifier
    account_id INT REFERENCES Account(account_id) ON DELETE CASCADE, -- Linked to account
    card_number VARCHAR(16) UNIQUE NOT NULL,  -- Card number (hashed in production for security)
    card_type VARCHAR(20) NOT NULL,           -- Type ('CREDIT', 'DEBIT')
    expiration_date DATE NOT NULL,            -- Expiration date of the card
    cvv VARCHAR(4) NOT NULL,                  -- Card CVV (should be hashed in production)
    card_status VARCHAR(20) DEFAULT 'ACTIVE', -- Card status ('ACTIVE', 'BLOCKED', 'EXPIRED')
    issued_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date card was issued
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE Loan (
    loan_id SERIAL PRIMARY KEY,               -- Unique loan identifier
    account_id INT REFERENCES Account(account_id) ON DELETE CASCADE, -- Linked to account
    loan_type VARCHAR(20) NOT NULL,           -- Type of loan ('PERSONAL', 'AUTO', 'HOME')
    loan_amount DECIMAL(15, 2) NOT NULL,      -- Loan amount
    interest_rate DECIMAL(5, 2) NOT NULL,     -- Interest rate for the loan
    loan_term INT NOT NULL,                   -- Loan term in months
    loan_start_date DATE NOT NULL,            -- Date when loan starts
    loan_end_date DATE,                       -- Date when loan is expected to end
    outstanding_balance DECIMAL(15, 2),       -- Current outstanding balance on the loan
    loan_status VARCHAR(20) DEFAULT 'ACTIVE', -- Loan status ('ACTIVE', 'PAID_OFF', 'DEFAULTED')
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,            -- Unique payment identifier
    loan_id INT REFERENCES Loan(loan_id) ON DELETE CASCADE, -- Linked to loan
    amount DECIMAL(15, 2) NOT NULL,           -- Payment amount
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date of the payment
    payment_status VARCHAR(20) DEFAULT 'SUCCESS', -- Payment status ('SUCCESS', 'FAILED')
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
	);

	CREATE TABLE Statement (
    statement_id SERIAL PRIMARY KEY,          -- Unique statement identifier
    account_id INT REFERENCES Account(account_id) ON DELETE CASCADE, -- Linked to account
    statement_date DATE NOT NULL,             -- Date of the statement
    opening_balance DECIMAL(15, 2) NOT NULL,  -- Opening balance at the start of the period
    closing_balance DECIMAL(15, 2) NOT NULL,  -- Closing balance at the end of the period
    total_credits DECIMAL(15, 2),             -- Total credits during the period
    total_debits DECIMAL(15, 2),              -- Total debits during the period
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Time the statement was generated
);

CREATE TABLE AuditLog (
    audit_id SERIAL PRIMARY KEY,              -- Unique audit log identifier
    action_by VARCHAR(100),                   -- User or system triggering the action
    action_type VARCHAR(50),                  -- Type of action (e.g., 'ACCOUNT_CREATION', 'TRANSACTION')
    action_description VARCHAR(255),          -- Detailed description of the action
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Date and time of the action
    related_account INT,                      -- Related account (if applicable)
    related_transaction INT                   -- Related transaction (if applicable)
);

commit