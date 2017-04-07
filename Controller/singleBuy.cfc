<cfcomponent>
<cfset variables.getProductDetails=createObject("component","db.productComponent.productInfo")>
<cfset variables.getAddressDetails=createObject("component","db.addressComponent.searchAndGetAddress")>


<cffunction name="buyNow" output="false" access="remote" returnType="void">
  <cfargument name="addressID" required="false" type="numeric" default=0 >

<cfset LOCAL.retriveproductquery=variables.getProductDetails.getProductInfo(session.productID)>
<cfset variables.getProductDetails.setOrderDetails(status="progress",productID=#LOCAL.retriveproductquery.productID#,afterDiscount=#LOCAL.retriveproductquery.afterDiscount#,supplierID=#LOCAL.retriveproductquery.supplierID#)>

<cfif arguments.addressID GT 0>
<cfset LOCAL.temp=variables.getProductDetails.setOrder(arguments.addressID)>
<cfelse>

  <cfset LOCAL.addressquery=variables.getAddressDetails.getAddressQuery()>
  <cfset LOCAL.temp=variables.getProductDetails.setOrder(LOCAL.addressquery.addressID)>
</cfif>

<cfset variables.getProductDetails.updateProductQtyOnOrder(LOCAL.retriveproductquery.productID)>
</cffunction>
</cfcomponent>
