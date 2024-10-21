package com.rajesh.expertise.statement;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;

@SpringBootApplication
public class StatementApplication {

	public static void main(String[] args) {
		SpringApplication.run(StatementApplication.class, args);
	}
	
	@Component
    public class StartupRunner implements CommandLineRunner {

        @Autowired
        private JobLauncher jobLauncher;

        @Autowired
        private Job job;

        @Override
        public void run(String... args) throws Exception {
            JobParameters jobParameters = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis())
                    .toJobParameters();

            jobLauncher.run(job, jobParameters);
            System.out.println("Batch job executed successfully!");
        }
    }

}
