require 'puppet/parser/functions/mongodb'

module Puppet::Parser::Functions
    newfunction(:mongodb_find, :type => :rvalue) do |args|
        coll = PuppetMongoHelpers.mongodb_collection(args[0])
        rows = []
        coll.find(args[1]).each { |row| rows.push( row ) }
        return rows
    end
end
