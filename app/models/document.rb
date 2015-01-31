class Document
  def initialize data
    @data = data.rows[2..-1].to_enum.map.with_index(3) do |data, row|
      Computer.new(data, row)
    end

    @last_reference = data["B1"].to_i
    @num_rows = data.num_rows
    @num_cols = data.num_cols
    @worksheet = data
  end

  def data(requested_data)
    if requested_data
      @data.select do |computer|
        [eval(requested_data)].flatten.detect{|requested_computer| requested_computer[:referencia] == computer.referencia &&  Date.strptime(requested_computer[:ultima_modificacion], "%d/%m/%Y")  < computer.ultima_modificacion}
      end
    else
      @data
    end
  end

  def to_hash()
    @data.inject([]) do |result, computer|
      result << computer.to_hash if computer.valid?
      result
    end
  end

  def find_by_reference reference
    @data.select { |value| value.referencia == reference.to_i }.first
  end

  def add_computer(data)
    computer = Computer.new([@last_reference + 1] + data)
    write(@num_rows + 1, computer)
  end

  def update_computer(reference, new_data)
    computer = find_by_reference(reference)
    if computer
      computer.update([computer.referencia] + new_data, computer.row)
      computer.fecha_de_modificacion = Date.today.strftime("%d/%m/%Y")
      write(computer.row ,computer )
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def write new_row_position, computer
    1.upto(@num_cols) do |index|
      @worksheet[new_row_position, index] = ''
    end
    computer.to_a.to_enum.with_index(1).each do |value, index|
      @worksheet[new_row_position, index] = value
    end
    @worksheet.save
  end
end
