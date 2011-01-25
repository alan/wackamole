module Session
  
  # ---------------------------------------------------------------------------
  # Check auth
  get "/login" do
    if console_auth?
      erb :'session/login'
    else 
      redirect '/mission'
    end
  end
  
  # ---------------------------------------------------------------------------
  # Log out  
  get "/session/delete" do
    session.clear
    redirect '/login'
  end
  
  # ---------------------------------------------------------------------------
  # Check credentials
  post "/session/create" do
    if authenticate( params[:login] )
      session[:user] = params[:login][:username]
      redirect '/mission'
    else
      flash_it!( :error, "Authentication failed! Please check credentials." )      
      redirect '/login'
    end
  end
end