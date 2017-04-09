<cfcomponent >
<cfset VARIABLES.saleDetails=createObject("component","db.adminPageComponent.orderAndBrandDetail")>

<cffunction name="highestSaleProduct" output="false" returntype="query" access="public">
<cfset LOCAL.productinfoquery=VARIABLES.saleDetails.highestSaleProductQuery()>
  <cfreturn LOCAL.productinfoquery>
</cffunction>


<cffunction name="countryStatus" output="false" returntype="query" access="public">
  <cfset LOCAL.countryquery=VARIABLES.saleDetails.countCountry()>
  <cfreturn LOCAL.countryquery>
</cffunction>

<cffunction name="allDetails" output="false" returntype="Struct" access="public">
<cfset var stData=StructNew()>

  <cfset LOCAL.customerquery=VARIABLES.saleDetails.countCustomer()>
  <cfset LOCAL.productquery=VARIABLES.saleDetails.countProduct()>
  <cfset LOCAL.categoryquery=VARIABLES.saleDetails.countCategory()>
  <cfset LOCAL.subcategoryquery=VARIABLES.saleDetails.countSubCategory()>
  <cfset LOCAL.supplierquery=VARIABLES.saleDetails.countSupplier()>
  <cfset LOCAL.shippingquery=VARIABLES.saleDetails.countShipping()>

  <cfset stData.customer=#LOCAL.customerquery.total#>
  <cfset stData.product=#LOCAL.productquery.total#>
  <cfset stData.category=#LOCAL.categoryquery.total#>
  <cfset stData.subcategory=#LOCAL.subcategoryquery.total#>
  <cfset stData.supplier=#LOCAL.supplierquery.total#>
  <cfset stData.shipping=#LOCAL.shippingquery.total#>

<cfreturn stData>
</cffunction>

</cfcomponent>
