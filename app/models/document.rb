class Document < ApplicationRecord
  belongs_to :folder

  attr_accessor :file

  after_save  :save_file, if: :file

  def save_file
    filename = file.original_filename

    Dir.chdir(ENV['APP_FOLDER'] + "/work-folder" + $global_path)

    if(File.exist?(filename))
      filename = "copy_" + filename
    end

    Dir.chdir(ENV['APP_FOLDER'])
    folder = "work-folder" + $global_path

    f = File.open File.join(folder, filename), "wb"
    f.write file.read()
    f.close

    self.file = nil
    # update file_filename: filename
  end
end
