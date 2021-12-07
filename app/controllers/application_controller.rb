class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def page
    @page ||= params[:page] || 1
  end

  def pagination_headers(pag)
    headers['X-Total-Count'] = pag.total_count

    links = []
    links << page_link(pag.prev_page, 'prev') if pag.prev_page
    links << page_link(pag.next_page, 'next') if pag.next_page

    headers['Link'] = links.join(', ') if links.present?
  end

  def page_link(page, rel)
    base_uri = request.url.split('?').first
    "<#{base_uri}?#{request.query_parameters.merge(page: page).to_param}>; rel='#{rel}'"
  end
end
