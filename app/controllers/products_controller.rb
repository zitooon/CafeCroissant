class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
	 @products = Product.find(:all)
	 
	 respond_to do |format|
		 format.html # index.html.erb
		 format.xml  { render :xml => @products }
	 end
  end

  def verif_admin
	  if session[:admin]
		  return true
	  else
	      return false
	  end
  end
  
  # GET /products/1
  # GET /products/1.xml
  def show
	  @product = Product.find(params[:id])
	  @products = Product.find(:all)
 
	  respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @product }
	  end
	end

  # GET /products/new
  # GET /products/new.xml
  def new
  if verif_admin
	  @product = Product.new
	  
	  respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @product }
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end   
  end

  # GET /products/1/edit
  def edit
  if verif_admin
    @product = Product.find(params[:id])
else
	redirect_to :controller => 'admins', :action => 'index'
end 
  end

  # POST /products
  # POST /products.xml
  def create
  if verif_admin
	  @product = Product.new(params[:product])
	  
	  respond_to do |format|
		  if @product.save
			  File.open("#{RAILS_ROOT}/public/images/products/"+@product.title+".jpg", "wb") do |f| 
				  f.write(params[:fichier].read)
			  end
			  @product.picture = @product.title+".jpg"
			  @product.save
			  flash[:notice] = 'Product was successfully created.'
			  format.html { redirect_to(@product) }
			  format.xml  { render :xml => @product, :status => :created, :location => @product }
		  else
			  format.html { render :action => "new" }
			  format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
		  end
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end   
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
  if verif_admin
	  @product = Product.find(params[:id])
	  
	  respond_to do |format|
		  if @product.update_attributes(params[:product])
			 if (params[:fichier] != "")
				 File.open("#{RAILS_ROOT}/public/images/products/"+@product.title+".jpg", "wb") do |f| 
					 f.write(params[:fichier].read)
				end
				@product.picture = @product.title+".jpg"
			 @product.save
			 end
		   flash[:notice] = 'Product was successfully updated.'
			  format.html { redirect_to(@product) }
			  format.xml  { head :ok }
		  else
			  format.html { render :action => "edit" }
			  format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
		  end
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end   
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
	  if verif_admin
		  @product = Product.find(params[:id])
		  if @product.picture
		  if (File.exist?("#{RAILS_ROOT}/public/images/products/"+@product.picture))
			 File.delete("#{RAILS_ROOT}/public/images/products/"+@product.picture)
		   end
	  end
	  @product.destroy
		  
		  respond_to do |format|
			  format.html { redirect_to(products_url) }
			  format.xml  { head :ok }
		  end
	else
		redirect_to :controller => 'admins', :action => 'index'
	end  
end
end
