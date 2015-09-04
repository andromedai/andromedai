function deleteLab(lab_id){

    var parameters = {};
    parameters['version'] = 'v1';
    parameters['api_name'] = 'lab';
    parameters['api_method'] = 'delete';
    parameters['p1'] = lab_id;

    if(lab_id == '') {
        alert('cannot delete lab');
        return false;
    }

    api_request(parameters, function(response){
        if(response['success'] == true) {

            $('#lab_row_' + lab_id).remove();
            return true;
        }
        else {
            alert(response['message']);
            return false;
        }
    });
}