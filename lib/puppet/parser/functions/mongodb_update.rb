require 'puppet/parser/functions/mongodb'

module Puppet::Parser::Functions
    newfunction(:mongodb_update) do |args|
        coll = PuppetMongoHelpers.mongodb_collection(args[0])
        coll.update(args[1], args[2])
    end
end
