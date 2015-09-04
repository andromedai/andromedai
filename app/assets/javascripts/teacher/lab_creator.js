$(document).ready(function(){

    /*
     --------------> PAGE DEPENDENT <--------------
     Automatically links/binds attempt login button in login page
     to javascript below **DO NOT REMOVE**
     --------------> BINDING CODE <----------------
     */
    $('#create-lab-button').on("click", function(){
        attemptCreateNewLab();
    });

});

function attemptCreateNewLab() {

    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'lab';
    parameters['api_method'] = 'create';
    parameters['p1'] = $('#lab-title').val();
    parameters['p2'] = $('#lab-description').val();
    parameters['p3'] = $('#lab-video-url').val();

    if(parameters['p1'] == ''){
        alert("Lab title cannot be empty");
        return false;
    }

    if(parameters['p2'] == ''){
        alert("Lab description cannot be empty");
        return false;
    }

    if(parameters['p3'] == ''){
        alert("Lab video url cannot be empty");
        return false;
    }

    $('#create-lab-button').prop("disabled", true);

    api_request(parameters, function(response){

        $('#create-lab-button').prop("disabled", false);
        if(response['success'] == true) {
            $('#lab-title').val('');
            $('#lab-description').val('');
            $('#lab-video-url').val('');
            alert("Lab Created");
            return true;
        }
        else {
            return false;
        }
    });
}

