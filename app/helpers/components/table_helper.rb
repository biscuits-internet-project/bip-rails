module Components::TableHelper
  def render_table(caption = nil, **options, &block)
    content_tag :table, options.reverse_merge(
      class: tw('w-full text-md border-solid', options[:class])
    ) do
      if caption.present?
        content_tag :caption, caption, class: 'mt-4 text-sm text-muted-foreground ' do
          capture(&block)
        end
      else
        capture(&block)
      end
    end
  end

  def table_head(**options, &block)
    content_tag :thead, options.reverse_merge(
      class: tw('[&_tr]:border-b', options[:class])
    ) do
      content_tag :tr, class: 'border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted' do
        capture(&block)
      end
    end
  end

  def table_header(content = nil, sort_column: nil, sort_direction: 'asc', **options, &block)
    options = options.reverse_merge(
      class: tw('h-12 px-4 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0',
                options[:class])
    )

    content_tag :th, options do
      if sort_column
        direction = sort_direction == 'asc' ? 'desc' : 'asc'
        link_to content, { sort: sort_column, direction: }, class: 'sort-link'
      elsif block
        capture(&block)
      else
        content
      end
    end
  end

  def table_body(**options, &block)
    content_tag :tbody, class: options.reverse_merge(
      class: tw('[&_tr:last-child]:border-0', options[:class])
    ), &block
  end

  def table_row(**options, &block)
    content_tag :tr, options.reverse_merge(
      class: tw('border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted', options[:class])
    ), &block
  end

  def table_column(content = nil, **options, &block)
    content_tag :td, options.reverse_merge(
      class: tw('p-4 align-middle [&:has([role=checkbox])]:pr-0 font-medium', options[:class])
    ) do
      if block
        capture(&block)
      else
        content
      end
    end
  end
end
