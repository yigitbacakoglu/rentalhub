user = User.new
user.email = 'admin@example.net'
user.firstname = 'Admin'
user.lastname = 'User'
user.description = 'Admin User'
user.username = 'Admin'
user.role = 'Admin'
user.password = 12345678
user.password_confirmation = 12345678
user.save


user = User.new
user.email = 'owner@example.net'
user.firstname = 'Owner'
user.lastname = 'User'
user.description = 'This is an example description for my account. '
user.username = 'Owner'
user.role = 'Owner'
user.password = 12345678
user.password_confirmation = 12345678
user.save


user = User.new
user.email = 'tenant@example.net'
user.firstname = 'tenant'
user.lastname = 'User'
user.description = 'This is an example description for my account. '
user.username = 'Tenant'
user.role = 'Tenant'
user.password = 12345678
user.password_confirmation = 12345678
user.save