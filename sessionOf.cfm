<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>

    <!-- Bootstrap -->

    <!---<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>--->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="./css/adminCSS.css">
  </head>
  <body>

<cfif structKeyExists(session, "stLoggedInUser")>

  <!---  <cfquery name="productquery">
      select Brands.brandName , Products.productID , Products.productName from Products
      inner join Brands
      on
      Brands.brandID=Products.brandID
    </cfquery>
--->
<cfinvoke component="adminDashBoard" method="highestSaleProduct" returnvariable="highestPopular" >
<cfinvoke component="adminDashBoard" method="countryStatus" returnvariable="countrySale">
<cfinvoke component="adminDashBoard" method="allDetails" returnvariable="stData" >

  <cfset countSession=createObject("java","coldfusion.runtime.SessionTracker")>
    <cfset sessionCollection=countSession.getSessionCollection("application_2_1_1")>

<cfset countVal=0>
  <cfset app=application.ApplicationName>
  <!---<cfloop collection="#sessionCollection#" item="keyValue">
<cfif NOT structIsEmpty(sessionCollection[keyValue])>
<cfset countVal=countVal+1>
</cfif>
  </cfloop>--->

<!---  <cfloop from="1" to="#structCount(sessionCollection)#" index="x">--->

<cfdump var=#countSession#>
  <cfdump var=#sessionCollection#>
<cfloop collection="#sessionCollection#" item="keyValue">

<!---    <cfloop collection=#sessionCollection[keyValue][innerKeyVal]# item="valOf">
    <cfoutput>
      #sessionCollection[keyValue][innerKeyVal][valOf]#<br/>#sessionCollection[keyValue]['sessionid']#
    </cfoutput>
  </cfloop>--->
  <cfif StructKeyExists(sessionCollection[keyValue],"stLoggedInUser")>
  <cfif  sessionCollection[keyValue]['stLoggedInUser']['userEmail'] EQ "avgchowdary@gmail.com">
    <cfset sessionVal=#sessionCollection[keyValue]['sessionID']#>
    <cfset userSessionInfo=countSession.getSession(app,sessionVal)>
  <cfset structDelete(sessionCollection[keyValue], "stloggedinuser")>
<cfdump var=#sessionCollection#>

  <!--- <cfoutput>
    #sessionCollection[keyValue]['stLoggedInUser']['userEmail']#
    <br/>
    #sessionCollection[keyValue]['sessionID']#
    <br/>
    #app#<br/>
    #sessionVal#<br/>
#countSession.getSession(app,sessionCollection[keyValue]['sessionID'])#
  </cfoutput> --->
</cfif>
</cfif>

</cfloop>

<cfset stdata={hey='works' , wow={wassap="wow"}}>
  <cfdump var="#stdata#" />

  <cfloop collection=#stdata# item="item">
  <cfif item EQ "wow">
    <cfloop collection="#stdata[item]#" item="itemVal">
      <cfoutput>
        #stdata[item][itemVal]#
      </cfoutput>
    </cfloop>
  </cfif>
</cfloop>

    <cfoutput>
      #countVal#

    </cfoutput>

    <cfdump var=#sessionCollection#>

      <body>
        <cfinclude template="header.cfm">
          <cfinclude template="adminMenu.cfm">
        <div class="container-fluid">


            <div class="col-md-8 col-sm-8">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">Track Session</h4>
                </div>
                <div class="panel-body">

                  <div class="col-md-3 col-sm-3 text-center colorBlue" id="customerInfo">
                    <div class="col-sm-8 col-md-8">
                  <cfoutput>
                     <h3>Hey</h3>
                     <h4>Active Users</h4>
                   </div>
                     <div class="col-md-3 col-sm-3" id="iTagDiv">
                       <span class="fa-stack fa-2x">
                  <i class="fa fa-circle-thin fa-stack-2x setCircle"></i>

                  <i class="fa fa-user fa-stack-1x setCircle"></i>
                </span>

                     </div>
                  </cfoutput>
                </div>


                </div>
              </div>
            </div>



        </div>
        <cfelse>
          <cflocation url="signin.cfm" />
    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="./script/adminEditAjax.js"></script>
  </body>
</html>
