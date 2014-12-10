class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all

    # Github sosedoff
    @key = "ud9nX57jOGdQCwP2PyP5Ig"
    @secret = "GQh5qIFlro973mZLQM6bJEnMvogN4WpxwAr24afcQ"
    @client = Goodreads::Client.new(:api_key => @key, :api_secret => @secret)


  end

  def show
    @favorite = Favorite.find(params[:id])

    # Github sosedoff
    @key = "ud9nX57jOGdQCwP2PyP5Ig"
    @secret = "GQh5qIFlro973mZLQM6bJEnMvogN4WpxwAr24afcQ"
    @client = Goodreads::Client.new(:api_key => @key, :api_secret => @secret)

    @book_id_search = @favorite.book_id
    @book_by_id = @client.book(@book_id_search)


    # Nokogiri
    url_of_book_id_search = "https://www.goodreads.com/book/show/" + @favorite.book_id.to_s + "?format=xml&key=" + @key
    raw_book_id_data = open(url_of_book_id_search).read
    parsed_book_id_data = Nokogiri::XML(raw_book_id_data)
    @book_id_results = parsed_book_id_data.css("GoodreadsResponse")

    @other_users = Favorite.where(:book_id => @favorite.book_id).map{|favorite| favorite.user} - [current_user]

  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new
    @favorite.user_id = params[:user_id]
    @favorite.book_id = params[:book_id]

    if @favorite.save
      redirect_to "/favorites", :notice => "Favorite created successfully."
    else
      render 'new'
    end
  end

  def edit
    @favorite = Favorite.find(params[:id])
  end

  def update
    @favorite = Favorite.find(params[:id])

    @favorite.user_id = params[:user_id]
    @favorite.book_id = params[:book_id]

    if @favorite.save
      redirect_to "/favorites", :notice => "Favorite updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])

    @favorite.destroy

    redirect_to "/favorites", :notice => "Favorite deleted."
  end
end
