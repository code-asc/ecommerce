<cfcomponent >
<cfset variables.saleDetails=createObject("component","db.adminPageComponent.orderAndBrandDetail")>

<cffunction name="highestSaleProduct" output="false" returntype="query" access="public">
<cfset LOCAL.productinfoquery=variables.saleDetails.highestSaleProductQuery()>
  <cfreturn LOCAL.productinfoquery>
</cffunction>


<cffunction name="countryStatus" output="false" returntype="query" access="public">
  <cfset LOCAL.countryquery=variables.saleDetails.countCountry()>
  <cfreturn LOCAL.countryquery>
</cffunction>

<cffunction name="allDetails" output="false" returntype="Struct" access="public">
<cfset var stData=StructNew()>

  <cfset LOCAL.customerquery=variables.saleDetails.countCustomer()>
  <cfset LOCAL.productquery=variables.saleDetails.countProduct()>
  <cfset LOCAL.categoryquery=variables.saleDetails.countCategory()>
  <cfset LOCAL.subcategoryquery=variables.saleDetails.countSubCategory()>
  <cfset LOCAL.supplierquery=variables.saleDetails.countSupplier()>
  <cfset LOCAL.shippingquery=variables.saleDetails.countShipping()>
    
  <cfset stData.customer=#LOCAL.customerquery.total#>
  <cfset stData.product=#LOCAL.productquery.total#>
  <cfset stData.category=#LOCAL.categoryquery.total#>
  <cfset stData.subcategory=#LOCAL.subcategoryquery.total#>
  <cfset stData.supplier=#LOCAL.supplierquery.total#>
  <cfset stData.shipping=#LOCAL.shippingquery.total#>

<cfreturn stData>
</cffunction>

</cfcomponent>
