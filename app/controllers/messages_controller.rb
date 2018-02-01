class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @place=Place.find(params[:place_id])
    @message = Message.create(message_params)
    if @message.save
      redirect_to place_path(@place)
    else
      redirect_to place_path(@place)
    end

  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_to  request.referrer || root_url
  end

  private

  def message_params
    params.require(:message).permit(:body, :place_id, :user_id, :user_name)
  end


end