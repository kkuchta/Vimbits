class BitsController < ApplicationController
  load_and_authorize_resource

  # GET /bits
  # GET /bits.json
  def index
    @bits = Bit
    @markdown = markdown

    # :tag is a single tag string.
    if params[:tag]
      @bits = @bits.tagged_with params[:tag]
    # :tags is a json tag string array
    # (only uses first tag for now)
    # Should this be an OR or an AND operation?
    elsif params[:tags]
      @tagsArray = ActiveSupport::JSON.decode(params[:tags])
      if @tagsArray.any?
        @bits = @bits.tagged_with @tagsArray.first
      end
    end

    # Handle sorting.  NOTE: "hot" results in an array, not a relation, so
    # trying to do more db-related operations later on may not work.  Try to
    # do that stuff before the sort if you can.  Need to figure out a better
    # way to handle the hotness algorithm- maybe just do it on the db.
    case params[:sort]
    when "new"
      @bits = @bits.order("created_at DESC")
      @title = "New Vimbits"
    when "rand"
      @bits = @bits.order("random()")
      @title = "Random Vimbits"
    when "hot"
      # Only calculate hot values for the last week of bits
      @bits = @bits.where("bits.created_at > ?", 1.week.ago)

      # Sort by hotness scores descending (0 is lowest hotness)
      @bits = @bits.sort_by{ |bit| -1 * bit.hotness }

    else
      # Top vimbits
      @bits = @bits.plusminus_tally
      @title = "Top Vimbits"
    end

    logger.info "inspect=" + @bits.class.name
    logger.info "isa=" + @bits.is_a?(Array).to_s
    if @bits.is_a?(Array)
      @bits = Kaminari.paginate_array(@bits).page(params[:page])
    else
      @bits = @bits.page params[:page]
    end

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
        expire_fragment( :action => 'index' )
        expire_fragment( controller: 'welcome', action: 'index' )
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
        expire_fragment( :action => 'index' )
        expire_fragment( action: 'show', id: params[:id] )
        expire_fragment( controller: 'welcome', action: 'index' )
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
      expire_fragment( :action => 'index' )
      expire_fragment( action: 'show', id: params[:id] )
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
    expire_fragment( :action => 'index' )
    expire_fragment( controller: 'welcome', action: 'index' )

    respond_to do |format|
      format.html { redirect_to bits_url, notice: 'Bit successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
