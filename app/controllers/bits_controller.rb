class BitsController < ApplicationController
  # GET /bits
  # GET /bits.json
  def index
    @bits = Bit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bits }
    end
  end

  # GET /bits/1
  # GET /bits/1.json
  def show
    @bit = Bit.find(params[:id])

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
    @bit = Bit.new(params[:bit])

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
    @bit = Bit.find(params[:id])

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
