class IgnoreListsController < ApplicationController
  # GET /ignore_lists
  # GET /ignore_lists.json
  def index
    @ignore_lists = IgnoreList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ignore_lists }
    end
  end

  # GET /ignore_lists/1
  # GET /ignore_lists/1.json
  def show
    @ignore_list = IgnoreList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ignore_list }
    end
  end

  # GET /ignore_lists/new
  # GET /ignore_lists/new.json
  def new
    @ignore_list = IgnoreList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ignore_list }
    end
  end

  # GET /ignore_lists/1/edit
  def edit
    @ignore_list = IgnoreList.find(params[:id])
  end

  # POST /ignore_lists
  # POST /ignore_lists.json
  def create
    @ignore_list = IgnoreList.new(params[:ignore_list])

    respond_to do |format|
      if @ignore_list.save
        format.html { redirect_to @ignore_list,
                      notice: 'Ignore list was successfully created.' }
        format.json { render json: @ignore_list, 
                      status: :created,
                      location: @ignore_list }
      else
        format.html { render action: "new" }
        format.json { render json: @ignore_list.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PUT /ignore_lists/1
  # PUT /ignore_lists/1.json
  def update
    @ignore_list = IgnoreList.find(params[:id])

    respond_to do |format|
      if @ignore_list.update_attributes(params[:ignore_list])
        format.html { redirect_to @ignore_list,
                      notice: 'Ignore list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ignore_list.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ignore_lists/1
  # DELETE /ignore_lists/1.json
  def destroy
    @ignore_list = IgnoreList.find(params[:id])
    @ignore_list.destroy

    respond_to do |format|
      format.html { redirect_to ignore_lists_url }
      format.json { head :no_content }
    end
  end
end
