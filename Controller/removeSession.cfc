<cfcomponent>

  <!---
  function     :removeUserSession
  returnType   :void
  hint         :It is used to remove the user from onile
  --->
<cffunction name="removeUserSession" output="false" access="public" returntype="void">
  <cfargument name="userEmail" required="true" type="string">
<cfset app=APPLICATION.ApplicationName>
    <cfset getAllUserSession=createObject("java","coldfusion.runtime.SessionTracker")>
      <cfset getAllUserCollection=getAllUserSession.getSessionCollection("application_2_1_1")>

        <cfloop collection="#getAllUserCollection#" item="keyValue">
        <cfif StructKeyExists(getAllUserCollection[keyValue], "stLoggedInUser")>
          <cfif getAllUserCollection[keyValue]["stLoggedInUser"]["userEmail"] EQ ARGUMENTS.userEmail>

            <cfset structDelete(getAllUserCollection[keyValue], "stloggedInUser")>
                <cfbreak>
          </cfif>
        </cfif>
        </cfloop>

        <cfinvoke method="deleteOnlineUser" component="db.userComponent.userRemoveOnline" userEmail="#ARGUMENTS.userEmail#" />
</cffunction>


<!---
function     :onWindowClose
returnType   :void
hint         :It is used to make user offline on browser window close
--->
<cffunction name="onWindowClose" output="false" access="remote" returntype="void">
  <cfinvoke method="updateUserToOffline" component="db.userComponent.userRemoveOnline" />
</cffunction>


<!---
function     :changeStatusToOnline
returnType   :void
hint         :It is used to change the user status to online
--->
<cffunction name="changeStatusToOnline" output="false" returntype="void" access="public">
<cfif structKeyExists(SESSION,"stLoggedInUser")>
  <cfinvoke method="updateUserOnline" component="db.userComponent.countOnlineUsers" >
</cfif>
</cffunction>

</cfcomponent>
