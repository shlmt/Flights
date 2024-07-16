--AirLines_tbl
INSERT INTO AirLines_tbl VALUES ('ElAl')
INSERT INTO AirLines_tbl VALUES ('British Airways')
INSERT INTO AirLines_tbl VALUES ('Delta')
INSERT INTO AirLines_tbl VALUES ('Wizz Air')
INSERT INTO AirLines_tbl VALUES ('United Airlines')
INSERT INTO AirLines_tbl VALUES ('Easy Jet')
INSERT INTO AirLines_tbl VALUES ('Lufthansa')
INSERT INTO AirLines_tbl VALUES ('Israir')

--Planes_tbl
INSERT INTO Planes_tbl VALUES (1, 282)
INSERT INTO Planes_tbl VALUES (1, 320)
INSERT INTO Planes_tbl VALUES (1, 250)
INSERT INTO Planes_tbl VALUES (2, 238)
INSERT INTO Planes_tbl VALUES (2, 285)
INSERT INTO Planes_tbl VALUES (3, 175)
INSERT INTO Planes_tbl VALUES (3, 190)
INSERT INTO Planes_tbl VALUES (4, 271)
INSERT INTO Planes_tbl VALUES (4, 362)
INSERT INTO Planes_tbl VALUES (5, 660)
INSERT INTO Planes_tbl VALUES (6, 166)
INSERT INTO Planes_tbl VALUES (7, 279)

--Destination_tbl
INSERT INTO Destination_tbl VALUES ('בודפשט')
INSERT INTO Destination_tbl VALUES ('דובאי')
INSERT INTO Destination_tbl VALUES ('אילת')
INSERT INTO Destination_tbl VALUES ('אמסטרדם')
INSERT INTO Destination_tbl VALUES ('לונדון')
INSERT INTO Destination_tbl VALUES ('וינה')
INSERT INTO Destination_tbl VALUES ('פריז')
INSERT INTO Destination_tbl VALUES ('ברלין')
INSERT INTO Destination_tbl VALUES ('ניו יורק')
INSERT INTO Destination_tbl VALUES ('פלורידה')
INSERT INTO Destination_tbl VALUES ('קפריסין')

--Flights_tbl 
INSERT INTO Flights_tbl
VALUES('BA165', 105, 107, 398, '02/01/2023', 'LY324')

INSERT INTO Flights_tbl
VALUES('W62811', 100, 102, 224, '09/02/2023', NULL)

INSERT INTO Flights_tbl
VALUES('LAUN125X', 107, 103, 246, '01/25/2023', 'LY324')

INSERT INTO Flights_tbl
VALUES('6H664', 101, 101, 156, '03/16/2023', NULL)

INSERT INTO Flights_tbl
VALUES('LY324', 103, 106, 196, '06/15/2023', NULL)

INSERT INTO Flights_tbl
VALUES('VA9240', 102, 108, 828, '05/12/2023', NULL)

INSERT INTO Flights_tbl
VALUES('EZY1827', 106, 105, 457, '12/17/2022', 'LAUN125X')

INSERT INTO Flights_tbl
VALUES('BA458C',103,103,326,'03/01/2023',NULL)

INSERT INTO Flights_tbl
VALUES('W4719',108, 110, 76, '12/29/2022', NULL)

INSERT INTO Flights_tbl
VALUES('BA135Z',105, 104, 308, '01/12/2023', 'UA6540')

INSERT INTO Flights_tbl
VALUES('UA6540',106, 109, 470, '01/12/2023', NULL)


--Passengers_tbl
INSERT INTO Passengers_tbl
VALUES('תמר','מילר', '0583288976')

INSERT INTO Passengers_tbl
VALUES('דוד','רובינזון', '0587514952')

INSERT INTO Passengers_tbl
VALUES('רוברט','פרנק', '0524816855')

INSERT INTO Passengers_tbl
VALUES('גון','גולד', '0586261268')

INSERT INTO Passengers_tbl
VALUES('דני','גרין', '0583278197')

INSERT INTO Passengers_tbl
VALUES('חנה','בראון', '0586428318')

INSERT INTO Passengers_tbl
VALUES('עליזה','שחור', '0527643342')

INSERT INTO Passengers_tbl
VALUES('מוחמד','אבו חליל', NULL)

--OrderTicket_tbl
INSERT INTO OrderTicket_tbl
VALUES('BA458C' ,100, '01/01/2023', 10)

INSERT INTO OrderTicket_tbl
VALUES('BA135Z' ,101, '12/11/2022', 150)

INSERT INTO OrderTicket_tbl
VALUES('UA6540' ,101, '12/11/2022', 67)

INSERT INTO OrderTicket_tbl
VALUES('LY324' ,102, '04/27/2023', 238)

INSERT INTO OrderTicket_tbl
VALUES('BA135Z' ,103, '12/29/2022', 68)

INSERT INTO OrderTicket_tbl
VALUES('w62811' ,104, '08/03/2023', 184)

INSERT INTO OrderTicket_tbl
VALUES('6H664' ,105, '03/16/2022', 223)

INSERT INTO OrderTicket_tbl
VALUES('LAUN125X' ,106, '01/24/2023', 171)

INSERT INTO OrderTicket_tbl
VALUES('LY324' ,107, '04/15/2023', 52)

INSERT INTO OrderTicket_tbl
VALUES('LY324' ,108, '04/15/2023', 53)

INSERT INTO OrderTicket_tbl
VALUES('6H664' ,109, '03/01/2023',298)


SELECT d.Destination, f.FlightCode,*
FROM Destination_tbl d JOIN Flights_tbl f ON f.DestinationCode = d.DestinationCode

