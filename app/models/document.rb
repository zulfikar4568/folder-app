class Document < ApplicationRecord
  belongs_to :folder
  
  # attr_accessor :file
  # after_save :save_file, if: :file
  # def save_file
  # filename = file.original_filename
  # Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")
  # if(File.exist?(filename))
  # filename = "copy_" + filename
  # end
  # Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")
  # f = File.open filename, "wb"
  # f.write file.read()
  # f.close
  # self.file = nil
  # end
  #!----------------------------PROGRAM DI ATAS UNTUK UPLOAD SATU FILE----------------------
  
  end