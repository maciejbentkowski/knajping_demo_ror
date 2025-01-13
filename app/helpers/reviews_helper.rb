module ReviewsHelper

    def review_avatar(user)
        if user.avatar.attached?
          image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]))
        else
          image_tag("default_avatar.png")
        end
      end
end
