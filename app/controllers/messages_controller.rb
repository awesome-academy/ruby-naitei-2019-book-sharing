class MessagesController < ApplicationController
  include ActionView::Helpers::AssetTagHelper
  before_action :logged_in_user
  before_action :get_messages

  def index
    session[:conversations] ||= []

    @users = current_user.following
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

  def create
    @conversation =
      Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    broadcast_message @message, @conversation
  end

  private

  def get_messages
    @messages = Message.for_display
    @message  = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

  def render_message _message
    render(partial: "message", locals: {message: @message})
  end

  def broadcast_message message, conversation
    return unless message.save
    recipient_id = conversation.opposed_user(current_user).id
    ActionCable.server.broadcast "room_channel_user_#{recipient_id}",
      content:  markdown_to_html(emojify(message.content)),
      username: message.user.name,
      conversation: conversation.id,
      user_id: current_user.id,
      created_at: message.message_time

    respond_to :js
  end
end
