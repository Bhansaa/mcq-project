--=============================================================-- 
--------------------------Master_Tables-------------------------- 
--=============================================================--

---- 1.

--Catergory_Master Table:

CREATE TABLE Category_master (
    category_id VARCHAR2(10) PRIMARY KEY,
    category_name VARCHAR2(100) NOT NULL,
    created_by VARCHAR2(100),
    created_datetime DATE
);

--TRIGGER

CREATE OR REPLACE TRIGGER category_master_audit_trigger
BEFORE INSERT ON Category_master
FOR EACH ROW
BEGIN
     :NEW.created_by := 'DEVUSER';
     :NEW.created_datetime := SYSDATE;
END;
/


---- 2.

--Question_Master Table:

CREATE TABLE QUESTION_MASTER (
    question_id NUMBER PRIMARY KEY,
    category_id VARCHAR2(10) REFERENCES Category_master(category_id),
    technology VARCHAR2(100)
    question_text VARCHAR2(1000) NOT NULL,
    difficulty_level VARCHAR2(10),
    created_by VARCHAR2(100),
    created_datetime DATE,
    last_update_by VARCHAR2(100),
    last_update_datetime DATE,
    CONSTRAINT chk_difficulty CHECK (difficulty_level IN ('E', 'M', 'H'))
);

--TRIGGER:

CREATE OR REPLACE TRIGGER question_master_audit_trigger
BEFORE INSERT OR UPDATE ON question_master
FOR EACH ROW
BEGIN
    IF INSERTING THEN
	:NEW.created_by := 'DEVUSER';
        :NEW.created_datetime := SYSDATE;
    END IF;
    :NEW.last_update_by := 'DEVUSER';
    :NEW.last_update_datetime := SYSDATE;
END;
/

--SEQUEBCE:

CREATE SEQUENCE question_sequence
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


---- 3.

--ANSWER_MASTER TABLE:

CREATE TABLE ANSWER_MASTER (
    answer_id NUMBER,
    question_id NUMBER REFERENCES question_master(question_id),
    answer_text VARCHAR2(500) NOT NULL,
    is_correct_answer VARCHAR2(10) NOT NULL,
    created_by VARCHAR2(100),
    created_datetime DATE,
    last_update_by VARCHAR2(100),
    last_update_datetime DATE,
    PRIMARY KEY (question_id, answer_id)
);

--TRIGGERS:

CREATE OR REPLACE TRIGGER answer_master_audit_trigger
BEFORE INSERT OR UPDATE ON answer_master
FOR EACH ROW
BEGIN
    IF INSERTING THEN
	:NEW.created_by := 'DEVUSER';
        :NEW.created_datetime := SYSDATE;
    END IF;
    :NEW.last_update_by := 'DEVUSER';
    :NEW.last_update_datetime := SYSDATE;
END;
/


--------------------------------------------------------------------------
-----------INSERT SCRIPT OF DIFFICULTY LEVEL IN CATEGORY_MASTER-----------
--------------------------------------------------------------------------

Insert into category_master values
('E', 'EASY', 'DEVUSER', SYSDATE);
Insert into category_master values
('M', 'MEDIUM', 'DEVUSER', SYSDATE);
Insert into category_master values
('H', 'HARD', 'DEVUSER', SYSDATE);
Insert into category_master values
('T', 'TECHNICAL', 'DEVUSER', SYSDATE);
Insert into category_master values
('F', 'FUNCTIONAL', 'DEVUSER', SYSDATE);


--------------------------------------------------------------------------
---------------------INSERT SCRIPT OF QUESTION MASTER---------------------
--------------------------------------------------------------------------

Declare
    v_question_id question_master.question_id%type;
    v_category_id question_master.category_id%type := :category_id;
    v_technology question_master.technology%type := :technology;
    v_question_txt question_master.question_text%type := :question_text;
    v_difficulty_level question_master.difficulty_level%type := :difficulty_level;
begin
    Select question_sequence.nextval into v_question_id from dual;
    
    Insert into question_master (question_id, category_id, technology, question_text, difficulty_level)
        values (v_question_id, v_category_id, v_technology, v_question_txt, v_difficulty_level);
        
    DBMS_output.put_line('Question no. : ' || v_question_id || '  added succesfully.');

    commit;

end;
/


--------------------------------------------------------------------------
----------------------INSERT SCRIPT OF ANSWER MASTER----------------------
--------------------------------------------------------------------------

declare
    v_question_id answer_master.question_id%type := :question_id;
    v_answer_id answer_master.answer_id%type;
    v_answer_txt answer_master.answer_text%type := :answer_text;
    v_is_correct_answer answer_master.is_correct_answer%type := :is_correct_answer;
    
    Cursor cur_max_ans_id is
    Select max(answer_id) from answer_master where question_id = v_question_id;
begin
    
    open cur_max_ans_id;
    Fetch cur_max_ans_id into v_answer_id;
    
    if v_answer_id is null then 
        v_answer_id := 1;
    else
        v_answer_id := v_answer_id + 1; 
    end if;
    
    Insert into answer_master(question_id, answer_id, answer_text, is_correct_answer) 
            values (v_question_id, v_answer_id, v_answer_txt, v_is_correct_answer);
            
    DBMS_output.put_line('Option ' ||v_answer_id  || ' added for question no. '|| v_question_id) ;

    commit;

end;
/
