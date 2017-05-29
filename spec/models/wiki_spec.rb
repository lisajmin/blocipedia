require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "Title", body: "Body") }

  describe "attribute" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Title", body: "Body")
    end
  end
end
