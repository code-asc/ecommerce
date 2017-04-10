<cfcomponent>
<cfset VARIABLES.getfilterProductInfo=createObject("component","db.productComponent.productInfo")>


  <!---
  function     :filterProduct
  returnType   :array
  hint         :It is used to filter the products based on brand and discount on AJAX call
  --->
<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">
<cfargument name="category" required="true" type="string">

<cfset LOCAL.filterquery=VARIABLES.getfilterProductInfo.productInfoForFilters(brand="#ARGUMENTS.brand#",discount="#ARGUMENTS.discount#",category="#ARGUMENTS.category#")>
    <cfset var arrayToStoreQuery=arrayNew(1)>


    <cfloop query="filterquery">
      <cfset stData=structNew()>
            <cfset stData.thumbNailPhoto=#LOCAL.filterquery.thumbNailPhoto#>
            <cfset stData.productID=#LOCAL.filterquery.productID#>
            <cfset stData.productName=#LOCAL.filterquery.productName#>
            <cfset stData.productDesc=#LOCAL.filterquery.productDesc#>
            <cfset stData.discount=#LOCAL.filterquery.discount#>
            <cfset stData.unitPrice=#LOCAL.filterquery.unitPrice#>
            <cfset stData.thumbNailPhoto=#LOCAL.filterquery.thumbNailPhoto#>
            <cfset stData.brandName=#LOCAL.filterquery.brandName#>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
    </cffunction>
    </cfcomponent>
