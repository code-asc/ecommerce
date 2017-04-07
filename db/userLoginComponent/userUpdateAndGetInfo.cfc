<cfcomponent>
  <cffunction name="getUserInfo" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="getquery">
        select userFirstName, userProfilePhoto,userMiddleName, userLastName, userEmail , userPhone from Customer
        where
        userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in getUserInfo function" application="true" >
          <cfset emptyQuery=queryNew("userFirstName, userProfilePhoto,userMiddleName, userLastName, userEmail , userPhone")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn getquery>
  </cffunction>

  <cffunction name="updateProfilePhoto" output="false" returntype="void" access="public">
  <cfargument name="path" required="true" type="string">
    <cftry>
      <cfquery name="updatequery">
        update Customer
        set userProfilePhoto=<cfqueryparam value="#arguments.path#" cfsqltype="cf_sql_varchar">
        where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateProfilePhoto function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>

<cffunction name="updateUserInfo" returntype="void" output="false" access="public">
  <cfargument name="firstName" required="true" type="string">
  <cfargument name="middleName" required="true" type="string">
  <cfargument name="lastName" required="true" type="string">
  <cfargument name="email" required="true" type="string">
  <cfargument name="phone" required="true" type="string">
    <cftry>
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
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateUserInfo function" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
