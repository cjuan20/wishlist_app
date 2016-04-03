# Require ShopSense API
require 'shopsense'

class ListsController < ApplicationController
	before_action :authenticate_user!

	def index
		#Shopsense API Setup 
    client = Shopsense::API.new({'partner_id' => 'uid7849-6112293-28'})
	end

	def show
		
	end

	def new
		@list = List.new			
	end

	def create
    @list = List.new(list_params)

    if @list.save
    	current_user.lists << @list
    	redirect_to :root
    end

	end

	def edit
		
	end

	def update
		
	end

	def destroy
	  @list = List.find(params[:id])
		current_user.lists.delete(@list)
		@list.destroy
		redirect_to :root
	end

	private
	# private methods for strong params
	def list_params
		params.require(:list).permit(:name, :image, :price, :url, :stock)
	end

end