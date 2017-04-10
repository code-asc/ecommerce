<cfcomponent>
<cfset VARIABLES.getProductDetails=createObject("component","db.productComponent.productInfo")>
<cfset VARIABLES.getAddressDetails=createObject("component","db.addressComponent.searchAndGetAddress")>

  <!---
  function     buyNow
  returnType   :void
  hint         :It is used to retrive the products , update the address and update product quantity
  --->
<cffunction name="buyNow" output="false" access="remote" returnType="void">
  <cfargument name="addressID" required="false" type="numeric" default=0 >

<cfset LOCAL.retriveproductquery=VARIABLES.getProductDetails.getProductInfo(session.productID)>
<cfset VARIABLES.getProductDetails.setOrderDetails(status="progress",productID=#LOCAL.retriveproductquery.productID#,afterDiscount=#LOCAL.retriveproductquery.afterDiscount#,supplierID=#LOCAL.retriveproductquery.supplierID#)>

<cfif ARGUMENTS.addressID GT 0>
<cfset LOCAL.temp=VARIABLES.getProductDetails.setOrder(ARGUMENTS.addressID)>
<cfelse>

  <cfset LOCAL.addressquery=VARIABLES.getAddressDetails.getAddressQuery()>
  <cfset LOCAL.temp=VARIABLES.getProductDetails.setOrder(LOCAL.addressquery.addressID)>
</cfif>

<cfset VARIABLES.getProductDetails.updateProductQtyOnOrder(LOCAL.retriveproductquery.productID)>
</cffunction>
</cfcomponent>
