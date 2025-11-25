# School Dropouts in Rwanda — PL/SQL Assignment
**PL/SQL Collections, Records, and GOTO Statements**

Student Name: Uwineza Delphine
Student ID: 27897

## Title
Monitoring and Analyzing School Dropouts in Rwanda

## Background
Rwanda's Ministry of Education collects reports on students who drop out of school. Each dropout record includes student demographics, last attended grade, district, reasons for dropping out, attendance trend, and follow-up actions by local education officers.

## Objective
Create PL/SQL code that demonstrates understanding and correct use of **Collections** (Associative arrays, Nested tables, VARRAYs), **Records** (%ROWTYPE and user-defined), and **GOTO** statements in controlled validation flows. The domain is school dropouts in Rwanda.

##  Solution Architecture
Data structures used and purpose:
- **VARRAY**: store fixed number of recent attendance percentages for a student.
- **Nested Table**: store dynamic lists like interventions or remarks (supports sparsity).
- **Associative Array**: compute and store dropout counts per district (keyed by district code).
- **User-Defined RECORD**: represent a dropout profile including embedded collections.
- **Nested Table of RECORDS**: batch in-memory processing of multiple dropouts.
- **GOTO**: controlled flow for validation (example only).


## Assumptions
- Attendance percentages are on a 0–100 scale.
- Age is positive and realistically between 6 and 25 for dropouts in primary/secondary.
- Districts are identified by codes like 'KIG' (Kigali), 'SOU' (Southern), etc.

##  Files in this repository
- `createTables.sql` — creates table `dropout_records`.
- `insertData.sql` — sample data insertion.
- `verifyData.sql` — verification queries.

## Screenshots


### Created tables

<img width="826" height="360" alt="image" src="https://github.com/user-attachments/assets/6aad842d-a57c-479f-801b-a131e6d40110" />

### inserted data in the table

<img width="1528" height="848" alt="image" src="https://github.com/user-attachments/assets/4e46fc3a-8d28-4ce9-bcd3-e71ff2b14e4e" />


### verified the table data
![verified table data ](screenshots/verifydata.png)

### dropped per district 

<img width="565" height="451" alt="image" src="https://github.com/user-attachments/assets/255a70ee-b66c-43cc-9274-96bc930fd929" />


### attendance of student

<img width="545" height="301" alt="image" src="https://github.com/user-attachments/assets/c088f9c4-aad0-4d09-a677-c48d4889fdb7" />


### intervention of teachers

<img width="900" height="477" alt="image" src="https://github.com/user-attachments/assets/20db7127-e06d-4c3e-b3e7-9b901404ea20" />


### nested and GOTO example

<img width="892" height="591" alt="image" src="https://github.com/user-attachments/assets/9c796609-371a-4012-92b3-be8814b76ee8" />


## Conclusion

This project demonstrates the effective use of PL/SQL collections, records, and controlled flow to manage and analyze school dropout data in Rwanda. By leveraging VARRAYs, Nested Tables, Associative Arrays, and user-defined RECORDs, we can efficiently store, process, and retrieve detailed student information. The repository provides a structured approach to data insertion, verification, and analysis, supporting insights into dropout trends and enabling better-informed educational interventions.
