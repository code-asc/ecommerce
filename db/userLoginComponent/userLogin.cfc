<cfcomponent>
  <cffunction name="doUserLogin" access="public" output="false" returntype="query">
    <cfargument name="userEmail" required="true" type="string">
    <cfargument name="userPassword" required="true" type="string">
      <cftry>
        <cfquery name="loginUser">
          select Customer.userID , Customer.userFirstName , Customer.userMiddleName , Customer.userLastName , Customer.userEmail , Customer.userPassword, Customer.userProfilePhoto  from Customer
          where
          userEmail=<cfqueryparam value = "#arguments.userEmail#" CFSQLType = "cf_sql_varchar" >
            AND
            userPassword=hashbytes('sha2_512',<cfqueryparam value = "#arguments.userPassword#" CFSQLType = "cf_sql_varchar">)
        </cfquery>
        <cfcatch type="any">
          <cflog file="ecommerece" text="error occured in userLogin.cfc in doUserLogin function" application="true" >
            <cfset emptyQuery=queryNew("userID,userFirstName,userMiddleName,userLastName,userEmail,userPassword,userProfilePhoto")>
              <cfreturn emptyQuery>
        </cfcatch>
      </cftry>
      <cfreturn loginUser>
  </cffunction>
</cfcomponent>
