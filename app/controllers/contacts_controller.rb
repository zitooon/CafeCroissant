class ContactsController < ApplicationController	
# GET /contacts
# GET /contacts.xml
  def index
    @contacts = Contact.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  
  def verif_admin
	  if session[:admin]
		  return true
	  else
	      return false
	  end
  end
  
  # GET /contacts/1
  # GET /contacts/1.xml
  def show
  if verif_admin
	  @contact = Contact.find(params[:id])
	  
	  respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @contact }
	  end
 else
	 redirect_to :controller => 'admins', :action => 'index'
 end  
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
  if verif_admin
	  @contact = Contact.new
	  
	  respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @contact }
	  end
 else
	 redirect_to :controller => 'admins', :action => 'index'
 end
  end

  # GET /contacts/1/edit
  def edit
  if verif_admin
    @contact = Contact.find(params[:id])
else
	redirect_to :controller => 'admins', :action => 'index'
end 
  end

  # POST /contacts
  # POST /contacts.xml
  def create
  if verif_admin
	  @contact = Contact.new(params[:contact])
	  
	  respond_to do |format|
		  if @contact.save
			  if (params[:fichier] != "")
			  File.open("#{RAILS_ROOT}/public/images/contacts/"+@contact.firstname+@contact.lastname+".jpg", "wb") do |f| 
				  f.write(params[:fichier].read)
			  end
			  @contact.picture = @contact.firstname+@contact.lastname+".jpg"
			  @contact.save
		  end
			  flash[:notice] = 'Contact was successfully created.'
			  format.html { redirect_to(@contact) }
			  format.xml  { render :xml => @contact, :status => :created, :location => @contact }
		  else
			  format.html { render :action => "new" }
			  format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
		  end
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end     
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
	  if verif_admin
		  @contact = Contact.find(params[:id])
		  
		  respond_to do |format|
			  if @contact.update_attributes(params[:contact])
				  if (params[:fichier] != "")
					  File.open("#{RAILS_ROOT}/public/images/contacts/"+@contact.firstname+@contact.lastname+".jpg", "wb") do |f| 
					  f.write(params[:fichier].read)
				  end
				  @contact.picture = @contact.firstname+@contact.lastname+".jpg"
				  @contact.save		
			  end
				  flash[:notice] = 'Contact was successfully updated.'
				  format.html { redirect_to(@contact) }
				  format.xml  { head :ok }
			  else
				  format.html { render :action => "edit" }
				  format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
			  end
		  end
else
	redirect_to :controller => 'admins', :action => 'index'
end   	  
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
   if verif_admin
	   @contact = Contact.find(params[:id])
	   if @contact.picture
		   if (File.exist?("#{RAILS_ROOT}/public/images/contacts/"+@contact.picture))
			   File.delete("#{RAILS_ROOT}/public/images/contacts/"+@contact.picture)
		   end
	   end
	   @contact.destroy
	   
	   respond_to do |format|
		   format.html { redirect_to(contacts_url) }
		   format.xml  { head :ok }
	   end
else
	redirect_to :controller => 'admins', :action => 'index'
end     
  end
end
