# Online Bookstore Analysis SQL Case Study

## Overview

This project presents a structured SQL analysis of an online bookstore database built in PostgreSQL. The objective is to simulate how a company operating in the e-commerce domain uses transactional data to monitor performance, evaluate customer behavior, track inventory levels, and support strategic decision-making. The analysis emphasizes practical query design, analytical reasoning, and business-focused reporting rather than isolated SQL exercises.

---

## Project Structure

```
├── Online_Bookstore_Analysis/
│   ├── Dataset/                         # CSV data files
│   ├── Online_Bookstore_Analysis.sql    # SQL analysis file
│   ├── Project_Report.pdf               # Final analytical report
│
├── README.md                            # Project documentation
```

---

## Business Context

The bookstore operates through an online sales model where customers purchase books across multiple genres and authors. Management aims to leverage transactional data to better understand:

* Revenue generation patterns
* High-value and repeat customers
* Best-performing books and authors
* Genre-level sales distribution
* Inventory position after order fulfillment

This case study addresses these objectives using structured SQL analysis.

---

## Database Model

The system is built on a normalized relational structure consisting of three core tables:

* **books** – Book metadata including genre, pricing, publication year, and stock levels.
* **customers** – Customer demographic and contact information.
* **orders** – Transaction records capturing purchased books, quantities, dates, and monetary value.

Relationships are defined using primary and foreign keys to ensure referential integrity and enable analytical joins.

---

## Analytical Approach

The analysis is divided into progressive stages:

1. **Foundational Queries** – Filtering, sorting, and basic aggregations.
2. **Business Metrics** – Revenue calculations, customer spending analysis, and sales volume evaluation.
3. **Ranking & Insights** – Identification of top customers, most ordered books, and genre performance using window functions.
4. **Inventory Evaluation** – Dynamic stock calculations after fulfilling recorded orders.

Advanced SQL constructs such as GROUP BY, HAVING, CTEs, window functions (ROW_NUMBER, RANK, DENSE_RANK), and deterministic ordering are applied to simulate real-world reporting scenarios.

---

## Key Observations

* Revenue distribution indicates concentration among a subset of repeat customers.
* Certain genres and authors consistently outperform others in sales volume.
* High-demand books require close inventory monitoring to prevent stockouts.
* Deterministic ranking techniques improve reporting stability in tie scenarios.

These findings illustrate how structured SQL analysis can translate transactional data into meaningful operational insights.

---

## Tools & Technologies

* **Database:** PostgreSQL
* **Language:** SQL
* **Concepts Applied:** Relational modeling, joins, aggregation, ranking functions, CTEs, and analytical query design

---

**Created By:** Divyadarshan Pattanayak\
**Date:** January 2026
