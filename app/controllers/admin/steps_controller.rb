# frozen_string_literal: true

class Admin::StepsController < Admin::ApplicationController
  before_action :set_roadmap
  before_action :set_step, only: %i[edit update destroy]

  def new
    @step = Step.new(step_params)
  end

  def edit
    render :new
  end

  def create
    @step = Step.new(step_params)
  
    respond_to do |format|
      if @step.save
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "#{@step.type} was successfully created." }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if  @step.update(step_params)
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "#{@step.type} was successfully created." }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if  @step.destroy
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Deleted successfully" }
        format.json { render json: :no_content }
      else
        format.html { redirect_back fallback_location: roadmap_path(@roadmap), notice: "Failed to delete", status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_roadmap
    @roadmap = Roadmap.find_by(id: params[:roadmap_id])
  end

  def set_step
    @step = Step.find_by_id(params[:id])
  end

  def step_params
    params.fetch(:step, {}).permit(:title, :description, :parent_id)
  end
end
