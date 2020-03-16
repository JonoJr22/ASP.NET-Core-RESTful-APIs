USE [BikeStores]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RemoveBrand]
@pnId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @cMessage VARCHAR(4000)

		IF ((SELECT COUNT(a.BrandID) FROM dbo.Brands AS a WHERE a.BrandID = @pnId) = 0)
		BEGIN
			SET @cMessage = 'Brand with ID' + ' ' + CONVERT(VARCHAR(10), @pnId) + ' ' + 'does not exist'
			RAISERROR(@cMessage, 11, 1)
		END

		CREATE TABLE 
			#deletedBrand (
				BrandID INT NULL
				, BrandName VARCHAR(255) NULL
			)

		INSERT INTO 
			#deletedBrand (
				BrandID
				, BrandName
			)
		SELECT
			a.BrandID
			, a.BrandName
		FROM
			dbo.Brands AS a
		WHERE
			a.BrandID = @pnId

		DELETE FROM 
			dbo.Brands 
		WHERE
			BrandID = @pnId

		SELECT
			a.BrandID
			, a.BrandName
		FROM
			#deletedBrand AS a
			
		DROP TABLE #deletedBrand
		
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