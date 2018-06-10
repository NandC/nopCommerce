/* ------------------------------------------------------------------

-- Nand's changes for Test Task to update LocaleStringResource table

STEPS:
1. Please execute this script on nopCommerce database
2. This cript is re-runable
------------------------------------------------------------------*/
DECLARE @LanguageID        int
DECLARE @ResourceName      nvarchar(200)
DECLARE @ResourceValue     nvarchar(MAX)
DECLARE @ResourceNameHint  nvarchar(200)
DECLARE @ResourceValueHint nvarchar(MAX)

SELECT TOP 1 
	@LanguageID =       ID,
	@ResourceName =     'Admin.Catalog.Products.Fields.Author',
	@ResourceValue =    'Author',
	@ResourceNameHint = 'Admin.Catalog.Products.Fields.Author.Hint',
	@ResourceValueHint= 'The name of the author who wrote the book.'
FROM 
	Language WITH (NOLOCK)


IF (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
            WHERE LanguageID = @LanguageID AND ResourceName = @ResourceName))

BEGIN
	UPDATE 
		LocaleStringResource
	SET 
		ResourceValue   = @ResourceValue
	WHERE 
		LanguageID       = @LanguageID 
		AND ResourceName = @ResourceName
END
ELSE 
BEGIN
	INSERT INTO LocaleStringResource (
		LanguageId,
		ResourceName,
		ResourceValue )
	VALUES (
		@LanguageID,
		@ResourceName,
		@ResourceValue )
END


-- insert Hint
IF (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
	    WHERE LanguageID = @LanguageID AND ResourceName = @ResourceNameHint))
BEGIN
	UPDATE 
		LocaleStringResource
	SET 
		ResourceValue = @ResourceValueHint
	WHERE 
		LanguageID       = @LanguageID 
		AND ResourceName = @ResourceNameHint		
END
ELSE
BEGIN
	INSERT INTO LocaleStringResource (
		LanguageId,
		ResourceName,
		ResourceValue )
	VALUES (
		@LanguageID,
		@ResourceNameHint,
		@ResourceValueHint )
END

-- print result
IF (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
            WHERE LanguageID = @LanguageID AND ResourceName = @ResourceName)
    AND (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
	    WHERE LanguageID = @LanguageID AND ResourceName = @ResourceNameHint)) )
BEGIN
	PRINT 'Successfully updated Admin.Catalog.Products.Fields.Author in LocaleStringResource table.'
END
ELSE
BEGIN
	RAISERROR ('Failure: The table LocaleStringResource  could not be updated with Admin.Catalog.Products.Fields.Author', 16, 1 );
END

GO
DECLARE @LanguageID        int
DECLARE @ResourceName      nvarchar(200)
DECLARE @ResourceValue     nvarchar(MAX)

SELECT TOP 1 
	@LanguageID =       ID,
	@ResourceName =     'Plugins.Widgets.ProdMsg.Message',
	@ResourceValue =    'Message'
FROM 
	Language WITH (NOLOCK)


IF (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
            WHERE LanguageID = @LanguageID AND ResourceName = @ResourceName))

BEGIN
	UPDATE 
		LocaleStringResource
	SET 
		ResourceValue   = @ResourceValue
	WHERE 
		LanguageID       = @LanguageID 
		AND ResourceName = @ResourceName
END
ELSE 
BEGIN
	INSERT INTO LocaleStringResource (
		LanguageId,
		ResourceName,
		ResourceValue )
	VALUES (
		@LanguageID,
		@ResourceName,
		@ResourceValue )
END


-- print result
IF (EXISTS (SELECT TOP 1 * FROM LocaleStringResource WITH (NOLOCK)
            WHERE LanguageID = @LanguageID AND ResourceName = @ResourceName) )
BEGIN
	PRINT 'Successfully updated Plugins.Widgets.ProdMsg.Message in LocaleStringResource table.'
END
ELSE
BEGIN
	RAISERROR ('Failure: The table LocaleStringResource  could not be updated with Plugins.Widgets.ProdMsg.Message', 16, 1 );
END

GO

-- add author column
IF NOT EXISTS(SELECT * FROM SYSCOLUMNS 
			  WHERE ID = OBJECT_ID(N'[DBO].[PRODUCT]') 
                         AND NAME = 'AUTHOR')
BEGIN
   ALTER TABLE dbo.Product ADD Author nvarchar(60) NULL
END
GO

-- print result
IF EXISTS(SELECT * FROM SYSCOLUMNS 
			  WHERE ID = OBJECT_ID(N'[DBO].[PRODUCT]') 
                         AND NAME = 'AUTHOR')
BEGIN
	PRINT 'Successfully added author column'
END
ELSE
BEGIN
	RAISERROR ('Failure: author column could not be added', 16, 1 );
END
