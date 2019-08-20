class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_from, only: [:show, :edit]
  before_action :set_to, only: [:show, :edit]
  before_action :authenticate_account!, only: [:new, :edit, :create, :update, :destroy]

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
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    puts event_params
    @event = Event.new(event_params)
    convert_datetimes
    @event.account = current_account
    @event.create_repeats

    puts @event

    respond_to do |format|
      if @event.save
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
    respond_to do |format|
      if @event.update(event_params)
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
    params.require(:event).permit(:title, :description, :account_id, :repeat_type, :from, :to)
  end

  def set_from
    @event.from = @event.repeats.map(&:datetime).min
  end

  def set_to
    unless @event.once?
      @event.to = @event.repeats.map(&:datetime).max
    end
  end

  def convert_datetimes
    @event.from = Time.new(*@event.from.values)
    if @event.to
      @event.to = Time.new(*@event.to.values)
    end
  end
end
