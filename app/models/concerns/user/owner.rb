class User
  module Owner
    extend ActiveSupport::Concern

    included do

      def own_property(property_id)
        p = Property.find(property_id)
        return false unless p.connection_property?
        tenant = p.user
        p.user = self
        p.connection = false
        p.leases.build(user_id: tenant.id)
        p.save
      end

    end

  end
end