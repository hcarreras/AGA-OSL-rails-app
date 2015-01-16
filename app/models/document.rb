class Document
  attr_accessor :data

  def initialize data
    @data = data
  end

  def to_hash(opts = {})
    raw_data = opts.has_key?(:without_headers) ? @data.rows[2..-1] : @data.rows
    raw_data.map{|row| row_to_hash(row)}
  end

  def find_by_reference reference
    @data.rows[2..-1].each do |row|
      return row if row[0] == reference
    end
  end

  def row_to_hash(row)
    row.each_with_index.map do |value, index|
      [@data.rows[1][index], value]
    end.to_h
  end

  def delete_row(reference)
    @data.rows.to_enum.with_index(1).each do |row, row_index|
      if row[0] == reference
        row.to_enum.with_index(1).each do |_, index|
          @data[row_index, index] = ''
        end
      end
    end
    @data.save
  end
end
