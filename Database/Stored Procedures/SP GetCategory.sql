USE [BikeStores]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[GetCategory]
@pnId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @cCustomErrorMessage VARCHAR(4000)

		IF ((SELECT COUNT(a.CategoryID) FROM dbo.Categories AS a WHERE a.CategoryID = @pnId) = 0)
		BEGIN
			SET @cCustomErrorMessage = 'Category with ID' + ' ' + CONVERT(VARCHAR(10), @pnId) + ' ' + 'does not exist'
			RAISERROR(@cCustomErrorMessage, 11, 1)
		END

		SELECT
			a.CategoryID
			, a. CategoryName
		FROM
			dbo.Categories AS a
		WHERE
			a.CategoryID = @pnId

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION

			DECLARE
				@cErrorMessage VARCHAR(4000)
				, @nErrorSeverity INT
				, @nErrorState INT

			SELECT
				@cErrorMessage = ERROR_MESSAGE()
				, @nErrorSeverity = ERROR_SEVERITY()
				, @nErrorState = ERROR_STATE()

			RAISERROR(@cErrorMessage, @nErrorSeverity, @nErrorState)
		END
	END CATCH
END
GO


