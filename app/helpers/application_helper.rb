module ApplicationHelper
    include Pagy::Frontend
    
    def is_active?(link_path)
        current_page?(link_path) ? 'ac' : ""
        # path = request.fullpath.split('/')
        # cnt = path.count
        # res = path[cnt - 2]
        # res.eql?(params[:controller].split('/').second) ? 'ac' : ''
    end
    
    # This method creates a link with `data-id` `data-fields` attributes. These attributes are used to create new instances of the nested fields through Javascript.
    def link_to_add_fields(name, f, association, html_class)

        # Takes an object (@item_size) and creates a new instance of its associated model (:item_sizes)
        # To better understand, run the following in your terminal:
        # rails c --sandbox
        # @item_size = ItemSize.new
        # new_object = @item_size.send(:item_sizes).klass.new
        new_object = f.object.send(association).klass.new

        # Saves the unique ID of the object into a variable.
        # This is needed to ensure the key of the associated array is unique. This is makes parsing the content in the `data-fields` attribute easier through Javascript.
        # We could use another method to achive this.
        id = new_object.object_id

        # https://api.rubyonrails.org/ fields_for(record_name, record_object = nil, fields_options = {}, &block)
        # record_name = :item_sizes
        # record_object = new_object
        # fields_options = { child_index: id }
            # child_index` is used to ensure the key of the associated array is unique, and that it matched the value in the `data-id` attribute.
            # `item_size[item_sizes_attributes][child_index_value][_destroy]`
        fields = f.fields_for(association, new_object, child_index: id) do |builder|

            # `association.to_s + "_fields"` ends up evaluating to `item_sizes_fields`
            # The render function will then look for `views/items/_item_size_fields.html.erb`
            # The render function also needs to be passed the value of 'builder', because `views/items/_item_size_fields.html.erb` needs this to render the form tags.
            render(association.to_s + "_fields", f: builder)
        end

        # This renders a simple link, but passes information into `data` attributes.
            # This info can be named anything we want, but in this case we chose `data-id:` and `data-fields:`.
        # The `id:` is from `new_object.object_id`.
        # The `fields:` are rendered from the `fields` blocks.
            # We use `gsub("\n", "")` to remove anywhite space from the rendered partial.
        # The `id:` value needs to match the value used in `child_index: id`.
        style = "
        max-width: 15%;
        height: 40px;
        text-align: center;
        padding: 7px;
        color: #FFFFFF;
        background-color: #00AB47;
        border-radius: 5px;
        "
        link_to(name, '#', data: {id: id, fields: fields.gsub("\n", "")}, class: "add_fields #{html_class} mt-3", style: style)

    end
end
