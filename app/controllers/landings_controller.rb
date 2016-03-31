# Require ShopSense API
require 'shopsense'

class LandingsController < ApplicationController
	before_action :authenticate_user!, only: :secure

	def index
  	#Shopsense API Setup 
    client = Shopsense::API.new({'partner_id' => 'uid7849-6112293-28'})

		# Empty products array
 		@products = []
    # a search has been performed
    if params[:search]
      response = client.search(params[:search])
      # puts response
      raw_products = JSON.parse(response)["products"]
      # puts raw_products.inspect

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
    end

    @trends = [];

    trendingResponse = client.get_trends("", 1);
    # puts trendingResponse;
    raw_trends = JSON.parse(trendingResponse);
    # puts raw_trends;
    trending = raw_trends["trends"];
    trending = trending.first(10);

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

		if current_user
			puts "I'm logged in as #{current_user.email} and my name is #{current_user.name}"
		else 
			puts "I'm not logged in"
		end
	end


	def secure
		id = current_user.id
		user = User.find(id)

		puts "============"
		p user
		puts "============"
	end

end