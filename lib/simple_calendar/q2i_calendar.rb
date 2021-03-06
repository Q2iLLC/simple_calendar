require 'rails'

module SimpleCalendar
  class Q2iCalendar < SimpleCalendar::Calendar
  	def render(&block)
      view_context.render(
        partial: partial_name,
        locals: {
          block: block,
          calendar: self,
          month_date_range: month_date_range,
          week_date_range: week_date_range,
          start_date: start_date, 
          sorted_events: sorted_events
        }
      )
    end

    def week_number
      format = (Date.beginning_of_week == :sunday) ? "%U" : "%W"
      start_date.beginning_of_week.strftime(format).to_i
    end

    def number_of_weeks
      options.fetch(:number_of_weeks, 1)
    end

    def end_week
      week_number + number_of_weeks - 1
    end

    def default_calendar_param
      options.fetch(:default_calendar_param, :default_calendar).to_sym
    end

    def default_calendar
      if options.has_key?(:default_calendar)
        options.fetch(:default_calendar)
      else
        view_context.params.fetch(default_calendar_param, 'month')
      end
    end

    def month_url_for_next_view
      view_context.url_for(@params.merge(start_date_param => month_date_range.last + 1.day, default_calendar_param => 'month'))
    end

    def month_url_for_previous_view
      view_context.url_for(@params.merge(start_date_param => month_date_range.first - 1.day, default_calendar_param => 'month'))
    end

    def week_url_for_next_view
      view_context.url_for(@params.merge(start_date_param => week_date_range.last + 1.day, default_calendar_param => 'week'))
    end

    def week_url_for_previous_view
      view_context.url_for(@params.merge(start_date_param => week_date_range.first - 1.day, default_calendar_param => 'week'))
    end

    def day_url_for_next_view
      view_context.url_for(@params.merge(start_date_param => start_date + 1.day, default_calendar_param => 'day'))
    end

    def day_url_for_previous_view
      view_context.url_for(@params.merge(start_date_param => start_date - 1.day, default_calendar_param => 'day'))
    end

    def month_date_range
      (start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).to_a
    end

    def week_date_range
      starting = start_date.beginning_of_week
      ending = (starting + (number_of_weeks - 1).weeks).end_of_week

      (starting..ending).to_a
    end

    def event_type_color(event_type_id)
      case event_type_id
      when 1
        'blue'
      when 2
        'grey'
      when 3
        'red'
      when 4
        'purple'
      else
        nil
      end
    end
  end
end