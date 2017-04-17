<!---
FileName      :signin.cfm
Functionality : It is used for sign In purpose
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
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.min.js"></script>
</head>

<body>

    <cfinclude template="/common/header.cfm" />
    <cfif StructKeyExists(form, "submit")>
        <cfset authenticationService=createObject( "component", "Controller.authentication")>
            <cfset aErrorMessage=authenticationService.validateUser(form.email,form.password)>
                <cfif arrayIsEmpty(aErrorMessage)>
                    <cfset isUserLoggedIn=authenticationService.doLogin(form.email,form.password)>

                </cfif>
    </cfif>

    <div class="container">

        <div class="row">
            <div class="col-md-3" id="form-border" style="margin:auto ; left:0 ; right:0  ; position : absolute">

                <!---this is success and errohandling--->
                <cfif StructKeyExists(SESSION, "stLoggedInUser")>

                    <cfif structKeyExists(SESSION, "currentURL")>

                        <cflocation url="#SESSION.currentURL#" addtoken="false" />

                        <cfelse>
                            <cflocation url="/index.cfm" addtoken="false" />
                    </cfif>
                    <cfelse>

                        <cfif structKeyExists(variables, "isUserLoggedIn") AND isUserLoggedIn EQ false>
                            <div class="alert alert-warning">
                                <p>Need to SignUp or Entered fields are incorrect ....</p>
                            </div>
                        </cfif>

                        <cfif structKeyExists(variables, "aErrorMessage") AND NOT ArrayIsEmpty(aErrorMessage)>
                            <div class="alert alert-warning">
                                <cfloop array="#aErrorMessage#" index="item">
                                    <cfoutput>
                                        #item#
                                        <br/>
                                    </cfoutput>
                                </cfloop>
                            </div>
                        </cfif>

                        <h2>SignIn</h2>

                        <cfform name="cf_form_signin" id="cf_form_signin">

                            <div class="form-group">
                              <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                <cfinput class="form-control" name="email" id="email" type="email" required placeholder="Email id">
                              </div>
                            </div>

                            <div class="form-group">
                              <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
                                <cfinput class="form-control" type="password" name="password" id="password" placeholder="Password" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <cfinput class="btn btn-success" type="submit" name="submit" value="SignIn">
                            </div>
                        </cfform>

                </cfif>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
              <cfcache action="cache" timespan="#createTimespan(0,14,0,0)#" >
                <cfinclude template="/common/footer.cfm" />
              </cfcache>
            </div>
        </div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="/assets/script/autoSuggestion.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="/assets/script/validateClientSignIn.js"></script>

</body>
</html>
