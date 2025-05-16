module SearchSortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  def search_records(records, search_fields)
    if params[:search].present?
      operator = ActiveRecord::Base.connection.adapter_name == "SQLite" ? "LIKE" : "ILIKE"
      query = search_fields.map { |f| "#{f} #{operator} :search" }.join(' OR ')
      records = records.where(query, search: "%#{params[:search]}%")
    end
    records
  end

  def sort_records(records, default_column = 'id')
    column = sort_column(default_column, records)
    direction = sort_direction
    records.order("#{column} #{direction}")
  end

  private

  def sort_column(default_column, records)
    params[:sort].present? && records.column_names.include?(params[:sort]) ? params[:sort] : default_column
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end

