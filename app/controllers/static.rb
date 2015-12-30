# get '/' do
#   @urls = Url.all.order(click_count: :desc)
#   erb :"static/index"

# end

get '/' do
	puts "[LOG] Getting /"
	@urls = Url.all
	erb :"static/index"
end

post '/urls' do
	puts "[LOG] Getting /urls"
	puts "[LOG] Params: #{params.inspect}"
	@url= Url.create(long_url: params[:long_url])
	@short_url = @url.shorten
	@url.update(short_url: @short_url)
	@url.save
	redirect '/'
	#redirect '/url/#{@url.id}'
end

get '/:short_url' do
	puts "[LOG] Getting /:short_url"
	puts "[LOG] Params: #{params.inspect}"
	@url = Url.find_by(short_url: params[:short_url])
	@url.count
	redirect to(@url.long_url)
end
