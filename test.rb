require "bundler/setup"
require "cid"

# Multibases.implement 'base58btc', '1', Multibases::BaseX, '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

str = 'bafybeihqx4lfeh6dgvb5lq7mzpzj2t5hy5uxirla7dm76lba4biy3hq2g4'

cids = [
  'bafybeihqx4lfeh6dgvb5lq7mzpzj2t5hy5uxirla7dm76lba4biy3hq2g4',
  'bafkqaaa',
  'QmcdkCU262taYxBqNFaUiDAyd2NkmTQoZ5DTXFqot9eReV',
  'zb2rhe5P4gXftAwvA4eXQ5HJwsER2owDyS9sKaQRRVQPn93bA',
  'z45btRgLsWtUjnxUC6eCo1EWfquee6nzwdLPDGyM7YAjiZHn6iArvVr546aaCXwsinDV7pLuzx3CfM7KiAXqf9CcqjjfVU9g4toFd9VE7VMASTrxDYWCzohasmJy1CbGhoArqQp5PyNPC6SBMYMqPQsGuUNXAtEBphybn9xRw3q9U7uyw77gMz3RzRSCo5D7nd6F3KcoQYuxD6NoGuqFuYoE2PHhZLksDd5StdH2a69WEWF2Y9RP1ZMZ5igg8XZH6DREV3h3'
]

cids.each do |str|

  puts str
  cid = Cid.decode str

  puts "version: cidv#{cid.version}"
  puts "multibase:"
  puts "  prefix: #{cid.multibase[:prefix]}"
  puts "  name: #{cid.multibase[:name]}"
  puts ""
  puts "multicodec:"
  puts "  code: 0x#{cid.multicodec[:code]}"
  puts "  name: #{cid.multicodec[:name]}"
  puts ""
  puts "multihash:"
  puts "  code: #{cid.multihash[:code].to_s(16)}"
  puts "  name: #{cid.multihash[:name]}"
  puts "  bits: #{cid.multihash[:bits]}"
  puts ""
end

# puts ""
#
# str = 'bafkqaaa'
# puts str
# p Cid.decode str
#
# puts ""
#
# str = 'QmcdkCU262taYxBqNFaUiDAyd2NkmTQoZ5DTXFqot9eReV'
# puts str
# p Cid.decode str
#
# puts ""
#
# str =
# puts str
# p Cid.decode str
