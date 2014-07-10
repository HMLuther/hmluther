class DesignersController < ApplicationController
  before_action :set_designer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_api_user, only: [:create, :edit, :update, :destroy], if: :json_request?

  # GET /designers
  # GET /designers.json
  def index
    @designer_alpha = Designer.listed.group_by { |c| c.name_initial }
    @designer_country = Designer.listed.group_by { |c| c.origin }
  end

  # GET /designers/1
  # GET /designers/1.json
  def show
    @container_size_1 = @designer.items.count * 915 - 40
    @precision_count = @designer.items.count / 2.to_f
    @container_size_2 = @precision_count.round * 384
  end

  # GET /designers/new
  def new
    @designer = Designer.new
  end

  # GET /designers/1/edit
  def edit
  end

  # POST /designers
  # POST /designers.json
  def create
    @designer = Designer.new(designer_params)

    respond_to do |format|
      if @designer.save
        format.html { redirect_to @designer, notice: 'Designer was successfully created.' }
        format.json { render :show, status: :created, location: @designer }
      else
        format.html { render :new }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /designers/1
  # PATCH/PUT /designers/1.json
  def update
    respond_to do |format|
      if @designer.update(designer_params)
        format.html { redirect_to @designer, notice: 'Designer was successfully updated.' }
        format.json { render :show, status: :ok, location: @designer }
      else
        format.html { render :edit }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /designers/1
  # DELETE /designers/1.json
  def destroy
    @designer.destroy
    respond_to do |format|
      format.html { redirect_to designers_url, notice: 'Designer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_designer
      @designer = Designer.find_by_slug!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def designer_params
      params.require(:designer).permit(:active, :affiliate_list, :bio, :name_first, :name_last, :listed, :origin, :production_date, :website, :filemaker_id)
    end
end