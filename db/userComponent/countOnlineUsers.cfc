<cfcomponent>

  <!---
  function     :getUsersOnline
  returnType   :query
  hint         :It returns total number of online users
  --->
  <cffunction name="getUsersOnline" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="onlinequery">
        SELECT count(userID) AS totalUsers FROM OnlineUser
        WHERE
        status=<cfqueryparam value="online" cfsqltype="cf_sql_varchar">
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in countOnlineUsers.cfc in getUsersOnline function.The SQL state : #cfcatch.SQLState#" application="true" >
          <cfset emptyQuery=queryNew("totalUsers")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn onlinequery>
  </cffunction>


  <!---
  function     :updateUserOnline
  returnType   :void
  hint         :It is used to  change the status of the user to online
  --->
  <cffunction name="updateUserOnline" output="false" returntype="void" access="public">
  <cftry>
    <cfquery name="updatequery">
      UPDATE  OnlineUser
      SET status='online'
      WHERE
      userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      status=<cfqueryparam value="offline" cfsqltype="cf_sql_varchar" >
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in countOnlineUsers.cfc in updateUserOnline function.The SQL state : #cfcatch.SQLState#" application="true" >
    </cfcatch>
  </cftry>
  </cffunction>

</cfcomponent>
