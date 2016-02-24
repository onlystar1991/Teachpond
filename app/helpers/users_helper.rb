module UsersHelper

  # Gravatar for the current user
  def gravatar_for(profile)
  	if profile.avatar.url == '/image/index.png'  		
	    gravatar_id = Digest::MD5::hexdigest(profile.user.email)
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
	    image_tag(gravatar_url, class: "gravatar")
	else
    	image_tag(profile.avatar.url, alt: profile.first_name, class: 'gravatar')
    end
  end
end
