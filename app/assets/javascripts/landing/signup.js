

/*
Setup bindings for SIGNUP PAGE
 */
$(document).ready(function(){

    /*
     --------------> PAGE DEPENDENT <--------------
     Automatically links/binds attempt signup button in login page
     to javascript below **DO NOT REMOVE**
     --------------> BINDING CODE <----------------
     */
    $('#signup-button').on("click", function(){
        attemptUserSignup();
    });


    /*
    Allows enter key to be used in signup form
     */
    $(document).on('keypress', function(e){
        //Check that enter key was pressed
        if(e.keyCode == 13 && ($("#signup-full-name").is(":focus") ||
            $("#signup-email").is(":focus") || $("#signup-password").is(":focus") ||
            $("#signup-confirm-password").is(":focus"))) {
            attemptUserSignup();
        }
    });

    /*
    Binds checkbox clicking event
     */
    $('#signup-show-password').click(function() {
        //If already checked, enable password view
        var password_field = $('#signup-password');
        var password_confirm_field = $('#signup-confirm-password');

        if($('#signup-show-password').is(':checked')) {
            password_field.get(0).setAttribute('type', 'none');
            password_confirm_field.get(0).setAttribute('type', 'none');
        }
        else { //Else, disable password view
            password_field.get(0).setAttribute('type', 'password');
            password_confirm_field.get(0).setAttribute('type', 'password');
        }
    });

});

/*
Attempts to signup user based off of form information
Pre: Not condition is required except that user is on signup page
 */
function attemptUserSignup() {

    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'user';
    parameters['api_method'] = 'signup';
    parameters['p1'] = '';
    parameters['p2'] = '';
    parameters['p3'] = $('#signup-email').val();
    parameters['p4'] = $('#signup-password').val();

    var account_type = $('input:radio[name=account_type]:checked').val();

    //Split name for verification later
    var full_name = $('#signup-full-name').val().split(' ');

    /*
    Check to make sure first and last name are provided
     */
    if(full_name.length != 2){
        alert("Please enter first and last name only");
        $('#signup-full-name').focus();
        return false;
    }
    else {
        //Set first and last name into parameters
        parameters['p1'] = full_name[0];
        parameters['p2'] = full_name[1];
    }

    if(parameters['p3'].length == 0){
        alert('Please provide a valid email address');
        $('#signup-email').focus();
        return false;
    }

    if(parameters['p4'].length < 6) {
        alert('Password must be at least 6 characters in length');
        $('#signup-password').focus();
        return false;
    }
    else if(parameters['p4'] != $('#signup-confirm-password').val()) {
        alert('Passwords must match!');
        $('#signup-password').focus();
        return false;
    }


    if(account_type == 'student' || account_type == 'teacher') {
        parameters['p5'] = account_type;
    }
    else {
        alert("You must register as a Student or Teacher!");
        return false;
    }


    $('#login-button').prop("disabled", true);

    api_request(parameters, function(response){

        $('#login-button').prop("disabled", false);
        if(response['success'] == true) {

            return true;
        }
        else {
            return false;
        }
    });
}