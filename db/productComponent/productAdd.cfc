<cfcomponent>

<cffunction name="addProductInfoToDatabase" access="public" output="false" returntype="void">
  <cfargument name="productName" type="string" required="true">
  <cfargument name="productDesc" type="string" required="true">
  <cfargument name="supplierID" type="numeric" required="true">
  <cfargument name="subcategoryID" type="numeric" required="true">
  <cfargument name="unitPrice" type="numeric" required="true">
  <cfargument name="thumbNail" type="string" required="true">
  <cfargument name="thumbNailType" type="string" required="true">
  <cfargument name="largePhotoType" type="string" required="true">
  <cfargument name="largePhoto" type="string" required="true">
  <cfargument name="quantity" type="numeric" required="true">
  <cfargument name="discount" type="numeric" required="true">
  <cfargument name="rating" type="numeric" required="true">
  <cfargument name="brandID" type="numeric" required="true">

<cftry>
    <cfquery name="addphotoquery" result="getPhotoIdentity">
    insert into ProductPhoto(thumbNailPhoto,thumbNailPhotoName,largePhoto,largePhotoName,brandID,subCategoryID)
    values(<cfqueryparam value="#arguments.thumbNail#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#arguments.thumbNailType#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#arguments.largePhoto#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#arguments.largePhotoType#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value=#arguments.brandID# cfsqltype="cf_sql_int">,
    <cfqueryparam value=#arguments.subcategoryID# cfsqltype="cf_sql_int">
    )
    </cfquery>


    <cfset var photoID=#getPhotoIdentity.identitycol#>


    <cfquery name="productquery">
    insert into Products(productName,productDesc,supplierID,subcategoryID,unitPrice,photoID,unitInStock,discount,rating,brandID)
    values(<cfqueryparam value="#arguments.productName#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#arguments.productDesc#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#arguments.supplierID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.subCategoryID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.unitPrice#" cfsqltype="cf_sql_decimal">,
      <cfqueryparam value="#photoID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.quantity#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.discount#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.rating#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#arguments.brandID#" cfsqltype="cf_sql_int">
    )
    </cfquery>

    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfoAndEdit.cfc" application="true" >
    </cfcatch>
  </cftry>
  </cffunction>


</cfcomponent>
