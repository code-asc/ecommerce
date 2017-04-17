<!---
FileName      :userProfileEdit.cfm
Functionality : It will show the profile details of the customer
--->
<!DOCTYPE html>
<cfheader name="Expires" value="#Now()#">
    <cfheader name="pragma" value="no-change" />
    <cfheader name="cache-control" value="no-cache,no-store,must-revalidate" />
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>
<cfset LOCAL.userProfile=createObject("component","Controller.userInfo")>
        <cfif structKeyExists(SESSION, "stLoggedInUser")>

            <cfif StructKeyExists(FORM, "submitUserEdit")>

                <cfoutput>
                    <cfif structKeyExists(FORM, "profilePhoto") AND len(FORM.profilePhoto) GT 0>
                        <cfif directoryExists( "D:\project_ecommerece\assets\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userID#")>
                            <cfdirectory action="delete" directory="D:\project_ecommerece\assets\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userID#" recurse="true">
                        </cfif>

                        <cfif NOT directoryExists( "D:\project_ecommerece\assets\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userID#")>
                            <cfdirectory action="create" directory="D:\project_ecommerece\assets\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userID#" />
                        </cfif>

                        <cffile action="upload" filefield="profilePhoto" destination="D:\project_ecommerece\assets\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userID#\" nameConflict="override" />

                        <!---<cffile action="rename" source="D:\project_ecommerece\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userEmail#\#cffile.ServerFileName#.#cffile.ServerFileExt#" destination="D:\project_ecommerece\usersInfo\ProfileImage\#SESSION.stLoggedInUser.userEmail#\#SESSION.stLoggedInUser.userID#_#SESSION.stLoggedInUser.userEmail#.#cffile.ServerFileExt#">--->

                        <cfset LOCAL.userProfile.uploadUserProfilePhoto(path="/assets/usersInfo/ProfileImage/#SESSION.stLoggedInUser.userID#/#cffile.ServerFileName#.#cffile.ServerFileExt#")>
                    </cfif>
                </cfoutput>

                <!---<cfinvoke component="userInfo" method="updateUserDetail" firstName="#form.firstName#" middleName="#form.middleName#" lastName="#form.lastName#" email="#form.email#" phone="#form.mobile#">--->
            </cfif>


              <cfset LOCAL.getquery=LOCAL.userProfile.getUserDetail()>
                <cfinclude template="/common/header.cfm">
                    <cfoutput query="LOCAL.getquery">
                        <div class="container">
                            <cfform enctype="multipart/form-data" id="userEditForm" name="userEditForm">
                                <div class="row" style="border-bottom:1px solid ##eaeaec ; margin-bottom:20px ; padding-bottom:15px">
                                    <h2>Edit Profile</h2>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3 col-md-3 col-xm-12" style="margin-bottom:20px;">

                                        <cfif len(userProfilePhoto) GT 0>
                                            <div class="row">
                                                <div style="height: 140px;width: 140px;overflow: hidden; overflow:hidden">
                                                    <img class="img-circle img-responsive" src="#LOCAL.getquery.userProfilePhoto#" alt=" ">
                                                </div>
                                            </div>
                                        </cfif>
                                        <div class="row">
                                            <p>Upload a different photo
                                        </div>
                                        <div class="row" style="margin-top:8px;">
                                            <div class="col-md-10 col-sm-10 col-xs-10" style="padding-left:0px;">
                                                <div class="form-group">
                                                    <cfinput type="file" name="profilePhoto" class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="col-sm-6 col-md-6 col-xm-6">
                                        <div class="row">
                                            <h3>Personal Info</h3>
                                        </div>
                                        <div class="col-sm-8 col-md-8 col-xs-8">
                                            <label for="firstName">First Name</label>
                                            <div class="form-group">
                                                <cfinput type="text" name="firstName" id="firstName" placeholder="First Name" class="form-control" value="#LOCAL.getquery.userFirstName#">
                                            </div>
                                        </div>

                                        <div class="col-sm-8 col-md-8 col-xs-8">
                                            <label for="middleName">Middle Name</label>
                                            <div class="form-group">
                                                <cfinput type="text" name="middleName" id="middleName" placeholder="Middle Name" class="form-control" value="#LOCAL.getquery.userMiddleName#">
                                            </div>
                                        </div>

                                        <div class="col-sm-8 col-md-8 col-xs-8">
                                            <label for="lastName">Last Name</label>
                                            <div class="form-group">
                                                <cfinput type="text" name="lastName" id="lastName" placeholder="Last Name" class="form-control" value="#LOCAL.getquery.userLastName#">
                                            </div>
                                        </div>

                                        <div class="col-sm-8 col-md-8 col-xs-8">
                                            <label for="email">Email Address</label>
                                            <div class="form-group">
                                                <cfinput type="text" id="email" name="email" placeholder="Email" class="form-control" value="#LOCAL.getquery.userEmail#">
                                            </div>
                                        </div>

                                        <div class="col-sm-8 col-md-8 col-xs-8">
                                            <label for="mobile">Mobile</label>
                                            <div class="form-group">
                                                <cfinput type="text" id="mobile" name="mobile" placeholder="mobile" class="form-control" value="#LOCAL.getquery.userPhone#">
                                            </div>
                                        </div>

                                        <div class="col-sm-12 col-md-12 col-xs-12">
                                            <div class="form-group">
                                                <cfinput type="submit" class="btn btn-primary" name="submitUserEdit" id="submitUserEdit" value="Save Changes">
                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </cfform>

                            <div id="showMessage">
                            </div>

                        </div>

                    </cfoutput>

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
                              <cfcache action="cache" timespan="#createTimespan(0,14,0,0)#" >
                                <cfinclude template="/common/footer.cfm" />
                              </cfcache>
                            </div>
                        </div>
                    </div>
                    <cfelse>
                        <cflocation url="/view/signin.cfm">
        </cfif>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="/assets/script/autoSuggestion.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
        <script src="/assets/script/validateClient.js"></script>
        <script src="/assets/script/userEditAjax.js"></script>
    </body>

    </html>
