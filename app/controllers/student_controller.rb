class StudentController < ApplicationController
  def index


  end

  def view
    @stu= Quizz.all
  end
  def show
    @stud = Student.find(params[:id])
  end

  # GET /quizzs/answer/1
  def answer
    @stud = Quizz.find(params[:id])
  end



end
