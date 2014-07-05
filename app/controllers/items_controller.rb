class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_api_user, only: [:create, :edit, :update, :destroy], if: :json_request?
  before_action :find_history, only: [:category, :show]
  after_action :store_history, only: [:show]

  # GET /items
  # GET /items.json
  def index
      @items = Item.all
  end

  #GET /category/:category
  def category
    @items = Item.category_list.tagged_with(params[:category])
    @container_size_1 = @items.count * 915 - 10
    @precision_count = @items.count / 2.to_f
    @container_size_2 = @precision_count.round * 384
  end

  #GET /maker/:maker
  def maker
    @items = Item.tagged_with(params[:maker])
    @container_size = @items.count * 883
  end


  # GET /items/1
  # GET /items/1.json
  def show
    @container_size = @item.images.active.count * 888
    @item_images = @item.images.show_list.shuffle
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find_by_slug!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:active, :circa, :description, :description_short, :featured, :filemaker_id, :sold, :listed_category, :listed_designer, :location, :reference, :height, :width, :depth, :diameter, :subcategory_id, :category_list, :maker_list)
    end

    def store_history
      @recent_item = @item.filemaker_id
      session[:history] ||= []
      session[:history].delete_at(0) if session[:history].size >= 6
      session[:history] << @recent_item unless session[:history].include?(@recent_item)
    end

    def find_history
      @history_items = Item.where(slug: session[:history])
    end

end
