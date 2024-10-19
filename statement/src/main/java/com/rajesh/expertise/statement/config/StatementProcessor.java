package com.rajesh.expertise.statement.config;

import org.springframework.batch.item.ItemProcessor;

import com.rajesh.expertise.statement.entity.Transaction;

public class StatementProcessor implements ItemProcessor<Transaction, Transaction> {
	
	public Transaction process(Transaction transaction) throws Exception{
		
		return transaction;
	}

}
