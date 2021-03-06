<cfcomponent>

  <!---
  function     :markAsReadNotificationQuery
  returnType   :void
  hint         :It is used to update the status of the notification
  --->
  <cffunction name="markAsReadNotificationQuery" output="false" access="public" returntype="void">
    <cftry>
      <cfquery name="updatequery">
        UPDATE Notification
        SET markAs='read'
        WHERE nid IN (SELECT TOP 3 nid FROM Notification ORDER BY nid DESC)
      </cfquery>
      <cfcatch>
          <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in markAsReadNotificationQuery function .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>


  <!---
  function     :insertNotificationDataQuery
  returnType   :void
  hint         :It is used to insert notification in database
  --->
  <cffunction name="insertNotificationDataQuery" output="false" access="public" returntype="void">
    <cfargument name="content" required="true" type="string">
      <cftry>
        <cfquery name="notificationquery">
        <!---  BEGIN
          IF NOT EXISTS(SELECT nid FROM Notification
          WHERE
          content=<cfqueryparam value="#ARGUMENTS.content#" cfsqltype="cf_sql_varchar">
            )
            BEGIN--->
          INSERT INTO Notification(content,postTime,markAs)
          VALUES(<cfqueryparam value="#ARGUMENTS.content#" cfsqltype="varchar">
            ,#now()#,
            <cfqueryparam value="unread" cfsqltype="cf_sql_varchar">)
          <!---    END
              END--->
        </cfquery>
        <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in insertNotificationDataQuery function. The SQL state : #cfcatch.queryError#" application="true">
        </cfcatch>
      </cftry>
  </cffunction>


  <!---
  function     :getTopNotification
  returnType   :query
  hint         :It is used to retrive top 3 notifications
  --->
  <cffunction name="getTopNotification" returntype="query" access="public" output="false">
    <cftry>
      <cfquery name="getquery">
        SELECT TOP 3 content ,replace(convert(nvarchar,postTime,105),' ','/') as postTime from Notification ORDER BY nid DESC
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in updateUserStatus.cfc in getTopNotification function .The SQL state : #cfcatch.queryError#" application="true">
          <cfset emptyQuery=queryNew("content,postTime")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn getquery/>
  </cffunction>

</cfcomponent>
