module ApplicationHelper
  include Pagy::Frontend

  def pagy_nav(pagy)
    html = %(<div class="join border border-black/20" aria-label="Pages">)

    if pagy.prev
      html << %(<a href="#{pagy_url_for(pagy, pagy.prev)}" class="join-item btn" aria-label="Previous">«</a>)
    else
      html << %(<button class="join-item btn" aria-disabled="true" aria-label="Previous">«</button>)
    end

    pagy.series.each do |item|
      if item.is_a? Integer
        html << %(<a href="#{pagy_url_for(pagy, item)}" class="join-item btn">#{item}</a>)
      elsif item.is_a? String
        html << %(<button class="join-item btn btn-active" aria-disabled="true" aria-current="page">#{item}</button>)
      elsif item == :gap
        html << %(<button class="join-item btn btn-disabled" aria-disabled="true">...</button>)
      end
    end

    if pagy.next
      html << %(<a href="#{pagy_url_for(pagy, pagy.next)}" class="join-item btn" aria-label="Next">»</a>)
    else
      html << %(<button class="join-item btn" aria-disabled="true" aria-label="Next">»</button>)
    end

    html << %(</div>)

    html.html_safe
  end




  def date(date)
      date.strftime("%d/%m/%Y")
  end

  def header_avatar
      user=current_user
      if user.avatar.attached?
        image_tag(user.avatar.variant(resize_and_pad: [ 500, 500 ]))
      else
        image_tag("default_avatar.png")
      end
  end
end
