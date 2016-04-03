# Require ShopSense API
require 'shopsense'

class LandingsController < ApplicationController
	before_action :authenticate_user!, only: :secure

	def index

    @list = List.new
  	#Shopsense API Setup 
    client = Shopsense::API.new({'partner_id' => 'uid7849-6112293-28'})

    @trends = [];
    trendingResponse = client.get_trends("", 1);
    # puts trendingResponse;
    raw_trends = JSON.parse(trendingResponse);
    # puts raw_trends;
    trending = raw_trends["trends"];
    # trending = trending.first(10);

    @trends = trending.map! do |trend|
    	product = trend["product"];
    	# puts product;
		 	image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      # puts image.inspect
      {
        'name' => product["name"],
        'image' => image["url"],
        'price' => product["priceLabel"],
        'url' => product["url"],
      }
    end

    # Empty products array
    if session[:show_more] == nil
      session[:show_more] = 20
    end
    # More search result has been performed
    if params[:more]
      @products = []
      response = client.search(params[:search], params[:more], params[:more])
      # puts response
      raw_products = JSON.parse(response)["products"]
      # puts raw_products.inspect
      raw_products = raw_products.first(10)

      # formating products 
      @products = raw_products.map! do |product|
        # gets the last large size image in the product image array
        image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
        # puts image.inspect
        {
          'name' => product["name"],
          'image' => image["url"],
          'price' => product["priceLabel"],
          'url' => product["url"],
          'inStock' => product["inStock"]
        }
      end
      @search = params[:search]
      session[:show_more] = session[:show_more] + 10

    elsif params[:search] && params[:more] == nil
      @products = []

      response = client.search(params[:search], 0, 10)
      # puts response
      raw_products = JSON.parse(response)["products"]
      # puts raw_products.inspect
      raw_products = raw_products.first(10)

      # formating products 
      @products = raw_products.map! do |product|
      # gets the last large size image in the product image array
      image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      # puts image.inspect
      {
        'name' => product["name"],
        'image' => image["url"],
        'price' => product["priceLabel"],
        'url' => product["url"],
        'inStock' => product["inStock"]
      }
      end
      # Set search to params
      @search = params[:search]
      session[:more] = 20
    end

		if current_user
      # Hide trending when user is logged-in
      @showTrend = "none"
		else 
      # When user is not logged-in show trending on homepage
      @showTrend = "block"
		end
	end


	def secure
		id = current_user.id
		user = User.find(id)

		puts "============"
		p user
		puts "============"
	end

  def trend
   @list = List.new
   client = Shopsense::API.new({'partner_id' => 'uid7849-6112293-28'})

    @trends = [];
    trendingResponse = client.get_trends("", 1);
    # puts trendingResponse;
    raw_trends = JSON.parse(trendingResponse);
    # puts raw_trends;
    trending = raw_trends["trends"];
    # trending = trending.first(10);

    @trends = trending.map! do |trend|
      product = trend["product"];
      # puts product;
      image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
      # puts image.inspect
      {
        'name' => product["name"],
        'image' => image["url"],
        'price' => product["priceLabel"],
        'url' => product["url"],
        'inStock' => product["inStock"]
      }
    end

    def user
    end
    
  end

end