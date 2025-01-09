module PagesHelper
    def profile_avatar(user)
        if user.avatar.attached?
          image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]))
        else
          image_tag("default_avatar.png", size: "500")
        end
    end
end
