<cfcomponent>
  <cffunction name="markAsReadNotificationQuery" output="false" access="public" returntype="void">
    <cftry>
      <cfquery name="updatequery">
        update Notification
        set markAs='read'
        where nid in (select TOP 3 nid from Notification order by nid DESC)
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
          insert into Notification(content,postTime,markAs)
          values(<cfqueryparam value="#arguments.content#" cfsqltype="varchar">
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
        select TOP 3 content ,replace(convert(nvarchar,postTime,105),' ','/') as postTime from Notification order by nid DESC
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
