USE BikeStores;
GO

SET IDENTITY_INSERT Categories ON;  

INSERT INTO Categories(CategoryID,CategoryName) VALUES(1,'Children Bicycles')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(2,'Comfort Bicycles')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(3,'Cruisers Bicycles')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(4,'Cyclocross Bicycles')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(5,'Electric Bikes')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(6,'Mountain Bikes')
INSERT INTO Categories(CategoryID,CategoryName) VALUES(7,'Road Bikes')

SET IDENTITY_INSERT Categories OFF; 