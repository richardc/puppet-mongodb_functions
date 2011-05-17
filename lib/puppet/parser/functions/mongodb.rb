# Dear world, I'm not sure if making everything a class method so you can
# have a utility class to put stuff in is particularly the right way to do it
# in ruby, but it worked.   Better approaches welcomed.

class PuppetMongoHelpers
    class << self
        def load_mongodb
            begin
                require 'rubygems'
                require 'mongo'
            rescue
                # you have no mongo gem - aiee!
                # TODO - report this better
                raise
            end
        end

        def mongodb_collection(args)
            load_mongodb()
            db = Mongo::Connection.new.db(args["database"])
            collection = db.collection(args["collection"])
            return collection
        end
    end
end
