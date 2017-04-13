<cfcomponent extends="db.userLoginComponent.userUpdateAndGetInfo" >

  <!---
  function     :doUserLogin
  returnType   :query
  hint         :It is used to get user details
  --->
  <cffunction name="doUserLogin" access="public" output="false" returntype="query">
    <cfargument name="userEmail" required="true" type="string">
    <cfargument name="userPassword" required="true" type="string">
      <cftry>
        <cfquery name="loginUser">
          SELECT Customer.userID , Customer.userFirstName , Customer.userMiddleName , Customer.userLastName , Customer.userEmail , Customer.userPassword, Customer.userProfilePhoto , Customer.roles  from Customer
          WHERE
          userEmail=<cfqueryparam value = "#ARGUMENTS.userEmail#" CFSQLType = "cf_sql_varchar" >
            AND
            userPassword=hashbytes('sha2_512',<cfqueryparam value = "#ARGUMENTS.userPassword#" CFSQLType = "cf_sql_varchar">)
        </cfquery>
        <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in userLogin.cfc in doUserLogin function .The SQL state : #cfcatch.queryError#" application="true" >
            <cfset emptyQuery=queryNew("userID,userFirstName,userMiddleName,userLastName,userEmail,userPassword,userProfilePhoto")>
              <cfreturn emptyQuery>
        </cfcatch>
      </cftry>
      <cfreturn loginUser>
  </cffunction>
</cfcomponent>
