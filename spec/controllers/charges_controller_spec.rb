require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end


end
