require 'spec_helper'

describe Document do
  before(:each){@document = Document.new(GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"]).spreadsheet_by_key("1hpawAU9Y0cKmKXg0ROtTwPVmA_qkd9y-0tS2HheZ5RI").worksheets[0])}

  it "creates valid computers" do
    @document.data.all?(&:valid?)
  end

  describe "finding computers" do
    it "can find a computer by its reference" do
      computer = @document.find_by_reference 1
      expect(computer.referencia).to eq 1
    end

    it "raise an exception if computer doesn't exists" do
      expect{ @document.find_by_reference(2)}.to raise_error('Not Found')
    end
  end

  describe "adding computers" do
    it "adds properly a computer" do
      last_reference = @document.last_reference
      @document.add_computer(['x', 'Almacén', 'Sobremesa', 'Pentium IV', '2600', '1024', '250', 'Grabadora DVD', 'Si', 'Xubuntu', 'Matemáticas', '9'])
      #Reload the document
      @document = Document.new(GoogleDrive.login(ENV["GDRIVE_USERNAME"], ENV["GDRIVE_PASSWORD"]).spreadsheet_by_key("1hpawAU9Y0cKmKXg0ROtTwPVmA_qkd9y-0tS2HheZ5RI").worksheets[0])
      expect(@document.last_reference).to eq (last_reference + 1)
      expect(@document.data.last.referencia).to eq(last_reference + 1)
      expect(@document.data.last.tipo).to eq("Sobremesa")
    end
  end

  describe "updating computer" do
    it "responds with 404 if computer doesn't exists" do
      expect{@document.update_computer(2,['Almacen',
                                          'Sobremesa',
                                          'Intel(R) Pentium(R) Dual',
                                          'CPU',
                                          'E2180',
                                          '2048',
                                          '1024',
                                          '160',
                                          'Grabadora DVD',
                                          'No',
                                          'Sí',
                                          '420',
                                          'W',
                                          'OSL',
                                          '71433554238',
                                          '10',
                                          '10',
                                          '85716777119'])
      }.to raise_error('Not Found')
    end

    it "updates properly if computer exists" do
      @document.update_computer(1, [ '',
                                     'Almacen',
                                     'Sobremesa',
                                     'Intel(R) Pentium(R) Dual CPU E2180',
                                     '2048',
                                     '1024',
                                     '160',
                                     'Grabadora DVD',
                                     'Sí',
                                     '',
                                     'OSL',
                                     '85716777119'])

      expect(@document.find_by_reference(1).localizacion).to eq("Almacen")
      #returning computer to base state
      @document.update_computer(1,[ '',
                                    'Oficina, en uso',
                                    'Sobremesa',
                                    'Intel(R) Pentium(R) Dual CPU E2180',
                                    '2048',
                                    '1024',
                                    '160',
                                    'Grabadora DVD',
                                    'Sí',
                                    '',
                                    'OSL',
                                    '85716777119'])
    end
  end
end
