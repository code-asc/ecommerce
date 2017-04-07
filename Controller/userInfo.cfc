<cfcomponent>
<cfset variables.userDetails=createObject("component","db.userLoginComponent.userUpdateAndGetInfo")>

  <cffunction name="getUserDetail" output="false" returntype="query"  access="public">
<cfset LOCAL.getInfo=variables.userDetails.getUserInfo()>
  <cfreturn LOCAL.getInfo>
  </cffunction>

<cffunction name="uploadUserProfilePhoto" output="false" returntype="void" access="public">
  <cfargument name="path" required="true" type="string">
    <cfset variables.userDetails.updateProfilePhoto(arguments.path)>
    <cfset session.stLoggedInUser.userProfilePhoto="#arguments.path#">
</cffunction>

<cffunction name="updateUserDetail" output="false" returntype="string" access="remote" returnformat="JSON" >
  <cfargument name="firstName" required="true" type="string">
  <cfargument name="middleName" required="true" type="string">
  <cfargument name="lastName" required="true" type="string">
  <cfargument name="email" required="true" type="string">
  <cfargument name="phone" required="true" type="string">

    <cfset variables.userDetails.updateUserInfo(firstName="#arguments.firstName#",middleName="#arguments.middleName#",lastName="#arguments.lastName#",email="#arguments.email#",phone="#arguments.phone#")>
    <cfset session.stLoggedInUser.userfirstName="#arguments.firstName#">
    <cfset session.stLoggedInUser.usermiddleName="#arguments.middleName#">
    <cfset session.stLoggedInUser.userlastName="#arguments.lastName#">
    <cfset session.stLoggedInUser.userEmail="#arguments.email#">
    <cfreturn #arguments.firstName#&" "&#arguments.middleName#&" "&#arguments.lastName#>
</cffunction>

</cfcomponent>
