SQL Case Study – Retail Data Analysis (Basic)
📌 Project Overview

This project is a SQL Case Study based on a retail store’s Point of Sale (POS) data.
The goal is to understand customer purchasing behavior, transactions, and product category performance using SQL queries.

The dataset contains 3 relational tables:

Customer → Customer demographic details

Transactions → Purchase and return transaction records

Product Category → Product category & sub-category mapping

🗂 Dataset Structure
1. Customer Table

Includes customer details like:

Customer ID

Date of Birth

Gender

City Code

2. Transactions Table

Stores transaction-level information:

Transaction ID

Customer ID

Transaction Date

Quantity (negative = return)

Total Amount

Store Type

3. Product Category Table

Contains product category hierarchy:

Category

Sub-Category

Product Code

🎯 Business Objective

A retail company wants to analyze POS data to answer key business questions such as:

✅ Customer demographics
✅ Most used transaction channels
✅ Product performance
✅ Revenue generation
✅ Returns analysis

✅ Case Study Questions Covered
Data Preparation & Understanding

Total number of rows in each table

Number of return transactions

Date format conversion

Transaction data time range (days/months/years)

Category of sub-category "DIY"

Data Analysis

Most frequently used channel for transactions

Count of male and female customers

City with maximum customers

Number of sub-categories under Books

Maximum quantity ordered

Net revenue in Electronics and Books

Customers with >10 transactions excluding returns

Revenue from Electronics & Clothing in Flagship stores

Revenue from Male customers in Electronics by sub-category

Top 5 sub-categories by sales with return %

Revenue from customers aged 25–35 in last 30 days

🛠 Tools & Technologies Used

SQL Server / MySQL

SQL Joins, Aggregations

GROUP BY, HAVING

Date Functions

Subqueries & Filters
