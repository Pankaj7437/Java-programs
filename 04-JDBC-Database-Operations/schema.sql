-- Experiment 04: Database Connectivity & SQL Operations (JDBC)
-- Author: Pankaj Sharma

-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

-- Drop table if re-running
DROP TABLE IF EXISTS student;

-- Create Student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL
);

-- Seed initial records (optional)
INSERT INTO student (id, name, branch) VALUES
(101, 'Pankaj Sharma', 'Computer Science & Engineering'),
(102, 'Rohan Verma', 'Information Technology'),
(103, 'Aarav Patel', 'Electronics & Communication');
