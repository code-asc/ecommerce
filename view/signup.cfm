<!---
FileName      :signup.cfm
Functionality : It will show sign up page
--->
<!DOCTYPE html>
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

    <cfinclude template="/common/header.cfm" />
    <cfif StructKeyExists(FORM, "submit")>
        <cfset LOCAL.checkIfNewUserCreatedError=createObject( "component", "Controller.authentication").addNewUser()>

            <cfif ArrayLen(LOCAL.checkIfNewUserCreatedError) GT 0>
                <cfset LOCAL.checkIfNewUserCreated=false>
                    <cfelse>
                        <cfset LOCAL.checkIfNewUserCreated=true>
            </cfif>
            <cfif LOCAL.checkIfNewUserCreated EQ true>
                <div class="alert alert-success">
                    <strong>Success....Registered</strong>
                    <br/>
                    <strong>Please SignIn To Continue....</strong>
                    <cfset structDelete(FORM, "submit")>
                </div>
                <cfelse>
                    <div class="alert alert-warning">
                        <strong>
      <cfloop array="#LOCAL.checkIfNewUserCreatedError#" index="item">
        <cfoutput>
          #item#
        </cfoutput>
      </cfloop>
    </strong>
                    </div>
            </cfif>

            <cfelse>

                <div class="container">
                    <div class="row" id="row_show_error">
                    </div>
                    <div class="row text-center">
                        <div class="col-md-4" id="form-border" style="margin:auto ; left:0 ; right:0  ; position : absolute">
                            <h2>SignUp Here</h2>
                            <cfform name="cf_form" id="cf_form">

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                    <cfinput name="firstName" id="firstName" type="text" class="form-control" placeholder="Your FirstName">
                                </div>
                              </div>

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                    <cfinput class="form-control" type="text" name="middleName" placeholder="Your MiddleName (Optional)">
                                </div>
                              </div>

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                    <cfinput class="form-control" type="text" name="lastName" placeholder="Your LastName (Optional)">
                                </div>
                              </div>

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-globe" aria-hidden="true"></i></span>
                                    <cfinput class="form-control" type="email" name="email" placeholder="Email id" required="true">
                                </div>
                              </div>

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-lock" aria-hidden="true"></i></span>
                                    <cfinput class="form-control" type="password" name="password" placeholder="Password" required="true">
                                </div>
                              </div>

                                <div class="form-group input-field">
                                  <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-mobile" aria-hidden="true"></i></span>
                                    <cfinput class="form-control" type="text" name="mobile" placeholder="Mobile" maxlength="10" minlength="10" required="true">
                                </div>
                              </div>

                                <div class="form-group">
                                    <cfinput class="btn btn-success" type="submit" name="submit" value="Register">
                                </div>
                            </cfform>
                        </div>
                    </div>
                </div>

    </cfif>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12" >
              <cfcache action="cache" timespan="#createTimespan(0,14,0,0)#" >
                <cfinclude template="/common/footer.cfm" />
              </cfcache>
            </div>
        </div>
    </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="/assets/script/autoSuggestion.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="/assets/script/validateClientTest.js"></script>
</body>
</html>
