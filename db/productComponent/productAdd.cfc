<cfcomponent>


  <!---
  function    :addProductInfoToDatabase
  returnType  :void
  hint        :It is used to insert a product along with photo in database
  --->
<cffunction name="addProductInfoToDatabase" access="public" output="false" returntype="string">
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

<cftransaction action="begin" >
<cftry>

    <cfquery name="addphotoquery" result="getPhotoIdentity">
    INSERT INTO ProductPhoto(thumbNailPhoto,thumbNailPhotoName,largePhoto,largePhotoName,brandID,subCategoryID)
    VALUES(<cfqueryparam value="#ARGUMENTS.thumbNail#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.thumbNailType#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.largePhoto#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#ARGUMENTS.largePhotoType#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value=#ARGUMENTS.brandID# cfsqltype="cf_sql_int">,
    <cfqueryparam value=#ARGUMENTS.subcategoryID# cfsqltype="cf_sql_int">
    )
    </cfquery>
    <cfset var photoID=#getPhotoIdentity.identitycol#>
    <cfquery name="productquery">
      BEGIN
      IF NOT EXISTS(SELECT productID from Products
      where
      productName=<cfqueryparam value="#ARGUMENTS.productName#" cfsqltype="cf_sql_varchar">)
        BEGIN
    INSERT INTO Products(productName,productDesc,supplierID,subcategoryID,unitPrice,photoID,unitInStock,discount,rating,brandID)
    VALUES(<cfqueryparam value="#ARGUMENTS.productName#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#ARGUMENTS.productDesc#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#ARGUMENTS.supplierID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.subCategoryID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.unitPrice#" cfsqltype="cf_sql_decimal">,
      <cfqueryparam value="#photoID#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.quantity#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.discount#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.rating#" cfsqltype="cf_sql_int">,
      <cfqueryparam value="#ARGUMENTS.brandID#" cfsqltype="cf_sql_int">
    )
    END
    ELSE
    THROW 50001 , 'row already Exists' ,198;
    END
    </cfquery>
<cftransaction action="commit"/>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in productInfoAndEdit.cfc . The SQL state : #cfcatch.queryError#" application="true" >
        <cftransaction action="rollback"/>
        <cfreturn "failed"/>
    </cfcatch>
  </cftry>
  </cftransaction>
  <cfreturn "success"/>
  </cffunction>


</cfcomponent>
