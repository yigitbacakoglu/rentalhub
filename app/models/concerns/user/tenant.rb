class User
  module Tenant
    extend ActiveSupport::Concern

    included do
      has_many :leases

    end

  end
end