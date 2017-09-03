class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    if params[:short_url]
        @url = Url.find_by short_url: params[:short_url]
      if redirect_to "#{@url.original_url}"
        @url.clicks += 1
        ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
        if !@url.ip_addresses.include? ip
          @url.ip_addresses.push(ip)
        end
        @url.save
      end
    else
      @base_url = "#{request.protocol}#{request.host_with_port}/"
      @url = Url.find(params[:id])
    end
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  def create
      @url = Url.new(url_params)

    if @url.save
        redirect_to @url
    else
      render 'new'
    end
  end


private
# Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
        params.require(:url).permit(:short_url, :original_url, :clicks, :ip_addresses)
    end
end
