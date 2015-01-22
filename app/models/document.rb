class Document

  attr_accessor :data

  def initialize data
    @data = data.rows[2..-1].map do |row|
      Computer.new(row)
    end

    @last_reference = data["B1"].to_i
    @num_rows = data.num_rows
    @num_cols = data.num_cols
    @raw_document = data
  end

  def filter_rows_by_reference_and_date requested_data
    requested_data.map do |reference_and_date|
      find_by_reference(reference_and_date.reference )
    end.keep_if do |row|
      row
    end
  end

  def to_hash()
    @data.inject([]) do |result, computer|
      result << computer.to_hash if computer.valid?
      result
    end
  end

  def find_by_reference reference
    computer = @data.first { |value| value.referencia == reference }
    computer.referencia == reference ? computer : Computer.new()
  end

  def add_computer(data)
    computer = Computer.new([last_reference + 1] + data)
    write(@num_rows + 1, computer)
  end

  def update_row(reference, new_data)
    @data.rows.to_enum.with_index(1).each do |row, row_index|
      if row[0] == reference.to_s
        2.upto(@data.num_cols) do |index|
          @data[row_index, index] = ''
        end
        new_data.to_enum.with_index(2).each do |value , index|
          @data[row_index, index] = value
        end
      end
    end
    @data.save
  end

  def write row, computer
    @raw_document.rows
  end
end
