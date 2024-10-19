package com.rajesh.expertise.statement.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "Statement") // The table name in the database
public class Statement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long statementId; // Unique statement identifier

    @ManyToOne
    @JoinColumn(name = "account_id", nullable = false)
    private Account account; // Linked to account

    @Column(name = "statement_date", nullable = false)
    private LocalDate statementDate; // Date of the statement

    @Column(name = "opening_balance", nullable = false, precision = 15, scale = 2)
    private BigDecimal openingBalance; // Opening balance at the start of the period

    @Column(name = "closing_balance", nullable = false, precision = 15, scale = 2)
    private BigDecimal closingBalance; // Closing balance at the end of the period

    @Column(name = "total_credits", precision = 15, scale = 2)
    private BigDecimal totalCredits; // Total credits during the period

    @Column(name = "total_debits", precision = 15, scale = 2)
    private BigDecimal totalDebits; // Total debits during the period

    @Column(name = "generated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime generatedAt; // Time the statement was generated

    // Getters and Setters

    public Long getStatementId() {
        return statementId;
    }

    public void setStatementId(Long statementId) {
        this.statementId = statementId;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public LocalDate getStatementDate() {
        return statementDate;
    }

    public void setStatementDate(LocalDate statementDate) {
        this.statementDate = statementDate;
    }

    public BigDecimal getOpeningBalance() {
        return openingBalance;
    }

    public void setOpeningBalance(BigDecimal openingBalance) {
        this.openingBalance = openingBalance;
    }

    public BigDecimal getClosingBalance() {
        return closingBalance;
    }

    public void setClosingBalance(BigDecimal closingBalance) {
        this.closingBalance = closingBalance;
    }

    public BigDecimal getTotalCredits() {
        return totalCredits;
    }

    public void setTotalCredits(BigDecimal totalCredits) {
        this.totalCredits = totalCredits;
    }

    public BigDecimal getTotalDebits() {
        return totalDebits;
    }

    public void setTotalDebits(BigDecimal totalDebits) {
        this.totalDebits = totalDebits;
    }

    public LocalDateTime getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(LocalDateTime generatedAt) {
        this.generatedAt = generatedAt;
    }
}
