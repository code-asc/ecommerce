<cfcomponent>
  <cffunction name="getUsersOnline" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="onlinequery">
        select count(userID) as totalUsers from OnlineUser
        where
        status=<cfqueryparam value="online" cfsqltype="cf_sql_varchar">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in countOnlineUsers.cfc in getUsersOnline function" application="true" >
          <cfset emptyQuery=queryNew("totalUsers")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn onlinequery>
  </cffunction>

  <cffunction name="updateUserOnline" output="false" returntype="void" access="public">
  <cftry>
    <cfquery name="updatequery">
      update  OnlineUser
      set status='online'
      where
      userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      status=<cfqueryparam value="offline" cfsqltype="cf_sql_varchar" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in countOnlineUsers.cfc in updateUserOnline function" application="true" >
    </cfcatch>
  </cftry>
  </cffunction>

</cfcomponent>
