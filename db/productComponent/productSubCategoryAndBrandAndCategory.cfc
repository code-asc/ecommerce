<cfcomponent>

  <!---
  function     :getSubCategoryQuery
  returnType   :query
  hint         :It is used to return subCategoryID
  --->
  <cffunction name="getSubCategoryQuery" output="false" access="public" returntype="query">
    <cfargument name="categoryID" required="true" cfsqltype="cf_sql_int">

<cftry>
      <cfquery name="subcategoryquery">
        SELECT subCategoryType , subCategoryID FROM SubCategory
        where categoryID=<cfqueryparam value=#ARGUMENTS.categoryID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in productSubCategoryAndBrandAndCategory.cfc" application="true">
          <cfset emptyQuery=queryNew("subCategoryType,subCategoryID")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
      <cfreturn subcategoryquery/>
  </cffunction>


  <!---
  function     :getProductQuery
  returnType   :query
  hint         :It is used to return product Information based on subCategoryID
  --->
<cffunction name="getProductQuery" output="false" access="public" returntype="query">
<cfargument name="subCategoryID" required="true" type="numeric">
<cftry>
  <cfquery name="productquery">
    SELECT Brands.brandName ,Products.productID ,Products.photoID , Products.productName FROM Products
    INNER JOIN Brands
    on
    Brands.brandID=Products.brandID
    WHERE
    subCategoryID=<cfqueryparam value=#ARGUMENTS.subCategoryID# cfsqltype="cf_sql_int" >
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productSubCategoryAndBrandAndCategory.cfc" application="true">
      <cfset emptyQuery=queryNew("brandName,productID,photoID,productName")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
  <cfreturn productquery/>
</cffunction>

</cfcomponent>
