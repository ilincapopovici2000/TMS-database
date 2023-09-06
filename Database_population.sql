CREATE DATABASE Practica

CREATE SCHEMA practica;

USE practica

--Users table

GO
BEGIN TRANSACTION
CREATE TABLE practica.Users(
	userID INT IDENTITY(1,1) PRIMARY KEY,
	userName VARCHAR(50),
	email VARCHAR(50) UNIQUE);
COMMIT TRANSACTION;

--Venues table

GO
BEGIN TRANSACTION
CREATE TABLE practica.Venues(
	venueID INT IDENTITY(1,1) PRIMARY KEY,
	venueLocation VARCHAR(50),
	venueType VARCHAR(50),
	capacity int);
COMMIT TRANSACTION;

--EventTypes table

GO
BEGIN TRANSACTION
CREATE TABLE practica.EventTypes(
	eventTypeID INT IDENTITY(1,1) PRIMARY KEY,
	eventTypeName VARCHAR(50));
COMMIT TRANSACTION;

--Event table

GO
BEGIN TRANSACTION
CREATE TABLE practica.Events(
	eventID INT IDENTITY(1,1) PRIMARY KEY,
	venueID int,
	eventTypeID int,
	eventName VARCHAR(50),
	startDate DATETIME,
	endDate DATETIME,
	eventDescription VARCHAR(50),
	CONSTRAINT FK_event_venue FOREIGN KEY (venueID) REFERENCES practica.Venues(venueID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_event_eventType FOREIGN KEY (eventTypeID) REFERENCES practica.EventTypes(eventTypeID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);
COMMIT TRANSACTION;

--TicketCategory table

GO
BEGIN TRANSACTION
CREATE TABLE practica.TicketCategories(
	ticketCategoryID INT IDENTITY(1,1) PRIMARY KEY,
	eventID int,
	price DECIMAL(10, 2),
	description VARCHAR(50),
	CONSTRAINT FK_ticketCategory_event FOREIGN KEY (eventID) REFERENCES practica.Events(eventID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);
COMMIT TRANSACTION;

--Orders table

GO
BEGIN TRANSACTION
CREATE TABLE practica.Orders(
	orderID INT IDENTITY(1,1) PRIMARY KEY,
	userID int,
	ticketCategoryID int,
	orderedAt datetime,
	numberOfTickets int,
	totalPrice DECIMAL(10, 2),
	CONSTRAINT FK_order_ticketCategory FOREIGN KEY (ticketCategoryID) REFERENCES practica.TicketCategories(ticketCategoryID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_order_user FOREIGN KEY (userID) REFERENCES practica.Users(userID)
	ON DELETE CASCADE
	ON UPDATE CASCADE);
COMMIT TRANSACTION;

--drop constraints

ALTER TABLE practica.Orders
DROP CONSTRAINT FK_order_user;

ALTER TABLE practica.Orders
DROP CONSTRAINT FK_order_ticketCategory;

ALTER TABLE practica.Events
DROP CONSTRAINT FK_event_venue;

ALTER TABLE practica.Events
DROP CONSTRAINT FK_event_eventType;

ALTER TABLE practica.TicketCategories
DROP CONSTRAINT FK_ticketCategory_event;

--drop tables

DROP TABLE practica.Users;
DROP TABLE practica.Orders;
DROP TABLE practica.Venues;
DROP TABLE practica.Events;
DROP TABLE practica.TicketCategories;
DROP TABLE practica.EventTypes;

--populate Users

INSERT INTO practica.Users (userName, email) VALUES ('Pop Adrian', 'pop_adrian@gmail.com');
INSERT INTO practica.Users (userName, email) VALUES ('Popescu Mirela', 'popescu_mirela@gmail.com');
INSERT INTO practica.Users (userName, email) VALUES ('Ursu Gabriel', 'gabriel_ursu@gmail.com');
INSERT INTO practica.Users (userName, email) VALUES ('Alexe Alexandru', 'alex_alexe@gmail.com');
INSERT INTO practica.Users (userName, email) VALUES ('Ducu Alexandra', 'alexandra_ducu@gmail.com');
INSERT INTO practica.Users (userName, email) VALUES ('Irimescu Adina', 'adina_irimescu@gmail.com');

SELECT * FROM practica.Users;

--populate Venues

INSERT INTO practica.Venues (venueLocation, venueType, capacity) VALUES ('Aleea Stadionului 2, Cluj-Napoca', 'Stadion', 1000);
INSERT INTO practica.Venues (venueLocation, venueType, capacity) VALUES ('Bontida Castle, Cluj-Napoca', 'Castle', 4000);
INSERT INTO practica.Venues (venueLocation, venueType, capacity) VALUES ('Central Park, Cluj-Napoca', 'Park', 3000);
INSERT INTO practica.Venues (venueLocation, venueType, capacity) VALUES ('Intre Lacuri, Cluj-Napoca', 'Park', 1000);

SELECT * FROM practica.Venues;

--populate EventTypes
INSERT INTO practica.EventTypes (eventTypeName) VALUES ('Festival de Muzica');
INSERT INTO practica.EventTypes (eventTypeName) VALUES ('Sport');
INSERT INTO practica.EventTypes (eventTypeName) VALUES ('Bauturi');

SELECT * FROM practica.EventTypes;

--populate Events

INSERT INTO practica.Events (venueID, eventTypeID, eventName, startDate, endDate, eventDescription) VALUES (1, 1, 'Untold', '2023-03-08 00:00:00.000', '2023-06-08 00:00:00.000', 'Muzica Electronica si nu numai');
INSERT INTO practica.Events (venueID, eventTypeID, eventName, startDate, endDate, eventDescription) VALUES (2, 1, 'Electric Castle', '1894-06-30 00:00:00.000', '1894-07-04 00:00:00.000', 'Muzica Electronica si nu numai');
INSERT INTO practica.Events (venueID, eventTypeID, eventName, startDate, endDate, eventDescription) VALUES (1, 2, 'Meci de fotbal', '1894-06-30 00:00:00.000', '1894-06-30 00:00:00.000', 'Fotbal');
INSERT INTO practica.Events (venueID, eventTypeID, eventName, startDate, endDate, eventDescription) VALUES (3, 3, 'Wine Festival', '1894-06-18 00:00:00.000', '1894-06-21 00:00:00.000', 'Festival de vin');

SELECT * FROM practica.Events;

--populate TicketCategories

INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (1, 800, 'Standard');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (2, 700, 'Standard');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (3, 300, 'Standard');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (4, 70, 'Standard');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (1, 1500, 'VIP');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (2, 1200, 'VIP');
INSERT INTO practica.TicketCategories (eventID, price, description) VALUES (3, 600, 'VIP');

SELECT * FROM practica.TicketCategories;

--populate Orders

INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (1, 1, '1894-06-16 00:00:00.000', 2, 1600);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (2, 2, '1894-07-07 00:00:00.000', 3, 2100);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (3, 2, '1894-07-07 00:00:00.000', 2, 1400);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (3, 4, '1894-07-01 00:00:00.000', 4, 280);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (4, 5, '1894-07-05 00:00:00.000', 2, 3000);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (4, 6, '1894-07-07 00:00:00.000', 2, 2400);
INSERT INTO practica.Orders (userID, ticketCategoryID, orderedAt, numberOfTickets, totalPrice) VALUES (5, 4, '1894-06-21 00:00:00.000', 5, 350);

SELECT * FROM practica.Orders;

--3. Modificati campul ‘location’ din tabela ‘venue’ astfel incat sa aiba tipul varchar(30) in loc de varchar (50). 
--Procedati la fel pentru campurile ‘description’ din ‘ticket_category’ si ‘email’ din ‘users’.

ALTER TABLE practica.Venues
ALTER COLUMN venueLocation VARCHAR(70);

ALTER TABLE practica.TicketCategories
ALTER COLUMN description VARCHAR(70);

ALTER TABLE practica.Users
ALTER COLUMN email VARCHAR(70);

--4. Modificati tabela ‘users’ prin adaugarea unei noi coloane numite ‘password’ de tipul varchar(20). 
--Inserati doua noi randuri in aceasta tabela completand si campul ‘password’. Ulterior, stergeti unul din randurile adaugate si renuntati la campul ‘password’.

ALTER TABLE practica.Users
ADD password VARCHAR(20);

INSERT INTO practica.Users (userName, email, password) VALUES ('Popa Ioana', 'popa_ioana@gmail.com', 'po23pa_io');
INSERT INTO practica.Users (userName, email, password) VALUES ('Chis Sebastian', 'chis_sebastian@gmail.com', 'chis098seba');

SELECT * FROM practica.Users 

DELETE FROM practica.Users WHERE userName='Popa Ioana';

ALTER TABLE practica.Users
DROP COLUMN password;

--5. Cresteti capacitatea locatiei de tip ‘Stadion’ din tabela venue la 2000.

UPDATE practica.Venues
SET capacity = 2000
WHERE venueType = 'Stadion';

SELECT * FROM practica.Venues; 

--6. Creati un view numit ‘total_number_of_tickets_per_category’ care sa contina 
--atât suma biletelor vandute cat si valoarea totala a vanzarilor pe fiecare categorie de bilete. 
--View ul trebuie sa contina campurile ticket_category_id si cele doua sume.

CREATE VIEW practica.total_number_of_tickets_per_category
AS SELECT ticketCategoryID, SUM(numberOfTickets) AS sumOfSoldTickets, SUM(totalPrice) AS total_value
FROM practica.Orders
GROUP BY ticketCategoryID;

DROP VIEW practica.total_number_of_tickets_per_category;

SELECT * FROM practica.total_number_of_tickets_per_category;
SELECT * FROM practica.Orders;
SELECT * FROM practica.TicketCategories;

--7. Calculati moving average pentru total_price din ‘orders’ pentru fiecare categorie de bilete.

SELECT ticketCategoryID, AVG(totalPrice) AS total_value
FROM practica.Orders
GROUP BY ticketCategoryID;

SELECT * FROM practica.Orders;
SELECT * FROM practica.TicketCategories;

--8. Afisati numarul de bilete vandute cat si pretul total pentru fiecare categorie 
--de bilet pentru care au existat bilete comandate. 
--Afisati si descrierea fiecarei categorii de bilete.

SELECT o.ticketCategoryID, SUM(o.numberOfTickets) AS sum_of_sold_tickets, SUM(o.totalPrice) AS total_value, tc.description
FROM practica.Orders o 
INNER JOIN practica.TicketCategories tc 
ON o.ticketCategoryID = tc.ticketCategoryID
GROUP BY o.ticketCategoryID, tc.description;

--9. Repetati exercitiul de la punctul 8 numai ca afisati si categoriile de bilete impreuna cu descrierea lor
--si pentru categoriile pentru care nu au existat comenzi.

SELECT tc.ticketCategoryID, SUM(o.numberOfTickets) AS sum_of_sold_tickets, SUM(o.totalPrice) AS total_value, tc.description
FROM practica.Orders o 
RIGHT OUTER JOIN practica.TicketCategories tc 
ON o.ticketCategoryID = tc.ticketCategoryID
GROUP BY tc.ticketCategoryID, tc.description;

--10. Calculati suma biletelor vandute si a pretului total de vanzare pentru fiecare categorie de bilet 
--pentru fiecare eveniment in parte.

SELECT e.eventID, e.eventName, tc.TicketCategoryID, SUM(o.numberOfTickets) AS sumOfSoldTickets, SUM(o.totalPrice) AS totalValue
FROM practica.Orders o
INNER JOIN practica.TicketCategories tc
ON o.ticketCategoryID = tc.TicketCategoryID
INNER JOIN practica.Events e
ON tc.eventID = e.eventID
GROUP BY e.eventID, e.eventName, tc.TicketCategoryID;