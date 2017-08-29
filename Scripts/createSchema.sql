
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
