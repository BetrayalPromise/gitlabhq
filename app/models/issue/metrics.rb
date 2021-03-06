class Issue::Metrics < ActiveRecord::Base
  belongs_to :issue

  def record!
    if issue.milestone_id.present? && self.first_associated_with_milestone_at.blank?
      self.first_associated_with_milestone_at = Time.now
    end

    if issue_assigned_to_list_label? && self.first_added_to_board_at.blank?
      self.first_added_to_board_at = Time.now
    end

    self.save
  end

  private

  def issue_assigned_to_list_label?
    issue.labels.any? { |label| label.lists.present? }
  end
end
