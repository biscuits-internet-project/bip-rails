module ApplicationHelper
  include Pagy::Frontend

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, { sort: column, direction: }
  end

  def format_show_date(date)
    date.strftime('%-m/%-d/%y') if date.present?
  end

  def track_segue(track, index, total_tracks)
    return '' if index == total_tracks - 1

    if track.segue.blank?
      content_tag(:span, ', ')
    else
      content_tag(:span, " #{track.segue} ")
    end
  end

  def track_annotations(track, annotations)
    return '' if track.annotations.blank?

    spans = track.annotations.map do |annotation|
      index = annotations.index(annotation.desc) + 1
      content_tag(:sup, " #{index} ")
    end

    safe_join(spans, '')
  end
end
