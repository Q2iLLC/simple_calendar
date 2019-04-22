module SimpleCalendar
  module ViewHelpers
    def calendar(options={}, &block)
      raise 'calendar requires a block' unless block_given?
      SimpleCalendar::Calendar.new(self, options).render(&block)
    end

    def month_calendar(options={}, &block)
      raise 'month_calendar requires a block' unless block_given?
      SimpleCalendar::MonthCalendar.new(self, options).render(&block)
    end

    def week_calendar(options={}, &block)
      raise 'week_calendar requires a block' unless block_given?
      SimpleCalendar::WeekCalendar.new(self, options).render(&block)
    end

    def q2i_calendar(options={}, &block)
      raise 'q2i_calendar requires a block' unless block_given?
      SimpleCalendar::Q2iCalendar.new(self, options).render(&block)
    end

    def casa_calendar(options={}, &block)
      raise 'casa_calendar requires a block' unless block_given?
      SimpleCalendar::CASACalendar.new(self, options).render(&block)
    end
  end
end
