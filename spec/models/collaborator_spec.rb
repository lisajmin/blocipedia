require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:wiki) { Wiki.create!(title: "Title", body: "Body") }
  let(:user) { User.create(email: "user@email.com", password: "password") }
  let(:collaborator) { Collaborator.create(user_id: user.id, wiki_id: wiki.id) }

  describe "attributes" do
    it "has user and wiki attributes" do
      expect(collaborator).to have_attributes(user_id: user.id, wiki_id: wiki.id)
    end

    it "refers to the user" do
      expect(collaborator.user_id).to eql(user.id)
    end

    it "refers to the wiki post" do
      expect(collaborator.wiki_id).to eql(wiki.id)
    end

  end

end
