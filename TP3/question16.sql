
SQL> select TABLE_NAME  from USER_TABLES;


SQL> ALTER TABLE GYMNASES
  2  ADD DATECREATION date;

Table altered.

SQL> select table_name , column_name, data_type from USER_TAB_COLUMNS;

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
ARBITRER                       IDSPORTIF                                        
NUMBER                                                                          
                                                                                
ARBITRER                       IDSPORT                                          
NUMBER                                                                          
                                                                                
ENTRAINER                      IDSPORTIFENTRAINEUR                              
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
ENTRAINER                      IDSPORT                                          
NUMBER                                                                          
                                                                                
GYMNASES                       IDGYMNASE                                        
NUMBER                                                                          
                                                                                
GYMNASES                       NOMGYMNASE                                       
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       ADRESSE                                          
VARCHAR2                                                                        
                                                                                
GYMNASES                       VILLE                                            
VARCHAR2                                                                        
                                                                                
GYMNASES                       SURFACE                                          
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       DATECREATION                                     
DATE                                                                            
                                                                                
JOUER                          IDSPORTIF                                        
NUMBER                                                                          
                                                                                
JOUER                          IDSPORT                                          
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SEANCES                        IDGYMNASE                                        
NUMBER                                                                          
                                                                                
SEANCES                        IDSPORT                                          
NUMBER                                                                          
                                                                                
SEANCES                        IDSPORTIFENTRAINEUR                              
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SEANCES                        JOUR                                             
VARCHAR2                                                                        
                                                                                
SEANCES                        HORAIRE                                          
FLOAT                                                                           
                                                                                
SEANCES                        DUREE                                            
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       IDSPORTIF                                        
NUMBER                                                                          
                                                                                
SPORTIFS                       NOM                                              
VARCHAR2                                                                        
                                                                                
SPORTIFS                       PRENOM                                           
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       SEXE                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       AGE                                              
NUMBER                                                                          
                                                                                
SPORTIFS                       IDSPORTIFCONSEILLER                              
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTS                         IDSPORT                                          
NUMBER                                                                          
                                                                                
SPORTS                         LIBELLE                                          
VARCHAR2                                                                        
                                                                                
TABLEERREURS                   ADRESSE                                          
ROWID                                                                           
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
TABLEERREURS                   UTILISATEUR                                      
VARCHAR2                                                                        
                                                                                
TABLEERREURS                   NOMTABLE                                         
VARCHAR2                                                                        
                                                                                
TABLEERREURS                   NOMCONTRAINTE                                    
VARCHAR2                                                                        
                                                                                

30 rows selected.

SQL> select table_name , column_name, data_type from USER_TAB_COLUMNS where table_name='GYMNASES';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       IDGYMNASE                                        
NUMBER                                                                          
                                                                                
GYMNASES                       NOMGYMNASE                                       
VARCHAR2                                                                        
                                                                                
GYMNASES                       ADRESSE                                          
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       VILLE                                            
VARCHAR2                                                                        
                                                                                
GYMNASES                       SURFACE                                          
NUMBER                                                                          
                                                                                
GYMNASES                       DATECREATION                                     
DATE                                                                            
                                                                                

6 rows selected.

SQL> ALTER TABLE Sportifs
  2  ADD CONSTRAINT ch_Sexenotnull CHECK(Sexe IS NOT NULL);

Table altered.

SQL> desc USER_CONSTRAINTS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OWNER                                              VARCHAR2(120)
 CONSTRAINT_NAME                           NOT NULL VARCHAR2(30)
 CONSTRAINT_TYPE                                    VARCHAR2(1)
 TABLE_NAME                                NOT NULL VARCHAR2(30)
 SEARCH_CONDITION                                   LONG
 R_OWNER                                            VARCHAR2(120)
 R_CONSTRAINT_NAME                                  VARCHAR2(30)
 DELETE_RULE                                        VARCHAR2(9)
 STATUS                                             VARCHAR2(8)
 DEFERRABLE                                         VARCHAR2(14)
 DEFERRED                                           VARCHAR2(9)
 VALIDATED                                          VARCHAR2(13)
 GENERATED                                          VARCHAR2(14)
 BAD                                                VARCHAR2(3)
 RELY                                               VARCHAR2(4)
 LAST_CHANGE                                        DATE
 INDEX_OWNER                                        VARCHAR2(30)
 INDEX_NAME                                         VARCHAR2(30)
 INVALID                                            VARCHAR2(7)
 VIEW_RELATED                                       VARCHAR2(14)

SQL> select CONSTRAINT_NAME from USER_CONSTRAINTS;

CONSTRAINT_NAME                                                                 
------------------------------                                                  
CS_SEXE                                                                         
PK_SPORTIFS                                                                     
FK_SPORTIFS                                                                     
PK_SPORTS                                                                       
PK_GYMNASES                                                                     
PK_ARBITRER                                                                     
FK_SPORTIF_ARBITRER                                                             
FK_SPORT_ARBITRER                                                               
PK_ENTRAINER                                                                    
FK_SPORTIFS_ENTRAINER                                                           
FK_SPORTIFS_ENTRAINEUR2                                                         

CONSTRAINT_NAME                                                                 
------------------------------                                                  
PK_JOUER                                                                        
FK_SPORT_JOUER                                                                  
FK_SPORTIFS_JOUER                                                               
CK_JOUR                                                                         
PK_SEANCES                                                                      
FK_SEANCES_GYMNASE                                                              
FK_SEANCES_SPORT                                                                
FK_SEANCES_ENRTRAINER                                                           
CH_SEXENOTNULL                                                                  

20 rows selected.

SQL> ALTER TABLE Sportifs
  2  ADD CONSTRAINT ch_Agenotnull CHECK(Age IS NOT NULL);

Table altered.

SQL> select CONSTRAINT_NAME from USER_CONSTRAINTS;

CONSTRAINT_NAME                                                                 
------------------------------                                                  
CS_SEXE                                                                         
PK_SPORTIFS                                                                     
FK_SPORTIFS                                                                     
PK_SPORTS                                                                       
PK_GYMNASES                                                                     
PK_ARBITRER                                                                     
FK_SPORTIF_ARBITRER                                                             
FK_SPORT_ARBITRER                                                               
PK_ENTRAINER                                                                    
FK_SPORTIFS_ENTRAINER                                                           
FK_SPORTIFS_ENTRAINEUR2                                                         

CONSTRAINT_NAME                                                                 
------------------------------                                                  
PK_JOUER                                                                        
FK_SPORT_JOUER                                                                  
FK_SPORTIFS_JOUER                                                               
CK_JOUR                                                                         
PK_SEANCES                                                                      
FK_SEANCES_GYMNASE                                                              
FK_SEANCES_SPORT                                                                
FK_SEANCES_ENRTRAINER                                                           
CH_SEXENOTNULL                                                                  
CH_AGENOTNULL                                                                   

21 rows selected.

SQL> ALTER TABLE Sportifs
  2  MODIFY Prenom VARCHAR2(60);

Table altered.


SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where TABLE_NAME='SPORTIFS';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       IDSPORTIF                                        
NUMBER                                                                          
                                                                                
SPORTIFS                       NOM                                              
VARCHAR2                                                                        
                                                                                
SPORTIFS                       PRENOM                                           
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       SEXE                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       AGE                                              
NUMBER                                                                          
                                                                                
SPORTIFS                       IDSPORTIFCONSEILLER                              
NUMBER                                                                          
                                                                                

6 rows selected.

SQL> ALTER TABLE GYMNASES
  2  DROP COLUMN DATECREATION;

Table altered.

SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where TABLE_NAME='GYMNASES';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       IDGYMNASE                                        
NUMBER                                                                          
                                                                                
GYMNASES                       NOMGYMNASE                                       
VARCHAR2                                                                        
                                                                                
GYMNASES                       ADRESSE                                          
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       VILLE                                            
VARCHAR2                                                                        
                                                                                
GYMNASES                       SURFACE                                          
NUMBER                                                                          
                                                                                

SQL> ALTER TABLE GYMNASES
  2  RENAME COLUMN Adresse TO ADRESSEGYM ;

Table altered.

SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where TABLE_NAME='GYMNASES';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       IDGYMNASE                                        
NUMBER                                                                          
                                                                                
GYMNASES                       NOMGYMNASE                                       
VARCHAR2                                                                        
                                                                                
GYMNASES                       ADRESSEGYM                                       
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
GYMNASES                       VILLE                                            
VARCHAR2                                                                        
                                                                                
GYMNASES                       SURFACE                                          
NUMBER                                                                          
                                                                                

SQL> ALTER TABLE Sports
  2  ADD CONSTRAINT ch_LIBELLE check (Libelle in ('Basket ball','Volley ball','Hand ball','Tennis', 'Hockey', 'Badmington','Ping pong','Football', 'Boxe'))
  3  ;

Table altered.

SQL> select CONSTRAINT_NAME from USER_CONSTRAINTS where CONSTRAINT_NAME='CH_LIBELLE';

CONSTRAINT_NAME                                                                 
------------------------------                                                  
CH_LIBELLE                                                                      

SQL> desc sportifs;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 IDSPORTIF                                 NOT NULL NUMBER
 NOM                                                VARCHAR2(50)
 PRENOM                                             VARCHAR2(60)
 SEXE                                               VARCHAR2(1)
 AGE                                                NUMBER
 IDSPORTIFCONSEILLER                                NUMBER

SQL> alter table sportifs rename column NOM TO NAME;

Table altered.

SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where TABLE_NAME='SPORTIFS';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       IDSPORTIF                                        
NUMBER                                                                          
                                                                                
SPORTIFS                       NAME                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       PRENOM                                           
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       SEXE                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       AGE                                              
NUMBER                                                                          
                                                                                
SPORTIFS                       IDSPORTIFCONSEILLER                              
NUMBER                                                                          
                                                                                

6 rows selected.

SQL> alter table sportifs add newCOLUmn VARCHAR(20);

Table altered.

SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where TABLE_NAME='SPORTIFS';

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       IDSPORTIF                                        
NUMBER                                                                          
                                                                                
SPORTIFS                       NAME                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       PRENOM                                           
VARCHAR2                                                                        
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       SEXE                                             
VARCHAR2                                                                        
                                                                                
SPORTIFS                       AGE                                              
NUMBER                                                                          
                                                                                
SPORTIFS                       IDSPORTIFCONSEILLER                              
NUMBER                                                                          
                                                                                

TABLE_NAME                     COLUMN_NAME                                      
------------------------------ ------------------------------                   
DATA_TYPE                                                                       
--------------------------------------------------------------------------------
SPORTIFS                       NEWCOLUMN                                        
VARCHAR2                                                                        
                                                                                

7 rows selected.

SQL> select TABLE_NAME, COLUMN_NAME, DATA_TYPE from USER_TAB_COLUMNS where
  2  
SQL> select column_name from user_tab_columns;

COLUMN_NAME                                                                     
------------------------------                                                  
IDSPORTIF                                                                       
IDSPORT                                                                         
IDSPORTIFENTRAINEUR                                                             
IDSPORT                                                                         
IDGYMNASE                                                                       
NOMGYMNASE                                                                      
ADRESSEGYM                                                                      
VILLE                                                                           
SURFACE                                                                         
IDSPORTIF                                                                       
IDSPORT                                                                         

COLUMN_NAME                                                                     
------------------------------                                                  
IDGYMNASE                                                                       
IDSPORT                                                                         
IDSPORTIFENTRAINEUR                                                             
JOUR                                                                            
HORAIRE                                                                         
DUREE                                                                           
IDSPORTIF                                                                       
NAME                                                                            
PRENOM                                                                          
SEXE                                                                            
AGE                                                                             

COLUMN_NAME                                                                     
------------------------------                                                  
IDSPORTIFCONSEILLER                                                             
NEWCOLUMN                                                                       
IDSPORT                                                                         
LIBELLE                                                                         
ADRESSE                                                                         
UTILISATEUR                                                                     
NOMTABLE                                                                        
NOMCONTRAINTE                                                                   

30 rows selected.




SQL> ALTER table sportifs add constraint ck_question16 check (name in ('name1', 'name2'));

Table altered.

SQL> select CONSTRAINT_NAME from USER_CONSTRAINTS;

CONSTRAINT_NAME                                                                 
------------------------------                                                  
CS_SEXE                                                                         
PK_SPORTIFS                                                                     
FK_SPORTIFS                                                                     
PK_SPORTS                                                                       
PK_GYMNASES                                                                     
PK_ARBITRER                                                                     
FK_SPORTIF_ARBITRER                                                             
FK_SPORT_ARBITRER                                                               
PK_ENTRAINER                                                                    
FK_SPORTIFS_ENTRAINER                                                           
FK_SPORTIFS_ENTRAINEUR2                                                         

CONSTRAINT_NAME                                                                 
------------------------------                                                  
PK_JOUER                                                                        
FK_SPORT_JOUER                                                                  
FK_SPORTIFS_JOUER                                                               
CK_JOUR                                                                         
PK_SEANCES                                                                      
FK_SEANCES_GYMNASE                                                              
FK_SEANCES_SPORT                                                                
FK_SEANCES_ENRTRAINER                                                           
CH_SEXENOTNULL                                                                  
CH_AGENOTNULL                                                                   
CH_LIBELLE                                                                      

CONSTRAINT_NAME                                                                 
------------------------------                                                  
CK_QUESTION16                                                                   

23 rows selected.

SQL> spool off
