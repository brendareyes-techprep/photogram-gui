class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :desc })
    render({ :template => "photo_templates/index"})
  end
  def show
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id})
    @the_photo = matching_photos.at(0)
    render({ :template => "photo_templates/show"})
  end
  def destroy
    #Parameters: {"path_id"=>"880"}
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => the_id})
    the_photo = matching_photos.at(0)
    the_photo.destroy 
    #render({ :template => "photo_templates/destroy"})
    redirect_to("/photos")
  end 
  def create
    #Parameters: {"input_image"=>"a", "input_caption"=>"b", "input_owner_id"=>"112"}
    input_image = params.fetch("input_image")
    input_caption = params.fetch("input_caption")
    input_owner = params.fetch("input_owner_id")

    input_photo = Photo.new
    input_photo.image = input_image
    input_photo.caption = input_caption
    input_photo.owner_id = input_owner
    input_photo.save
    #render({ :template => "photo_templates/create"})
    redirect_to("/photos/" + input_photo.id.to_s)
  end
end
