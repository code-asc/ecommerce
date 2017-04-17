<cfcomponent>

  <!---
  function     :showDetails
  returnType   :query
  hint         :It is used to return customer address details
  --->
<cffunction name="showDetails" output="false" access="public" returnType="query">
  <cfinvoke method="customerAddressDetail" component="db.addressComponent.searchAndGetAddress" returnvariable="detailquery" />
  <cfreturn detailquery>
</cffunction>


<!---
function    :showDetailsUsingPagenation
returnType  :query
hint        :It is used to return customer address details
--->
<cffunction name="showDetailsUsingPagenation" output="false" access="public" returnType="query">
<cfargument name="start" required="true" type="numeric"/>
<cfargument name="limit" required="true" type="numeric">
  <cfinvoke method="customerAddressDetailForPagenation" component="db.addressComponent.searchAndGetAddress" returnvariable="detailquery" start=#ARGUMENTS.start# limitTo=#ARGUMENTS.limit#/>
  <cfreturn detailquery>
</cffunction>


<!---
function     :cartDetails
returnType   :query
hint         :It is used to return cartDetails
--->
<cffunction name="cartDetails" output="false" access="public" returntype="query">
<cfargument name="status" required="true" type="string"/>
  <cfinvoke method="productCartDetails" component="db.productComponent.productInfo" status="#ARGUMENTS.status#" returnvariable="cartDetailQuery" />
  <cfreturn cartDetailQuery/>
</cffunction>

<!---
function    :deleteOrderHistory
returnType  :void
hint        :It is used to delete the purchased history
--->
<cffunction name="deleteOrderHistory" output="false" access="remote" returntype="numeric" returnformat="JSON" >
<cfargument name="orderID" required="true" type="numeric">
  <cfinvoke method="ondeleteOrderHistory" component="db.userComponent.userDeleteHistory" orderID=#ARGUMENTS.orderID#>
<cfreturn ARGUMENTS.orderID/>
</cffunction>
</cfcomponent>
