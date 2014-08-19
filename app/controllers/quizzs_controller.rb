class QuizzsController < ApplicationController
  before_action :set_quizz, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :except => [:answer,:answering,:check]

  # GET /quizzs
  # GET /quizzs.json
  def index
    @quizzs = Quizz.all
  end

  # GET /quizzs/1
  # GET /quizzs/1.json
  def show
  end

  # GET /quizzs/new
  def new
    @quizz = Quizz.new
  end

  # GET /quizzs/1/edit
  def edit
  end

  # POST /quizzs
  # POST /quizzs.json
  def create
    @quizz = Quizz.new(quizz_params)

    respond_to do |format|
      if @quizz.save
        format.html { redirect_to @quizz, notice: 'Quizz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quizz }
      else
        format.html { render action: 'new' }
        format.json { render json: @quizz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzs/1
  # PATCH/PUT /quizzs/1.json
  def update
    respond_to do |format|
      if @quizz.update(quizz_params)
        format.html { redirect_to @quizz, notice: 'Quizz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quizz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzs/1
  # DELETE /quizzs/1.json
  def destroy
    @quizz.destroy
    respond_to do |format|
      format.html { redirect_to quizzs_url }
      format.json { head :no_content }
    end
  end


  # GET /quizzs/answerwing/1
  def answering
    @quizzs = Quizz.all
  end
  # GET /quizzs/answer/1
  def answer
    @quizz = Quizz.find(params[:id])
  end

  # PUT /quizzs/answering/1
  # PUT /quizzs/answering/1.xml
  def check

    @quizz = Quizz.find(params[:id])
    respond_to do |format|
      if params[:q].to_i==@quizz.correctans
        flash[:notice] = "Congratulation. You gave the correct answer to the question: " + @quizz.question + ""
        format.html { redirect_to({:controller => "quizzs", :action => "answering" } ) }
        format.xml { head :ok }
      else
        flash[:notice] = "I am sorry but that is not the right answer to the question: " + @quizz.question + ""
        format.html { redirect_to({:controller => "quizzs", :action => "answering" } ) }
        format.xml { head :ok }
      end
    end
  end

  def complete
    @quizz = Quizz.find(params[:id])
      respond_to do |format|
        if params[:ans1_check_box].to_i==@quizz.correctans
          flash[:notice] = "Congratulation. You gave the correct answer to the question: " + @quizz.question + ""
          format.html { redirect_to({:controller => "quizzs", :action => "answering" } ) }
          format.xml { head :ok }
        else
          flash[:notice] = "I am sorry but that is not the right answer to the question: " + @quizz.question + ""
          format.html { redirect_to({:controller => "quizzs", :action => "answering" } ) }
          format.xml { head :ok }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quizz
      @quizz = Quizz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quizz_params
      params.require(:quizz).permit(:question, :ans1, :ans2, :ans3, :ans4, :correctans)
    end

  def authenticate
    authenticate_or_request_with_http_basic do |name,password|
      name=="admin" && password=="admin"
    end
  end
end
