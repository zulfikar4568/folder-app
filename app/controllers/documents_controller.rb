class DocumentsController < ApplicationController
    before_action :set_document, only: [:destroy]

    def index
        
    end
    
    def new
        @document = Document.new
    end


    def create
        if Document.where(name: document_params[:file].original_filename).length > 0
            document_params[:file].original_filename = "copy_" + document_params[:file].original_filename
        end
        @document = Document.new(document_params.merge(name: document_params[:file].original_filename, folder_id: $parent_id, description: document_params[:description]))

        if @document.save
            redirect_to folders_path
        else
            render :new
        end
    end

    def destroy
        @document.destroy
        Dir.chdir(ENV['APP_FOLDER'] + "/work-folder" + $global_path)
        FileUtils.rm_rf(@document.name)
        redirect_to folders_path
    end

    private

    def set_document
        @document = Document.find(params[:id])
    end

    def document_params
        params.require(:document).permit(:description, :file)
    end
end