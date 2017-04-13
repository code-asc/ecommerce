<cfcomponent>

<!---
function    :checkUserAlreadyRegistered
returnType  :query
hint        :It is used to check userEmail is already registered or not.
--->
<cffunction name="checkUserAlreadyRegistered" output="false" returntype="query" access="public">
  <cfargument name="email" required="true" type="string"/>
  <cftry>
    <cfquery name="checkquery">
    SELECT userEmail FROM Customer WHERE
    userEmail=<cfqueryparam value=#email#  cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfcatch type="database">
      <cflog text="error in userUpdateAndGetInfo.cfc in checkUserAlreadyRegistered . The SQL error : #cfcatch.queryError#" application="true" />
    </cfcatch>
  </cftry>
  <cfreturn checkquery/>
</cffunction>


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
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in getUserInfo function .The SQL state : #cfcatch.queryError#" application="true" >
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
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateProfilePhoto function .The SQL state : #cfcatch.queryError#" application="true" >
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
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in userUpdateAndGetInfo.cfc in updateUserInfo function .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
