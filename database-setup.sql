-- Asset Management System Database Setup
-- Run these commands in your MySQL client

-- Create database and user
CREATE DATABASE asset_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Optionally create a dedicated DB user (adjust password)
CREATE USER 'assetuser'@'localhost' IDENTIFIED BY 'assetpass';
GRANT ALL PRIVILEGES ON asset_db.* TO 'assetuser'@'localhost';
FLUSH PRIVILEGES;

-- Switch to database
USE asset_db;

-- Users table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin','manager','user') NOT NULL DEFAULT 'user',
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Assets table
CREATE TABLE assets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  assetId VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(100),
  purchaseDate DATE,
  location VARCHAR(255),
  value DECIMAL(12,2),
  status ENUM('available','assigned','retired','maintenance') DEFAULT 'available',
  ownerId INT NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (ownerId) REFERENCES users(id) ON DELETE SET NULL
);

-- Transactions table
CREATE TABLE transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  assetId INT NOT NULL,
  userId INT NULL,
  type ENUM('assign','transfer','checkout','checkin','retire') NOT NULL,
  notes TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (assetId) REFERENCES assets(id) ON DELETE CASCADE,
  FOREIGN KEY (userId) REFERENCES users(id) ON DELETE SET NULL
);

-- Note: Sample data will be inserted via the Node.js seed script
-- Run: npm run seed (after setting up the backend)
