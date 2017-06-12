class CollaboratorsController < ApplicationController

  def create
    @user = User.where(email: params[:email]).take
    @wiki = Wiki.find(params[:wiki_id])

    if @user == nil
      flash[:notice] = "User could not be found."
      redirect_to edit_wiki_path(@wiki)

    elsif @wiki.users.include?(@user)
      flash[:notice] = "User is already a collaborator."
      redirect_to edit_wiki_path(@wiki)

    else
      @collaborator = Collaborator.new
      @collaborator.user_id = @user.id
      @collaborator.wiki_id = @wiki.id

      if @collaborator.save
        flash[:notice] = "Collaborator added."
        redirect_to edit_wiki_path(@wiki)
      else
        flash[:notice] = "Error. Please try again."
        redirect_to edit_wiki_path(@wiki)
      end
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:alert] = "Error. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

end
