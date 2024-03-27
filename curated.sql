IF OBJECT_ID('[dbo].[deso_view]', 'V') IS NOT NULL
BEGIN
    DROP VIEW [dbo].[deso_view];
END
GO

CREATE VIEW [dbo].[deso_view]
AS
SELECT [currency],
       [rate_code]
FROM [dbo].[data]
WHERE [currency] = 'DESO';

 select * from [dbo].[deso_view];