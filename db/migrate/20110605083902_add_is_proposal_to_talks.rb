class AddIsProposalToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :is_proposal, :boolean
  end

  def self.down
    remove_column :talks, :is_proposal
  end
end
