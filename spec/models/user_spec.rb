require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: "user@email.com", password: "password") }

  describe "attributes" do
    it "email and password attributes" do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end
  end

end
