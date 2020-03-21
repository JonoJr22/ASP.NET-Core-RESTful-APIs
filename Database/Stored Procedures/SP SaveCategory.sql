USE [BikeStores]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[SaveCategory]
@pjCategory VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @nCategoryID INT

		INSERT INTO 
			dbo.Categories
		SELECT
			CategoryName
		FROM OPENJSON (@pjCategory)
		WITH (CategoryName VARCHAR(255))

		SET @nCategoryID = SCOPE_IDENTITY()

		SELECT 
			a.CategoryID
			, a.CategoryName
		FROM
			dbo.Categories AS a
		WHERE
			a.CategoryID = @nCategoryID

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


