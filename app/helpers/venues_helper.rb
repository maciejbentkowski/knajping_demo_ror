module VenuesHelper
    def datetime(date)
        date.strftime("%d/%m/%Y - %H:%M")
    end

    def check_primary_photo(venue)
        if venue.primary_photo.attached?
          image_tag(venue.primary_photo, class: "rounded-md m-auto drop-shadow-2xl")
        else
          image_tag("default_primary_photo.webp", class: "rounded-md m-auto drop-shadow-2xl")
        end
   end
end
