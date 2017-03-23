class DemoController < ApplicationController
  layout 'application'

  def index
  end

  def hello
    @array = [1, 2, 3, 4 ,5]

    #use string or symbol
    @id = params['id']
    @page = params[:page]
  end

  def other_hello
    redirect_to('http://localhost:3000/demo/index')
  end

  def lynda
    redirect_to('https://www.lynda.com/')
  end

  def text_helpers

  end

end
