<cfcomponent>
<cfset variables.getfilterProductInfo=createObject("component","db.productComponent.productInfo")>

<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">
<cfargument name="category" required="true" type="string">

<cfset LOCAL.filterquery=variables.getfilterProductInfo.productInfoForFilters(brand="#arguments.brand#",discount="#arguments.discount#",category="#arguments.category#")>
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
