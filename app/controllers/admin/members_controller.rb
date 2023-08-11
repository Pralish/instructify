class Admin::MembersController < Admin::ApplicationController
  before_action :set_member, only: %i[show update destroy]

  # GET /admin/users
  def index
  end

  # GET /admin/users/new
  def new
  end

  # POST /admin/users
  def create
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/1/edit
  def edit
  end

  # PATCH /admin/users/1
  def update
  end

  # DELETE /admin/users/1
  def destroy
  end

  private

  def set_user
    @member = Member.find(params[:id])
  end
end
