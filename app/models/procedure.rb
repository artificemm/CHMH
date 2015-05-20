class Procedure < ActiveRecord::Base
  belongs_to :user
  belongs_to :surgery
  has_many :task_procedures
  has_many :examineds
  validates :folio,:donedate  ,presence: true
  validates :minutes, numericality: {greater_than: 0}
  validate :donedate_less_than_today

  def last_month_notes
    Procedure.where('created_at BETWEEN ? AND ? ',1.month.ago.beginning_of_month , 1.month.ago.end_of_month)
  end

  def donedate_less_than_today
    errors.add(:donedate, 'La fecha no puede ser despues de hoy') if donedate > Date.today
  end

  # def self.examined_procedures(user_id)
  #   Procedure.where(user: user_id).order('surgery_id DESC').to_a.each do |procedure|
  #     if procedure.examamineds.exist?(user_id: current_user,procedure: procedure.id)
  #
  #     end
  #
  # end

end
