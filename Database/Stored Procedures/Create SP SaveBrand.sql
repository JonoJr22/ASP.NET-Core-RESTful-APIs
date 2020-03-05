USE [BikeStores]
GO
/****** Object:  StoredProcedure [dbo].[SaveBrand]    Script Date: 3/5/2020 9:20:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBrand] 
@pjBrand VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brandID INT

	INSERT INTO
		dbo.Brands
	SELECT
		BrandName
	FROM OPENJSON (@pjBrand)
	WITH (BrandName NVARCHAR(255))

	SET @brandID = SCOPE_IDENTITY()

	SELECT
		a.BrandID,
		a.BrandName
	FROM
		dbo.Brands a
	WHERE 
		a.BrandID = @brandID

END
