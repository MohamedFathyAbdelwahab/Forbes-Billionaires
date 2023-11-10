/* 
 --Overviewing the data 

 */
 
 SELECT *
 FROM [Billionaire-Forbes]..[Forbes-Billionares]
 ORDER BY 4 DESC

 SELECT  *
FROM [Billionaire-Forbes]..[Forbes-Billionares]
WHERE [Source of Wealth] IS  NULL

SELECT *
FROM [Billionaire-Forbes]..[Forbes-Billionares] 
WHERE [Marital Status] LIKE '%Rema%'

SELECT   DISTINCT industry
FROM [Billionaire-Forbes]..[Forbes-Billionares]
 

SELECT COUNT(*)
FROM [Billionaire-Forbes]..[Forbes-Billionares]
WHERE [Marital Status] IS NULL



 -----------------------------------------------------------------------------------------------------------------------

 --Check for duplicates

 SELECT name,country, source, [Source of Wealth], industry, COUNT(*) as Count_Duplicates
 FROM [Billionaire-Forbes]..[Forbes-Billionares]
 GROUP BY name,country, source, [Source of Wealth], industry
 HAVING COUNT(*) > 1


 -----------------------------------------------------------------------------------------------------------------------

 /*

 Cleaning Data 

 */

 -- Correcting misspelling data

 SELECT DISTINCT SOURCE, [Source of Wealth]
 FROM [Billionaire-Forbes]..[Forbes-Billionares]
 WHERE source LIKE 'L''Or%'

 UPDATE [Billionaire-Forbes]..[Forbes-Billionares]
 SET source = 'L''Oreal'
 WHERE source LIKE 'L''Or%'

 UPDATE [Billionaire-Forbes]..[Forbes-Billionares]
 SET [Source of Wealth] = 'L''Oreal'
 WHERE [Source of Wealth] LIKE 'L''Or%'

 ---------------------------------------------------------------------------------------------------------------------

 -- Changing Self Made From '0' or '1' TO 'Yes' Or 'No'

 SELECT *, CASE 
           WHEN [Self Made]  = '1' THEN 'Yes'
		   WHEN [Self Made]  = '0' THEN 'No'
		   END AS Self_Made
 FROM [Billionaire-Forbes]..[Forbes-Billionares]

 ALTER TABLE  [Billionaire-Forbes]..[Forbes-Billionares]
 ADD Self_Made nvarchar(255);

 UPDATE [Billionaire-Forbes]..[Forbes-Billionares]
 SET Self_Made = CAST([Self Made] as nvarchar(255))

 UPDATE [Billionaire-Forbes] ..[Forbes-Billionares]
 SET [Self_Made] = CASE 
           WHEN [Self Made]  = '1' THEN 'Yes'
		   WHEN [Self Made]  = '0' THEN 'No'
		   END
		
------------------------------------------------------------------------------------------------------------------------

--Replace 'Widowed,Remarried' to be 'Remarried'

SELECT *, CASE 
          WHEN [Marital Status] LIKE '%Remar%' THEN 'Remarried'
		  ELSE [Marital Status]
		  END
FROM [Billionaire-Forbes]..[Forbes-Billionares] 

UPDATE [Billionaire-Forbes]..[Forbes-Billionares]
   SET [Marital Status] = CASE 
          WHEN [Marital Status] LIKE '%Remar%' THEN 'Remarried'
		  ELSE [Marital Status]
		  END

SELECT *
FROM [Billionaire-Forbes]..[Forbes-Billionares]
WHERE [Marital Status] LIKE '%Remarried'

------------------------------------------------------------------------------------------------------------------------
-- Populate "source of wealth" Which is null from "Source"

SELECT Source,[Source of Wealth]
FROM [Billionaire-Forbes]..[Forbes-Billionares]
WHERE [Source of Wealth] IS NULL

UPDATE [Billionaire-Forbes]..[Forbes-Billionares]
SET [Source of Wealth] = ISNULL([Source of Wealth],Source)

SELECT Source,[Source of Wealth]
FROM [Billionaire-Forbes]..[Forbes-Billionares]
WHERE [Source of Wealth] IS NULL


------------------------------------------------------------------------------------------------------------------------

-- Romoving unwanted columns

SELECT *
FROM [Billionaire-Forbes]..[Forbes-Billionares]

ALTER TABLE  [Billionaire-Forbes]..[Forbes-Billionares]
DROP COLUMN [Self-Made Score], [Philanthropy Score], [Self Made]

SELECT *
FROM [Billionaire-Forbes]..[Forbes-Billionares]



