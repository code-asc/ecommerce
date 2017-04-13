<cfcomponent>

  <!---
  function     :deleteOnlineUser
  returnType   :void
  hint         :It is used to delete the online user
  --->
  <cffunction name="deleteOnlineUser" returntype="void" output="false" access="public">
    <cfargument name="userEmail" required="true" type="string">
      <cftry>
        <cfquery name="deletequery">
          DELETE FROM OnlineUser
          WHERE
          email=<cfqueryparam value="#ARGUMENTS.userEmail#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in userRemoveOnline.cfc in deleteOnlineUser function .The SQL state : #cfcatch.queryError#" application="true" >
        </cfcatch>
      </cftry>
  </cffunction>


  <!---
  function     :updateUserToOffline
  returnType   :void
  hint         :It is used to change the user status to offline
  --->
  <cffunction name="updateUserToOffline" output="false" returntype="void" access="public">
    <cftry>
      <cfif StructKeyExists(SESSION, "stLoggedInUser")>
      <cfquery name="changeStatusToOffline">
        UPDATE OnlineUser
        SET status='offline'
        WHERE
        userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
    </cfif>
      <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in userRemoveOnline.cfc in updateUserToOffline function .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>

    </cftry>
  </cffunction>

</cfcomponent>
