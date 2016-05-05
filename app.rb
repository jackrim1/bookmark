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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
