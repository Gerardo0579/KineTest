require 'date_diff'

class Baby < ApplicationRecord
    has_many :activity_logs

    def months
        diff = Date.diff(self.birthday, Time.new)
        months = diff[:year]*12 + diff[:month]
    end
end
