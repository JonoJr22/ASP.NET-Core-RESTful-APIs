USE [BikeStores]
GO

CREATE PROCEDURE [dbo].[GetBrands] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		a.BrandID,
		a.BrandName
	FROM
		Brands AS a
END
GO


