<cfcomponent>
<cfset variables.getProductDetails=createObject("component","db.productComponent.productInfo")>
<cffunction name="getProducts" returnType="query" access="public" output="false">
<cfargument name="productID" required="true" type="numeric">

<cfset LOCAL.retriveProduct=variables.getProductDetails.getProductInfo(arguments.productID)>
<cfreturn LOCAL.retriveProduct>
</cffunction>

<cffunction name="getProductBrand" output="false" access="public" returntype="query">
<cfargument name="subCategoryID" required="true" type="numeric">

  <cfset LOCAL.retriveBrand=variables.getProductDetails.getBrandBySubCategory(arguments.subCategoryID)>
  <cfreturn LOCAL.retriveBrand>
</cffunction>

<cffunction name="similarProducts" access="public" returntype="any" output="false">
  <cfargument name="subCategoryID" required="true" type="numeric">
  <cfargument name="productID" required="true" type="numeric">
<cfset LOCAL.retriveProduct=variables.getProductDetails.suggestedProduct(arguments.subCategoryID,arguments.productID)>
  <cfreturn LOCAL.retriveProduct>
</cffunction>
</cfcomponent>