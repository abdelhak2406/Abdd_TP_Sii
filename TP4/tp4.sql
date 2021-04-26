
--1
DECLARE
CURSOR cr is 
SELECT S.IDSPORT , S.LIBELLE, COUNT(DISTINCT SS.IDGYMNASE )as NBGYM  FROM SPORTS S, SEANCES SS WHERE S.IDSPORT = SS.IDSPORT GROUP BY S.IDSPORT, S.LIBELLE;

BEGIN 
    FOR item in cr
    LOOP 
    dbms_output.put_line('le sport '||item.libelle||' est organise par '||item.nbgym);
    END LOOP;
    EXCEPTION WHEN NO_DATA_FOUND THEN  dbms_output.put_line('pas de donne trouve');
CLOSE cr;
END;
/
-- check la contrainte
select * from user_constraints where CONSTRAINT_NAME='CK_SPORTIFS_AGE';


--2
-- le contrainte que j'ai deja defini est CK_SPORTIFS_AGE check que l'age n'est n'est pas Null
    --Ajouter la nouvelle contrainte age du sportif entre 20 et 45 ans.
    ALTER TABLE Sportifs ADD CONSTRAINT ck_Sportifs_age_20_45  CHECK( (age > 20) AND (age < 45) );
--

CREATE OR REPLACE Procedure Maj_age_plus5 AS
CURSOR cr is SELECT idsportif, nom, prenom, age FROM Sportifs;
newage sportifs.age%TYPE;
BEGIN
    FOR item in cr
    LOOP
    newage := item.age + 5 ;
    UPDATE Sportifs SET age = newage
    WHERE idsportif = item.idsportif;
    dbms_output.put_line('lage du sportif '||item.nom||' est passer de '||item.age||' a '||newage);
    END LOOP;
END ;
 /

-- Desactiver la contrainte

ALTER TABLE  Sportifs DISABLE CONSTRAINT   ck_Sportifs_age_20_45 ;


--3 

CREATE OR REPLACE Procedure question_3 AS
CURSOR cr is SELECT  G.Nomgymnase, S.jour, min(S.Horaire) as Deb, max(S.horaire) as Fin 
  from Gymnases G, seances S where G.idGymnase = S.idGymnase  AND G.Surface >400 group by G.nomGymnase,S.jour;


BEGIN
FOR item in cr
LOOP
    IF (item.Deb = item.Fin) THEN
         dbms_output.put_line('Gymnase:'||item.Nomgymnase||'  '||item.JOUR||' 1 seul seance a '||item.deb||' h');
    ELSE
        dbms_output.put_line('Gymnase:'||item.Nomgymnase||'  '||item.JOUR||' 1ere seance a '||item.deb||' h dernier seance a '||item.Fin||' h');
    END IF; 
END LOOP;
 END ;
 /
--EXECUTION
SET SERVEROUTPUT ON
EXECUTE question_3


--4

CREATE or REPLACE FUNCTION question4(id in number) return number IS
    n number ;
    BEGIN
        SELECT COUNT(E.idSport) INTO n FROM ENTRAINER E WHERE IDSPORTIFENTRAINEUR=id ;
        return n;  
    END;
    /
        
-- execution
DECLARE
    CURSOR cr IS SELECT nom, prenom, idSportif FROM  Sportifs  WHERE
     idSportif >= 1 AND idSportif<=10;
    nba number;
    BEGIN
    FOR item in cr
    LOOP
    dbms_output.put_line('Le sportif ' ||item.nom|| ' ' ||item.prenom|| ' entraine ' ||
      question4(item.idSportif)||' sports !');
    END LOOP;
    EXCEPTION WHEN NO_DATA_FOUND THEN  dbms_output.put_line('pas de donne trouve');
    CLOSE cr;
    END;
/


--5


-- try 1(created witout errors)
CREATE OR REPLACE Procedure question5 (idgym in number,idsp in number,
                        isportifentrain in number, jr in VARCHAR2,
                        hor in FLOAT,dur in NUMBER) IS

    CURSOR cr_Pk_verif IS SELECT * FROM Seances WHERE 
        IDGYMNASE =idgym AND IDSPORT=idsp AND 
        isportifentrain = IDSPORTIFENTRAINEUR AND
        JOUR = jr ;
    CURSOR cr_Fk_idgym IS SELECT  IDGYMNASE  FROM GYMNASES WHERE IDGYMNASE=idgym;
    CURSOR cr_Fk_sport IS SELECT IDSPORT  FROM SPORTS WHERE IDSPORT=idsp;
    CURSOR cr_Fk_sportif IS  SELECT IDSPORTIF  FROM SPORTIFS WHERE IDSPORTIF=isportifentrain;
    Pk_exist EXCEPTION;
    Fk_idgym_exist EXCEPTION;
    Fk_sport_exist EXCEPTION;
    Fk_sportif_exist EXCEPTION;
    i NUMBER;

    BEGIN
    i:=0;
            --verifier clées primaire
    FOR item in cr_Pk_verif
        LOOP
            i:=i+1;
        END LOOP;
    
    IF (i >0) THEN RAISE Pk_exist;
    END IF;
    
    -- verifier cle etrangere
    --! 1 IDGYMNASE  dans  GYMNASES (IDGYMNASE)

    FOR item in cr_Fk_idgym
        LOOP
            i:=i+1;
        END LOOP;
    IF (i=0) THEN RAISE Fk_idgym_exist;
    END IF;

    --* (IDSPORT) dans SPORTS (IDSPORT)
    FOR item in cr_Fk_sport
        LOOP
            i:=i+1;
        END LOOP;
    IF (i=0) THEN RAISE Fk_sport_exist;
    END IF;

    --* (IDSPORTIFENTRAINEUR) dans SPORTIFS (IDSPORTIF) 
    FOR item in cr_Fk_sportif
        LOOP
            i:=i+1;
        END LOOP;
    IF (i=0) THEN RAISE Fk_sportif_exist;
    END IF;
    INSERT INTO SEANCES VALUES (idgym,idsp,
                        isportifentrain, jr,
                        hor ,dur );

    EXCEPTION 
        WHEN Pk_exist THEN   dbms_output.put_line('Erreur Cle primaire deja utilisé'); 
        WHEN Fk_idgym_exist THEN dbms_output.put_line('Erreur! table GYMNASE cle etrangere inexistante');
        WHEN Fk_sport_exist THEN dbms_output.put_line('Erreur! table sport cle etrangere inexistante');
        WHEN Fk_sportif_exist THEN dbms_output.put_line('Erreur! table SPORTIFS cle etrangere inexistante');
    
    END;
    /

--execution
EXECUTE question5(17,2,57,'Dimanche',17.0,60);
EXECUTE question5(29,2,57,'Dimanche',17.0,60);


