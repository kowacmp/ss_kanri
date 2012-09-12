class DWashpurikaReportsController < ApplicationController
  # GET /d_washpurika_reports
  # GET /d_washpurika_reports.json
  def index
    @d_washpurika_reports = DWashpurikaReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_washpurika_reports }
    end
  end

  # GET /d_washpurika_reports/1
  # GET /d_washpurika_reports/1.json
  def show
    @d_washpurika_report = DWashpurikaReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_washpurika_report }
    end
  end

  # GET /d_washpurika_reports/new
  # GET /d_washpurika_reports/new.json
  def new
    @d_washpurika_report = DWashpurikaReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_washpurika_report }
    end
  end

  # GET /d_washpurika_reports/1/edit
  def edit
    @d_washpurika_report = DWashpurikaReport.find(params[:id])
  end

  # POST /d_washpurika_reports
  # POST /d_washpurika_reports.json
  def create
    @d_washpurika_report = DWashpurikaReport.new(params[:d_washpurika_report])

    respond_to do |format|
      if @d_washpurika_report.save
        format.html { redirect_to @d_washpurika_report, notice: 'D washpurika report was successfully created.' }
        format.json { render json: @d_washpurika_report, status: :created, location: @d_washpurika_report }
      else
        format.html { render action: "new" }
        format.json { render json: @d_washpurika_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_washpurika_reports/1
  # PUT /d_washpurika_reports/1.json
  def update
    @d_washpurika_report = DWashpurikaReport.find(params[:id])

    respond_to do |format|
      if @d_washpurika_report.update_attributes(params[:d_washpurika_report])
        format.html { redirect_to @d_washpurika_report, notice: 'D washpurika report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_washpurika_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_washpurika_reports/1
  # DELETE /d_washpurika_reports/1.json
  def destroy
    @d_washpurika_report = DWashpurikaReport.find(params[:id])
    @d_washpurika_report.destroy

    respond_to do |format|
      format.html { redirect_to d_washpurika_reports_url }
      format.json { head :ok }
    end
  end
end
