class AdmissionsController < ApplicationController
  
  def index
    @admissions = Admission.all
  end

  def new
    @admission = Admission.new
    # render layout: "application" # Force default layout
  end

  # def create
  #   @admission = Admission.new(patient_params)
  #   if @admission.save
  #     respond_to do |format|
  #       format.html { redirect_to admissions_path, notice: 'Admission created successfully.' }
  #       format.turbo_stream
  #     end
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end


  def create
    @admission = Admission.new(patient_params)

    if @admission.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admissions_path, notice: "Admission created successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("form_container", partial: "admissions/form", locals: { admission: @admission }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def patient_params
    params.require(:admission).permit(:department_id, :cashless_hospitalization, :scheduled_date)
  end
end
