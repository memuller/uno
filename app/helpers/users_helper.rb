module UsersHelper
  def profile_field(name, options={})
    locals = {:field => name, :value => nil, :field_setter => name}
    locals.merge!({:value => @current_user.send((options[:getter] || name))}) if @current_user
    locals.merge!({:field_setter => options[:setter]}) if options[:setter]
    render :partial => "users/fields/#{options[:type] || :text}", :locals => locals
  end

end
