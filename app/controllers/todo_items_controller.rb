class TodoItemsController < ApplicationController
	before_action :set_todo_list

	def create
		@todo_items = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end


	def mark_as_complete
		@todo_item = @todo_list.todo_items.find(params[:id])
		if @todo_item.update_attributes(completed: true, completed_at: DateTime.now)
			flash[:success] = 'List is mark as completed'
		else
			flash[:error] = @todo_item.error.full_message.join(', ')
		end
		redirect_to @todo_list
	end

	def destroy
		@todo_item = @todo_list.todo_items.find(params[:id])
		if @todo_item.destroy
			flash[:success] = 'List item deleted'
		else
			flash[:error] = @todo_item.error.full_message.join(', ')
		end
		redirect_to @todo_list
	end

	def sort
    params[:todo_item].each_with_index do |id, index|
      @todo_list.todo_items.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

	private

		# Use callbacks to share common setup or constraints between actions.
	  def set_todo_list
	    @todo_list = current_user.todo_lists.find_by_id(params[:todo_list_id])
	    p @todo_list
	  end

		# Never trust parameters from the scary internet, only allow the white list through.
	  def todo_item_params
	    params.require(:todo_item).permit(:content)
	  end
end
