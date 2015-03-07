Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'landing#landing'

  get 'login' => 'landing#login'
  get 'signup' => 'landing#signup'

  # API ROUTES *Change With Caution*
  # get 'apis', to: ApiController.action(:api_documentation)
  get 'api' => 'api#api_documentation'
  get 'api/:version/' => 'api#api_documentation'

  # Semi-Public Views
  get 'labs' => 'public#labs'
  get 'lab_view' => 'public#lab_view'

  # Teacher Routes
  get 'student_dashboard' => 'student#student_dashboard'

  # Student Routes
  get 'teacher_dashboard' => 'teacher#teacher_dashboard'
  get 'lab_creator' => 'teacher#lab_creator'

  # Matches all v1 apis requests to the request manager
  get 'api/:version/:api', to: 'api#request_manager', via: :all, constraints: {}
  get 'api/:version/:api/:method', to: 'api#request_manager', via: :all, constraints: {}
  get 'api/:version/:api/:method/:p1', to: 'api#request_manager', via: :all, constraints: {}
  get 'api/:version/:api/:method/:p1/:p2', to: 'api#request_manager', via: :all, constraints: {}
  get 'api/:version/:api/:method/:p1/:p2/:p3', to: 'api#request_manager', via: :all, constraints: {}
  get 'api/:version/:api/:method/:p1/:p2/:p3/:p4', to: 'api#request_manager', via: :all, constraints: {}



end
