class Computer
  attr_accessor :referencia, :revisado, :localizacion, :tipo, :cpu, :mhz, :ram, :disco_duro, :cd_dvd, :floppy, :ethernet, :fuente_alimentación, :notas, :campana_numero, :puntuacion_cpu, :puntuacion_ram, :puntuacion_dd, :puntuacion, :fecha_de_modificacion

  def initialize row = []
    @referencia = row[0]
    @revisado = row[1]
    @localizacion = row[2]
    @tipo = row[3]
    @cpu = row[4]
    @mhz = row[5]
    @ram = row[6]
    @disco_duro = row[7]
    @cd_dvd = row[8]
    @floppy = row[9]
    @ethernet = row[10]
    @fuente_alimentación = row[11]
    @notas = row[12]
    @campana_numero = row[13]
    @puntuacion_cpu = row[14]
    @puntuacion_ram = row[15]
    @puntuacion_dd = row[16]
    @puntuacion = row[17]
    @fecha_de_modificacion = row[18]
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def valid?
    !invalid?
  end

  def invalid?
    referencia.blank?
  end
end