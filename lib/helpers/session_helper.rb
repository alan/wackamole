module SessionHelper  
  helpers do
    
    # Check credentials against config file
    def authenticate( creds )
      return true
      
      # No auth. Let it go
      return true unless auth
      
      # Validate creds      
      ((creds['username'] == auth['user']) and (creds['password'] == auth['password']))
    end
    
    # Check if auth is defined
    def console_auth?
      false
    end
    
    # Check if session has auth
    def authenticated?
      true
    end
    
    # check for login path
    def root_path?
      request.path == "/"
    end
  end
end