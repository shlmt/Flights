
CREATE DATABASE Flights_DB

USE Flights_DB

CREATE TABLE AirLines_tbl
(
	AirLineCode smallint identity(1, 1) primary key,
	AirLineName varchar(20) unique
)
GO

CREATE TABLE Planes_tbl
(
	PlaneCode int identity(100, 1) primary key,
	AirLineCode smallint references AirLines_tbl,
	NumberOfSeats int default 300
)
GO


CREATE TABLE Destination_tbl
(
	DestinationCode int identity(100, 1) primary key,
	Destination varchar(20) unique NOT NULL
)
GO

CREATE TABLE Flights_tbl
(
	FlightCode varchar(10) primary key,
	PlaneCode int references Planes_tbl,
	DestinationCode int references Destination_tbl,
	TicketPrice money,
	FlightDate date,
	ContinueFlight varchar(10)
)
GO

CREATE TABLE Passengers_tbl
(
	PassengerCode int identity(100,1) primary key,
	FirstName varchar(10),
	LastName varchar(10),
	Phone varchar(10) check(len(Phone)=10)
)
GO

CREATE TABLE OrderTicket_tbl
(
	OrderCode int identity(100,1) primary key,
	FlightCode varchar(10) references Flights_tbl,
	PassengerCode int references Passengers_tbl,
	OrderDate date default GETDATE(),
	SeatNum int
)
GO

---------------------------------------------------------------------------------------------

SELECT *
FROM AirLines_tbl
SELECT *
FROM Planes_tbl
SELECT *
FROM Destination_tbl
SELECT *
FROM Flights_tbl
SELECT *
FROM Passengers_tbl
SELECT *
FROM OrderTicket_tbl

---------------------------------------------------------------------------------------------

--טריגרים
CREATE TRIGGER Shabbos_trigger ON Flights_tbl
FOR INSERT, UPDATE
	AS
		BEGIN
			DECLARE @Date DATE
			DECLARE @Day varchar(10)
			SELECT @Date =  FlightDate FROM inserted
			SELECT @Day = DATENAME(DW, @Date)
			IF @Day = 'saturday'
				BEGIN
					UPDATE Flights_tbl
					SET FlightDate = DATEADD(DD,1, @Date)
					FROM Flights_tbl f JOIN inserted i ON f.FlightCode=i.FlightCode
				END
			IF @Day = 'friday'
				BEGIN
					UPDATE Flights_tbl SET FlightDate = DATEADD(dd,2, @Date) 
					FROM Flights_tbl f JOIN inserted i ON f.FlightCode=i.FlightCode
				END
		END
GO

CREATE TRIGGER seat_trigger ON OrderTicket_tbl
FOR INSERT, UPDATE
	AS
		BEGIN
			DECLARE @SeatNum int
			DECLARE @MaxSeat int
			SELECT @SeatNum = SeatNum FROM inserted 
			SELECT @MaxSeat = p.NumberOfSeats
							  FROM (Planes_tbl p JOIN Flights_tbl f ON p.PlaneCode=f.PlaneCode) JOIN OrderTicket_tbl o ON f.FlightCode = o.FlightCode JOIN inserted i ON i.OrderCode = o.OrderCode
			IF @SeatNum>@MaxSeat
					ROLLBACK
			END
GO

--טריגר שלא יזמינו טיסה שכבר היתה
CREATE TRIGGER date_trigger ON OrderTicket_tbl
FOR INSERT, UPDATE
	AS
		BEGIN
			DECLARE @flightdate date
			SELECT @flightdate = f.flightdate FROM Flights_tbl f JOIN inserted i ON f.FlightCode=i.FlightCode
			DECLARE @OrderDate date
			SELECT @OrderDate = i.OrderDate FROM Flights_tbl f JOIN inserted i ON f.FlightCode=i.FlightCode
			if @flightdate<@OrderDate
					ROLLBACK
			END
GO

---------------------------------------------------------------------------------------------

--view
CREATE VIEW FlightsDetailsByOrders
AS
	SELECT o.OrderCode ,p.LastName+' '+p.FirstName as FullName, o.FlightCode, f.FlightDate, d.Destination, a.AirLineName, o.SeatNum
	FROM OrderTicket_tbl o JOIN Passengers_tbl p ON o.PassengerCode=p.PassengerCode JOIN Flights_tbl f ON o.FlightCode=f.FlightCode JOIN Destination_tbl d ON f.DestinationCode=d.DestinationCode JOIN Planes_tbl pl ON pl.PlaneCode=f.PlaneCode JOIN AirLines_tbl a ON pl.AirLineCode=a.AirLineCode
GO

SELECT *
FROM FlightsDetailsByOrders
WHERE Destination = 'אמסטרדם'


CREATE VIEW SumPlanesOfAirLines
AS
	SELECT AirLineName, CASE 
							WHEN COUNT(*) = 1 THEN 'SMALL'
							WHEN COUNT(*) BETWEEN 2 AND 3 THEN 'MEDIUM'
							WHEN COUNT(*)>3 THEN 'BIG'
						END as CompanySize
	FROM AirLines_tbl a JOIN Planes_tbl p ON a.AirLineCode=p.AirLineCode
	GROUP BY a.AirLineCode, a.AirLineName
GO

SELECT *
FROM SumPlanesOfAirLines
