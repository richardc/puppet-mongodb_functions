require 'puppet/parser/functions/mongodb'

module Puppet::Parser::Functions
    newfunction(:mongodb_insert) do |args|
        coll = PuppetMongoHelpers.mongodb_collection(args[0])
        coll.insert(args[1])
    end
end
