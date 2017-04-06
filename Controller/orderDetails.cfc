<cfcomponent>
  
<cffunction name="showDetails" output="false" access="public" returnType="query">
<cfinvoke method="customerAddressDetail" component="db.addressComponent.searchAndGetAddress" returnvariable="detailquery" />
<cfreturn detailquery>
</cffunction>

</cfcomponent>
