class ApplicationController < ActionController::API
  include Knock::Authenticable

  private
  def find_list(id)
    @list = current_user.lists.find(id)
  end
end
