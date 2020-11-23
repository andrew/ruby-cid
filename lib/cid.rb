require "cid/version"
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
      # CIDv0 decode as base58btc
      binary = Base58.base58_to_binary(string, :bitcoin)
      version = 0
      multicodec = {code: 'implicit', name: 'dag-pb'}

      integer, length, digest = binary.unpack('CCa*')

      mh = {code: integer, hash_function: Multicodecs[integer].name, length: length, digest: digest}

      multihash = {code: mh[:code], name: mh[:hash_function], bits: mh[:digest].bytesize*8, digest: mh[:digest]}
      multibase = {prefix: 'implicit', name: 'base58btc'}
    else
      m = Multibases.unpack(string)

      code = string[0]
      encoded_data = string[1..-1]
      engine = Multibases.find_by(code: code)
      # bytes = encoded_data.bytes
      p encoded_data
      p bytes = engine.engine.decode(encoded_data)

      integer, length, digest = bytes.instance_variable_get(:encoding).unpack('CCa*')

      version = integer

      multicodec = Multicodecs[length]

      integer, length, digest = digest.unpack('CCa*')
      mh = {code: integer, hash_function: Multicodecs[integer].name, length: length, digest: digest}

      multihash = {code: mh[:code], name: mh[:hash_function], bits: mh[:digest].bytesize*8, digest: mh[:digest]}

      multibase = {prefix: m.code, name: m.encoding}
    end

    cid = OpenStruct.new(version: version, multihash: multihash, multibase: multibase, multicodec: multicodec)
  end
end
