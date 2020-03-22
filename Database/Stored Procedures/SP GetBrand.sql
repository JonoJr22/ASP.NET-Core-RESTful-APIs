USE [BikeStores]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[GetBrand]
@pnId INT
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRANSACTION
	
		DECLARE @cCustomErrorMessage VARCHAR(4000)

		IF ((SELECT COUNT(a.BrandID) FROM dbo.Brands AS a WHERE a.BrandID = @pnId) = 0)
		BEGIN
			SET @cCustomErrorMessage = 'Brand with ID' + ' ' + CONVERT(VARCHAR(10), @pnId) + ' ' + 'does not exist'
			RAISERROR(@cCustomErrorMessage, 11, 1)
		END

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
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
		END

		DECLARE 
			@cErrorMessage VARCHAR(4000)
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


