class FoldersController < ApplicationController
    require 'fileutils'
    before_action :set_folder, only: [:show, :destroy, :edit, :update]
    before_action :authenticate_account!
    load_and_authorize_resource
    
    def index
        @folders = Folder.all
        $global_path = "/" #Insialisai Directory
        $parent_id = 0 #Inisialisasi Id parent saat ini
        $akun_id = current_account.id
    end

    def new
        @folder = Folder.new
    end

    def create
        @param_name = folder_params[:name] 
        Dir.chdir("#{ENV['APP_FOLDER']}#{$global_path}") # Pindah folder ke folder ini
        if Dir.exist?(@param_name) #Jika file sudah ada maka ganti nama file
            @param_name = "#{@param_name}_copy"
        end

        # @folder = Folder.new(folder_params.merge(name: @param_name, path: $global_path, parent_id: $parent_id))
        @folder = Folder.new(name: @param_name, path: $global_path, parent_id: $parent_id, account_id: current_account.id)
        if @folder.save
            Dir.mkdir(@param_name)
            redirect_to folders_path
        else
            render :new
        end
    end

    def edit
        
    end

    def update
        Dir.chdir("#{ENV['APP_FOLDER']}#{@folder.path}")
        File.rename @folder.name, folder_params[:name]
        if @folder.update(folder_params)
            redirect_to folders_path
        else
            render :edit
        end
    end
    
    def show
        @folders = Folder.all
        $global_path = @folder.path + @folder.name + "/" # Posisi Folder saat ini
        $parent_id = @folder.id # Id parent di isi dengan id yang sedang di lihat
        $akun_id = @folder.account_id
        @content_folders = (Dir.each_child("#{ENV['APP_FOLDER']}#{$global_path}"))
    end

    def children_destroy(idd_parent)
        folder_destroys = Folder.where(parent_id: idd_parent)
        folder_destroys.each do |folder_destroy|
            folder_destroy.destroy
            unless folder_destroys.length == 0
                children_destroy(folder_destroy.id)
            end
        end
    end


    def destroy
        @folder.destroy
        children_destroy(params[:id])
        Dir.chdir("#{ENV['APP_FOLDER']}#{@folder.path}")
        FileUtils.rm_rf(@folder.name)
        redirect_to folders_path
    end

    private

    def set_folder
        @folder = Folder.find(params[:id])
        @children_folders = Folder.where(parent_id: params[:id])
    end

    def folder_params
        params.require(:folder).permit(:name, :path, :parent_id)
    end
end