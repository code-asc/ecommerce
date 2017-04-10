<cfcomponent extends="db.userComponent.updateSocketStatus" >


  <!---
  function     :getNotificationQuery
  returnType   :query
  hint         :It is used to return the top 3 notifications
  --->
  <cffunction name="getNotificationQuery" output="false" access="public" returntype="query">
    <cftry>
    <cfquery name="getquery">
      SELECT TOP 3 content,
      (SELECT count(case when markAs='unread' then 1 else null end) from Notification l
      where x.nid=l.nid) as totalRead ,
      replace(convert(nvarchar,postTime,105),' ','/') as postTime
      FROM
      Notification x
      ORDER BY nid DESC
    </cfquery>
    <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in socketNotification.cfc" application="true" >
          <cfset emptyQuery=queryNew("totalRead,postTime")>
            <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getquery/>
  </cffunction>
</cfcomponent>
