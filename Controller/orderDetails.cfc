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
function     :cartDetails
returnType   :query
hint         :It is used to return cartDetails
--->
<cffunction name="cartDetails" output="false" access="public" returntype="query">
<cfargument name="status" required="true" type="string"/>
<cfinvoke method="productCartDetails" component="db.productComponent.productInfo" status="#ARGUMENTS.status#" returnvariable="cartDetailQuery" />
<cfreturn cartDetailQuery/>
</cffunction>
</cfcomponent>
