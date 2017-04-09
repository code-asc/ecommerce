<cfcomponent extends="db.addressComponent.searchAndGetAddress" >

<cffunction name="updateAddressQuery" output="false" returntype="void" access="public">
  <cftry>
    <cfquery name="updatedefaultquery">
      UPDATE Address
      SET addressType=NULL
      where userID= <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
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
    INSERT INTO Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID,addressType)
    values(<cfqueryparam value=#ARGUMENTS.address# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#ARGUMENTS.address2# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#ARGUMENTS.pincode# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#ARGUMENTS.city# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#ARGUMENTS.state# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#ARGUMENTS.country# cfsqltype="cf_sql_varchar">,
      <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
      <cfqueryparam value="default" cfsqltype="cf_sql_varchar">)
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in updateAddress.cfc in updateDefaultAdderssQuery function" application="true" >
  </cfcatch>
</cftry>
<cfreturn result.identitycol>
</cffunction>

</cfcomponent>
