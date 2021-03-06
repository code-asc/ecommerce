<cfcomponent extends="db.addressComponent.updateAddress" >

  <!---
  function    :checkUserAddress
  returnType  :query
  hint        :check if user address already exists or not.
  --->
  <cffunction name="checkUserAddress" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.checkuserquery=queryNew("addressID")>
      <cfquery name="checkuserquery">
        SELECT addressID FROM Address
        where userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int" >
      </cfquery>
      <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in setAddress.cfc in checkUserAddress function.The SQL state : #cfcatch.queryError#" application="true" >
        <!---  <cfset emptyQuery=queryNew("addressID")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.checkuserquery/>
      </cfcatch>
    </cftry>
    <cfreturn LOCAL.checkuserquery/>
  </cffunction>


  <!---
  function   :setAddressWithoutAddressType
  returnType : numeric
  hint       : It returns the identitycol of the newly inserted record
  --->
  <cffunction name="setAddressWithoutAddressType" output="false" returntype="numeric" access="public">
    <cfargument name="country" required="true" type="string">
    <cfargument name="state" required="true" type="string">
    <cfargument name="city" required="true" type="string">
    <cfargument name="address" required="true" type="string">
    <cfargument name="address2" required="true" type="string">
    <cfargument name="pincode" required="true" type="string">

      <cftry>
            <cfquery name="addressquery" result="result">
            INSERT INTO Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID,addressType)
            VALUES(<cfqueryparam value=#ARGUMENTS.address# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#ARGUMENTS.address2# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#ARGUMENTS.pincode# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#ARGUMENTS.city# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#ARGUMENTS.state# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#ARGUMENTS.country# cfsqltype="cf_sql_varchar">,
              <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
              <cfqueryparam value="default" cfsqltype="cf_sql_varchar">)
            </cfquery>
        <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in setAddress.cfc in setAddressWithoutAddressType function.The SQL state : #cfcatch.queryError#" application="true" >
        </cfcatch>
      </cftry>
  <cfreturn result.identitycol/>
  </cffunction>


  <!---
  function      :setAddressWithAddressType
  returnType    :numeric
  hint          :return the identitycol of the newlt inserted record
  --->
  <cffunction name="setAddressWithAddressType" output="false" returntype="numeric" access="public">
    <cfargument name="country" required="true" type="string">
    <cfargument name="state" required="true" type="string">
    <cfargument name="city" required="true" type="string">
    <cfargument name="address" required="true" type="string">
    <cfargument name="address2" required="true" type="string">
    <cfargument name="pincode" required="true" type="string">

      <cftry>
        <cfquery name="addressquery" result="result">
        INSERT INTO Address(customerAddress1,customerAddress2,customerZip,customerCity,customerState,customerCountry,userID)
        VALUES(<cfqueryparam value=#ARGUMENTS.address# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#ARGUMENTS.address2# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#ARGUMENTS.pincode# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#ARGUMENTS.city# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#ARGUMENTS.state# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#ARGUMENTS.country# cfsqltype="cf_sql_varchar">,
          <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
        </cfquery>
        <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in setAddress.cfc in setAddressWithAddressType function. The SQL state : #cfcatch.queryError#" application="true" >
        </cfcatch>
      </cftry>
      <cfreturn result.identitycol/>
  </cffunction>
</cfcomponent>
