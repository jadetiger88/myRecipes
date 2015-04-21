module ApplicationHelper
    def gravatar_for(chef, options = {size: 80})
        gravarta_id = Digest::MD5::hexdigest(chef.email.downcase) 
        size = options[:size]
        gravata_url= "https://secure.gravatar.com/avatar/#{gravarta_id}?s=#{size}"
        image_tag(gravata_url, alt: chef.chef_name, class: "gravartar")
    end
end
