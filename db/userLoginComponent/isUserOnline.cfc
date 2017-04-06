<cfcomponent extends="db.userLoginComponent.userLogin" >
  <cffunction name="checkUserOnline" returntype="query" access="public" output="false">
    <cfargument name="userID" required="true" type="any"/>
    <cftry>
      <cfquery name="checkStatus">
        select OnlineUser.userID,OnlineUser.email from OnlineUser
        where
        userID=<cfqueryparam value=#arguments.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in isUserOnline.cfc in checkUserOnline function" application="true" >
          <cfset emptyQuery=queryNew("userID,userEmail")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn checkStatus/>
  </cffunction>


  <cffunction name="changeUserStatus" output="false" returntype="void" access="public">
    <cftry>
      <cfquery name="insertquery">
      insert into OnlineUser(userID,status,email)
      values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
        <cfqueryparam value="online" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#session.stLoggedInUser.userEmail#" cfsqltype="cf_sql_varchar">)
      </cfquery>

      <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in isUserOnline.cfc in changeUserStatus function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>
</cfcomponent>
