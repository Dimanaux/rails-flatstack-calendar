class EventsController < ApplicationController
  before_action :set_event, only: %i( show edit update destroy )
  before_action :set_from_to, only: %i( show edit )
  before_action :authenticate_account!, only: %i( new edit create update destroy)

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
    @event.from = Date.parse(params[:from]).to_time if params[:from]
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    convert_datetimes(@event)
    @event.account = current_account

    respond_to do |format|
      if @event.save
        @event.create_repeats
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    raise "Cannot update other's event" unless @event.account == current_account

    respond_to do |format|
      if @event.update(event_params)
        @event.update_repeats
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    raise "Can't destroy other's event" unless @event.account == current_account

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :repeat_type,
      :from,
      :to
    )
  end

  def set_from_to
    @event.fetch_from_to!
  end

  def convert_datetimes(event)
    event.from = Time.new(*event.from.values)
    event.to = Time.new(*event.to.values) if event.to
  end
end
