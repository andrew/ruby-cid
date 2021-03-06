require "cid/version"
require 'cid/varint'
require 'delegate'
require 'base58'
require 'ostruct'
require 'multibases'
require 'multicodecs'

module Cid
  class Error < StandardError; end
  extend self
  def decode(string)
    if string.length == 46 && string[0..1] == 'Qm'
      # legacy CIDv0 decode as base58btc
      binary = Base58.base58_to_binary(string, :bitcoin)
      version = 0
      multicodec = OpenStruct.new(code: 'implicit', name: 'dag-pb')

      integer, length, digest = binary.unpack('CCa*')

      mh = {code: integer, hash_function: Multicodecs[integer].name, length: length, digest: digest}

      multihash = OpenStruct.new(code: mh[:code], name: mh[:hash_function], bits: mh[:digest].bytesize*8, digest: mh[:digest])
      multibase = OpenStruct.new(prefix: 'implicit', name: 'base58btc')
    else
      m = Multibases.unpack(string)
      decoded = m.decode
      version = decoded[0]

      multicodec_identifer = decoded[1]
      multicodec = Multicodecs[multicodec_identifer]

      encoded_multihash = decoded[2..-1]

      io = StringIO.new encoded_multihash.pack('c*')
      code = Varint.decode(io)
      codec = Multicodecs[code]
      length = Varint.decode(io)*8
      digest = io.read

      multihash = OpenStruct.new(code: codec.code, name: codec.name, bits: length, digest: digest)

      multibase = OpenStruct.new(prefix: m.code, name: m.encoding)
    end

    OpenStruct.new(version: version, multihash: multihash, multibase: multibase, multicodec: multicodec)
  end
end
