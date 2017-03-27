<cfcomponent>

<cffunction name="getProducts" returnType="query" access="public" output="false">
<cfargument name="productID" required="true" type="numeric">
<cftry>
<cfquery name="retriveProduct">
  select  Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.unitInStock ,ProductPhoto.largePhoto,ProductPhoto.photoID ,Products.discount ,Brands.brandName from Products
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

</cfcomponent>
