class Backend::ProfileController < BaseController


  def index
    @profile = @current_user.profile
  end

end

