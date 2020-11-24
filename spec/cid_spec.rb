require 'cid'

describe Cid do
  it "decode ipfs cidv0" do
    cid = Cid.decode("QmcdkCU262taYxBqNFaUiDAyd2NkmTQoZ5DTXFqot9eReV")
    expect(cid.version).to eql(0)

    expect(cid.multibase.name).to eql("base58btc")
    expect(cid.multibase.prefix).to eql("implicit")

    expect(cid.multicodec.code).to eql("implicit")
    expect(cid.multicodec.name).to eql("dag-pb")

    expect(cid.multihash.code).to eql(18)
    expect(cid.multihash.name).to eql("sha2-256")
    expect(cid.multihash.bits).to eql(256)
    expect(cid.multihash.digest.unpack('H*').first).to eql('d464b2763c32ff62236e08eafeb945fe4ed7ba0196907453bce3308f1dd63c86')
  end

  it "decode ipfs cidv1" do
    cid = Cid.decode("bafybeihqx4lfeh6dgvb5lq7mzpzj2t5hy5uxirla7dm76lba4biy3hq2g4")
    expect(cid.version).to eql(1)

    expect(cid.multibase.name).to eql("base32")
    expect(cid.multibase.prefix).to eql("b")

    expect(cid.multicodec.code.to_s(16)).to eql('70')
    expect(cid.multicodec.name).to eql("dag-pb")

    expect(cid.multihash.code).to eql(18)
    expect(cid.multihash.name).to eql("sha2-256")
    expect(cid.multihash.bits).to eql(256)
    expect(cid.multihash.digest.unpack('H*').first).to eql('f0bf16521fc33543d5c3eccbf29d4fa7c769744560f8d9ff2c20e0518d9e1a37')
  end

  it "decode short ipfs cidv1" do
    cid = Cid.decode("bafkqaaa")
    expect(cid.version).to eql(1)

    expect(cid.multibase.name).to eql("base32")
    expect(cid.multibase.prefix).to eql("b")

    expect(cid.multicodec.code.to_s(16)).to eql('55')
    expect(cid.multicodec.name).to eql("raw")

    expect(cid.multihash.code).to eql(0)
    expect(cid.multihash.name).to eql("identity")
    expect(cid.multihash.bits).to eql(0)
    expect(cid.multihash.digest.unpack('H*').first).to eql('')
  end


  it "decode base58btc ipfs cidv1" do
    cid = Cid.decode("zb2rhe5P4gXftAwvA4eXQ5HJwsER2owDyS9sKaQRRVQPn93bA")
    expect(cid.version).to eql(1)

    expect(cid.multibase.name).to eql("base58btc")
    expect(cid.multibase.prefix).to eql("z")

    expect(cid.multicodec.code.to_s(16)).to eql('55')
    expect(cid.multicodec.name).to eql("raw")

    expect(cid.multihash.code.to_s(16)).to eql("12")
    expect(cid.multihash.name).to eql("sha2-256")
    expect(cid.multihash.bits).to eql(256)
    expect(cid.multihash.digest.unpack('H*').first).to eql('6e6ff7950a36187a801613426e858dce686cd7d7e3c0fc42ee0330072d245c95')
  end

  it "decode long base58btc ipfs cidv1" do
    cid = Cid.decode("z45btRgLsWtUjnxUC6eCo1EWfquee6nzwdLPDGyM7YAjiZHn6iArvVr546aaCXwsinDV7pLuzx3CfM7KiAXqf9CcqjjfVU9g4toFd9VE7VMASTrxDYWCzohasmJy1CbGhoArqQp5PyNPC6SBMYMqPQsGuUNXAtEBphybn9xRw3q9U7uyw77gMz3RzRSCo5D7nd6F3KcoQYuxD6NoGuqFuYoE2PHhZLksDd5StdH2a69WEWF2Y9RP1ZMZ5igg8XZH6DREV3h3")
    expect(cid.version).to eql(1)

    expect(cid.multibase.name).to eql("base58btc")
    expect(cid.multibase.prefix).to eql("z")

    expect(cid.multicodec.code.to_s(16)).to eql('55')
    expect(cid.multicodec.name).to eql("raw")

    expect(cid.multihash.code.to_s(16)).to eql("0")
    expect(cid.multihash.name).to eql("identity")
    expect(cid.multihash.bits).to eql(1504)
    expect(cid.multihash.digest.unpack('H*').first).to eql("48656c6c6f20576f726c6473212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020206466202020202020202020202020202020202020202020202020206620202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a")
  end
end
