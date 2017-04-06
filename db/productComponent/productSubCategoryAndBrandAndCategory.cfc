<cfcomponent>
  <cffunction name="getSubCategoryQuery" output="false" access="public" returntype="query">
    <cfargument name="categoryID" required="true" cfsqltype="cf_sql_int">

<cftry>
      <cfquery name="subcategoryquery">
        select subCategoryType , subCategoryID from SubCategory
        where categoryID=<cfqueryparam value=#arguments.categoryID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in productSubCategoryAndBrandAndCategory.cfc" application="true">
          <cfset emptyQuery=queryNew("subCategoryType,subCategoryID")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
      <cfreturn subcategoryquery/>
  </cffunction>

<cffunction name="getProductQuery" output="false" access="public" returntype="query">
<cfargument name="subCategoryID" required="true" type="numeric">
<cftry>
  <cfquery name="productquery">
    select Brands.brandName ,Products.productID ,Products.photoID , Products.productName from Products
    inner join Brands
    on
    Brands.brandID=Products.brandID
    where
    subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_int" >
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
