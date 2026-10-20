-- Experiment 05: Database-Driven GUI Application (Swing + JDBC Integration)
-- Author: Pankaj Sharma

CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

-- Table for persisted student registrations from the Swing GUI Form
CREATE TABLE IF NOT EXISTS streg (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
