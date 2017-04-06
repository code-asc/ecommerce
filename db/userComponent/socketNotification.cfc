<cfcomponent extends="db.userComponent.updateSocketStatus" >
  <cffunction name="getNotificationQuery" output="false" access="public" returntype="query">
    <cftry>
    <cfquery name="getquery">
      select TOP 3 content,
      (select count(case when markAs='unread' then 1 else null end) from Notification l
      where x.nid=l.nid) as totalRead ,
      replace(convert(nvarchar,postTime,105),' ','/') as postTime
      from
      Notification x
      order by nid DESC
    </cfquery>
    <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in socketNotification.cfc" application="true" >
          <cfset emptyQuery=queryNew("totalRead,postTime")>
            <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getquery/>
  </cffunction>
</cfcomponent>
