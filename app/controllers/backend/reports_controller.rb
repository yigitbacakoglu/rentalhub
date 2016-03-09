module Backend
  class ReportsController < Backend::BaseController
    before_filter :only_admin

    def index
      @owner_count = User.owner.count
      @tenant_count = User.tenant.count
      @property_count_for_rent = Property.for_rent.count
      @property_count_for_sale = Property.for_sale.count
    end

  end
end