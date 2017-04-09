<cfcomponent>
  <cffunction name="markAsReadNotificationQuery" output="false" access="public" returntype="void">
    <cftry>
      <cfquery name="updatequery">
        UPDATE Notification
        SET markAs='read'
        WHERE nid IN (SELECT TOP 3 nid FROM Notification ORDER BY nid DESC)
      </cfquery>
      <cfcatch>
          <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in markAsReadNotificationQuery function" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>

  <cffunction name="insertNotificationDataQuery" output="false" access="public" returntype="void">
    <cfargument name="content" required="true" type="string">
      <cftry>
        <cfquery name="notificationquery">
          INSERT INTO Notification(content,postTime,markAs)
          VALUES(<cfqueryparam value="#ARGUMENTS.content#" cfsqltype="varchar">
            ,#now()#,
            <cfqueryparam value="unread" cfsqltype="cf_sql_varchar">)
        </cfquery>
        <cfcatch type="any">
          <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in insertNotificationDataQuery function" application="true">
        </cfcatch>
      </cftry>
  </cffunction>

  <cffunction name="getTopNotification" returntype="query" access="public" output="false">
    <cftry>
      <cfquery name="getquery">
        SELECT TOP 3 content ,replace(convert(nvarchar,postTime,105),' ','/') as postTime from Notification ORDER BY nid DESC
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in getTopNotification function" application="true">
          <cfset emptyQuery=queryNew("content,postTime")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn getquery/>
  </cffunction>

</cfcomponent>
