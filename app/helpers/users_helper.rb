module UsersHelper
  def profile_field(name, options={})
    locals = {:field => name, :value => nil, :field_setter => name}
    options.merge! User.profile_fields[name]
    locals.merge!({:value => @current_user.send((options[:getter] || name))}) and options.delete(:getter) if @current_user
    locals.merge!({:field_setter => options[:setter]}) and options.delete(:setter) if options[:setter]
    locals.merge! options
    render :partial => "users/fields/#{options[:type] || :text}", :locals => locals
  end

end
