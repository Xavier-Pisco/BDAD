Drop table if EXISTS Aluno;
CREATE table Aluno (
  nr int PRIMARY key,
  nome text
  );
Drop table if EXISTS Prof;
CREATE table Prof (
  sigla text PRIMARY key,
  nome text
  );
Drop table if EXISTS Cadeira;
Create table Cadeira (
  cod text PRIMARY key,
  design text,
  curso text,
  regente text REFERENCES Prof(sigla)
  );
Drop table if EXISTS Prova;
Create table Prova (
  nr int REFERENCES Aluno(nr),
  cod text REFERENCES Cadeira(cod),
  data Date,
  nota int check (nota > 0 and nota < 20),
  PRIMARY key (nr, cod, data)
  );
INSERT into Aluno VALUES (100, 'João');
INSERT into Aluno VALUES (110, 'Manuel');
INSERT into Aluno VALUES (120, 'Rui');
INSERT into Aluno VALUES (130, 'Abel');
INSERT into Aluno VALUES (140, 'Fernando');
INSERT into Aluno VALUES (150, 'Ismael');
Insert into Prof Values ('ECO', 'Eugénio');
INSErT into Prof VALUES ('FNF', 'Fernando');
INSErT into Prof VALUES ('JLS', 'João');
INSErT into Cadeira VALUES ('TS1', 'Teoria dos Sistemas 1', 'IS', 'FNF');
INSErT into Cadeira VALUES ('BD', 'Bases de Dados', 'IS', 'ECO');
INSErT into Cadeira VALUES ('EIA', 'Estruturas de Informação e Algoritmos', 'IS', 'ECO');
INSErT into Cadeira VALUES ('EP', 'Eletrónica de Potência', 'AC', 'JLS');
INSErT into Cadeira VALUES ('IE', 'Instalações Elétricas', 'AC', 'JLS');
INSErT into Prova VALUES (100, 'TS1', '92-02-11', 8);
INSErT into Prova VALUES (100, 'TS1', '93-02-02', 11);
INSErT into Prova VALUES (100, 'BD', '93-02-04', 17);
INSErT into Prova VALUES (100, 'EIA', '92-01-29', 16);
INSErT into Prova VALUES (100, 'EIA', '93-02-02', 13);
INSErT into Prova VALUES (110, 'EP', '92-01-30', 12);
INSErT into Prova VALUES (110, 'IE', '92-02-05', 10);
INSErT into Prova VALUES (110, 'IE', '93-02-01', 14);
INSErT into Prova VALUES (120, 'TS1', '93-01-31', 15);
INSErT into Prova VALUES (120, 'EP', '93-02-04', 13);
INSErT into Prova VALUES (130, 'BD', '93-02-04', 12);
INSErT into Prova VALUES (130, 'EIA', '93-02-02', 7);
INSErT into Prova VALUES (130, 'TS1', '92-02-11', 8);
INSErT into Prova VALUES (140, 'TS1', '93-01-31', 10);
INSErT into Prova VALUES (140, 'TS1', '92-02-11', 13);
INSErT into Prova VALUES (140, 'EIA', '93-02-02', 11);
INSErT into Prova VALUES (150, 'TS1', '92-02-11', 10);
INSErT into Prova VALUES (150, 'EP', '93-02-02', 11);
INSErT into Prova VALUES (150, 'BD', '93-02-04', 17);
INSErT into Prova VALUES (150, 'EIA', '92-01-29', 16);
INSErT into Prova VALUES (150, 'IE', '93-02-02', 13);