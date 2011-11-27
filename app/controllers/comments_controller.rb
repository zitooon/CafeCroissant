class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  def verif_admin
	  if session[:admin]
		  return true
	  else
	      return false
	  end
  end
  
  # GET /comments/1
  # GET /comments/1.xml
  def show
	  if verif_admin
		  @comment = Comment.find(params[:id])
		  
		  respond_to do |format|
			  format.html # show.html.erb
			  format.xml  { render :xml => @comment }
		  end
else
	redirect_to :controller => 'admins', :action => 'index'
end  	  
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
	 if verif_admin
		 @comment = Comment.new
	  
	  respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @comment }
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end    
  end

  # GET /comments/1/edit
  def edit
   if verif_admin
	   @comment = Comment.find(params[:id])
else
  redirect_to :controller => 'admins', :action => 'index'
end  
end

  # POST /comments
  # POST /comments.xml
  def create
   if verif_admin
	   @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
		  if (params[:fichier] != "")
			  File.open("#{RAILS_ROOT}/public/images/services/"+@comment.title+".jpg", "wb") do |f| 
				  f.write(params[:fichier].read)
			  end
			  @comment.picture = @comment.title+".jpg"
			  @comment.save
		  end
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
else
redirect_to :controller => 'admins', :action => 'index'
end  
	end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
	 if verif_admin
		 @comment = Comment.find(params[:id])
	  
	  respond_to do |format|
		  if @comment.update_attributes(params[:comment])
			   if (params[:fichier] != "")
				   File.open("#{RAILS_ROOT}/public/images/services/"+@comment.title+".jpg", "wb") do |f| 
					   f.write(params[:fichier].read)
				   end
				   @comment.picture = @comment.title+".jpg"
				   @comment.save
			   end
			  flash[:notice] = 'Comment was successfully updated.'
			  format.html { redirect_to(@comment) }
			  format.xml  { head :ok }
		  else
			  format.html { render :action => "edit" }
			  format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
		  end
	  end
else
	redirect_to :controller => 'admins', :action => 'index'
end    
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    if verif_admin
		@comment = Comment.find(params[:id])
		if @comment.picture
			if (File.exist?("#{RAILS_ROOT}/public/images/services/"+@comment.picture))
				File.delete("#{RAILS_ROOT}/public/images/services/"+@comment.picture)
			end
		end
		@comment.destroy

		 respond_to do |format|
		   format.html { redirect_to(comments_url) }
		   format.xml  { head :ok }
		  end
 else
	 redirect_to :controller => 'admins', :action => 'index'
 end  
	 end
end
