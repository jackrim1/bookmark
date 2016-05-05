ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  get '/' do
    'Hello BookmarkManager!'
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
    tag = Tag.first_or_create(name: params[:link_tag])
    LinkTag.create(:link => link, :tag => tag)
    redirect('/links')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
