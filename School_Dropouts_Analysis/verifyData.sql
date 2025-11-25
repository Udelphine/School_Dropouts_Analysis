

SET SERVEROUTPUT ON SIZE 1000000;

PROMPT All records:
SELECT student_id, student_name, age, district, dropout_reason FROM dropout_records;

PROMPT Count per district:
SELECT district, COUNT(*) AS cnt FROM dropout_records GROUP BY district ORDER BY district;

PROMPT Average estimated loss:
SELECT ROUND(AVG(est_annual_loss),2) avg_loss FROM dropout_records;
