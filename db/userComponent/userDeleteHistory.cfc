<cfcomponent>

  <!---
  function    :ondeleteOrderHistory
  returnType  :void
  hint        :It is used to delete the purchased history
  --->
<cffunction name="ondeleteOrderHistory" output="false" returntype="void" access="public">
<cfargument name="orderID" required="true" type="numeric"/>
    <cftry>
      <cfquery name="updatequery">
        UPDATE OrderDetails
        set displayStatus='removed'
        where
        orderID = <cfqueryparam value=#ARGUMENTS.orderID# cfsqltype="cf_sql_int"/>
        AND
        userID =<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int" >
      </cfquery>
      <cfcatch type="database">
        <cflog file="ecommerece" text="error occured in userDeleteHistory.cfc in ondeleteOrderHistory function.The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
</cffunction>

</cfcomponent>
