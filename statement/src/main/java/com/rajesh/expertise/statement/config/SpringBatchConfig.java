package com.rajesh.expertise.statement.config;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.database.JpaPagingItemReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.batch.item.data.RepositoryItemWriter;
import org.springframework.batch.item.database.JpaItemWriter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

import com.rajesh.expertise.statement.entity.Statement;
import com.rajesh.expertise.statement.entity.Transaction;
import com.rajesh.expertise.statement.repository.StatementRepository;

import jakarta.persistence.EntityManagerFactory;

@Configuration
@EnableBatchProcessing
public class SpringBatchConfig {

	private JobBuilder jobBuilder;
	private StepBuilder stepBuilder;
	
//	@Autowired
	private StatementRepository statementRepository;
	
	
	 @Bean
	 @StepScope
	 public JpaPagingItemReader<Transaction> jpaPagingItemReader() {
	       
		 return JpaPagingItemReaderBuilder<Transaction>()
				 .name("transactinReader")
				 .entityManagerFactory(entityManagerFactory())
				 .queryString("SELECT t FROM Transaction t")
				 .pageSize(100)
    			 .build();
		 
//		 	JpaPagingItemReader<Transaction> reader = new JpaPagingItemReader<>();
//	        
//	        reader.setEntityManagerFactory(entityManagerFactory);
//	        reader.setQueryString("SELECT t FROM Transaction t");
//	        reader.setPageSize(100); // Fetch 100 records per page
//	        return reader;
	    }
	 
	 @Bean
	 public StatementProcessor processor() {
		 return new StatementProcessor();
	 }
	
	 public  RepositoryItemWriter<Statement> writer(StatementRepository statementRepository)
	 {
		 RepositoryItemWriter<Statement> writer = new RepositoryItemWriter<>();
		 writer.setRepository(statementRepository);
		 writer.setMethodName("saveAll");
		 	 
			
		 return writer; 
		 
	 }
	 
	 @Bean
	 public Step step1(JobRepository jobRepository, 
				PlatformTransactionManager transactionManager) {
	        return new StepBuilder("step1", jobRepository)	        		        		
	                .<Transaction, Statement>chunk(10,transactionManager)
	                .reader(jpaPagingItemReader()) // Assuming you have a reader defined
	                .processor(StatementProcessor()) // Assuming you have a processor defined
	                .writer(writer()) // Use the HibernateItemWriter here
	                .build();
	    }
	 
	 public Job FirstJob(JobRepository jobRepository) {
		 return new JobBuilder("FirstJob", jobRepository)
				 .start(step1)
				 .build();
	 }
	 
}
