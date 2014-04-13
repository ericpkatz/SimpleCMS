class ContentsController < ApplicationController

  def create
    content = Content.new content_params
    content.save!
    render json: content.to_json
  end

  def update
    content = Content.find params[:id]
    content.update_attributes content_params
    render json: content.to_json
  end

  def destroy
    content = Content.find params[:id]
    content.destroy!
    render json: { success: true } 
  end

  def content_params
    params.require(:content).permit(:title, :body, :priority)
  end

end
