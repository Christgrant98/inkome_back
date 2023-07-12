class StoriesController < ApplicationController

  before_action :set_story, only: [:show, :update, :destroy]

def index
    render(
      json: @current_user.stories,
      each_serializer: StorySerializer
    )
end

  # POST /users/:user_id/stories
  def create
    @story = Story.new(story_params)
    @story.user_id = @current_user.id


    if @story.save
      render json: @story, serializer: StorySerializer, status: :created
    else
      render json: { error: @story.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  private

  def set_story
    @story = @current_user.stories.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:image)
  end


end
