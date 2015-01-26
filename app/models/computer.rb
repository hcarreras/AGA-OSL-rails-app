class Computer
  attr_accessor :referencia, :revisado, :localizacion, :tipo, :cpu, :mhz, :ram, :disco_duro, :cd_dvd, :floppy, :ethernet, :fuente_alimentación, :notas, :campana_numero, :puntuacion_cpu, :puntuacion_ram, :puntuacion_dd, :puntuacion, :fecha_de_modificacion, :row

  def initialize data = [], row = nil
    update(data, row)
  end

  def update data, row
    @referencia = data[0]
    @revisado = data[1]
    @localizacion = data[2]
    @tipo = data[3]
    @cpu = data[4]
    @mhz = data[5]
    @ram = data[6]
    @disco_duro = data[7]
    @cd_dvd = data[8]
    @floppy = data[9]
    @ethernet = data[10]
    @fuente_alimentación = data[11]
    @notas = data[12]
    @campana_numero = data[13]
    @puntuacion_cpu = data[14]
    @puntuacion_ram = data[15]
    @puntuacion_dd = data[16]
    @puntuacion = data[17]
    @fecha_de_modificacion = data[18]
    @row = row
  end

  def to_hash
    hash = {}
    instance_variables[0..-2].each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def to_a
    instance_variables[0..-2].map{|var| instance_variable_get(var)}
  end

  def valid?
    !invalid?
  end

  def invalid?
    referencia.blank?
  end
end