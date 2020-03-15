USE [BikeStores]
GO
/****** Object:  StoredProcedure [dbo].[SaveBrand]    Script Date: 3/15/2020 10:41:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SaveBrand] 
@pjBrand VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brandID INT

	BEGIN TRY
		BEGIN TRANSACTION
	
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
