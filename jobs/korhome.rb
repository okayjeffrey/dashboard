require 'net/http'
require 'json'

# authenticate
ip_address = "192.168.86.111"
http = Net::HTTP.new(ip_address, 80)
username = "1e42344837c87b7f15bb21f8362a2f6f"
info = Net::HTTP::Get.new('/api/'+username+'/lights')

# data.each do |i|
#     # puts "#{x}. I got #{i}"
#     i.each { |item|
#         puts item['name']
#     }
#     x += 1
# end

# for i, item in data
#   # puts "This is count #{item}"
#   puts item['name']
# end

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '30s', :first_in => 0 do |job|
    response = http.request(info)
    data = JSON.parse(response.body)
    index = 0

    data.each do |i, items|
        index += 1

        puts "/// #{i}"
        puts items['name']

        puts items

        # items['state'].each do |item|
        for item in items['state'] do

            puts "--- #{item}"

                # if light['colormode'] == 'xy'
                #     #convert from xy to rgb
                #     x = light["xy"][0]
                #     y = light["xy"][1]
                #     z = 1.0 - x - y
                #     brightness = 200
                #     print "brightness is " + String(brightness)
                #     final_x = (brightness / y) * x
                #     final_z = (brightness / y) * z
                #     r =  (String(final_x * 1.656492 - brightness * 0.354851 - final_z * 0.255038).split "." )[0]
                #     g = (String(-final_x * 0.707196 + brightness * 1.655397 + final_z * 0.036152).split "." )[0]
                #     b =  (String(final_x * 0.051713 - brightness * 0.121364 + final_z * 1.011530).split "." )[0]
                #     color = "rgb(#{r},#{g},#{b})"
                # else
                #       print light["hue"]
                #       #convert from philips hue to hsl
                #       hue = (String((light["hue"]*360)/65535))
                #       sat = String(light["sat"]*100/255)
                #       bri = String(100*200/255)
                #       color = "hsl("+hue+","+sat+"%,"+bri+"%)"
                # end

                # send_event('korhome-light-'+String(i), { hue_id:i, light_name: iname}) #,  bg_color: color})

        end
    end
end
