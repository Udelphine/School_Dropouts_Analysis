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
![inserted table data ](screenshots/insertdata.png)

### verified the table data
![verified table data ](screenshots/verifydata.png)

### dropped per district 
![verified table data ](screenshots/dropperdistrict.png)

### attendance of student
![verified table data ](screenshots/attendance.png)

### intervation of teachers
![verified table data ](screenshots/interventions.png)

### nested and GOTO example
![verified table data ](screenshots/nested%20and%20goto.png)

## Conclusion

This project demonstrates the effective use of PL/SQL collections, records, and controlled flow to manage and analyze school dropout data in Rwanda. By leveraging VARRAYs, Nested Tables, Associative Arrays, and user-defined RECORDs, we can efficiently store, process, and retrieve detailed student information. The repository provides a structured approach to data insertion, verification, and analysis, supporting insights into dropout trends and enabling better-informed educational interventions.
