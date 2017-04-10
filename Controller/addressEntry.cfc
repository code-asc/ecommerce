<cfcomponent>
<cfset variables.addOrUpdateAddress=createObject("component","db.addressComponent.setAddress")>

  <!---
  function     :storeAddress
  returnType   :numeric
  hint         :It is used to store the address and return identitycol of inserted record
  --->
<cffunction name="storeAddress" output="false" returnType="numeric" access="public">
<cfargument name="country" required="true" type="string">
<cfargument name="state" required="true" type="string">
<cfargument name="city" required="true" type="string">
<cfargument name="address" required="true" type="string">
<cfargument name="address2" required="true" type="string">
<cfargument name="pincode" required="true" type="string">

<cftry>
<cfif SESSION.repeat EQ true>

  <cfset LOCAL.checkuserquery=variables.addOrUpdateAddress.checkUserAddress()>

  <cfif LOCAL.checkuserquery.recordCount EQ 0 AND NOT structKeyExists(SESSION,"setDifferentAddress")>
<cfset LOCAL.returnVal=variables.addOrUpdateAddress.setAddressWithoutAddressType(ARGUMENTS.country,ARGUMENTS.state,ARGUMENTS.city,ARGUMENTS.address,ARGUMENTS.address2,ARGUMENTS.pincode)>
<cfreturn LOCAL.returnVal>
  <cfelseif structKeyExists(SESSION,"setDifferentAddress") AND SESSION.setDifferentAddress EQ true>
    <cfset LOCAL.returnVal=variables.addOrUpdateAddress.setAddressWithAddressType(ARGUMENTS.country,ARGUMENTS.state,ARGUMENTS.city,ARGUMENTS.address,ARGUMENTS.address2,ARGUMENTS.pincode)>
    <cfreturn LOCAL.returnVal>
<cfelse>

<cfset variables.addOrUpdateAddress.updateAddressQuery()>
<cfset LOCAL.returnVal=variables.addOrUpdateAddress.updateDefaultAdderssQuery(ARGUMENTS.country,ARGUMENTS.state,ARGUMENTS.city,ARGUMENTS.address,ARGUMENTS.address2,ARGUMENTS.pincode)>
<cfreturn LOCAL.returnVal>
</cfif>
</cfif>
<cfcatch>
  <cflog file="ecommerece" text="trying to access payment page directly" application="true" >
</cfcatch>
</cftry>
</cffunction>


<!---
function     :searchUserAddress
returnType   :boolean
hint         :It is used to search the customer address and return boolean value
--->
<cffunction name="searchUserAddress" output="false" returnType="boolean" access="public">
<cfset LOCAL.searchquery=variables.addOrUpdateAddress.searchUserAddressQuery()>
<cfif NOT LOCAL.searchquery.recordCount EQ 0>
<cfreturn true>
<cfelse>
<cfreturn false>
</cfif>
</cffunction>


<!---
function     :getAddressOfUser
returnType   :query
hint         :It is used to get address of the customer
--->
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
