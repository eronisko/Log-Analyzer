class EliminationListsController < ApplicationController
  # GET /elimination_lists
  # GET /elimination_lists.json
  def index
    @elimination_lists = EliminationList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @elimination_lists }
    end
  end

  # GET /elimination_lists/1
  # GET /elimination_lists/1.json
  def show
    @elimination_list = EliminationList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @elimination_list }
    end
  end

  # GET /elimination_lists/new
  # GET /elimination_lists/new.json
  def new
    @elimination_list = EliminationList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @elimination_list }
    end
  end

  # GET /elimination_lists/1/edit
  def edit
    @elimination_list = EliminationList.find(params[:id])
  end

  # POST /elimination_lists
  # POST /elimination_lists.json
  def create
    @elimination_list = EliminationList.new(params[:elimination_list])

    respond_to do |format|
      if @elimination_list.save
        format.html { redirect_to @elimination_list, notice: 'Elimination list was successfully created.' }
        format.json { render json: @elimination_list, status: :created, location: @elimination_list }
      else
        format.html { render action: "new" }
        format.json { render json: @elimination_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elimination_lists/1
  # PUT /elimination_lists/1.json
  def update
    @elimination_list = EliminationList.find(params[:id])

    respond_to do |format|
      if @elimination_list.update_attributes(params[:elimination_list])
        format.html { redirect_to @elimination_list, notice: 'Elimination list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @elimination_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elimination_lists/1
  # DELETE /elimination_lists/1.json
  def destroy
    @elimination_list = EliminationList.find(params[:id])
    @elimination_list.destroy

    respond_to do |format|
      format.html { redirect_to elimination_lists_url }
      format.json { head :no_content }
    end
  end
end
