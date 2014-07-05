class CollectionsController < ApplicationController
  before_action :authenticate_user!, :except => [:carousel, :slideshow]
  before_action :set_collection, only: [:carousel, :slideshow, :show, :edit, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @collections = current_user.collections
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CollectionPdf.new(@collection, view_context)
        send_data pdf.render, filename: "#{@collection.name}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /collections/1/carousel
  def carousel
  end

  # GET /collections/1/slideshow
  def slideshow
    @container_size_1 = @collection.collection_items.active.count * 915 - 10
    @precision_count = @collection.collection_items.active.count / 2.to_f
    @container_size_2 = @precision_count.round * 384
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:active, :name, :description, :public, :user_id)
    end
end
