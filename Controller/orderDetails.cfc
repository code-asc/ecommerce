<cfcomponent>

<cffunction name="showDetails" output="false" access="public" returnType="query">
<cfinvoke method="customerAddressDetail" component="db.addressComponent.searchAndGetAddress" returnvariable="detailquery" />
<cfreturn detailquery>
</cffunction>

<cffunction name="cartDetails" output="false" access="public" returntype="query">
<cfargument name="status" required="true" type="string"/>
<cfinvoke method="productCartDetails" component="db.productComponent.productInfo" status="#arguments.status#" returnvariable="cartDetailQuery" />
<cfreturn cartDetailQuery/>
</cffunction>
</cfcomponent>
