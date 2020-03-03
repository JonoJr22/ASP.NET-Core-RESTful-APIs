USE BikeStores
GO

CREATE TABLE Categories (
	CategoryID INT IDENTITY (1, 1) PRIMARY KEY,
	CategoryName VARCHAR (255) NOT NULL
);