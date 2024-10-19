package com.rajesh.expertise.statement.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.rajesh.expertise.statement.entity.Statement;
import com.rajesh.expertise.statement.entity.Transaction;



	
	public interface TransactionRepository extends JpaRepository<Transaction,Long> {

	}


