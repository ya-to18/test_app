class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @form = TodoForm.new
  end

  # GET /todos/1/edit
  def edit
    @form = TodoForm.new(todo: @todo)
  end

  # POST /todos or /todos.json
  def create
    @form = TodoForm.new(todo_params)
    # @form.assign_attributes(todo_params)

    if @form.save
      redirect_to todos_path, notice: "Todo was successfully created."
    else
      puts "保存できなかった"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    @form = TodoForm.new(todo: @todo)
    @form.assign_attributes(todo_params)

    if @todo.save
      redirect_to todo_url(@todo), notice: "Todo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo_form).permit(:name, :limit, tasks_attributes: [:title, :content])
    end
end
