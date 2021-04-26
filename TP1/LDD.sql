--5 ajout d l'attrbut DATECREATION de type date dans la relation GYMNASES
    ALTER TABLE GYMNASES ADD DATECREATION DATE NOT NULL ;

--6 Ajout de la contrainte sur les attribut sex et age de la table SPORTIF:
    ALTER TABLE SPORTIFS ADD CONSTRAINT ck_SPORTIFS_AGE CHECK (AGE IS NOT NULL);
    
    ALTER TABLE SPORTIFS ADD CONSTRAINT ck_SPORTIFS_SEXE CHECK (SEXE IS NOT NULL);


--7 modifier longeur de l'attribut prenom

    ALTER TABLE SPORTIFS MODIFY ( PRENOM VARCHAR(45));
--8  Supprimer la colonne dateCreation dans la table gymnase. 
    ALTER TABLE GYMNASES DROP COLUMN DATECREATION ;
    -- verifier
    desc  GYMNASES;
    
--9 Renommer la colonne ADRESSE dans la table gymnase par adressegym.    
    ALTER TABLE GYMNASES RENAME COLUMN ADRESSE TO adressegym;
    --verifier
    desc  GYMNASES;

--10 Ajout d'un domaine pour libelle :5
    ALTER TABLE SPORTS ADD CONSTRAINT CK_SPORTS_LIBELLE CHECK (LOWER(LIBELLE) IN ('Basket ball','Volley ball','Hand ball','Tennis', 'Hockey', 'Badmington','Ping pong','Football', 'Boxe'));



