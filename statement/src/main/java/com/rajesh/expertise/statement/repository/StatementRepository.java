package com.rajesh.expertise.statement.repository;

import com.rajesh.expertise.statement.entity.Statement;
import com.rajesh.expertise.statement.entity.Transaction;

import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;



public interface StatementRepository extends JpaRepository<Statement,Long> {

}
