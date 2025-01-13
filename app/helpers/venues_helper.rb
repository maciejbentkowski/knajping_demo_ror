module VenuesHelper
    def datetime(date)
        date.strftime("%d/%m/%Y - %H:%M")
    end

    def check_primary_photo(venue)
        if venue.primary_photo.attached?
          image_tag(venue.primary_photo.variant(resize_to_fill: [ 250, 250 ]).processed, class: "rounded-md m-auto drop-shadow-2xl")
        else
          image_tag("default_primary_photo.webp", width: 250, height: 250, class: "rounded-md m-auto drop-shadow-2xl")

        end
   end

   def check_photo(venue)
      if venue.photos.attached?
        image_tag(venue.photo, class: "rounded-md m-auto drop-shadow-2xl")
      else
        "Lokal nie zawiera zdjęć"
      end
   end

   def primary_photo_in_form(venue)
      if venue.primary_photo.attached?
        image_tag(venue.primary_photo.variant(resize_to_fill: [ 200, 200 ]).processed, class: "mx-auto object-cover my-5")
      else
        "Zdjęcie nie zostało dodane"
      end
   end

   def photo_in_form(photo)
      image_tag(photo.variant(resize_to_fill: [ 300, 300 ]).processed, class: "mx-auto object-cover my-5")
   end

   def check_reviews(venue)
      if venue.reviews.count == 0
        ""
      else
        "( %s in %s Reviews )" % [ venue.avg_venue_rating, venue.reviews_count ]
      end
   end

  def comment_avatar(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]))
    else
      image_tag("default_avatar.png")
    end
  end

  def review_avatar(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]))
    else
      image_tag("default_avatar.png")
    end
  end
end
