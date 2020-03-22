USE [BikeStores]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[SaveBrand] 
@pjBrand VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

			DECLARE @brandID INT
	
			INSERT INTO
				dbo.Brands
			SELECT
				BrandName
			FROM OPENJSON (@pjBrand)
			WITH (BrandName NVARCHAR(50))

			SET @brandID = SCOPE_IDENTITY()

			SELECT
				a.BrandID,
				a.BrandName
			FROM
				dbo.Brands AS a
			WHERE 
				a.BrandID = @brandID

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


