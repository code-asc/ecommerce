<cfcomponent>
  <cffunction name="deleteOnlineUser" returntype="void" output="false" access="public">
    <cfargument name="userEmail" required="true" type="string">
      <cftry>
        <cfquery name="deletequery">
          delete from OnlineUser
          where
          email=<cfqueryparam value="#arguments.userEmail#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfcatch type="any">
          <cflog file="ecommerece" text="error occured in userRemoveOnline.cfc in deleteOnlineUser function" application="true" >
        </cfcatch>
      </cftry>
  </cffunction>

  <cffunction name="updateUserToOffline" output="false" returntype="void" access="public">
    <cftry>
      <cfquery name="changeStatusToOffline">
        update OnlineUser
        set status='offline'
        where
        userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
          <cflog file="ecommerece" text="error occured in userRemoveOnline.cfc in updateUserToOffline function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>
  
</cfcomponent>
