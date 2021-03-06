class CollectionItemsController < ApplicationController
  before_action :set_collection_item, only: [:show, :edit, :update, :destroy]

  # GET /collection_items
  # GET /collection_items.json
  def index
    @collection_items = CollectionItem.all
  end

  # GET /collection_items/1
  # GET /collection_items/1.json
  def show
  end

  # GET /collection_items/new
  def new
    @collection_item = CollectionItem.new
  end

  # GET /collection_items/1/edit
  def edit
  end

  # POST /collection_items
  # POST /collection_items.json
  def create
    @collection_item = CollectionItem.new(collection_item_params)

    respond_to do |format|
      if @collection_item.save
        format.html { redirect_to :back, notice: 'Collection item was successfully created.' }
        format.json { render :show, status: :created, location: @collection_item }
        format.js {
          flash[:notice] = "Added to Collection"
          render :template => "collection_items/create.js.erb"
          flash.discard
        }
      else
        format.html { render :new }
        format.json { render json: @collection_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /collection_items/1
  # PATCH/PUT /collection_items/1.json
  def update
    respond_to do |format|
      if @collection_item.update(collection_item_params)
        format.html { redirect_to @collection_item, notice: 'Collection item was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @collection_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /collection_items/1
  # DELETE /collection_items/1.json
  def destroy
    @collection_item.destroy
    respond_to do |format|
      format.html { redirect_to collection_items_url, notice: 'Collection item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_item
      @collection_item = CollectionItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_item_params
      params.require(:collection_item).permit(:active, :collection_id, :item_id, :position)
    end
end
