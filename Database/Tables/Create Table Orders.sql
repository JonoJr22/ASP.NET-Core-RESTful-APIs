USE BikeStores
GO

CREATE TABLE Orders (
	OrderID INT IDENTITY (1, 1) PRIMARY KEY,
	CustomerID INT,
	OrderStatus tinyint NOT NULL,
	OrderDate DATE NOT NULL,
	RequiredDate DATE NOT NULL,
	ShippedDate DATE,
	StoreID INT NOT NULL,
	StaffID INT NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (StoreID) REFERENCES Stores (StoreID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (StaffID) REFERENCES Staffs (StaffID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*
	OrderStatus: 
		1 = Pending; 
		2 = Processing; 
		3 = Rejected; 
		4 = Completed
*/
