<cfcomponent>

<cffunction name="removeUserSession" output="false" access="public" returntype="void">
  <cfargument name="userEmail" required="true" type="string">
<cfset app=application.ApplicationName>
    <cfset getAllUserSession=createObject("java","coldfusion.runtime.SessionTracker")>
      <cfset getAllUserCollection=getAllUserSession.getSessionCollection("application_2_1_1")>

        <cfloop collection="#getAllUserCollection#" item="keyValue">
        <cfif StructKeyExists(getAllUserCollection[keyValue], "stLoggedInUser")>
          <cfif getAllUserCollection[keyValue]["stLoggedInUser"]["userEmail"] EQ arguments.userEmail>

            <cfset structDelete(getAllUserCollection[keyValue], "stloggedInUser")>
                <cfbreak>
          </cfif>
        </cfif>
        </cfloop>

        <cfquery name="deletequery">
          delete from OnlineUser
          where
          email=<cfqueryparam value="#arguments.userEmail#" cfsqltype="cf_sql_varchar">
        </cfquery>

</cffunction>

<cffunction name="onWindowClose" output="false" access="remote" returntype="void">
  <cfquery name="deletequery">
    update OnlineUser
    set status='offline'
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>
</cffunction>


<cffunction name="changeStatusToOnline" output="false" returntype="void" access="public">
<cfif structKeyExists(session,"stLoggedInUser")>
  <cfquery name="updatequery">
    update  OnlineUser
    set status='online'
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    AND
    status=<cfqueryparam value="offline" cfsqltype="cf_sql_varchar" >
  </cfquery>
</cfif>
</cffunction>

</cfcomponent>
