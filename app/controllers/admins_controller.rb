class AdminsController < ApplicationController
  # GET /admins
  # GET /admins.xml
  def index
	  if verif_admin
		 render :action => 'index'
	  else
		  render :action => 'login'
	  end
  end

  def verif_admin
	  if session[:admin]
		  return true
	  else
	      return false
	  end
  end
  
  def list
  @admins = Admin.find(:all)
  respond_to do |format|
	  format.html #list.html.erb
	  format.xml  { render :xml => @admins }
  end
end

  
  def login 
	  @admin = Admin.find_by_name_and_password(params[:admin][:name],params[:admin][:password])
	  if @admin
		  session[:admin] ||= true
		  flash[:notice] = 'You are succesfully logged'
		  redirect_to :action => 'index'
	  else
		  flash[:notice] = 'Bad name or password.'
		  render :action => 'login'
	  end
  end
  
  def logout
	session[:admin] = nil
	flash[:notice] = 'You are succesfully logged out'
	redirect_to :controller => 'products', :action => 'index'
  end
  
  
  # GET /admins/1
  # GET /admins/1.xml
  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        flash[:notice] = 'Admin was successfully created.'
        format.html { redirect_to(@admin) }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = 'Admin was successfully updated.'
        format.html { redirect_to(@admin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to(admins_url) }
      format.xml  { head :ok }
    end
  end
end
