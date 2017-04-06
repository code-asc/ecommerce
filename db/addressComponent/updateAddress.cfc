<cfcomponent extends="db.addressComponent.searchAndGetAddress" >

<cffunction name="updateAddressQuery" output="false" returntype="void" access="public">
  <cftry>
    <cfquery name="updatedefaultquery">
      update Address
      set addressType=NULL
      where userID= <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfcatch>
      <cflog file="ecommerece" text="error occured in updateAddress.cfc in updateAddressQuery function" application="true" >
    </cfcatch>
  </cftry>
</cffunction>

<cffunction name="updateDefaultAdderssQuery" returntype="numeric" output="false" access="public">
  <cfargument name="country" required="true" type="string">
  <cfargument name="state" required="true" type="string">
  <cfargument name="city" required="true" type="string">
  <cfargument name="address" required="true" type="string">
  <cfargument name="address2" required="true" type="string">
  <cfargument name="pincode" required="true" type="string">
<cftry>
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
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in updateAddress.cfc in updateDefaultAdderssQuery function" application="true" >
  </cfcatch>
</cftry>
<cfreturn result.identitycol>
</cffunction>

</cfcomponent>
