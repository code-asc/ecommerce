<cfcomponent>
<cfset this.name="application_2_1_1">
<cfset this.datasource="ecommerece">
  <cfset this.sessionManagement=true>
   <!--- <cfset this.clientManagement=true> --->
    <cfset this.applicationTimeout=#createTimespan(0, 12, 0, 0)#>
      <cfset this.sessionTimeout=#createTimespan(0, 4,0, 0)#>

<cfset this.ormEnabled=true>
<cfset this.ormSettings.dbcreate="update">

<cfset this.invokeimplicitaccessor=true>


<cffunction name="onApplicationStart" returntype="boolean" output="false" access="public">
  <cfreturn true>
</cffunction>

<cffunction name="onMissingTemplate" output="false" access="public" returntype="boolean" >
  <cfargument name="targetPage" required="true" type="string"/>
<cflocation url="missingPage.cfm" addtoken="false"  />
  <cfreturn true>
</cffunction>

<cffunction name="onSessionEnd" returntype="void">
  <cfargument name="SessionScope" required="true">
    <cfargument name="ApplicationScope" required="false">
      <cfquery name="deletequery">
        delete from OnlineUser
        where
        userID=<cfqueryparam value=#arguments.SessionScope.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
</cffunction>

<!---
<cffunction name="onError" output="false" returntype="void" access="public" >
  <cfargument name="exception" type="any" required="true">
  <cfargument name="eventName" type="string" required="true">
    <cfset errorDetails="Details :" & #exception.detail# & " Type :" & #exception.type# & "Message :" & #exception.Message#>
  <cflog file="ecommerece" text="#arguments.exception#" application="true" >
    <cfif arguments.exception EQ "coldfusion.runtime.UndefinedElementException: Element STLOGGEDINUSER.USERID is undefined in SESSION.">
      <cflocation url="signin.cfm" addtoken="false" >
    </cfif>
</cffunction>
--->

</cfcomponent>
