require 'test/test_helper'

class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  
  context "logged in" do
    setup do
      do_login
    end

    context "get index" do
      setup do
        get :index
      end

      should_respond_with :success
      should_render_template :index
      should_assign_to(:<%= table_name %>)
    end
    
    context "get new" do
      setup do
        get :new
      end

      should_respond_with :success
      should_render_template :new
      should_assign_to(:<%= file_name %>)
    end
    
    context "post create" do
      setup do
        post :create, :<%= file_name %> => new_params
      end
      
      should_change("<%= class_name %>.count") { <%= class_name %>.count }
      should_assign_to(:<%= file_name %>)
      should_redirect_to("<%= file_name %> page") {<%= file_name %>_path(assigns(:<%= file_name %>))}
    end

    context "post create failure" do
      setup do
        post :create, :<%= file_name %> => new_params({})
      end
      
      should_not_change("<%= class_name %>.count") { <%= class_name %>.count }
      should_assign_to(:<%= file_name %>)
      should_render_template :new
    end    
    
    context "delete destroy" do
      setup do
        delete :destroy, :id => <%= table_name %>(:one).to_param
      end
      
      should_change("<%= class_name %>.count", :by => -1) { <%= class_name %>.count }
      should_redirect_to("index") {<%= table_name %>_path}
            
      should "flash message" do
        assert_not_nil flash[:notice]
      end
    end
    
    context "get edit" do
      setup do
        get :edit, :id => <%= table_name %>(:one).to_param
      end

      should_respond_with :success
      should_render_template :edit
      should_assign_to(:<%= file_name %>)
      
    end
    
    context "get show" do
      setup do
        get :show, :id => <%= table_name %>(:one).to_param
      end

      should_respond_with :success
      should_render_template :show
      should_assign_to(:<%= file_name %>)
      
    end
    
    context "put update" do
      setup do
        put :update, :id => <%= table_name %>(:one).to_param, :<%= file_name %> => existing_params
      end

      should_assign_to(:<%= file_name %>)
      should_redirect_to("<%= file_name %> page") {<%= file_name %>_path(assigns(:<%= file_name %>))}
    end
    
    context "put update with error" do
      setup do
        put :update, :id => <%= table_name %>(:one).to_param, :<%= file_name %> => existing_params({})
      end

      should_assign_to(:<%= file_name %>)
      should_render_template :edit
    end    
    
  end
  
  user_type_not_allowed_on(:viewer, :create, :update, :destroy, :new, :edit)
  
protected
  
  def existing_params(options={})
    <%= table_name %>(:one).to_params(options)
  end
  
  def new_params(options={})
    {<%= attributes.map{|x| ":#{x.name} => #{[:string, :text].include?(x.type) ? "Some Text"  : x.default }"}.join(",\n      ") %>
      }.merge(options)
  end
  
end