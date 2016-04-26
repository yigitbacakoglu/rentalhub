module Backend
  class LeasesController < Backend::BaseController
    before_action :only_tenant

    def index
      @leases = @current_user.leases
    end

    def only_tenant
      redirect_to backend_profile_path and return unless @current_user.tenant?
    end

  end
end