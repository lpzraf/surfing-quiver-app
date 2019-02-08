require './config/environment'

use Rack::MethodOverride

use SessionsController
use SurfboardOwnersController
use SurfboardsController
run ApplicationController
