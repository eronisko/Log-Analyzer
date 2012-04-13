class MessagePatternsController < ApplicationController
  before_filter :get_source_from_url, only: [:new, :create, :delete]

  # GET /message_patterns/1
  # GET /message_patterns/1.json
  def show
    @message_pattern = MessagePattern.find(params[:id])
    @source = @message_pattern.source;

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_pattern }
    end
  end

  # GET /message_patterns/new
  # GET /message_patterns/new.json
  def new
    @message_pattern = MessagePattern.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_pattern }
    end
  end

  # GET /message_patterns/1/edit
  def edit
    @message_pattern = MessagePattern.find(params[:id])
  end

  # POST /message_patterns
  # POST /message_patterns.json
  def create
    @message_pattern = MessagePattern.new(params[:message_pattern])
    @message_pattern.source = @source

    respond_to do |format|
      if @message_pattern.save
        format.html { redirect_to @message_pattern, notice: 'Message pattern was successfully created.' }
        format.json { render json: @message_pattern, status: :created, location: @message_pattern }
      else
        format.html { render action: "new", source: @source }
        format.json { render json: @message_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_patterns/1
  # PUT /message_patterns/1.json
  def update
    @message_pattern = MessagePattern.find(params[:id])

    respond_to do |format|
      if @message_pattern.update_attributes(params[:message_pattern])
        format.html { redirect_to @message_pattern, notice: 'Message pattern was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_patterns/1
  # DELETE /message_patterns/1.json
  def destroy
    @message_pattern = MessagePattern.find(params[:id])
    @message_pattern.destroy

    respond_to do |format|
      format.html { 
        redirect_to source_message_patterns_url(@message_pattern.source) }
      format.json { head :no_content }
    end
  end

  private

  def get_source_from_url
    @source = Source.find(params[:source_id])
  end
end
