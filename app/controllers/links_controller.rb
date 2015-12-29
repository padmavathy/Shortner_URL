require 'bitly'
require 'socket'

class LinksController < ApplicationController
  before_action :set_link, only: [:show, :destroy]
  before_filter :authenticate_user!, only: [:new,:create,:destroy]

  def index
    current_user.present? ? @links = current_user.links : @links = Link.all
    @client = Bitly.client
    @ip_address = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
  end

  def show
    @client = Bitly.client
  end

  def new
    @link = Link.new
  end


  def create
    @link = Link.new(link_params)
    client = Bitly.client
    unless link_params["given_url"].empty?
    url = client.shorten(link_params["given_url"]).short_url
    @link.given_url = link_params["given_url"]
    @link.shortened_url = url
    end
    @link.user_id = current_user.id
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url,:slug,:count)
    end
end
