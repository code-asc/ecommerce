<cfcomponent>

<cffunction name="doLogoutOf" output="false" returntype="void" access="public">
<cftry>
  <cfquery name="deletequery">
    DELETE FROM OnlineUser
    WHERE
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in doUserLogout.cfc" application="true">
  </cfcatch>
</cftry>
</cffunction>
</cfcomponent>
