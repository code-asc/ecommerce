<cfcomponent>

  <cffunction name="getUserDetail" output="false" returntype="query"  access="public">
  <cfquery name="getquery">
    select userFirstName, userProfilePhoto,userMiddleName, userLastName, userEmail , userPhone from Customer
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>

  <cfreturn getquery>
  </cffunction>

<cffunction name="uploadUserProfilePhoto" output="false" returntype="void" access="public">
  <cfargument name="path" required="true" type="string">
    <cfquery name="updatequery">
      update Customer
      set userProfilePhoto=<cfqueryparam value="#arguments.path#" cfsqltype="cf_sql_varchar">
      where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    </cfquery>
    <cfset session.stLoggedInUser.userProfilePhoto="#arguments.path#">
</cffunction>

<cffunction name="updateUserDetail" output="false" returntype="string" access="remote" returnformat="JSON" >
  <cfargument name="firstName" required="true" type="string">
  <cfargument name="middleName" required="true" type="string">
  <cfargument name="lastName" required="true" type="string">
  <cfargument name="email" required="true" type="string">
  <cfargument name="phone" required="true" type="string">
    <cfquery name="updatequery">
      update Customer
      set userFirstName=<cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
        userMiddleName=<cfqueryparam value="#arguments.middleName#" cfsqltype="cf_sql_varchar">,
        userLastName=<cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
        userEmail=<cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
        userPhone=<cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
        where
       userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    </cfquery>

    <cfset session.stLoggedInUser.userfirstName="#arguments.firstName#">
    <cfset session.stLoggedInUser.usermiddleName="#arguments.middleName#">
    <cfset session.stLoggedInUser.userlastName="#arguments.lastName#">
    <cfset session.stLoggedInUser.userEmail="#arguments.email#">
    <cfreturn #arguments.firstName#&" "&#arguments.middleName#&" "&#arguments.lastName#>
</cffunction>

</cfcomponent>
