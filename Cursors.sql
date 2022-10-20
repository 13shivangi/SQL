--cursors
--requirement
--depending on how many products belong to a product category 
--display a message that productCategory is trending
                         --    /no products in product Category
						 --    /normal purchases for productCategory
DECLARE @ProductCount INT
DECLARE @Category NVARCHAR(50)

DECLARE cur_trendingCategories CURSOR FOR
select Count(Product.[Name]) as [ProductCount], ProductCategory.[Name]from Product RIGHT OUTER JOIN ProductCategory
ON Product.CategoryId=ProductCategory.Id
Group by ProductCategory.[Name]

OPEN cur_trendingCategories
FETCH NEXT FROM cur_trendingCategories
INTO @ProductCount,@Category
--logic
WHILE @@FETCH_STATUS =0
BEGIN
   IF @ProductCount > 3
       Print @Category + ' is trending';
    ELSE IF @ProductCount >0 and @ProductCount <3
	   Print @Category + ' has normal purchase';
      ELSE 
	   Print @Category + ' has no products'

fetch next from  cur_trendingCategories INTO @ProductCount,@Category
END
--end of row bt row processing

CLOSE  cur_trendingCategories
DeAllocate  cur_trendingCategories
