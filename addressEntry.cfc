<cfcomponent>

<cffunction name="storeAddress" output="false" returnType="numeric" access="public">
<cfargument name="country" required="true" type="string">
<cfargument name="state" required="true" type="string">
<cfargument name="city" required="true" type="string">
<cfargument name="address" required="true" type="string">
<cfargument name="address2" required="true" type="string">
<cfargument name="pincode" required="true" type="string">

<cftry>
<cfif session.repeat EQ true>
  <cfquery name="checkuserquery">
    select addressID from Address
    where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int" >
  </cfquery>

  <cfif checkuserquery.recordCount EQ 0 AND NOT structKeyExists(session,"setDifferentAddress")>
<cfquery name="addressquery">
insert into Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID,addressType)
values(<cfqueryparam value=#arguments.address# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#arguments.address2# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#arguments.pincode# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#arguments.city# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#arguments.state# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#arguments.country# cfsqltype="cf_sql_varchar">,
  <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
    <cfqueryparam value="default" cfsqltype="cf_sql_varchar">)
</cfquery>
<cfreturn result.identitycol>
  <cfelseif structKeyExists(session,"setDifferentAddress") AND session.setDifferentAddress EQ true>
    <cfquery name="addressquery" result="result">
    insert into Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID)
    values(<cfqueryparam value=#arguments.address# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.address2# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.pincode# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.city# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.state# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.country# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
    </cfquery>
<cfreturn result.identitycol>
<cfelse>

  <cfquery name="updatedefaultquery">
    update Address
    set addressType=NULL
    where userID= <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
  </cfquery>
  <cfquery name="updatequery" result="result" >
    insert into Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID,addressType)
    values(<cfqueryparam value=#arguments.address# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.address2# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.pincode# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.city# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.state# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#arguments.country# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
        <cfqueryparam value="default" cfsqltype="cf_sql_varchar">)
    <!---
    update Address
    set
    customerAddress1=<cfqueryparam value=#arguments.address# cfsqltype="cf_sql_varchar">,
      customerAddress2=<cfqueryparam value=#arguments.address2# cfsqltype="cf_sql_varchar">,
      customerZip=<cfqueryparam value=#arguments.pincode# cfsqltype="cf_sql_varchar">,
        customerCity=<cfqueryparam value=#arguments.city# cfsqltype="cf_sql_varchar">,
          customerState=<cfqueryparam value=#arguments.state# cfsqltype="cf_sql_varchar">,
            customerCountry=<cfqueryparam value=#arguments.country# cfsqltype="cf_sql_varchar">
              where
              userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
                AND
                  addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">

--->
  </cfquery>
  <cfreturn result.identitycol>
</cfif>
</cfif>
<cfcatch>
  <cflog file="ecommerece" text="trying to access payment page directly" application="true" >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="searchUserAddress" output="false" returnType="boolean" access="public">
<cfquery name="searchquery">
  select addressID from Address
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
</cfquery>
<cfif NOT searchquery.recordCount EQ 0>
<cfreturn true>
<cfelse>
<cfreturn false>
</cfif>
</cffunction>

<cffunction name="getAddressInProductPage" access="public" output="false" returntype="query">
<cftry>
  <cfquery name="addressquery">
    select Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry from Address
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
  </cfquery>
<cfcatch>
  <cflog file="ecommerece" text="exception in addressEntry.cfc----getAddressInProductPage method" application="true" >
</cfcatch>
</cftry>
<cfreturn addressquery>
</cffunction>

</cfcomponent>
