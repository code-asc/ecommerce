<cfcomponent>
<cfset VARIABLES.userDetails=createObject("component","db.userLoginComponent.userUpdateAndGetInfo")>

  <cffunction name="getUserDetail" output="false" returntype="query"  access="public">
<cfset LOCAL.getInfo=VARIABLES.userDetails.getUserInfo()>
  <cfreturn LOCAL.getInfo>
  </cffunction>

<cffunction name="uploadUserProfilePhoto" output="false" returntype="void" access="public">
  <cfargument name="path" required="true" type="string">
    <cfset VARIABLES.userDetails.updateProfilePhoto(ARGUMENTS.path)>
    <cfset session.stLoggedInUser.userProfilePhoto="#ARGUMENTS.path#">
</cffunction>

<cffunction name="updateUserDetail" output="false" returntype="string" access="remote" returnformat="JSON" >
  <cfargument name="firstName" required="true" type="string">
  <cfargument name="middleName" required="true" type="string">
  <cfargument name="lastName" required="true" type="string">
  <cfargument name="email" required="true" type="string">
  <cfargument name="phone" required="true" type="string">

    <cfset VARIABLES.userDetails.updateUserInfo(firstName="#ARGUMENTS.firstName#",middleName="#ARGUMENTS.middleName#",lastName="#ARGUMENTS.lastName#",email="#ARGUMENTS.email#",phone="#ARGUMENTS.phone#")>
    <cfset session.stLoggedInUser.userfirstName="#ARGUMENTS.firstName#">
    <cfset session.stLoggedInUser.usermiddleName="#ARGUMENTS.middleName#">
    <cfset session.stLoggedInUser.userlastName="#ARGUMENTS.lastName#">
    <cfset session.stLoggedInUser.userEmail="#ARGUMENTS.email#">
    <cfreturn #ARGUMENTS.firstName#&" "&#ARGUMENTS.middleName#&" "&#ARGUMENTS.lastName#>
</cffunction>

</cfcomponent>
