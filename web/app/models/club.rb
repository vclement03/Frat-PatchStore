class Club < ApplicationRecord
  belongs_to :patch_type
  has_many :items

  enum value_type: [:biannual_event, :annual_event, :year]

  def self.get_options
    [["Patch custom", ""]] + Club.all.map { |c| [c.name, c.id] }
  end

  def validate_value(value, today=Date.today)
    if year?
      if /\A[0-9]{2}-[0-9]{2}\z/ === value
        year1, year2 = value.split('-').map(&:to_i)

        # following year format only
        return false if year2 - year1 != 1

        year = Club.short_year_to_full(year1)

        if self.start_date
          return false if year < self.start_date.year
        end

        year = Club.short_year_to_full(year2)

        if self.end_date
          return false if year > self.end_date.year
        end

        date = Date.new(year, 5, 1)

        if date > today
          return false
        end

        true
      end
    elsif annual_event?
      if /\A[0-9]{2}\z/ === value
        year = Club.short_year_to_full(value)

        if self.start_date && today < self.start_date
          return false
        end

        if self.end_date && today > self.end_date
          return false
        end

        if year > today.year
          return false
        end

        true
      end
    elsif biannual_event?
      if /\A[AH][0-9]{2}\z/ === value
        current_semester = Config.get('current_semester')
        year = Club.short_year_to_full(value[1..-1])
        current_year = Club.short_year_to_full(current_semester[1..-1])

        if year == current_year
          # patch for the same year, only possible if ordered at fall for an
          # event that happened last winter
          return (current_semester[0] == 'H' and value[0] == 'A')
        end

        if year > current_year
          # A19 not possible if current_semester is A18
          return false
        end

        if current_semester[0] == 'A'
          month = Date.new(current_year, 9, 1)
        else
          month = Date.new(current_year, 1, 1)
        end

        if self.start_date && month < self.start_date
          return false
        end

        if self.end_date && month > self.end_date
          return false
        end

        true
      end
    end
  end

  def self.short_year_to_full(value)
    if value.to_i < 70
      ('20' + value.to_s.rjust(2, '0')).to_i
    else
      ('19' + value.to_s.rjust(2, '0')).to_i
    end
  end

end
