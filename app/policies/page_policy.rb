class PagePolicy
	attr_reader :user, :collection

  def initialize(user, collection)
    @user = user
    @collection = collection
  end

  def index?
    @user.admin?
  end

  def show?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

end