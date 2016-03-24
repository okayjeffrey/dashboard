require 'net/http'
require 'json'

# authenticate
ip_address = "192.168.86.111"
http = Net::HTTP.new(ip_address, 80)
username = "1e42344837c87b7f15bb21f8362a2f6f"
info = Net::HTTP::Get.new('/api/'+username+'/lights')

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '10s', :first_in => 0 do |job|
  response = http.request(info)
  data = JSON.parse(response.body)
  index = 0

  data.each do |i, light|
    hue   = "hsl(0, 0%, 20%)"
    color = "rgb(0, 128, 0)" #green

    if light["modelid"] == "LCT001" # AKA Extended color light
        #--- convert from philips hue to hsb to HSL
        hue = (String((light["state"]["hue"]*360)/65535))
        sat = String((light["state"]["sat"]*100/255)/1.12)
        bri = String((light["state"]["bri"]*100/255)/1.75)

        if light["state"]["on"] == true && light["state"]["reachable"] == true
            color = "hsl("+hue+","+sat+"%,"+bri+"%)"
        else
            color = "hsl(0, 0%,1%)"
        end
    elsif light["modelid"] == "LWB004" # AKA Dimmable light
        bri = String((light["state"]["bri"]*80/255))

        if light["state"]["on"] == true && light["state"]["reachable"] == true
            color = "hsl(60, 100%,"+bri+"%)"
        else
              color = "hsl(0, 0%,1%)"
        end
    else
        color = "rgb(255, 0, 0)" #red
    end
    puts "--- light: #{String(i)} --- hue_id: #{i} --- light_name: #{light["name"]} --- bg_color: #{color} //"
    send_event("huebutton-light-"+String(i), { hue_id: i, light_name: light["name"], bg_color: color })
  end
end
