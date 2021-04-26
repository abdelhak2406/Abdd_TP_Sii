--1
--print apres chaque insertion
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER Trig_print_ajout_sportif
    AFTER INSERT ON Sportifs  FOR EACH ROW 
    BEGIN 
    dbms_output.put_line('Un nouveau sportif est ajouté!!');
    END;
    /

    INSERT INTO Sportifs VALUES(200,'Testeur','Tournevisse','M',25,2);//TODO: supprimer cet utilisateurs apres la fin du tp
--print apres chaque modification
CREATE OR REPLACE TRIGGER Trig_print_modif_sportif
    AFTER UPDATE ON Sportifs  FOR EACH ROW 
    BEGIN 
    dbms_output.put_line('sportif  updated. ');
    END;
    /
    UPDATE Sportifs SET NOM='Humanoide'  WHERE IDSPORTIF=200;

--print apres chaque supression


CREATE OR REPLACE TRIGGER Trig_print_delete_sportif
    AFTER DELETE ON Sportifs  FOR EACH ROW 
    BEGIN 
    dbms_output.put_line('sportif Supprime! ');
    END;
    /
        DELETE FROM SPORTIFS WHERE IDSPORTIF=200;





-- 2

/
-------------------------------------------

CREATE OR REPLACE TRIGGER TrigPriSeanceEntrain
AFTER
INSERT ON seances FOR EACH ROW
DECLARE 
ne SPORTIF.nom%TYPE;
pe SPORTIF.prenom%TYPE;
BEGIN
SELECT NOM INTO ne
FROM SPORTIFS
WHERE IDSPORTIF = :new.IDSPORTIFENTRAINEUR;
SELECT PRENOM INTO pe
FROM SPORTIFS 
WHERE IDSPORTIF = :new.IDSPORTIFENTRAINEUR;
dbms_output.put_line(
    'Une seance est ajoutée à l entaineur ' || ne || ' , ' || pz || ' .'
);
END;
/





--3

CREATE OR REPLACE TRIGGER verif_age_sportif
    BEFORE UPDATE ON Sportifs  
    FOR EACH ROW 
    BEGIN 
    IF :new.age < :old.age THEN
       raise_application_error(-20101, 'new age doit etre plus grand que lancien');
    END IF;
    END;
    /

--SQL> select idsportif,age from sportifs where idsportif=12;

    UPDATE Sportifs SET Age=28  WHERE IDSPORTIF=12;



--4 a
ALTER TABLE SPORTS 
ADD TOTAL_ENTRAINEURS INTEGER;
ALTER TABLE SPORTS 
ADD TOTAL_ARBITRES INTEGER;



DECLARE
CURSOR CR IS SELECT IDSPORT FROM SPORTS;

BEGIN

FOR ITEM IN CR 
LOOP
UPDATE SPORTS 
SET TOTAL_ARBITRES =(SELECT COUNT(DISTINCT IDSPORTIF) FROM ARBITRER A WHERE A.IDSPORT=ITEM.IDSPORT )
WHERE IDSPORT = ITEM.IDSPORT;

UPDATE SPORTS 
SET TOTAL_ENTRAINEURS =(SELECT COUNT(DISTINCT IDSPORTIFENTRAINEUR) FROM ENTRAINER E WHERE E.IDSPORT=ITEM.IDSPORT )
WHERE IDSPORT = ITEM.IDSPORT;

END LOOP;

end;
/
--4 b
CREATE OR REPLACE TRIGGER DLL_ARBITRE
AFTER DELETE ON ARBITRER 
FOR EACH ROW
BEGIN
UPDATE SPORTS
SET TOTAL_ARBITRES = TOTAL_ARBITRES - 1 WHERE IDSPORT = :old.IDSPORT; 
END;
/

---ARBITRER
--AJOUT
CREATE OR REPLACE TRIGGER ADD_ARBITRE
AFTER DELETE ON ARBITRER 
FOR EACH ROW
BEGIN
UPDATE SPORTS
SET TOTAL_ARBITRES = TOTAL_ARBITRES + 1 WHERE IDSPORT = :NEW.IDSPORT; 
END;
/

---
--SUPPRESSION 
CREATE OR REPLACE TRIGGER DLL_ARBITRE
AFTER DELETE ON ARBITRER 
FOR EACH ROW
BEGIN
UPDATE SPORTS
SET TOTAL_ARBITRES = TOTAL_ARBITRES - 1 WHERE IDSPORT = :OLD.IDSPORT; 
END;
/
---ENTRAINER
--AJOUT
CREATE OR REPLACE TRIGGER ADD_ENTRAINEUR
AFTER DELETE ON ENTRAINER 
FOR EACH ROW
BEGIN
UPDATE SPORTS
SET TOTAL_ENTRAINEURS = TOTAL_ENTRAINEURS + 1 WHERE IDSPORT = :NEW.IDSPORT; 
END;
/

---
--SUPPRESSION 
CREATE OR REPLACE TRIGGER DLL_ENTRAINEUR
AFTER DELETE ON ENTRAINER 
FOR EACH ROW
BEGIN
UPDATE SPORTS
SET TOTAL_ENTRAINEURS = TOTAL_ENTRAINEURS - 1 WHERE IDSPORT = :OLD.IDSPORT; 
END;
/




-- 5



    create table historique_seance_par_jour(
    jour varchar2(30),
    total_seance int,
    constraint pk_hist_seance_par_jour primary key (jour)
);

create or replace trigger updateHistory
    after insert on seances 
    for each row
    declare
    s_count number := 0;
    begin 
        select count(*) into s_count from historique_seance_par_jour where jour = :new.jour;
        if (s_count = 0) then
            insert into historique_seance_par_jour values (:new.jour, 1);
        else 
            update historique_seance_par_jour set total_seance = total_seance + 1 where jour = :new.jour;
        end if;
    end; 
    /

