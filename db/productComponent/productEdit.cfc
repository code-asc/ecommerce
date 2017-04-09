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
    UPDATE Products
    SET productDesc=<cfqueryparam value="#ARGUMENTS.productDesc#" cfsqltype="cf_sql_varchar">,
    unitPrice=<cfqueryparam value=#ARGUMENTS.unitPrice# cfsqltype="cf_sql_decimal">,
    unitInStock=<cfqueryparam value=#ARGUMENTS.unitInStock# cfsqltype="cf_sql_int">,
    discount=<cfqueryparam value=#ARGUMENTS.discount# cfsqltype="cf_sql_int">
    WHERE
    productID=<cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int">
    </cfquery>

    <cfquery name="photoupdatequery">
    UPDATE ProductPhoto
    SET thumbNailPhoto=<cfqueryparam value="#ARGUMENTS.thumbNailPhoto#" cfsqltype="cf_sql_varchar">,
       largePhoto=<cfqueryparam value="#ARGUMENTS.largePhoto#" cfsqltype="cf_sql_varchar">
      from ProductPhoto
      inner join Products
      on
      Products.photoID=ProductPhoto.photoID
      WHERE
      Products.productID=<cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int" >
    </cfquery>

<cfcatch type="any">
  <cflog file="ecommerece" text="error occured in productEdit.cfc" application="true" >
</cfcatch>
</cftry>
  </cffunction>
</cfcomponent>
