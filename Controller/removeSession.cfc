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

        <cfinvoke method="deleteOnlineUser" component="db.userComponent.userRemoveOnline" userEmail="#arguments.userEmail#" />
</cffunction>

<cffunction name="onWindowClose" output="false" access="remote" returntype="void">
  <cfinvoke method="updateUserToOffline" component="db.userComponent.userRemoveOnline" />
</cffunction>


<cffunction name="changeStatusToOnline" output="false" returntype="void" access="public">
<cfif structKeyExists(session,"stLoggedInUser")>
  <cfinvoke method="updateUserOnline" component="db.userComponent.countOnlineUsers" >
</cfif>
</cffunction>

</cfcomponent>
