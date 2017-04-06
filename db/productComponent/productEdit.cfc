<cfcomponent>
  <cffunction name="productEdit" output="false" access="public" returnType="void">
  <cfargument name="productID" type="numeric" required="true">
  <cfargument name="productDesc" type="string" required="true">
  <cfargument name="unitPrice" type="numeric" required="true">
  <cfargument name="unitInStock" type="numeric" required="true">
  <cfargument name="discount" type="numeric" required="true">
  <cfargument name="thumbNailPhoto" type="string" required="true">
  <cfargument name="largePhoto" type="string" required="true">

<cftry>
    <cfquery name="productupdatequery">
    update Products
    set productDesc=<cfqueryparam value="#arguments.productDesc#" cfsqltype="cf_sql_varchar">,
    unitPrice=<cfqueryparam value=#arguments.unitPrice# cfsqltype="cf_sql_decimal">,
    unitInStock=<cfqueryparam value=#arguments.unitInStock# cfsqltype="cf_sql_int">,
    discount=<cfqueryparam value=#arguments.discount# cfsqltype="cf_sql_int">
    where
    productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int">
    </cfquery>

    <cfquery name="photoupdatequery">
    update ProductPhoto
    set thumbNailPhoto=<cfqueryparam value="#arguments.thumbNailPhoto#" cfsqltype="cf_sql_varchar">,
       largePhoto=<cfqueryparam value="#arguments.largePhoto#" cfsqltype="cf_sql_varchar">
      from ProductPhoto
      inner join Products
      on
      Products.photoID=ProductPhoto.photoID
      where
      Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int" >
    </cfquery>

<cfcatch type="any">
  <cflog file="ecommerece" text="error occured in productEdit.cfc" application="true" >
</cfcatch>
</cftry>
  </cffunction>
</cfcomponent>
