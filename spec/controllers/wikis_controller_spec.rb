require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let (:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  let (:private_wiki) {Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: true) }
  let (:my_user) { create(:user) }
  let (:premium_user) { User.create!(email: "lisa@email.com", password: "password", role: "premium") }
  let (:other_user) { create(:user) }

  context "signed in user" do
    before do
      sign_in(my_user)
    end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_wiki.id}
      expect(response).to render_template :edit
    end

    it "assigns wiki post to @wiki" do
      get :edit, {id: my_wiki.id}
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end
  end

  describe "POST create" do
    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new post" do
      post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "PUT update" do
    it "updates wiki post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
      expect(response).to redirect_to my_wiki
    end

    it "edits wiki by another user" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      other_post = Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: other_user)

      put :update, id: other_post.id, wiki: {title: new_title, body: new_body}
      updated_wiki = assigns(:wiki)

      expect(updated_wiki.id).to eq other_post.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
      expect(updated_wiki.user).to eq other_user
      expect(subject.current_user).to eq my_user
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_wiki.id}
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to wiki index" do
      delete :destroy, {id: my_wiki.id}
      expect(response).to redirect_to wikis_path
    end
  end

end

  context "signed in as premium user" do
    before do
      sign_in(premium_user)
    end
    describe "private wiki" do
      it "creates a private wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph, private: true }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "show the private wiki" do
        get :show, {id: private_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
