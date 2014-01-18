class AddActionCodeAndResultTypeAndCustomDisplayOrderToActions < ActiveRecord::Migration
  def change
    add_column :actions, :action_code, :string
    add_column :actions, :result_type, :string
    add_column :actions, :custom_display_order, :integer
  end
end
