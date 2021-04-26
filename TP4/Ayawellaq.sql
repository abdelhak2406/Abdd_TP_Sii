-- ----------------- Procédure Q3---------------

Create or replace Procedure HoraireGymnase2(Id in number) IS

  cursor cr is select G.nomGymnase, S.jour, min(S.Horaire) as Debut, max(S.horaire) as Fin 
  from Gymnases G, seances S where G.idGymnase = S.idGymnase AND S.idGymnase = Id 
  group by S.jour, G.nomGymnase;
  
  i integer;
  vide EXCEPTION;
  Begin
    i := 1;
    for item in cr
    loop
      dbms_output.put_line('==> Pour "' ||item.jour|| '" : sa 1ère séance est à ' 
      ||item.Debut|| 'H et sa dernière est à ' ||item.Fin|| 'H');
      i := i+1;
    end loop;

    if(i<2) then RAISE vide;
    end if;
    EXCEPTION
    WHEN vide THEN dbms_output.put_line('==> Gymnase ne gère aucune séance !!');

  END;
/

 --  ------------------ Appel Procédure Q3 ------------------------
declare
cursor cr is select nomGymnase, idGymnase from Gymnases;
begin
  for item in cr
  loop
    dbms_output.put_line('------------------------------------------------------------');
    dbms_output.put_line('Gymnase num '||item.idGymnase||' "'||item.nomGymnase||'" :');
    HoraireGymnase2(item.idGymnase);
  end loop;
end;
/


-- ------------------------- Fonction Q4 --------------------------------

create or replace function NbSports(id in number) return number IS 
  
  cursor cr is select count(E.idSport) INTO n from Entrainer E where IDSPORTIFENTRAINEUR =2;
  


  begin
  return n;  
  end;
/  

-- ------------------------------ Appel Fonction Q4 ---------------------------------

declare

  cursor cr is select nom, prenom, idSportif from Sportifs where 
  idSportif <= 10 AND idsportif >= 1 ;
  vide EXCEPTION;
  begin
    for item in cr
    loop
      dbms_output.put_line('Le sportif ' ||item.nom|| ' ' ||item.prenom|| ' entraine ' ||
      NbSports(item.idSportif)||' sports !');
    end loop;

  end;
/



-- ---------------------------- Procédure Q5 ------------------------------

Create or Replace Procedure AddSeance(idG in number, idS in number, idE in number, 
                                   jr in Varchar2, h in number, d in number ) IS 
  
  cursor cr1 is select * from seances where idGymnase = idG AND idSport = idS 
  AND IDSPORTIFENTRAINEUR = idE AND jour = jr AND horaire = h; -- Verifier la clé primaire

  cursor cr2 is select G.idGymnase, S.idSport, T.idSportif FROM Gymnases G, 
  Sports S, Sportifs T WHERE G.idGymnase = idG AND S.idSport = idS 
  AND T.idSportif = idE; -- Verifier les clés étrangères 
               
  i integer; j integer;
  existePk EXCEPTION;  -- Une Exception si la PK existe
  notExisteFk EXCEPTION; -- Une Exception si une des FK n'existe pas
  begin
    i := 0; 
    for item in cr1
    loop
      i := i+1;
    end loop;
    if(i > 0) then RAISE existePk; -- Si i > 0 alors la PK existe déja ==> Exception 
    end if;

    j := 0;
    for item in cr2 
    loop
      j := j+1; 
    end loop;
    if(j < 1) then RAISE notExisteFk; --Si j < 1 alors une des FK n'existe pas ==> Exception 
    end if;

    INSERT INTO Seances VALUES(idG,idS,idE,jr,h,d); -- Si tout va bien on insert une nvl ligne
    dbms_output.put_line('Succès : Insertion d''une ligne dans la Table Seance '); 

    EXCEPTION

    WHEN existePk THEN dbms_output.put_line('==> Erreur : La base de données 
    contient déja cette séance !!');
    WHEN notExisteFk THEN dbms_output.put_line('==> Erreur : Une des clés étrangères 
    n''existe pas !!');
   
  end;
/



