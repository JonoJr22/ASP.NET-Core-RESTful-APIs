USE [BikeStores]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[GetBrands] 
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @cCustomErrorMessage VARCHAR(4000)

		IF ((SELECT COUNT(a.BrandID) FROM Brands AS a) = 0)
		BEGIN
			SET @cCustomErrorMessage = 'No brands exist'
			RAISERROR(@cCustomErrorMessage, 11, 1)
		END

		SELECT 
			a.BrandID
			, a.BrandName
		FROM
			Brands AS a

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
		END
		
		DECLARE 
			@cErrorMessage NVARCHAR(4000)
			, @nErrorSeverity INT
			, @nErrorState INT

		SELECT 
			@cErrorMessage = ERROR_MESSAGE()
			, @nErrorSeverity = ERROR_SEVERITY()
			, @nErrorState = ERROR_STATE()

		RAISERROR(@cErrorMessage, @nErrorSeverity, @nErrorState)
	END CATCH
END
GO


