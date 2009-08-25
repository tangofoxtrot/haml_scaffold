require 'test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  
  def test_all_<%= plural_name %>_are_valid
    <%= class_name %>.find(:all).each {|x| assert x.valid?, x.errors.full_messages }
  end
  
  def test_create
    assert_difference('<%= class_name %>.count', 1) do
      create_<%= file_name %>
    end
  end

  def test_destroy
    assert_difference('<%= class_name %>.count', -1) do
      <%= plural_name %>(:one).destroy
    end
  end 
 
  should_validate_presence_of <%= attributes.map{|x| ":#{x.name}"}.join(', ') %>
  #should_validate_uniqueness_of <%= attributes.map{|x| ":#{x.name}"}.join(', ') %>

<% attributes.each do |attribute| -%>
  #should_ensure_length_in_range :<%= attribute.name %>, (0..250)
<% end -%>  

  #### Callback Tests: before_save, after_save, etc
  
  
  #### Method Tests: User.authenticate, Article.recent, etc

protected

  def create_<%= singular_name %>(options={})
    <%= class_name %>.create({<%= attributes.map{|x| ":#{x.name} => #{[:string, :text].include?(x.type) ? "Some Text"  : x.default }"}.join(",\n      ") %>
    }.merge(options))
  end

  
end
