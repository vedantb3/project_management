class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_number, :string
    add_column :users, :job_title, :string
    add_column :users, :team_name, :string
    add_column :users, :skills, :string
    add_column :users, :joining_date, :date
  end
end
