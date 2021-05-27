module ApplicationHelper
    def is_active?(link_path)
        # byebug
        current_page?(link_path) ? 'ac' : ""
        # path = request.fullpath.split('/')
        # cnt = path.count
        # res = path[cnt - 2]
        # res.eql?(params[:controller].split('/').second) ? 'ac' : ''
    end
end
