<cfcomponent extends="db.userLoginComponent.userLogin" >

  <!---
  function     :checkUserOnline
  returnType   :query
  hint         :It is used to return userID and email of the online user
  --->
  <cffunction name="checkUserOnline" returntype="query" access="public" output="false">
    <cfargument name="userID" required="true" type="any"/>
    <cftry>
      <cfquery name="checkStatus">
        SELECT OnlineUser.userID,OnlineUser.email FROM OnlineUser
        WHERE
        userID=<cfqueryparam value=#ARGUMENTS.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in isUserOnline.cfc in checkUserOnline function" application="true" >
          <cfset emptyQuery=queryNew("userID,userEmail")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn checkStatus/>
  </cffunction>

  <!---
  function     :changeUserStatus
  returnType   :void
  hint         :It is used to insert the user into OnlineUser table
  --->
  <cffunction name="changeUserStatus" output="false" returntype="void" access="public">
    <cftry>
      <cfquery name="insertquery">
      INSERT INTO OnlineUser(userID,status,email)
      VALUES(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
        <cfqueryparam value="online" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.stLoggedInUser.userEmail#" cfsqltype="cf_sql_varchar">)
      </cfquery>

      <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in isUserOnline.cfc in changeUserStatus function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>
</cfcomponent>
