/*
 Setup bindings for LOGIN PAGE
 */
$(document).ready(function(){

    /*
     --------------> PAGE DEPENDENT <--------------
     Automatically links/binds attempt login button in login page
     to javascript below **DO NOT REMOVE**
     --------------> BINDING CODE <----------------
     */
    $('#login-button').on("click", function(){
        attemptUserLogin();
    });


    /*
     Allows enter key to be used in login form
     */
    $(document).on('keypress', function(e){
        //Check that enter key was pressed
        if(e.keyCode == 13 && ($("#login-email").is(":focus") || $("#login-password").is(":focus")) ) {
            attemptUserLogin();
        }
    });

});