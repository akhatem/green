module ApplicationHelper
    def is_active?(link_path)
        current_page?(link_path) ? 'ac' : ""
    end
end
