require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
Dir['./lib/*.rb'].each { |f| require f }

configure :development, :test do
  set :database, {adapter: 'sqlite3', database: 'interview.db'}
end

class Main < Sinatra::Base
  get '/' do
    @addresses = Address.all
    erb :index #, locals: { address: address }
  end
end
