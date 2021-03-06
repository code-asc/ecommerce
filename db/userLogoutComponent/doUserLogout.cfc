<cfcomponent>

  <!---
  function     :doLogOutOf
  returnType   :void
  hint         :It is used to logout the user
  --->
<cffunction name="doLogoutOf" output="false" returntype="void" access="public">
<cftry>
  <cfquery name="deletequery">
    DELETE FROM OnlineUser
    WHERE
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in doUserLogout.cfc inn doLogoutOf method.The SQL state : #cfcatch.queryError#" application="true">
  </cfcatch>
</cftry>
</cffunction>

<!---
function     :doLogOutOfSession
returnType   :void
hint         :It is used to logout the user
--->
<cffunction name="doLogOutOfSession" output="false" returntype="void" access="public">
<cfargument name="userID" required="true" type="numeric">
<cftry>
<cfquery name="deletequery">
  DELETE FROM OnlineUser
  WHERE
  userID=<cfqueryparam value=#ARGUMENTS.userID# cfsqltype="cf_sql_int">
</cfquery>
<cfcatch type="Database">
    <cflog file="ecommerece" text="error occured in doUserLogout.cfc in doLogOutOfSession method.The SQL state : #cfcatch.queryError#" application="true">
</cfcatch>
</cftry>
</cffunction>

</cfcomponent>
