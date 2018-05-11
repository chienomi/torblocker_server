User.create(
  [
    {
      user_name: "root",
      email: "hq@torblocker.com",
      password: "rootroot"
    },
    {
      user_name: "demo",
      email: "domo@torblocker.com",
      password: "demodemo"
    }
  ]
)

def get_tor_ip_list()
  filepath = Rails.root.to_s+"/db/tor_ip_list_preprocessed.txt"
  f = File.open(filepath, "r")

  buffer = f.read()
  tor_list = buffer.strip.split("\n")
  return tor_list
end

ip_list = get_tor_ip_list()
ips = []
ip_list.each do |ip_table|
  ips << {a: ip_table}
end

Ip.create(ips)
