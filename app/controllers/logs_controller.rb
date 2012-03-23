class LogsController < ApplicationController
  before_filter :get_investigation_from_url, only: [:new, :create]
  
  # GET /logs/1
  # GET /logs/1.json
  def show
    @log = Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @log }
    end
  end

  # GET /logs/new
  # GET /logs/new.json
  def new
    @log = Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @log }
    end
  end

  # GET /logs/1/edit
  def edit
    @log = Log.find(params[:id])
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = Log.new(params[:log])
    @log.investigation = @investigation

    respond_to do |format|
      if @log.save
      	@log.import_to_db(params[:log][:uploaded_file])

        format.html { redirect_to @log, notice: 'Log was successfully created.' }
        format.json { render json: @log, status: :created, location: @log }
      else
        format.html { render action: "new", investigation: @investigation}
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logs/1
  # PUT /logs/1.json
  def update
    @log = Log.find(params[:id])

    respond_to do |format|
      if @log.update_attributes(params[:log])
        format.html { redirect_to @log, notice: 'Log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    respond_to do |format|
      format.html { redirect_to investigation_url(@log.investigation) }
      format.json { head :no_content }
    end
  end

  def filter
    @log = Log.find(params[:id])
    @ignore_list = IgnoreList.find(params[:ignore_list][:id])

    @log.log_messages.ignore_matching @ignore_list

    respond_to do |format|
      format.html { redirect_to @log, notice: 'The log has been filtered' }
    end
  end

  private

  def get_investigation_from_url
    @investigation = Investigation.find(params[:investigation_id])
  end
end
