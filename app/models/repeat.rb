class Repeat < ApplicationRecord
  belongs_to :event

  def self.map_days_to_repeats(days_range, account = nil)
    repeats = find_by_range_and_account(days_range, account)
    days = {}
    days_range.each do |d|
      days[d] = repeats
                .filter { |r| r.datetime.to_date == d }
                .map(&:event)
    end
    days
  end

  def self.find_by_range_and_account(days_range, account)
    repeats = Repeat
    if account
      repeats = repeats
                .includes(:event)
                .where('events.account_id = :id', id: account.id)
                .references('event')
    end
    repeats.where('datetime BETWEEN :from AND :to',
                  from: days_range.min, to: days_range.max)
  end
end
