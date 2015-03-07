$(document).ready(function(){

    /*
     --------------> PAGE DEPENDENT <--------------
     Automatically links/binds attempt login button in login page
     to javascript below **DO NOT REMOVE**
     --------------> BINDING CODE <----------------
     */
    $('#landing-invite-button').on("click", function(){
        attemptEmailRequest();
    });


    /*
     Allows enter key to be used in login form
     */
    $(document).on('keypress', function(e){
        //Check that enter key was pressed
        if(e.keyCode == 13 && $("#landing-invite-input").is(":focus") ) {
            attemptEmailRequest();
        }
    });

});


/*
Requests an email invite signup
 */
function attemptEmailRequest(){

    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'public';
    parameters['api_method'] = 'request-invite';
    parameters['p1'] = $('#landing-invite-input').val();

    if(parameters['p1'] == ''){
        return false;
    }

    api_request(parameters, function(response){
        if(response['success'] == true) {
            animateResponse(response['completion_message']);
            return true;
        }
        else {
            animateResponse(response['completion_message']);
            return false;
        }
    });

}

function animateResponse(message){

}