USE [BikeStores]
GO

ALTER PROCEDURE [dbo].[GetBrands] 
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION

		SELECT 
			a.BrandID,
			a.BrandName
		FROM
			Brands AS a

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
GO


