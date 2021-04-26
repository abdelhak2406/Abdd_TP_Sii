--1 se connecter en tant que systeme voi
DescRibe dict;

select * from DICT;

Describe ALL_TAB_COLUMNS;


select COMMENTS from DICT where TABLE_NAME='ALL_TAB_COLUMNS';

describe USER_USERS;--la vue User_users affiche les informations concernant les utilstaatuer conecteé
select COMMENTS from DICT where TABLE_NAME='USER_USERS';

describe ALL_CONSTRAINTS; --nous donne toutes les contraintes auquel l'utilisateurs a acces
select COMMENTS from DICT where TABLE_NAME='ALL_CONSTRAINTS';




describe USER_TAB_PRIVS; --privileges objet
select COMMENTS from DICT where TABLE_NAME='USER_TAB_PRIVS';

--3 trouve 
show user;--oui mais non, on veut utiliser les vues

select username from user_users; 

select USERNAME from DBA_USERS;

--4
desc USER_TAB_COLUMNS;
desc ALL_TAB_COLUMNS;

select COMMENTS from DICT where table_name='ALL_TAB_COLUMNS';
select COMMENTS from DICT where table_name='USER_TAB_COLUMNS';
-- difference entre all tab et user tab c'est que user tab affiche les colonne de 
-- l'uilisateur connecté, dans all_ta il y'a le owner en plus pour savoir qui est le creéateur de la table.
select * from USER_TAB_COLUMNS;

select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS;

select TABLE_NAME, COLUMN_NAME, DATA


select OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE from ALL_TAB_COLUMNS where table_name='ALL_OBJECTS';
select OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE from ALL_TAB_COLUMNS where table_name='USER_OBJECTS';
select OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE from ALL_TAB_COLUMNS where table_name='USER_TAB_COLUMNS';
select OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE from ALL_TAB_COLUMNS where table_name='ALL_TAB_COLUMNS';
select OWNER, TABLE_NAME, COLUMN_NAME, DATA_TYPE from ALL_TAB_COLUMNS where table_name='DBA_USERS';

desc dba_users; 
select username, created from dba_users;
--entre parenthese , changer la taille des linges
set linesize 200 --fin dela parentheres

--- on gros la, on check  les tables les utilisateurs ect, l'idee est d'utiliser les dictonnaires. de voir la differences entre les dico ect.

--on test sur differents utilisateurs. et on regarde la difference celon le droit de chaqu'un

--connecte en tant que admindba #
select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where table_name='SPORTS';

--5
--se ceonnecter en tant que dbaGymnase

select COMMENTS from DICT where table_name='USER_TABLES'; 

describe USER_TABLES; -

select * from USER_TABLES; 

select TABLE_NAME, TABLESPACE_NAME from USER_TABLES;

select TABLE_NAME from USER_TABLES;

--6
--connecte en tant que systeme
select TABLE_NAME from USER_TABLES;


select TABLE_NAME from dba_tables where OWNER='SYSTEM';

select TABLE_NAME from dba_tables where OWNER='DBAGYMNASE';

--7
--connecte en tant que dbagymnase
select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where table_name='SPORTS';

select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where table_name='SEANCES';

--8
--connecte en tant que systeme
desc dba_constraints;

select CONSTRAINT_NAME, CONSTRAINT_TYPE,  R_CONSTRAINT_NAME from dba_constraints where TABLE_NAME='JOUER' and OWNER='DBAGYMNASE';

--on peut se connecte en tant que dbagymnase et utiliser user_constraints
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONS


select COMMENTS from DICT where table_name=upper('user_cons_columns');


desc user_cons_columns;
select CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME from user_cons_columns where table_name='SPORTS';
select CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME from user_cons_columns where table_name='JOUER';

--9
select COMMENTS from DICT where table_name='USER_CONSTRAINTS';

desc user_constraints;
select OWNER, CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE, STATUS from user_constraints;

--afficher les contraintes de la table jouer
select CONSTRAINT_NAME, STATUS from user_constraints where table_name=upper('jouer');

select CONSTRAINT_NAME, STATUS from user_constraints where table_name=upper('jouer');
select CONSTRAINT_NAME, STATUS from user_constraints where table_name=upper('jouer') and CONSTRAINT_TYPE='R';--cle etrangere


--10
--afficher les contraintes
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='SEANCES';

select CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME from user_cons_columns where table_name='SEANCES';

--afficher les attributs de la table seances et le type
select COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where table_name='SEANCES';

--11 la derniere fois on a supprimer les privileges de admingym
--on se connecte en tant que systeme

select * from DBA_SYS_PRIVS where GRANTEE='ADMINGYM';


connect dbagymnase/psw
grant create table, create view, create user to ADMINGYM;


grant select on GYMNASES to ADMINGYM;
connect system/psw

select * from DBA_SYS_PRIVS where GRANTEE='ADMINGYM';
select grantee, owner, table_name, privilege, grantable from dba_tab_privs where grantee='ADMINGYM';



connect admingym/psw
select * from USER_SYS_PRIVS;
select privilege, admin_option from user_sys_privs;
---
select * from user_tab_privs;


--12 trouve les roles .
--coonecte en tant que systeme
select * from user_tab_privs;
                    
select * from DBA_ROLE_PRIVS where GRANTEE='ADMINGYM';

select privilege, table_name from dba_tab_privs where grantee='GESTIONNAIRE_DES_GYMNASES';

--se connecte en tant que admingym

--pour afficher les privilèges objets accordés à GESTIONNAIRE_DES_GYMNASES
select privilege, table_name from dba_tab_privs where grantee='GESTIONNAIRE_DES_GYMNASES';


connect admingym/psw
---
SELECT * FROM user_role_privs;



connect admingym/psw
select * from user_objects;
select object_name, object_type from user_objects;
connect system/psw
select object_name, object_type from dba_objects where owner='ADMINGYM';

--14

connect system/psw
---
desc dba_tables
select owner from dba_tables where table_name='SPORTIFS';

--15 l'espace
connect dbagymnase/psw
desc user_segments;

select BYTES/1024, BLOCKS, segment_type from user_segments where segment_name = 'SPORTIFS';
--https://docs.oracle.com/pls/db92/db92.catalog_views?remark=homepage#index-USE

--16
select TABLE_NAME  from USER_TABLES;

select COLUMN_NAME from USER_TAB_COLUMNS;
select CONSTRAINT_NAME  from USER_CONSTRAINTS;
--quand on modifie un attribut on regarde la vue 'user_tab_columns'(si on est connecte en tant qu'utiliseateurs)
select column_name from user_tab_columns;







select CONSTRAINT_NAME  from USER_CONSTRAINTS;