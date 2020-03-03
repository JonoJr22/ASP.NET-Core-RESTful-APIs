USE BikeStores;
GO 

SET IDENTITY_INSERT Staffs ON;  

INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(1,'Fabiola','Jackson','fabiola.jackson@bikes.shop','(831) 555-5554',1,1,NULL);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(2,'Mireya','Copeland','mireya.copeland@bikes.shop','(831) 555-5555',1,1,1);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(3,'Genna','Serrano','genna.serrano@bikes.shop','(831) 555-5556',1,1,2);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(4,'Virgie','Wiggins','virgie.wiggins@bikes.shop','(831) 555-5557',1,1,2);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(5,'Jannette','David','jannette.david@bikes.shop','(516) 379-4444',1,2,1);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(6,'Marcelene','Boyer','marcelene.boyer@bikes.shop','(516) 379-4445',1,2,5);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(7,'Venita','Daniel','venita.daniel@bikes.shop','(516) 379-4446',1,2,5);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(8,'Kali','Vargas','kali.vargas@bikes.shop','(972) 530-5555',1,3,1);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(9,'Layla','Terrell','layla.terrell@bikes.shop','(972) 530-5556',1,3,7);
INSERT INTO Staffs(StaffID, FirstName, LastName, Email, Phone, Active, StoreID, ManagerID) VALUES(10,'Bernardine','Houston','bernardine.houston@bikes.shop','(972) 530-5557',1,3,7);

SET IDENTITY_INSERT Staffs OFF; 