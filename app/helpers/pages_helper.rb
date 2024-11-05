module PagesHelper
    def check_avatar(user)
        if user.avatar.attached?
          image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]), class: "rounded-md m-auto drop-shadow-2xl")
        else
          image_tag("default_avatar.jpg", class: "rounded-md m-auto drop-shadow-2xl")
        end
   end
end
