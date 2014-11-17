class CollectionPolicy
	attr_reader :user, :collection

  def initialize(user, collection)
    @user = user
    @collection = collection
  end

  def index?
  end

  def show?
  	@user.id == @collection.user_id or @user.admin?
  end

  def new?
  end

  def edit?
    @user.id == @collection.user_id
  end

  def update?
    @user.id == @collection.user_id
  end

  def destroy?
    @user.id == @collection.user_id
  end

end