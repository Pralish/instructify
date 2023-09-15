# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def show_creator
    creator_id = @roadmap.creator.pluck(:user_id)
    User.find(creator_id).map(&:first_name).join(' | ')
  end

  def format_date
    improper_date_format = @roadmap.created_at
    datetime = DateTime.parse(improper_date_format.to_s)

    # Format the DateTime object as "Month Day, Year" (e.g., "May 18, 2020")
    datetime.strftime('%B %d, %Y')
  end
end