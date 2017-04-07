<cfcomponent>
<cfset variables.addOrUpdateAddress=createObject("component","db.addressComponent.setAddress")>

<cffunction name="storeAddress" output="false" returnType="numeric" access="public">
<cfargument name="country" required="true" type="string">
<cfargument name="state" required="true" type="string">
<cfargument name="city" required="true" type="string">
<cfargument name="address" required="true" type="string">
<cfargument name="address2" required="true" type="string">
<cfargument name="pincode" required="true" type="string">

<cftry>
<cfif session.repeat EQ true>

  <cfset LOCAL.checkuserquery=variables.addOrUpdateAddress.checkUserAddress()>

  <cfif LOCAL.checkuserquery.recordCount EQ 0 AND NOT structKeyExists(session,"setDifferentAddress")>
<cfset LOCAL.returnVal=variables.addOrUpdateAddress.setAddressWithoutAddressType(arguments.country,arguments.state,arguments.city,arguments.address,arguments.address2,arguments.pincode)>
<cfreturn LOCAL.returnVal>
  <cfelseif structKeyExists(session,"setDifferentAddress") AND session.setDifferentAddress EQ true>
    <cfset LOCAL.returnVal=variables.addOrUpdateAddress.setAddressWithAddressType(arguments.country,arguments.state,arguments.city,arguments.address,arguments.address2,arguments.pincode)>
    <cfreturn LOCAL.returnVal>
<cfelse>

<cfset variables.addOrUpdateAddress.updateAddressQuery()>
<cfset LOCAL.returnVal=variables.addOrUpdateAddress.updateDefaultAdderssQuery(arguments.country,arguments.state,arguments.city,arguments.address,arguments.address2,arguments.pincode)>
<cfreturn LOCAL.returnVal>
</cfif>
</cfif>
<cfcatch>
  <cflog file="ecommerece" text="trying to access payment page directly" application="true" >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="searchUserAddress" output="false" returnType="boolean" access="public">
<cfset LOCAL.searchquery=variables.addOrUpdateAddress.searchUserAddressQuery()>
<cfif NOT LOCAL.searchquery.recordCount EQ 0>
<cfreturn true>
<cfelse>
<cfreturn false>
</cfif>
</cffunction>

<cffunction name="getAddressOfUser" returntype="query" output="false" access="public">
<cfset LOCAL.addressResult=variables.addOrUpdateAddress.searchUserAddressQuery()>
  <cfreturn LOCAL.addressResult>
</cffunction>

<cffunction name="getAddressInProductPage" access="public" output="false" returntype="query">
<cftry>
  <cfset LOCAL.addressquery=variables.addOrUpdateAddress.getAddressQuery()>
<cfcatch>
  <cflog file="ecommerece" text="exception in addressEntry.cfc----getAddressInProductPage method" application="true" >
</cfcatch>
</cftry>
<cfreturn LOCAL.addressquery>
</cffunction>

</cfcomponent>
