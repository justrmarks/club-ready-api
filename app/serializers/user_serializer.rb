class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :aboutme, :role


  attribute :email, if: Proc.new { |user, params|
    user.role == 'organizer'
 }

end
