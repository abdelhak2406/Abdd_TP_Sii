--creation utilisateurs
create user ADMINGYM1 identified by psw
default tablespace GYMNASE_TBS
temporary tablespace GYMNASE_TempTBS;
--afcicher les utlisateurs (il faut se connecter en system)
desc dba_users;
select username, created from dba_users where username=upper('admingym');

--ACCORDER DROIT ed connexion A ADMINGYM

GRANT CREATE SESSION to ADMINGYM
--pour afficher les privileges  (en etant connecté en tant que ADMINGYM)

desc user_sys_privs;

select * from user_sys_privs;
    --on ne lui as pas donner les privileges admin d'ou le no


-- on se connecte a dydteme pour checker les droit d'un utilsateur

desc dba_sys_privs;
select privilege, admin_option from dba_sys_privs where grantee='ADMINGYM';

--connecter en tant que DBAGYM
    --AJOUTER DES PRIVILEGE
GRANT CREATE TABLE, CREATE VIEW, CREATE USER TO ADMINGYM;
        --CES PRIVILEGES SONT DE TYPE SYSTEME
        --ON PEUT VERIRIFER SOIT A PARTIR DE SYSTEME

-- ON Verifie droits UNE TABLE
select privilege, admin_option from user_sys_privs;
--ON ESSAI DE CREER UNE TABLE
create table test (a integer, b char(1));
 --C'EST IMPOSSIBLE 
    --POUR REGLER PROBLEME ON FAIT SA EN ETANT COONNCTE A DBAGYMNASE
    alter user ADMINGYM quota unlimited on GYMNASE_TBS;

    --ON RECREE LA TABLE
    create table test (a integer, b char(1));
select table_name from tabs;
-- ON CHECK LES TABLES

select table_name from tabs;
--ON CHECK SI ON PEUT INSEREE
    insert into test values (1, 'b'); --ELLE MARCHE PARCE QUE LA TABLE TEST EST SA PROPRE TABLE.

-- LE CATALOGUE USER_OBJECTS 
--ON CHECK LES OBJETS DONT DISPOSE L'UTILISATEURS
select object_name, object_type from user_objects;
    --A PARTIR DE SYSTEME ON FAIT
    desc dba_objects;
select owner, object_name, object_type from dba_objects where owner='ADMINGYM';

--EXEMPLE DE CREATION D'UNE VUE SUR LA COLONNE A DE LA TABLE TEST (CONNECTE EN TANT QUE ADMINGYM)
create view view1 as select a from test;
select * from view1;

--ON CHECK SI LA VUE A BIEN ETAIT CREER A PARTIR DE SYSTEME

select owner, object_name, object_type from dba_objects where owner='ADMINGYM';

-- CREER UTILISATEUR EN TANT QUE ADMINGYM
create user usertest identified by psw;
--ON REGARDE SI L'UTILISATEUR EST CREER A PARTIR DE SYSTE
select username, default_tablespace, temporary_tablespace, password, profile from dba_users where username =upper('usertest');


-- connecter en tant que admingym
    --check si on peu acceder a une table 
    Select * from  GYMNASES; 

    --on essai en précisant le nom de la base de donner
Select * from DBAGYMNASE.GYMNASES;

--on se connecte a DBAGYMNASE et donne le droit select a l'utilsateur admingym;
grant select on GYMNASES to ADMINGYM;

-- on vas s'assurer que ce privilége a bien etait recu .
    --1. a partir de systeme
     desc dba_tab_privs

    select grantee, owner, table_name, privilege, grantable from dba_tab_privs where grantee='ADMINGYM';

    -- a partir de l'utilsateur?
    select * from user_tab_privs;

-- on regarde si el select marche a partir de admingym
Select * from DBAGYMNASE.GYMNASES;--ne marche pas sans le DBAGYMNASES

--  ON ESSAI DE SUPPRIMER  tout les gymnases qui n’organisent pas de séances A PARTIR DE ADMINGYM

delete from DBAGYMNASE.GYMNASES where IdGymnase not in (select IdGymnase from DBAGYMNASE.Seances);
    --ON DONNE LES DROIT (ETANT CONNECTE A DRAGYMNASE)
    grant delete on GYMNASES to ADMINGYM;
    -- LE TRUC C'EST QUE SA MARCHE TOUJOURS PAS, pOURQUOI? PARCE QU'ON A PAS DE DROIT SUR LA TABLE SEANCES!
    grant select on Seances to ADMINGYM; ---ON LUI ATTRIBUT
    -- ET LA SA MARCHE!
    -- ON CHECK QU'IL A BIEN ELS DROITS EN ETANT CONNECTE EN SYSTEME
    select grantee, owner, table_name, privilege, grantable from dba_tab_privs where grantee='ADMINGYM';

-- n essai de creer un index
CREATE index LIBELLE_1X ON DBAGYMNASE.SPORTS(Libelle); --!ne marche pas du coup
-- on donne les droit a partir de dbagymnase
grant index on SPORTS to ADMINGYM; --index est un privilege objet
    --check a partir de systeme
    select grantee, owner, table_name, privilege, grantable from dba_tab_privs where grantee='ADMINGYM';

    -- on reesai de creer l'index
create index LIBELLE_IX  on DBAGYMNASE.SPORTS(Libelle);

    --on verifie sur le catalogue user_objhects
    select object_name, object_type from user_objects

    select * from user_tab_privs;

-- enlever tout les priviléges accorder a  admingym
revoke all privileges from ADMINGYM; --car on ne lui a pas donner tout les priviléges, donc il faut enlever les privileges un par un

    --on commence par supprimer les privileges systeme
    revoke create session, create user, create table, create view from ADMINGYM;
    -- on check a partir de system 
    select privilege , admin_option from dba_sys_privs where grantee=upper('admingym');

    --On supprime maintenant les priviléges objet
    revoke select, delete on gymnases from ADMINGYM;
    revoke select on seances from ADMINGYM;
    revoke index on sports from ADMINGYM;
    --on verifie a partir de systeme
    select grantee,owner, grantor, table_name, privilege from dba_tab_privs where grantee=upper('admingym');

--14. creation d'un profile Gymnase_Profil
    --on se connecte en tant que dbagymnase et creons le profile
    create profile Gymnase_Profil limit
sessions_per_user 4
cpu_per_call 3000
connect_time 70
logical_reads_per_session 1300
private_sga 30K
idle_time 20
failed_login_attempts 3
password_lock_time 1
password_life_time 60
password_reuse_time 40
password_reuse_max unlimited
password_grace_time 7;
    -- verifier que le profile a bien etait créer(en tant que systeme).
    select * from dba_profiles where profile=upper('Gymnase_Profil');
    -- afficher juste ce qu'on a modifier?
    select * from dba_profiles where profile=upper('Gymnase_Profil') and limit <>'DEFAULT';
    --regarde le profile pour admingym
    select username, profile from dba_users where username=upper('admingym');

--affecer profile (connecte en atnt que DBAGYMNASE)
alter user ADMINGYM profile Gymnase_Profil;
    --verifier (systeme)
    select username, profile from dba_users where username=upper('admingym');

--  ON CREER LE ROLE GESTIONNAIRE_DES_GYMNASES(un role est un ensemble de priviléges systeme et/ou objet
--simplifie la gestino des priviléges et leurs attributions)
    --conecte en tant que dbagymnase
    create role GESTIONNAIRE_DES_GYMNASES;
    grant select on SPORTIFS to GESTIONNAIRE_DES_GYMNASES;
grant select on SPORTS to GESTIONNAIRE_DES_GYMNASES;
grant select on GYMNASES to GESTIONNAIRE_DES_GYMNASES;
grant update on ARBITRER to GESTIONNAIRE_DES_GYMNASES;
grant update on ENTRAINER to GESTIONNAIRE_DES_GYMNASES;
grant update on JOUER to GESTIONNAIRE_DES_GYMNASES;
grant update on SEANCES to GESTIONNAIRE_DES_GYMNASES;

    -- assigner ce role a admingym(toujours co en tant que dbagymnase)
grant GESTIONNAIRE_DES_GYMNASES to ADMINGYM;
    --check si c'est bien creer(systeme)
select * from dba_role_privs where GRANTEE ='ADMINGYM';
