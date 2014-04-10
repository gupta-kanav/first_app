require 'open-uri'
require 'json'
require 'net/http'
class UsersController < ApplicationController
  
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # render :json => Task.group_by_day(:completed_at).count
    @data = [[34, 42], [56, 49]]
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def getvisualizations
    @data = [[34, 42], [56, 49]]
    @users = User.all
    @dos_5K = 0
    @dos_5K_10K = 0
    @dos_10K_15K = 0
    @dos_15K_20K = 0
    @dos_20K = 0
    parsed_json={}
    arry=[]
    open("https://api.parse.com/1/classes/BigData",
       "X-Parse-Application-Id" => "WSMU16w9uji7NXC9VpgYs8marftMwiGwyyiveZbw",
       "X-Parse-REST-API-Key" => "mmMJUgaACO63XShGn3pAHDohkCBblNsz9czqEZ0U",
        "data-urlencode" =>'where={"MonthlyIncome":{"$gt":20000}}',
       "content-type" => "application/json") {|f|
         parsed_json = ActiveSupport::JSON.decode(f)
         
         # Rails.logger.info "---- FBUid header -----#{parsed_json.inspect}" 
       # f.each_line {|line| p line}
     }
     
     parsed_json["results"].each do |name|
       if name["MonthlyIncome"]!=nil
         
         if name["MonthlyIncome"]>=0 && name["MonthlyIncome"]<=5000
             @dos_5K+=1
         elsif name["MonthlyIncome"]>5000 && name["MonthlyIncome"]<=10000
             @dos_5K_10K+=1
           elsif name["MonthlyIncome"]>10000 && name["MonthlyIncome"]<=15000
               @dos_10K_15K+=1
           elsif name["MonthlyIncome"]>15000 && name["MonthlyIncome"]<=20000
               @dos_15K_20K+=1
         else
             @dos_20K+=1
         end
       # arry << name["MonthlyIncome"]
       end
     end
     Rails.logger.info "----0_5K-----#{@dos_5K.inspect}"
          Rails.logger.info "----5k_10K-----#{@dos_5K_10K.inspect}"
               Rails.logger.info "----10K_15K-----#{@dos_10K_15K.inspect}"
                    Rails.logger.info "----15K_20K-----#{@dos_15K_20K.inspect}"
                         Rails.logger.info "----g_20K-----#{@dos_20K.inspect}"
     
     @array_of_arrays1 = [[5000,@dos_5K], [10000,@dos_5K_10K],[15000,@dos_10K_15K],[20000,@dos_15K_20K],[">20000 INR",@dos_20K,]]
     
                         @array_of_arrays = [[@dos_5K,"0-5000 INR"], [@dos_5K_10K,"5000-10000 INR"],[@dos_10K_15K,"10000-15000 INR"],[@dos_15K_20K,"15000-20000 INR"],[@dos_20K,">20000 INR"]]

                         @array_of_hashes = []
                         @array_of_arrays.each { |record| @array_of_hashes << {'name' => record[1], 'data' => record[0].to_i} }

                         # p @array_of_hashes
       
    
 #    require "net/http"
 
   
  
  
   #  uri = URI.parse("https://api.parse.com/1/classes/BigData")
   #  http = Net::HTTP.new(uri.host, uri.port)
   #  http.use_ssl = true
   #  http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
   #   
   #  request["X-Parse-Application-Id"] = "WSMU16w9uji7NXC9VpgYs8marftMwiGwyyiveZbw"
   #  request["X-Parse-REST-API-Key"] = "mmMJUgaACO63XShGn3pAHDohkCBblNsz9czqEZ0U"
   #  # response["content-type"]= "application/json; charset=UTF-8"
   #  request = Net::HTTP::Get.new(uri.request_uri)
   #  
   #  response = http.request(request)
   # test_json = ActiveSupport::JSON.decode(response.read_body)
    
    # response.read_body do |str|   # read body now
  #      print str
  #    end
  #  
 # Rails.logger.info "---- FBUid header -----#{test_json.inspect}" 
 #    # Get specific header
 # 
 #    # Iterate all response headers.
 #    response.each_header do |key, value|
 #      puts "#{key} => #{value}"
 #    
 #    end
 respond_to do |format|
     format.html { render action: 'visual' }
   end
   
   
 end
    
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
