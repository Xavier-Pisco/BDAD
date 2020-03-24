drop table if exists Team;
CREATE TABLE Team (
  name text PRIMARY KEY,
  country text
  );
DROP TABLE IF EXISTS Aircraft;
Create Table Aircraft (
  model text primary KEY,
  horsepower int,
  topspeed int,
  width int,
  height INT,
  weight int
  );
Drop table if EXISTS Pilot;
Create table Pilot (
  num int PRIMARY key,
  firstname text,
  surname text,
  nationality text
  birthday date,
  name text References Team(name),
  model text references Aircraft(model)
  );
Drop TABLE IF EXISTS Race;
Create TABLE Race (
  location text,
  edition text,
  country text,
  day date UNIQUE,
  gates text,
  eliminations text,
  PRIMARY KEY (location, edition)
  );
Drop table if exists Participation;
create table Participation (
  num INT REFERENCES Pilot(num),
  location text,
  edition text,
  trainingtime int CHECK(trainingtime > 0),
  trainingpos int check(trainingpos >= 1),
  trainingpenalty INt,
  qualificationtime int CHECK(qualificationtime > 0),
  qualificationpos int check(qualificationpos >= 1),
  qualificationpenalty INt,
  eliminationtime int CHECK(eliminationtime > 0),
  eliminationpos int check(eliminationpos >= 1),
  eliminationpenalty INt,
  Foreign key (location, edition) References Race(location, edition),
  PRIMARY Key(num, location, edition)
  );
DROP TABLE if EXISTS Duel;
CREATE table Duel (
  numpilot1 INt REFERENCES Pilot(num),
  numpilot2 int references Pilot(num),
  location text,
  edition text,
  dueltype text,
  timepilot1 int,
  timepilot2 int,
  penaltypilot1 int,
  penaltypilot2 int,
  FOREIGN KEY (location, edition) REFERENCES Race(location, edition),
  PRIMARY key (numpilot1, numpilot2, location, edition)
  );
