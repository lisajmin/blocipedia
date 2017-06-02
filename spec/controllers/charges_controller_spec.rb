require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "POST create" do
    it "upgrades a user role" do
      post :create, { current_user: user }
      expect(user.role).to eql("premium")
    end
  end

  describe "PUT downgrade" do
    it "downgrades a user role" do
      user.premium!
      put :downgrade, { current_user: user }
      expect(user.role).to eql("standard")
    end
  end

end
