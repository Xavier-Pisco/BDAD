DROP table if exists Marca;
Create Table Marca(
  idMarca int PRIMARY KEY,
  nome text
  );
Drop table if EXISTS Modelo;
CREATE Table Modelo (
  idModelo int,
  nome text,
  idMarca int REFERENCES Marca(idMarca)
  );
Drop table if exists CodPostal;
Create TABLE CodPostal (
  codPostal1 int PRIMARY key,
  nome text,
  idMarca int REFERENCES Marca(idMarca)
  );
 Drop table if EXISTS Cliente;
 Create TABLE Cliente(
   idCliente int PRIMARY key,
   nome text,
   morada text,
   codPostal1 int REFERENCES CodPostal(codPostal1),
   codPostal2 int REFERENCES CodPostal(codPostal1),
   telefone INT
   );
Drop TABLE if EXISTS Carro;
CREATE TABLE Carro (
  idCarro int Primary key,
  matricula text UNIQUE,
  idModelo int REFERENCES Modelo(idModelo),
  idCliente int REFERENCES Cliente(idCliente)
  );
Drop TABLE if EXISTS Reparacao;
create table Reparacao (
  idReparacao int PRIMARY KEY,
  dataInicio date,
  dataFim date,
  idCliente int REFERENCES Cliente(idCliente),
  idCarro int REFERENCES Carro(idCarro),
  CHECK(dataFim >= dataInicio)
  );
Drop table if EXISTS Peca;
CREATE table Peca(
  idPeca int PRIMARY KEY,
  codigo int unique,
  designacao text,
  custoUnitario int CHECK(custoUnitario > 0),
  quantidade int check (quantidade > 0)
  );
Drop table if EXISTS ReparacaoPeca;
Create table ReparacaoPeca(
  idReparacao int REFERENCES Reparacao(idReparacao),
  idPeca int REFERENCES Peca(idPeca),
  quantidade int check (quantidade > 0),
  PRIMARY key (idreparacao, idpeca)
  );
Drop table if EXISTS PecaModelo;
Create Table PecaModelo (
  idPeca int REFERENCES Peca(idpeca),
  idModelo int REFERENCES Modelo(idmodelo),
  PRIMARY key (idPeca, idModelo)
  );
Drop table if EXISTS Especialidade;
CREATE table Especialidade (
  idEspecialidade INt PRIMARY KEY,
  nome text,
  custoHorario int CHECK (custoHorario > 0)
  );
Drop table if EXISTS Funcionario;
Create table Funcionario (
  idFuncionario int PRIMARY key,
  nome text,
  morada text,
  CodPostal1 int REFERENCES CodPostal(codpostal1),
  CodPostal2 int REFERENCES CodPostal(codpostal1),
  telefone int,
  idEspecialidade int REFERENCES Especialidade(idespecialidade)
  );
Drop table if EXISTS FuncionarioReparacao;
Create TABLE FuncionarioReparacao (
  idFuncionario int REFERENCES Funcionario(idfuncionario),
  idReparacao int REFERENCES Reparacao(idreparacao),
  numHoras int CHECK (numHoras > 0),
  PRIMARY key (idFuncionario, idReparacao)
  );