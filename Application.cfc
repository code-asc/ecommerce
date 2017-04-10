<cfcomponent>

<cfset this.name="application_2_1_1">
<cfset this.wsChannels=[{name="world" ,cfcListener="myChannelListener"}]>
<cfset this.datasource="ecommerece">
  <cfset this.sessionManagement=true>
   <!--- <cfset this.clientManagement=true> --->
    <cfset this.applicationTimeout=#createTimespan(0, 12, 0, 0)#>
      <cfset this.sessionTimeout=#createTimespan(0, 4,0, 0)#>

<cfset this.ormEnabled=true>
<cfset this.ormSettings.dbcreate="update">

<cfset this.invokeimplicitaccessor=true>

    <cffunction name="onWSAuthenticate" returntype="boolean" access="public" output="false">
		<cfargument name="userName" required="true" type="string">
        <cfargument name="password" required="true" type="string">
        <cfargument name="connectionInfo" required="true" type="struct">

		<cfset ARGUMENTS.connectionInfo=#ARGUMENTS.userName#>
        <cfreturn true>
    </cffunction>

<cffunction name="onSessionStart" output="false" access="public" returntype="void">
  <cfcookie name="CFID" value="#SESSION.CFID#" />
          <cfcookie name="CFTOKEN" value="#SESSION.CFTOKEN#" />

          <!--- Store date the session was created. --->
          <cfset SESSION.DateInitialized = Now() />
</cffunction>

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
      <cftry>
      <cfquery name="deletequery">
        DELETE FROM OnlineUser
        WHERE
        userID=<cfqueryparam value=#arguments.SessionScope.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="#cfcatch.queryError#" application="true">
      </cfcatch>
    </cftry>
</cffunction>


<cffunction name="onError" output="false" returntype="void" access="public" >
  <cfargument name="exception" type="any" required="true">
  <cfargument name="eventName" type="string" required="true">
    <cfset errorDetails="Details :" & #exception.detail# & " Type :" & #exception.type# & "Message :" & #exception.Message#>
  <cflog file="ecommerece" text="#arguments.exception#" application="true" >
    <cfif arguments.exception EQ "coldfusion.runtime.UndefinedElementException: Element STLOGGEDINUSER.USERID is undefined in SESSION.">
      <cflocation url="signin.cfm" addtoken="false" >
    </cfif>
</cffunction>


</cfcomponent>
