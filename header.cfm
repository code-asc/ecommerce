<!DOCTYPE html>
<cfheader name="Expires" value="#Now()#">
  <cfheader name="pragma" value="no-change"/>
  <cfheader  name="cache-control" value="no-cache,no-store,must-revalidate"/>
<html lang="en">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="./css/csstyle.css">
  <link rel="stylesheet" href="./css/notification.css">
  <link rel="stylesheet" href="./css/signup.css">
  <!---<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--->

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>

  </head>
<body>

  <cfif StructKeyExists(session, "stLoggedInUser")>
      <cfthread action="run" name="setOnlineThread">
  <cfinvoke method="changeStatusToOnline" component="removeSession">
  </cfthread>
  </cfif>

<cfif structKeyExists(form,"submit")>
  <cfif StructKeyExists(form, "searchVal")>
  <cfset session.searchVal="#form.searchVal#">
    <cflocation url="searchPage.cfm?brand=#session.searchVal#" addtoken="false" />
  </cfif>
</cfif>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button class="btn btn-default navbar-toggle" data-toggle="collapse" data-target="#myMenu">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a href="index.cfm"><img class=" img-size" src="./images/logo.png"></a>
    </div>

    <div class="collapse navbar-collapse" id="myMenu">
    <ul class="nav navbar-nav">
      <li><a data-toggle="modal" data-target="#menModal" >Men</a>

      <!-- Modal -->
      <div class="modal fade" id="menModal" role="dialog">
      <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">

        <div class="modal-body">

          <cfquery name="subCategory">
            select Category.categoryType , SubCategory.subCategoryType , SubCategory.subCategoryID from Category
            inner join SubCategory
            on
            Category.categoryID=SubCategory.categoryID
            where Category.categoryID IN (2,3)

          </cfquery>
          <div class="row">
            <cfoutput query="subCategory" group="categoryType">
            <div class="col-md-6 col-sm-6 col-xm-6 col-lg-6">
            <h4>#subCategory.categoryType#</h4>
            <cfoutput>
          <a href="user_action.cfm?subCategoryType=#subCategory.subCategoryType#&subCategoryID=#subCategory.subCategoryID#">#subCategory.subCategoryType#</a>
            <br/>
            </cfoutput>
            </div>
            </cfoutput>
          </div>
        </div>

      </div>

      </div>
      </div>
</li>

      <li><a data-toggle="modal" data-target="#womenModal">Women</a>

      <!-- Modal -->
      <div class="modal fade" id="womenModal" role="dialog">
      <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">

        <div class="modal-body">

          <cfquery name="subCategory">
            select Category.categoryType , SubCategory.subCategoryType , SubCategory.subCategoryID from Category
            inner join SubCategory
            on
            Category.categoryID=SubCategory.categoryID
            where Category.categoryID IN (4,5)

          </cfquery>
          <div class="row">
            <cfoutput query="subCategory" group="categoryType">
            <div class="col-md-6 col-sm-6 col-xm-6 col-lg-6">
            <h4>#subCategory.categoryType#</h4>
            <cfoutput>
            <!---#subCategory.subCategoryType#--->
            <a href="user_action.cfm?subCategoryType=#subCategory.subCategoryType#&subCategoryID=#subCategory.subCategoryID#">#subCategory.subCategoryType#</a>
            <br/>
            </cfoutput>
            </div>
            </cfoutput>
          </div>
        </div>

      </div>

      </div>
      </div>


      </li>


      <li><a data-toggle="modal" data-target="#electronicsModal">Electronics</a>

      <!-- Modal -->
      <div class="modal fade" id="electronicsModal" role="dialog">
      <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">

        <div class="modal-body">

          <cfquery name="subCategory">
            select Category.categoryType , SubCategory.subCategoryType , SubCategory.subCategoryID from Category
            inner join SubCategory
            on
            Category.categoryID=SubCategory.categoryID
            where Category.categoryID IN (1)

          </cfquery>
          <div class="row">
            <cfoutput query="subCategory" group="categoryType">
            <div class="col-md-4 col-sm-4 col-xm-4 col-lg-4">
            <h4>#subCategory.categoryType#</h4>
            <cfoutput>
            #subCategory.subCategoryType#
            <br/>
            </cfoutput>
            </div>
            </cfoutput>
          </div>
        </div>

      </div>

      </div>
      </div>
      </li>
    </ul>
    <form class="navbar-form navbar-left" action="header.cfm" method="post">
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search" name="searchVal" id="getSuggestion">
        <div class="input-group-btn">
          <button class="btn btn-default btn-search-color" name="submit" type="submit">
            <i class="glyphicon glyphicon-search"></i>
          </button>
        </div>
      </div>
    </form>

    <ul class="nav navbar-nav">
      <li>
        <a href="#" type="button" class="dropdown-toggle" data-toggle="dropdown" data-target="loginButton">
          <i class="fa fa-user"  aria-hidden="true"></i>
           &nbsp <cfoutput>
             <cfif structKeyExists(session, "stLoggedInUser")>
               <i class="fa fa-caret-down" aria-hidden="true"></i>
               <cfelse>
             Login
           </cfif>
           </cfoutput>
         </a>

       <ul class="dropdown-menu" id="loginButton">

         <!---if user exists , we hide SignIn and SignUp options--->
         <cfif structKeyExists(session, "stLoggedInUser")>
           <li class="dropdown-header"><cfoutput>
             #session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userMiddleName# #session.stLoggedInUser.userLastName#
           </cfoutput></li>

           <cfif session.stLoggedInUser.userEmail EQ 'admin@admin.com'>
              <li><a href="admin.cfm">Admin Edit</a></li>
           <cfelse>
           <li class="divider"></li>

           <li><a href="OrderDetails.cfm"><i class="fa fa-credit-card" aria-hidden="true"></i>&nbsp Purchases</a></li>
           <li class="divider"></li>
         </cfif>

<li><a href="index.cfm?logout"><i class="fa fa-sign-out" aria-hidden="true"></i> &nbsp SignOut</a></li>
           <cfelse>
         <li><a href="signin.cfm"><i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp SignIn</a></li>
         <li><a href="signup.cfm"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp SignUp</a></li>
       </cfif>
       </ul>
     </li>


<!--- Notification --->
<li>
  <cfwebsocket name="world" onmessage="msgHandler" onopen="openHandler" subscribeTo="world"/>

<cfinvoke method="getNotification" component="adminData" returnvariable="notificationquery">
  <a id="dLabel" role="button" data-toggle="dropdown" data-target="#">
    <i  class="glyphicon glyphicon-bell"></i>
  </a>

  <ul class="dropdown-menu notifications" role="menu" aria-labelledby="dLabel">

    <div class="notification-heading"><h4 class="menu-title">Notifications</h4><h4 class="menu-title pull-right">View all</h4>
    </div>
    <li class="divider"></li>
   <div class="notifications-wrapper">

<cfif notificationquery.recordCount GT 0>
  <cfloop query="notificationquery">
    <cfoutput>
      <a class="content" href="##"><div class="notification-item"><h4 class="item-title">#notificationquery.postTime# ago</h4><p class="item-info">#notificationquery.content#</p></div></a>
    </cfoutput>
  </cfloop>

  <cfelse>
    <a class="content" href="##"><div class="notification-item"><h4 class="item-title"></h4><p class="item-info">No notifications</p></div></a>
</cfif>
   </div>
    <li class="divider"></li>

  </ul>

</li>
<!--- --->

<li><a href="userCart.cfm"><i class="fa fa-shopping-cart" aria-hidden="true"></i>&nbsp Cart&nbsp
<cfif structKeyExists(session,"cartCount")>
  <span class="badge" id="traceCount">
  <cfoutput>
    #session.cartCount#
  </cfoutput>
  </span>

</cfif>
</a>
</li>

    </ul>

</div>
  </div>
</nav>

<!---<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="./script/autoSuggestion.js"></script>--->
<script src="./script/userSocketAjax.js"></script>
<script src="./script/onWindowClose.js"></script>
</body>
</html>
