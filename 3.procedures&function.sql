--פרוצדורות
CREATE PROCEDURE insertPassenger(@firstName varchar(10), @lastName varchar(10), @phone varchar(10))
AS
BEGIN
	insert into Passengers_tbl
	values(@firstName,@lastName,@phone)
END
GO

EXECUTE insertPassenger 'דונלד','טראמפ','0911111111'
GO

CREATE PROCEDURE updateFlightDate(@flightCode varchar(10), @newDate date)
AS
BEGIN
	UPDATE Flights_tbl
	SET FlightDate = @newDate
	WHERE flightCode = @flightCode
END
GO

EXEC updateFlightDate '6H664', '2023-03-17'
GO
--נהיה בDB 19-03 כי 17 יוצא בשישי

--פונקציות
--מחזירה סקלר
CREATE FUNCTION NumberOfPassengers(@flightCode varchar(10))
RETURNS int
AS
	BEGIN
		DECLARE @count int
		SELECT @count = COUNT(*)
						FROM OrderTicket_tbl
						WHERE flightCode = @flightCode
		RETURN @count
	END
GO

PRINT dbo.NumberOfPassengers('BA135Z')

--מחזירה טבלה
CREATE FUNCTION continueFlight(@flightCode varchar(10)) RETURNS TABLE
AS
		RETURN(SELECT f1.FlightCode as 'Your flight',f2.FlightCode as 'continueFlight', d.Destination, f2.TicketPrice*0.9 as 'SpasialTicketPrice', f2.FlightDate
			FROM Flights_tbl f1 JOIN Flights_tbl f2 ON f1.ContinueFlight=f2.FlightCode JOIN Destination_tbl d ON f2.DestinationCode=d.DestinationCode
			WHERE f1.FlightCode = @flightCode)
GO


SELECT *
FROM continueFlight('BA165')

--הגרלה
DECLARE @row smallint
SELECT @row = COUNT(*)
			FROM Passengers_tbl
SET @row = CAST(RAND()*@row AS INT)+1

SELECT FirstName+' '+LastName as 'fullName', Phone, CASE
									WHEN SUBSTRING(Phone,1,5) IN('05832','05276','05331', '05484', '05485') THEN 'שלח הודעה טלפונית'
									ELSE 'שלח הודעת טקסט' 
								END AS 'הודעת זכיה'
FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY passengerCode) as rowNumber  
	  FROM Passengers_tbl) q
WHERE q.rowNumber = @row
