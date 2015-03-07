// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//All global variables for the apis
var apiCallInProgress = false;

/**
 * API Request Format
 * www.domain.ext/apis/v1/api_name/method/param1/param2/etc...
 * parameters['version']
 * parameters['api_name']
 * parameters['api_method']
 * parameters['p1']
 * parameters['p2']
 * up to 7 parameters...
 */
function api_test() {
    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'user';
    parameters['api_method'] = 'create';
    parameters['p1'] = 'agasdsdin@gmail.com';
    parameters['p2'] = 'Christopher';
    parameters['p3'] = 'Wood';

    api_request(parameters, function(response){
        if(response['success'] == true) {
            alert(response);
        }
        else {
            alert('api called failed');
        }
    });
}


/**
 * Makes a call to the apis
 * @param parameters All parameters being sent to the request
 * @param callback The callback function
 */
function api_request(pars, callback) {

    //Every request starts valid till proven wrong
    var api_response = null;
    var validRequest = true;

    //Validate request before proceeding
    if (!typeof(pars['version']==='string')) { validRequest = false; }
    if (!typeof(pars['api_name']==='string')) { validRequest = false; }
    if (!typeof(pars['api_method']==='string')) { validRequest = false; }

    if (validRequest) {

        //Build request url
        var request_url = 'http://localhost:3000/api/' + pars['version'] + '/' + pars['api_name'] + '/' +
            pars['api_method'];

        //Create Ajax Request
        var request = $.ajax({
            url: request_url,
            beforeSend: function() {

            },
            data: pars,
            dataType: 'json',
            processData: true

        });
        request.done(function(data){
            api_response = data;
            if (typeof(callback)==='function')
            {
                callback(data);
            }
        });
        request.fail(function(data){

        });
        request.always(function(data){

        });
        request.then(function(){

        });

        return JSON.parse(api_response);
    }
    else {
        return false;
    }

}

function attemptUserLogin() {

    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'user';
    parameters['api_method'] = 'login';
    parameters['p1'] = $('#login-email').val();
    parameters['p2'] = $('#login-password').val();
    parameters['p3'] = $('#login-remember-me').is(":checked");

    api_request(parameters, function(response){
        if(response['success'] == true) {

            if(response['user_account_type'] == 'student') {
                window.location.replace("user_dashboard");
            }
            else if(response['user_account_type'] == 'teacher'){
                window.location.replace("teacher_dashboard");
            }
            return true;
        }
        else {
            return false;
        }
    });

}

function attemptUserLogout() {
    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'user';
    parameters['api_method'] = 'logout';

    api_request(parameters, function(response){
        if(response['success'] == true) {
            window.location.replace("login");
            return true;
        }
        else {
            return false;
        }
    });
}
