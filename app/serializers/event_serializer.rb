class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :start_time, :end_time,
   :location, :google_link
        

  attribute :host do |event|
    event.host
  end

 attribute :image_src do |event, params|
  event.picture_file.attached? ? params[:img_url] : false
 end

 attribute :accessability do |event|
  {water: event.water, mobility: event.mobility, flashing_lights: event.flashing_lights, bathrooms: event.bathrooms}
 end

  attribute :attending do |event, params|
    event.attendees.include?(params[:current_user])
  end

  attribute :attendees, if: Proc.new { |event, params|
    if (params[:current_user])
      event.host.id == params[:current_user].id || params[:current_user].role == 'admin'
    else
      false
    end
 }

 attribute :comments do |event|
  event.comments.order('comments.created_at DESC')[0..5]
 end
  
end
