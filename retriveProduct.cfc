<cfcomponent>

<cffunction name="getProducts" returnType="query" access="public" output="false">
<cfargument name="productID" required="true" type="numeric">
<cftry>
<cfquery name="retriveProduct">
  select  Products.productID, Products.subCategoryID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.unitInStock ,ProductPhoto.largePhoto,ProductPhoto.photoID ,Products.discount ,Brands.brandName from Products
  inner join ProductPhoto
  on
  Products.photoID=ProductPhoto.photoID
  inner join Brands
  on
  Products.brandID=Brands.brandID
  where Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_integer">

</cfquery>

<cfcatch type="any">
<cflog file="ecommerece" text="exception in retriveProduct.cfc" application="true" >
</cfcatch>
</cftry>
<cfreturn retriveProduct>
</cffunction>

<cffunction name="getProductBrand" output="false" access="public" returntype="query">
<cfargument name="subCategoryID" required="true" type="numeric">
  <cfquery name="retriveBrand">
    select DISTINCT Brands.brandName,Brands.brandID from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    where Products.subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_integer">
      ORDER BY Brands.brandName ASC
  </cfquery>
  <cfreturn retriveBrand>
</cffunction>

<cffunction name="similarProducts" access="public" returntype="any" output="false">
  <cfargument name="subCategoryID" required="true" type="numeric">
  <cfargument name="productID" required="true" type="numeric">
    <cftry>
    <cfquery name="retriveProduct">
      select TOP 3 Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.discount ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
      inner join ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      inner join Brands
      on
      Products.brandID=Brands.brandID
      where Products.subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_integer">
        AND
        NOT Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int" >
      order by NEWID()
    </cfquery>

   <cfcatch type="any">
      <cfreturn javacast("null",0)>
    </cfcatch>
  </cftry>
  <cfreturn retriveProduct>
</cffunction>
</cfcomponent>
