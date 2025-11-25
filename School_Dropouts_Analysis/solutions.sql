-- solutions.sql
-- Combined, polished PL/SQL blocks for the School Dropouts assignment.
SET SERVEROUTPUT ON SIZE 1000000;

PROMPT Running PL/SQL solution blocks for School Dropouts in Rwanda.

-- 1) Associative array: dropout counts per district
DECLARE
  TYPE district_counts IS TABLE OF NUMBER INDEX BY VARCHAR2(10);
  counts district_counts;
BEGIN
  FOR r IN (SELECT district FROM dropout_records) LOOP
    IF counts.EXISTS(r.district) THEN
      counts(r.district) := counts(r.district) + 1;
    ELSE
      counts(r.district) := 1;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('--- Dropout counts by district ---');
  -- iterate using FIRST/NEXT for associative arrays
  DECLARE
    k VARCHAR2(10);
  BEGIN
    k := counts.FIRST;
    WHILE k IS NOT NULL LOOP
      DBMS_OUTPUT.PUT_LINE(k || ': ' || counts(k));
      k := counts.NEXT(k);
    END LOOP;
  END;
END;
/

-- 2) VARRAY: last 5 attendance percentages for a student (example)
DECLARE
  TYPE attendance_varray IS VARRAY(5) OF NUMBER;
  att attendance_varray := attendance_varray(92, 88, 75, 80, 60);
  total NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- VARRAY: last 5 attendance percentages ---');
  FOR i IN 1..att.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Term '||i||': '||att(i)||'%');
    total := total + att(i);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Average: ' || ROUND(total/att.COUNT,2) || '%');
END;
/

-- 3) Nested table: interventions (sparse) demo
DECLARE
  TYPE interv_tab IS TABLE OF VARCHAR2(200);
  interventions interv_tab := interv_tab('Counselling', 'Cash support', 'Catch-up lessons');
BEGIN
  interventions.DELETE(2); -- create sparsity
  DBMS_OUTPUT.PUT_LINE('--- Nested table of interventions (sparse demo) ---');
  FOR i IN 1..interventions.LAST LOOP
    IF interventions.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE('Intervention '||i||': '||interventions(i));
    ELSE
      DBMS_OUTPUT.PUT_LINE('Intervention '||i||': <deleted>');
    END IF;
  END LOOP;
END;
/

-- 4) Cursor-based record using %ROWTYPE
DECLARE
  CURSOR c_drop IS SELECT * FROM dropout_records;
  rec dropout_records%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Cursor-based record output ---');
  OPEN c_drop;
  LOOP
    FETCH c_drop INTO rec;
    EXIT WHEN c_drop%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID:'||rec.student_id||' Name:'||rec.student_name||' Age:'||rec.age||' District:'||rec.district||' Reason:'||rec.dropout_reason);
  END LOOP;
  CLOSE c_drop;
END;
/

-- 5) User-defined record with embedded VARRAY (attendance)
DECLARE
  TYPE att3_varray IS VARRAY(3) OF NUMBER;
  TYPE StudentRec IS RECORD(
    sid NUMBER,
    name VARCHAR2(200),
    district VARCHAR2(10),
    last3 att3_varray
  );
  s StudentRec;
BEGIN
  s.sid := 2;
  s.name := 'Aimee Mukakarisa';
  s.district := 'SOU';
  s.last3 := att3_varray(88, 85, 82);
  DBMS_OUTPUT.PUT_LINE('--- Record with embedded VARRAY ---');
  DBMS_OUTPUT.PUT_LINE('Student: '||s.name||' District:'||s.district);
  FOR i IN 1..s.last3.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Att'||i||': '||s.last3(i)||'%');
  END LOOP;
END;
/

-- 6) Nested table of records: load multiple dropouts
DECLARE
  TYPE DropRec IS RECORD(
    id NUMBER,
    name VARCHAR2(200),
    age NUMBER,
    district VARCHAR2(10),
    reason VARCHAR2(400)
  );
  TYPE DropTable IS TABLE OF DropRec;
  drops DropTable := DropTable();
BEGIN
  FOR r IN (SELECT student_id, student_name, age, district, dropout_reason FROM dropout_records ORDER BY student_id) LOOP
    drops.EXTEND;
    drops(drops.COUNT).id := r.student_id;
    drops(drops.COUNT).name := r.student_name;
    drops(drops.COUNT).age := r.age;
    drops(drops.COUNT).district := r.district;
    drops(drops.COUNT).reason := r.dropout_reason;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('--- In-memory nested table of records ---');
  FOR i IN 1..drops.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Rec '||i||': ID='||drops(i).id||' Name='||drops(i).name||' Age='||drops(i).age||' District='||drops(i).district);
  END LOOP;
END;
/

-- 7) GOTO: validation demo (age out-of-bounds)
DECLARE
  v_ages SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15,13,17,14,-2); -- invalid age included
  i PLS_INTEGER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- GOTO validation demo ---');
  FOR i IN 1..v_ages.COUNT LOOP
    IF v_ages(i) < 6 OR v_ages(i) > 25 THEN
      DBMS_OUTPUT.PUT_LINE('Invalid age at index '||i||': '||v_ages(i));
      GOTO age_error;
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('All ages valid.');
  GOTO finish;

<<age_error>>
  DBMS_OUTPUT.PUT_LINE('ERROR: Age value out of realistic bounds. Please review data.');

<<finish>>
  DBMS_OUTPUT.PUT_LINE('--- End of solutions.sql run ---');
END;
/
