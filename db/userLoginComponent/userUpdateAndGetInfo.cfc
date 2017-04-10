<cfcomponent>

  <!---
  function     :getUserInfo
  returnType   :query
  hint         :It is used to get user profile info
  --->
  <cffunction name="getUserInfo" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="getquery">
        SELECT userFirstName, userProfilePhoto,userMiddleName, userLastName, userEmail , userPhone FROM Customer
        WHERE
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


  <!---
  function     :updateProfilePhoto
  returnType   :void
  hint         :It is used to update user profile photo
  --->
  <cffunction name="updateProfilePhoto" output="false" returntype="void" access="public">
  <cfargument name="path" required="true" type="string">
    <cftry>
      <cfquery name="updatequery">
        UPDATE Customer
        SET userProfilePhoto=<cfqueryparam value="#ARGUMENTS.path#" cfsqltype="cf_sql_varchar">
        WHERE userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateProfilePhoto function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>


  <!---
  function     :updateUserInfo
  returnType   :void
  hint         :It is used to update profile
  --->
<cffunction name="updateUserInfo" returntype="void" output="false" access="public">
  <cfargument name="firstName" required="true" type="string">
  <cfargument name="middleName" required="true" type="string">
  <cfargument name="lastName" required="true" type="string">
  <cfargument name="email" required="true" type="string">
  <cfargument name="phone" required="true" type="string">
    <cftry>
      <cfquery name="updatequery">
        UPDATE Customer
        SET userFirstName=<cfqueryparam value="#ARGUMENTS.firstName#" cfsqltype="cf_sql_varchar">,
          userMiddleName=<cfqueryparam value="#ARGUMENTS.middleName#" cfsqltype="cf_sql_varchar">,
          userLastName=<cfqueryparam value="#ARGUMENTS.lastName#" cfsqltype="cf_sql_varchar">,
          userEmail=<cfqueryparam value="#ARGUMENTS.email#" cfsqltype="cf_sql_varchar">,
          userPhone=<cfqueryparam value="#ARGUMENTS.phone#" cfsqltype="cf_sql_varchar">
          WHERE
         userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateUserInfo function" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
