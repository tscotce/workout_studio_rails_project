class WorkoutClassesController < ApplicationController
  before_action :set_workout_class, only: [:show, :edit, :update, :destroy, :signup, :drop]

    # GET /workout_classes
    def index
      if params[:instructor_id]      
        @workout_classes = Instructor.find(params[:instructor_id]).workout_classes    
      else      
        @workout_classes = WorkoutClass.all
      end 
    end
  
    # GET /workout_classes/1
    def show
    end
  
    # GET /workout_classes/new
    def new
      if params[:instructor_id]
        @workout_class = WorkoutClass.new(instructor_id: params[:instructor_id])
      else @workout_class = WorkoutClass.new
      end
      render :layout => "admin"
    end

    # GET /workout_classes/1/edit
    def edit
      render :layout => "admin"
    end
  
    # POST /workout_classes
    def create
      @workout_class = WorkoutClass.new(workout_class_params)
      if @workout_class.save
        redirect_to admin_workout_classes_path
      else render new_workout_class_path
      end
    end
  
    # PATCH/PUT /workout_classes/1
    def update
      @workout_class.update(workout_class_params)
      redirect_to admin_workout_classes_path
    end
  
    # DELETE /workout_classes/1
    def destroy
      @workout_class.destroy
      redirect_to admin_workout_classes_path
    end

    # GET /workout_classes/1/signup
    def signup
      if session[:student_id]
      @workout_class.student_id = session[:student_id]
      @workout_class.save
      redirect_to student_path(session[:student_id])
      else 
        flash[:message] = "Please log in."
        redirect_to login_path
      end
    end

    # GET /workout_classes/1/drop
    def drop
      @workout_class.update(student_id: nil)
      @workout_class.save
      redirect_to student_path(session[:student_id])
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_workout_class
        @workout_class = WorkoutClass.find_by(id: params[:id])
      end
  
      # White list params.
      def workout_class_params
        params.require(:workout_class).permit(:name, :date, :time, :description, :instructor_id, :student_id, :instructor_name)
      end
end