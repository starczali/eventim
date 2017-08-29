
--REFRESH
--tables
DROP table if exists ticket;
DROP TABLE if exists event_artist;
DROP TABLE if exists "event";
DROP TABLE if exists artist;
DROP table if exists category;
DROP TABLE if exists temporaryUsers;
DROP TABLE if exists users;

--sequences
drop sequence if exists ticket_seq;
drop sequence if exists event_seq;
drop sequence if exists artist_seq;
DROP SEQUENCE if exists category_seq;
DROP SEQUENCE if EXISTS temporary_seq;
drop sequence if exists user_seq;
DROP SEQUENCE if EXISTS barcode_seq;


--Create
--sequences
create sequence user_seq start 1;
CREATE SEQUENCE temporary_seq START 1;
CREATE SEQUENCE category_seq START 1;
create sequence artist_seq start 1;
CREATE SEQUENCE event_seq START 1;
create sequence ticket_seq START 1;
create SEQUENCE barcode_seq START 56734986734;


--tables
CREATE TABLE users(
  id Integer Primary KEY default nextval('user_seq'),
  name varchar(250) NOT NULL,
  password varchar(250) NOT NULL,
  email VARCHAR(250) NOT NULL ,
  type varchar(10) NOT NULL
);

CREATE TABLE temporaryUsers(
  id Integer Primary KEY default nextval('temporary_seq'),
  name varchar(250) NOT NULL,
  password varchar(250) NOT NULL,
  email VARCHAR(250) NOT NULL,
  type varchar(10) NOT NULL,
  registered BOOLEAN DEFAULT FALSE
);

CREATE TABLE category (
  id   INTEGER DEFAULT NEXTVAL('category_seq')    PRIMARY KEY,   --not null & unique
  type   VARCHAR(100) NOT NULL);   --type of event

CREATE TABLE artist(
  id Integer PRIMARY KEY default nextval('artist_seq'),
  "image" bytea,
  name VARCHAR(1000) NOT NULL
);

CREATE TABLE "event" (
  "id" int PRIMARY KEY DEFAULT NEXTVAL('event_seq'),
  "name" VARCHAR(250) DEFAULT NULL,
  "location" VARCHAR(250) DEFAULT NULL,
  "startdate" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'EET'),
  "enddate" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'EET'),
  "image" bytea,
  "category_id" int,
  "price" FLOAT default 0);
ALTER TABLE "event" ADD CONSTRAINT categoryForeignKey FOREIGN KEY(category_id) REFERENCES category(id) on update cascade on delete set null;

CREATE TABLE event_artist(
  eventid Integer NOT NULL,
  artistid Integer NOT NULL,
  PRIMARY KEY(eventid, artistid),
  FOREIGN KEY (eventid) REFERENCES event (id) on delete cascade on update cascade,
  FOREIGN KEY (artistid) REFERENCES artist (id));

create table ticket
(id int primary key default NEXTVAL('ticket_seq'),
 userId int not NULL references users(ID)  on update cascade on delete cascade,
 eventId int not NULL references "event"(ID) match simple on update cascade on delete cascade,
 barCode bigint);



--Inserts
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Sava', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'admin');
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Salajan', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'normal');
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Bogdan', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'admin');
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Petra', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'admin');
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Gabriel', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'admin');
INSERT INTO public.users(
  name, password, email, type)
VALUES ('Gellert', 'ch@ng3m3', 'bogdanmorariu96@gmail.com', 'admin');

INSERT INTO public.category(type)
VALUES
  ('THEATRE'),
  ('MUSIC'),
  ('DANCE');

INSERT INTO public.artist(name)
VALUES ('Franz Ferdinand');
INSERT INTO public.artist(name)
VALUES ('Ricky Martin');
INSERT INTO public.artist(name)
VALUES ('David Guetta');

INSERT INTO "event"("name","location","startdate","enddate","image","category_id","price") VALUES('testName1','testLoc1','2017-08-01 13:15:00 EET','2017-08-01 15:15:00 EET',null,1,20.7);
INSERT INTO "event"("name","location","startdate","enddate","image","category_id","price") VALUES('testName2','testLoc2','2016-08-01 13:15:00 EET','2016-08-01 15:15:00 EET',null,2,40);
INSERT INTO "event"("name","location","startdate","enddate","image","category_id","price") VALUES('testName3','testLoc3','2015-08-01 13:15:00 EET','2015-08-01 15:15:00 EET',null,3,0.3);

insert into ticket(userId,eventId,barCode) values(1,1,7812465646);
insert into ticket(userId,eventId,barCode) values(2,2,7817578299);
insert into ticket(userId,eventId,barCode) values(2,2,7817918299);

INSERT INTO public.event_artist(eventid, artistid)
VALUES (1,1), (2,2)


