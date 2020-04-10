class AddColumnFromForeignCountriesToThailandSummary < ActiveRecord::Migration[6.0]
  def change
    add_column :thailand_summaries, :confirmed_case_from_foreign_countries, :integer, default: 0
    add_column :thailand_summaries, :confirmed_add_today_from_foreign_countries, :integer, default: 0
    add_column :thailand_summaries, :confirmed_deaths_from_foreign_countries, :integer, default: 0
  end
end
