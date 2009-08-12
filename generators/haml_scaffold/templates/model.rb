class <%= class_name %> < ActiveRecord::Base
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>
  validates_presence_of <%= attributes.map{|x| ":#{x.name}"}.join(", ") %>
  #validates_uniqueness_of <%= attributes.map{|x| ":#{x.name}"}.join(", ") %>
<% attributes.each do |attribute| -%>
  #validates_length_of :<%= attribute.name %>, :maximum => 250, :allow_nil => true
<% end -%>  
end