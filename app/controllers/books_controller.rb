require 'open-uri'
require 'json'

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class BooksController < ApplicationController
  def index
    @books = Book.all

    # Github sosedoff
    key = "ud9nX57jOGdQCwP2PyP5Ig"
    secret = "GQh5qIFlro973mZLQM6bJEnMvogN4WpxwAr24afcQ"
    @client = Goodreads::Client.new(:api_key => key, :api_secret => secret)
    @result = @client.book_by_title("East of Eden")

  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new
    @book.book_title = params[:book_title]
    @book.author_id = params[:author_id]
    @book.published_year = params[:published_year]

    if @book.save
      redirect_to "/books", :notice => "Book created successfully."
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    @book.book_title = params[:book_title]
    @book.author_id = params[:author_id]
    @book.published_year = params[:published_year]

    if @book.save
      redirect_to "/books", :notice => "Book updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])

    @book.destroy

    redirect_to "/books", :notice => "Book deleted."
  end
end
