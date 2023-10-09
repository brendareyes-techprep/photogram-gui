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
  def update 
    #Parameters: {"input_image"=>"https://robohash.org/modieumvoluptate.png?size=300x300&set=set1", "input_caption"=>"hi", "modify_id"=>"785"}
    the_id = params.fetch("modify_id")
    matching_photos = Photo.where( :id => the_id)
    the_photo = matching_photos.at(0)

    input_image = params.fetch("input_image")
    input_caption = params.fetch("input_caption")

    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save
    #render({ :template => "photo_templates/update"})
    redirect_to("/photos/" + the_photo.id.to_s)
  end 
  def comment
    #Parameters: {"input_photo_id"=>"777", "input_author_id"=>"113", "input_comment"=>"hi"}
  input_photo_id = params.fetch("input_photo_id")
  input_author_id  = params.fetch("input_author_id")
  input_new_comment = params.fetch("input_comment")
  
  input = Comment.new
  input.photo_id = input_photo_id
  input.author_id = input_author_id
  input.body = input_new_comment

  input.save

  redirect_to("/photos/#{input.photo_id}")
    #render({ :template => "photo_templates/comment"})
  end
end
