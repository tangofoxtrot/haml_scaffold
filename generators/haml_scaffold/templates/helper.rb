module <%= controller_class_name %>Helper

  def <%= plural_name %>_table(<%= plural_name %>)
    collection_table(<%= plural_name %>, {:footer => true}, :id => '<%= singular_name %>_table', :class => "table") do |t|
<% attributes.each_with_index do |attribute, index| -%>
      t.header :<%= attribute.name -%>    
<% end -%>
      t.rows.alternate = :odd
      t.rows.each do |row, <%= singular_name %>, index|
<% attributes.each_with_index do |attribute,index| -%>
        row.<%= attribute.name %>  <%= index == 0 ? "link_to(#{singular_name}.#{attribute.name},#{singular_name}_path(#{singular_name}))" : "#{singular_name}.#{attribute.name}" -%>    
<% end -%>
      end
      if <%= plural_name %>.is_a?(WillPaginate::Collection) && WillPaginate::ViewHelpers.total_pages_for_collection(<%= plural_name %>) > 1
        t.footer :<%= attributes.first.name %>, will_paginate(<%= plural_name %>)
      end
    end
  end 


end