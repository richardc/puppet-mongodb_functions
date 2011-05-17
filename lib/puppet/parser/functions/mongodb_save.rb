require 'puppet/parser/functions/mongodb'

module Puppet::Parser::Functions
    newfunction(:mongodb_save) do |args|
        coll = PuppetMongoHelpers.mongodb_collection(args[0])
        coll.save(args[1])
    end
end
