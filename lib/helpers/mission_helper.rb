module MissionHelper
  helpers do 

    def extract_applications( pulse )
      apps = BSON::OrderedHash.new
      pulse[:to_date].keys.sort.each { |app_name| apps[app_name] = pulse[:to_date][app_name].keys.sort }
      apps
    end
    
    # -------------------------------------------------------------------------
    def load_report      
      @old_reports = Wackamole::Mission.find( {}, :sort => [ [:app, Mongo::ASCENDING], [:env, Mongo::ASCENDING] ] ).to_a
      last_tick           = session[:last_tick]
      reset               = last_tick.nil?
      last_tick           = last_tick || Chronic.parse( '1 minute ago' )
      session[:last_tick] = Time.now
      
      @reports = Wackamole::Mission.rollups( last_tick.utc, reset )
    end
    
    # -------------------------------------------------------------------------
    # compute diff delta    
    def delta?( diff )
      diff == 0 ? content_tag( :span, diff, :class => "no_diff") : content_tag( :span, "+#{diff}", :class => "diff")
    end
    
    # -------------------------------------------------------------------------
    # Assign status fg for application
    def assign_class( type, count )
      clazz = case type
        when Rackamole.fault
          (count > 0 ? "fault" : "")
        when Rackamole.perf
          (count > 0 ? "perf" : "")
        when Rackamole.feature
          (count > 0 ? "feature" : "" )
        else              
          ""
      end      
      clazz
    end
    
    # -------------------------------------------------------------------------
    # Computes count diff since last check point
    def compute_diff( app_name, env, type_name, count )
      old_count = find_report_count( app_name, env, type_name )
      return (count - old_count) if( old_count )
      count
    end
  
    # =========================================================================
    private
  
      # -----------------------------------------------------------------------
      # Find report count for a given report
      def find_report_count( app, env, type )
        @old_reports.each do |report|
          next unless report['app'] == app      
          report['envs'].each_pair do |e, details|
            next unless e == env        
            details.each_pair do |type_name, count|
              return count if type_name == type
            end  
          end      
        end
        nil
      end    
  end
end