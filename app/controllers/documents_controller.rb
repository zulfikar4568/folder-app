class DocumentsController < ApplicationController
    before_action :set_document, only: [:destroy, :edit, :update, :show]

    def index
        
    end

    def new
        @document = Document.new
    end

    def download
        @document = Document.find($id_doc)
        file_path = "#{ENV['APP_FOLDER']}#{$global_path}"
        send_file(File.join(file_path, @document.name))
        # redirect_to document_path($id_doc)
    end

    def create
        puts document_params[:files]

        document_params[:files].each do |file|
            @document = Document.new(name: file.original_filename, folder_id: $parent_id, description: document_params[:description], version: "1.0",  content: file.content_type)
            if @document.save
                filename = file.original_filename
                Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")

                if(File.exist?(filename))
                    filename = "copy_" + filename
                end

                Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")
                f = File.open filename, "wb"
                f.write file.read()
                f.close

                if Document.where(name: file.original_filename).length > 0
                    file.original_filename = "copy_#{file.original_filename}"
                end
            end
           
        end
        
        redirect_to folders_path

        #!-----------------------------------------------PROGRAM DI BAWAH UNTUK UPLOAD SINGLE FILES----------------
        # if Document.where(name: document_params[:file].original_filename).length > 0
        #     document_params[:file].original_filename = "copy_#{document_params[:file].original_filename}"
        # end
        # @document = Document.new(document_params.merge(name: document_params[:file].original_filename, folder_id: $parent_id, description: document_params[:description]))

        # if @document.save
        #     redirect_to folders_path
        # else
        #     render :new
        # end
    end

    def destroy
        @document.destroy
        Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")
        FileUtils.rm_rf(@document.name)
        redirect_to folder_path($parent_id)
    end

    def show
        $id_doc = @document.id
        Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}")
        @modify = File.mtime(@document.name)
        @access = File.atime(@document.name)
        @size = (File.size(@document.name) / 1000.0)
    end


    def edit
        
        
    end

    def update
        Dir.chdir("#{ENV['APP_FOLDER']}#{@document.folder.path}#{@document.folder.name}")
        File.rename @document.name, update_params[:name]
        if @document.update(update_params)
            redirect_to folders_path
        else
            render :edit
        end
    end
    
    private

    def set_document
        @document = Document.find(params[:id])
    end

    def document_params
        params.require(:document).permit(:description, {files: []})
    end

    def update_params
        params.require(:document).permit(:name, :description)
    end
end