package com.rajesh.expertise.statement.config;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.springframework.batch.item.ItemProcessor;

import com.rajesh.expertise.statement.entity.Account;
import com.rajesh.expertise.statement.entity.Statement;
import com.rajesh.expertise.statement.entity.Transaction;

public class StatementProcessor implements ItemProcessor<Transaction, Statement> {
	
	public Statement process(Transaction transaction) throws Exception{
		
		Statement statement= new Statement();
		
//		INSERT INTO Statement (account_id, statement_date, opening_balance, closing_balance, total_credits, total_debits)
//		VALUES 
//		    (1, '2024-01-31', 1000.00, 1200.00, 300.00, 100.00),
//		    (2, '2024-01-31', 1500.00, 1800.00, 400.00, 100.00),
//		
		Account account=new Account();
		account.setAccountId(1L);
		
		System.out.println("create statement object to save to database");
		
		statement.setAccount(account);
		statement.setStatementDate(LocalDate.now());
		statement.setOpeningBalance(BigDecimal.valueOf(1000.00));
		statement.setClosingBalance(BigDecimal.valueOf(1000.00));
		statement.setTotalCredits(BigDecimal.valueOf(1000.00));
		statement.setTotalDebits(BigDecimal.valueOf(1000.00));
		
		
		return statement;
	}

}
