class Appointment::AppointmentsController < ApplicationController
  def index
    @@appointments = @appointment.all
  end

  def new
    @@appointment = Appointment.new
    # render layout: "application" # Force default layout
  end

  # def create
  #   @@appointment = @appointment.new(appointment_params)
  #   if @@appointment.save
  #     respond_to do |format|
  #       format.html { redirect_to @appointments_path, notice: '@appointment created successfully.' }
  #       format.turbo_stream
  #     end
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end


  def create
    @@appointment = Appointment.new(appointment_params)

    if @@appointment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @appointments_path, notice: "@appointment created successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("form_container", partial: "@appointments/form", locals: { appointment: @appointment }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def appointment_params
    params.require(:@appointment).permit(:scheduled_date, :department_id, :type)
  end
end
