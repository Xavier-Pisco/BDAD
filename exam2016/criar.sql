PRAGMA FOREIGN_KEYS=ON;

drop trigger if exists amizades;
/* Apaga as tabelas se ja existirem */
drop table if exists Amizade;
drop table if exists Estudante;
drop table if exists Curso;

drop table if exists Estudante;
drop table if exists Amizade;


/* Cria as tabelas */
create table Estudante(
    ID int PRIMARY KEY, 
    nome text, 
    curso int REFERENCES Curso(ID), 
    anoCurricular int);

create table Amizade(
    ID1 int REFERENCES Estudante(ID), 
    ID2 int REFERENCES Estudante(ID), 
    PRIMARY KEY (ID1, ID2));

create table Curso (
    ID int PRIMARY KEY, 
    nome text);

/* Insere dados nas tabelas */
insert into Curso values (1, 'MIEIC');
insert into Curso values (2, 'MIEEC');

insert into Estudante values (201101510, 'Ana Lopes', 1, 1);
insert into Estudante values (201101689, 'Gabriel Maria', 2, 1);
insert into Estudante values (201101381, 'Joao Nunes', 1, 1);
insert into Estudante values (201101709, 'Luis Goncalves', 2, 5);
insert into Estudante values (201101101, 'Maria Felisberta', 1, 2);
insert into Estudante values (201101782, 'Barbara Coutinho', 2, 2);
insert into Estudante values (201101468, 'Cristiano Rodrigo', 1, 2);
insert into Estudante values (201101641, 'Diogo Teixeira', 2, 2);
insert into Estudante values (201101247, 'Carla Silva', 1, 3);
insert into Estudante values (201101316, 'Joana Teixeira', 2, 3);
insert into Estudante values (201101911, 'Carlos Rodrigues', 1, 3);
insert into Estudante values (201101501, 'Sergio Carvalho', 2, 3);
insert into Estudante values (201101304, 'Mafalda Pimentel', 1, 4);
insert into Estudante values (201101025, 'Miguel Sampaio', 2, 4);
insert into Estudante values (201101934, 'Pedro Nunes', 1, 5);
insert into Estudante values (201101661, 'Cristina Ribeiro', 2, 5);


insert into Amizade values (201101689, 201101316);
insert into Amizade values (201101689, 201101304);

insert into Amizade values (201101510, 201101381);
insert into Amizade values (201101510, 201101689);
insert into Amizade values (201101689, 201101709);
insert into Amizade values (201101381, 201101247);
insert into Amizade values (201101709, 201101247);
insert into Amizade values (201101689, 201101782);
insert into Amizade values (201101782, 201101316);
insert into Amizade values (201101782, 201101304);
insert into Amizade values (201101101, 201101641);
insert into Amizade values (201101247, 201101911);
insert into Amizade values (201101247, 201101501);
insert into Amizade values (201101911, 201101501);
insert into Amizade values (201101501, 201101934);
insert into Amizade values (201101316, 201101934);
insert into Amizade values (201101934, 201101304);
insert into Amizade values (201101304, 201101661);
insert into Amizade values (201101661, 201101025);

insert into Amizade select ID2, ID1 from Amizade;


-- Pergunta 14
/*
SELECT Estudante.nome, Curso.nome
FROM Estudante, Curso on curso = Curso.id
WHERE Estudante.anoCurricular = 3;
*/

-- Pergunta 15
/*
Select nome
From Estudante, (
    Select count(*) as C, ID1
    From Amizade group by ID1
) where C > 3 and Estudante.id = ID1; 
*/

-- Pergunta 16 (Funciona mas de certeza que há uma melhor maneira)
/*
Select Estudante.nome, Estudante.anoCurricular
From Estudante
where Estudante.id not in (
    Select E1.id
    From Estudante E1, Estudante E2 on E1.anoCurricular != E2.anoCurricular, Amizade
    where E1.id = Amizade.ID1 and E2.id = Amizade.ID2
) and Estudante.id in (
    Select ID1
    From Amizade group by ID1
);
*/

-- Pergunta 17
/*
Select Distinct E4.id
From Estudante E1, Amizade A1 on E1.id = A1.ID1, Estudante E2 on A1.ID2 = E2.id,
    Amizade A2 on A2.ID1 = E2.id, Estudante E3 on A2.ID2 = E3.id, 
    Amizade A3 on A3.ID1 = E3.id, Estudante E4 on A3.ID2 = E4.id
where E1.nome like "Miguel Sampaio";
*/

-- Pergunta 18
/*
Select nome, anoCurricular
From (
    Select nome, anoCurricular, max(C)
    From Estudante, (
        Select count(*) as C, ID1
        From Amizade group by ID1
    ) where Estudante.id = ID1
);
*/

-- Pergunta 19
/*
create Trigger amizades
after insert on Estudante
begin
    insert into Amizade select New.id, Estudante.id from Estudante where Estudante.id != New.id and Estudante.curso = New.curso;
    insert into Amizade select Estudante.id, New.id from Estudante where Estudante.id != New.id and Estudante.curso = New.curso;
end;

insert into Estudante values (1, "Manel", 1, 1);
select * from Amizade where Amizade.ID1 = 1 or Amizade.ID2 = 1;
*/
