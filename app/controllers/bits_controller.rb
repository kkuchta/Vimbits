class BitsController < ApplicationController
  load_and_authorize_resource
  #caches_page :index, :show, :votes

  # GET /bits
  # GET /bits.json
  def index
    @bits = Bit

    case params[:sort]
    when "new"
      @bits = @bits.order("created_at DESC")
      @title = "New Vimbits"
    when "rand"
      @bits = @bits.order("random()")
      @title = "Random Vimbits"
    else
      # Top vimbits
      @bits = @bits.plusminus_tally
      @title = "Top Vimbits"
    end

    @markdown = markdown

    # :tag is a single tag string.
    if params[:tag]
      @bits = @bits.tagged_with params[:tag]
    # :tags is a json tag string array
    # (only uses first tag for now)
    elsif params[:tags]
      tagsArray = ActiveSupport::JSON.decode(params[:tags])
      if tagsArray.length > 0
        @bits = @bits.tagged_with tagsArray.first
      end
    end

    @bits = @bits.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bits }
    end
  end

  # GET /bits/1
  # GET /bits/1.json
  def show
    @bit = Bit.find(params[:id])
    @markdown = markdown

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bit }
    end
  end

  # GET /bits/new
  # GET /bits/new.json
  def new
    @bit = Bit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bit }
    end
  end

  # GET /bits/1/edit
  def edit
    @bit = Bit.find(params[:id])
  end

  # POST /bits
  # POST /bits.json
  def create
    #params[:bit][:owner] = current_user
    tag_list = ActiveSupport::JSON.decode(params[:tag_list])
    @bit = Bit.new(params[:bit])
    @bit.tag_list = tag_list
    @bit.user = current_user
    logger.info "params=" + params.inspect

    respond_to do |format|
      if @bit.save
        format.html { redirect_to @bit, notice: 'Bit was successfully created.' }
        format.json { render json: @bit, status: :created, location: @bit }
      else
        format.html { render action: "new" }
        format.json { render json: @bit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bits/1
  # PUT /bits/1.json
  def update
    tag_list = ActiveSupport::JSON.decode(params[:tag_list])
    @bit = Bit.find(params[:id])
    @bit.tag_list = tag_list

    respond_to do |format|
      if @bit.update_attributes(params[:bit])
        format.html { redirect_to @bit, notice: 'Bit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bit.errors, status: :unprocessable_entity }
      end
    end
  end

  def votes
    @bit = Bit.find(params[:id])
    if request.get?
      render json: {votes: @bit.plusminus}
    elsif request.put?
      case params[:direction]
        when 'up'
          current_user.vote_exclusively_for(@bit)
        when 'down'
          current_user.vote_exclusively_against(@bit)
      end
      head :no_content
    end
  end

  # DELETE /bits/1
  # DELETE /bits/1.json
  def destroy
    @bit = Bit.find(params[:id])
    @bit.destroy

    respond_to do |format|
      format.html { redirect_to bits_url }
      format.json { head :no_content }
    end
  end
end
