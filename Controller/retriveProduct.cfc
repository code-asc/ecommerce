<cfcomponent>
<cfset variables.getProductDetails=createObject("component","db.productComponent.productInfo")>

<cffunction name="getProducts" returnType="query" access="public" output="false">
<cfargument name="productID" required="true" type="numeric">

<cfset LOCAL.retriveProduct=variables.getProductDetails.getProductInfo(ARGUMENTS.productID)>
<cfreturn LOCAL.retriveProduct>
</cffunction>

<cffunction name="getProductBrand" output="false" access="public" returntype="query">
<cfargument name="subCategoryID" required="true" type="numeric">

  <cfset LOCAL.retriveBrand=variables.getProductDetails.getBrandBySubCategory(ARGUMENTS.subCategoryID)>
  <cfreturn LOCAL.retriveBrand>
</cffunction>

<cffunction name="displayProductBasedOnCategory" returntype="query" output="false" access="public">
  <cfset LOCAL.retriveProduct=variables.getProductDetails.productsDisplay()>
    <cfreturn LOCAL.retriveProduct/>
</cffunction>

<cffunction name="similarProducts" access="public" returntype="any" output="false">
  <cfargument name="subCategoryID" required="true" type="numeric">
  <cfargument name="productID" required="true" type="numeric">
<cfset LOCAL.retriveProduct=variables.getProductDetails.suggestedProduct(ARGUMENTS.subCategoryID,ARGUMENTS.productID)>
  <cfreturn LOCAL.retriveProduct>
</cffunction>

<cffunction name="getCategoryForHeader" output="false" returntype="query" access="public">
  <cfargument name="arg1" required="true" type="numeric"/>
  <cfargument name="arg2" required="false" type="numeric" default=0 />
  <cfargument name="arg3" required="false" type="numeric" default=0 />
  <cfset LOCAL.retriveCategory=variables.getProductDetails.categoryOptionForHeader(ARGUMENTS.arg1,ARGUMENTS.arg2,ARGUMENTS.arg3)>
  <cfreturn LOCAL.retriveCategory>
</cffunction>

<cffunction name="productsForSearchPage" output="false" returntype="query" access="public">
<cfargument name="brandName" required="false" default="notGiven">
<cfif NOT ARGUMENTS.brandName EQ 'notGiven'>
  <cfset LOCAL.returnQuery=variables.getProductDetails.productInfoForSearchPage(ARGUMENTS.brandName)>
  <cfelse>
    <cfset LOCAL.returnQuery=variables.getProductDetails.productInfoForSearchPage()>
</cfif>
<cfreturn LOCAL.returnQuery/>
</cffunction>
</cfcomponent>
