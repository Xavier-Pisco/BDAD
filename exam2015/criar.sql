PRAGMA foreign_keys = ON;

/* Delete the tables if they already exist */
drop table if exists Likes;
drop table if exists AppearsIn;
drop table if exists Friend;
drop table if exists Photo;
drop table if exists User;

/* Create the schema for our tables */
create table Photo(
    id int PRIMARY KEY, 
    caption text, 
    creationDate date, 
    uploadDate date, 
    user int REFERENCES User(id)
);
create table User(
    id int PRIMARY KEY, 
    name text
);
create table Likes(
    user int REFERENCES User(id), 
    photo int REFERENCES Photo(id) ON DELETE CASCADE, 
    PRIMARY KEY (user, photo)
);
create table AppearsIn(
    user int REFERENCES User(id), 
    photo int REFERENCES Photo(id) ON DELETE CASCADE, 
    PRIMARY KEY (user, photo)
);
create table Friend(
    user1 int REFERENCES User(id), 
    user2 int REFERENCES User(id), 
    PRIMARY KEY (user1, user2)
);

/* Populate the tables with our data */
insert into User values(1, 'Daniel Ramos');
insert into User values(2, 'Catarina Oliveira');
insert into User values(3, 'Manuel Pinto');
insert into User values(4, 'Jorge Rodrigues ');
insert into User values(5, 'Miguel Ferreira ');
insert into User values(6, 'Nuno Reis');
insert into User values(7, 'Pedro Ponte');
insert into User values(8, 'Augusto Cortez');

insert into Photo values(1, 'Lightning!', '2015-06-13', '2015-06-15', 1);
insert into Photo values(2, 'Milky Way', '2015-05-13', '2015-06-27', 1);
insert into Photo values(3, 'The stillness of the Escalante', '2014-06-03', '2015-06-27', 1);
insert into Photo values(4, 'Marco Polo Dog Style', '2009-01-01', '2009-06-27', 1);
insert into Photo values(5, 'Unfolding', '2012-01-26', '2015-06-27', 1);
insert into Photo values(6, 'Misty Mountain Hop', '2008-08-07', '2015-06-27', 1);
insert into Photo values(7, 'dance with me in the morning sun', '2015-06-01', '2015-06-27', 1);
insert into Photo values(8, 'The Silence of Dusk', '2015-06-23', '2015-06-27', 1);
insert into Photo values(9, 'What?', '2015-06-23', '2015-06-27', 1);

insert into Likes values(1, 1);
insert into Likes values(2, 6);
insert into Likes values(3, 3);
insert into Likes values(3, 8);
insert into Likes values(4, 1);
insert into Likes values(5, 3);
insert into Likes values(5, 4);
insert into Likes values(5, 8);
insert into Likes values(6, 7);
insert into Likes values(6, 6);
insert into Likes values(7, 7);
insert into Likes values(8, 4);
insert into Likes values(3, 1);
insert into Likes values(3, 2);
insert into Likes values(3, 4);
insert into Likes values(3, 5);
insert into Likes values(3, 6);
insert into Likes values(3, 7);
insert into Likes values(3, 9);
insert into Likes values(4, 4);
insert into Likes values(4, 5);
insert into Likes values(4, 6);
insert into Likes values(4, 7);
insert into Likes values(4, 9);

insert into AppearsIn values(1, 1);
insert into AppearsIn values(2, 6);
insert into AppearsIn values(3, 3);
insert into AppearsIn values(3, 8);
insert into AppearsIn values(4, 1);
insert into AppearsIn values(5, 3);
insert into AppearsIn values(5, 8);
insert into AppearsIn values(6, 7);
insert into AppearsIn values(6, 6);
insert into AppearsIn values(7, 7);
insert into AppearsIn values(8, 4);
insert into AppearsIn values(3, 1);
insert into AppearsIn values(3, 2);
insert into AppearsIn values(3, 5);
insert into AppearsIn values(3, 6);
insert into AppearsIn values(8, 6);
insert into AppearsIn values(3, 7);
insert into AppearsIn values(3, 9);


insert into Friend values(2, 6);
insert into Friend values(6, 2);
insert into Friend values(5, 3);
insert into Friend values(3, 5);
insert into Friend values(5, 4);
insert into Friend values(4, 5);
insert into Friend values(5, 8);
insert into Friend values(8, 5);
insert into Friend values(6, 7);
insert into Friend values(7, 6);
insert into Friend values(8, 4);
insert into Friend values(4, 8);
insert into Friend values(3, 1);
insert into Friend values(1, 3);
insert into Friend values(3, 2);
insert into Friend values(2, 3);
insert into Friend values(3, 4);
insert into Friend values(4, 3);
insert into Friend values(3, 6);
insert into Friend values(6, 3);
insert into Friend values(3, 7);
insert into Friend values(7, 3);


-- Pergunta 14
/*
Select Photo.caption
From User, Photo on User.id = Photo.user
Where User.name LIKE "Daniel Ramos" and julianday(Photo.uploadDate) = julianday(Photo.creationDate) + 2;
*/

-- Pergunta 15
/*
Select name
From User
Where User.id not in(
    Select Photo.user
    From Photo
);
*/

-- Pergunta 16
/*
Select avg(C) From (
    Select Likes.photo as likesPhoto
    From Likes
    Group by Likes.photo
    Having count(*) > 3
),  (
    Select count(*) as C, AppearsIn.photo as appearsInPhoto
    From AppearsIn
    Group by AppearsIn.photo
) on likesPhoto = appearsInPhoto;
*/

-- Pergunta 17
/*
drop view if exists DRFriends;

create view DRFriends as
Select U1.id as user
From User as U1, Friend as F1 on U1.id = F1.user1, 
    User as U2 on U2.id = F1.user2, Friend as F2 on U2.id = F2.user1,
    User as U3 on U3.id = F2.user2 
Where U1.name LIKE "Daniel Ramos" or U2.name Like "Daniel Ramos" or U3.name LIKE "Daniel Ramos";


Select Distinct caption
From Photo, AppearsIn on AppearsIn.photo = Photo.id, DRFriends on AppearsIn.user = DRFriends.user;
*/

-- Pergunta 18
/*
drop view if exists lessThan2Users;

create View lessThan2Users as 
Select AppearsIn.photo as photoId
From AppearsIn
Group by photo
Having count(*) < 2;

delete from Photo
where julianday(uploadDate) < 2455197.5 and Photo.id in lessThan2Users ;
*/

-- Pergunta 19
/*
drop trigger if exists autoLike;

create trigger autoLike
After insert on AppearsIn
Begin
    insert into Likes values (New.user, New.photo);
End;
*/


