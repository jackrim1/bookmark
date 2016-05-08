ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :sessions_secret, 'super secret'

  get '/' do
    redirect '/users/new'
  end

  get '/links' do
  	@links = Link.all
  	erb :links
  end

  get '/links/new' do
    erb :new_link
  end

  post '/links' do
    link = Link.create(title: params[:link_title], url: params[:link_url])
    tag_array = params[:link_tag].split(/\s*,\s*/)
    tag_array.each do |tag_name|
      tag = Tag.first_or_create(name: tag_name)
      LinkTag.create(:link => link, :tag => tag)
    end
    redirect('/links')
  end

  get '/tags/:tag' do
    tag = Tag.all.find {|tag| tag.name == params[:tag]}
    @links = tag.links
    erb :links
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to('/links')
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
