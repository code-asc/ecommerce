<cfcomponent extends="db.addressComponent.updateAddress" >
  <cffunction name="checkUserAddress" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="checkuserquery">
        select addressID from Address
        where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int" >
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in setAddress.cfc in checkUserAddress function" application="true" >
          <cfset emptyQuery=queryNew("addressID")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn checkuserquery/>
  </cffunction>

  <cffunction name="setAddressWithoutAddressType" output="false" returntype="numeric" access="public">
    <cfargument name="country" required="true" type="string">
    <cfargument name="state" required="true" type="string">
    <cfargument name="city" required="true" type="string">
    <cfargument name="address" required="true" type="string">
    <cfargument name="address2" required="true" type="string">
    <cfargument name="pincode" required="true" type="string">

      <cftry>
        <cfquery name="addressquery" result="result">
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
          <cflog file="ecommerece" text="error occured in setAddress.cfc in setAddressWithoutAddressType function" application="true" >
        </cfcatch>
      </cftry>
      <cfreturn result.identitycol/>
  </cffunction>

  <cffunction name="setAddressWithAddressType" output="false" returntype="numeric" access="public">
    <cfargument name="country" required="true" type="string">
    <cfargument name="state" required="true" type="string">
    <cfargument name="city" required="true" type="string">
    <cfargument name="address" required="true" type="string">
    <cfargument name="address2" required="true" type="string">
    <cfargument name="pincode" required="true" type="string">

      <cftry>
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
        <cfcatch type="any">
          <cflog file="ecommerece" text="error occured in setAddress.cfc in setAddressWithAddressType function" application="true" >
        </cfcatch>
      </cftry>
      <cfreturn result.identitycol/>
  </cffunction>
</cfcomponent>
