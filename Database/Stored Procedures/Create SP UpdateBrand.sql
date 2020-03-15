USE [BikeStores]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UpdateBrand]
@pnId INT
, @pjBrand VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @cBrandName VARCHAR(50)
		DECLARE @cMessage VARCHAR(200)

		IF ((SELECT COUNT(a.BrandID) FROM dbo.Brands AS a WHERE a.BrandID = @pnId) = 0 )
		BEGIN
			SET @cMessage = 'Brand with ID' + ' ' + CONVERT(VARCHAR(10), @pnId) + ' ' + 'does not exist'
			RAISERROR(@cMessage, 11, 1)
		END

		SELECT
			@cBrandName = BrandName
		FROM OPENJSON (@pjBrand)
		WITH (BrandName VARCHAR(50))
		
		UPDATE
			a
		SET
			a.BrandName = @cBrandName
		FROM
			dbo.Brands AS a
		WHERE
			a.BrandID = @pnId

		SELECT 
			a.BrandID
			, a.BrandName
		FROM
			dbo.Brands AS a
		WHERE
			a.BrandID = @pnId
			
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
			
			DECLARE @errorMessage NVARCHAR(4000)
			DECLARE @errorSeverity INT
			DECLARE @errorState INT

			SELECT 
				@errorMessage = ERROR_MESSAGE(),
				@errorSeverity = ERROR_SEVERITY(),
				@errorState = ERROR_STATE()

			RAISERROR(@errorMessage, @errorSeverity, @errorState)
	END CATCH
END