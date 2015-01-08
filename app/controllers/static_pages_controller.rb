class StaticPagesController < ApplicationController

  skip_before_action :authorize

  def home
  end

  def help
  end
end
