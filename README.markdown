provides wrappers to mongodb via the 'mongo' gem

http://www.mongodb.org/display/DOCS/Ruby+Language+Center


Basic pattern is `mongo_function($dsn, $doc, [$args])`

The DSN specifies the database and collection name

Semi-baked example:

        define haproxy::backend ($port = 80) {
            $mdsn = { database => "puppet", collection => "haproxy" }
            $document = {
                _id => "${fqdn}_${name}",
                fqdn => $fqdn,
                name => $name,
                ip   => $ipaddress,
                port => $port,
            }
            mongodb_save( $mdsn, $document )
        }

        class haproxy {
            $mdsn = { database => "puppet", collection => "haproxy" }
            $haproxy_backends = mongodb_find( $mdsn, {} )
            file { "/etc/haproxy/haproxy.cfg":
                content => template("haproxy/haproxy.cfg"),
            }
        }

        # templates/haproxy.cfg
        <% apps = haproxy_backends.collect { |b| b["name"] }.uniq %>
        <% apps.each do |app| %>
        backend <%= app %>
            balance roundrobin
            <% haproxy_backends.select { |b| b["name"] == app }.each do |backend| %>
            server <%= backend["fqdn"] %> <%= backend["ip"] %>:<%= backend["port"] %> check
            <% end %>
        <% end %>

Don't forget to restart your puppetmaster after pluginsync puts the functions
in place.

