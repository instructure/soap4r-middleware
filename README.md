Soap4r Rack Middleware
======================

This small library provides a Rack Middleware interface to exposing
Soap4r server endpoints. This is a lightweight alternative to using
ActionWebService for exposing SOAP in a Rails application, as well as
allowing SOAP endpoints in any other Rack-based application. It's been
tested with Rails 2.3.x, but should work fine in Rails 3 as well.

Install
-------

    $ gem install soap4r-middleware

Usage
-----

First, get yourself some Soap4r endpoint code. The easiest way to do
this is to generate it from a WSDL file. Details are in the Soap4r
documentation, or see http://dev.ctor.org/soap4r/wiki/HowtouseWSDL4R ,
but basically:

    $ wsdl2ruby.rb --wsdl /path/to/definiton.wsdl --type server

You'll get some generated files. One of them will be named
like `*APIService.rb`, near the bottom will be a class of the same name.
To enable middleware functionality, you want to copy this class'
initialization code into a new class that subclasses `Soap4r::Middleware::Base`, and replace the initialize method with a block passed to `setup`. For instance:

    gem 'soap4r-middleware' # or use Bundler
    require 'soap4r-middleware'

    class MyAPIMiddleware < Soap4r::Middleware::Base
      setup do
        self.endpoint = %r{^/url/to/soap/endpoint/}
        servant MyAPIPort.new
        MyAPIPort::Methods.each do |definitions|
          opt = definitions.last
          if opt[:request_style] == :document
            @router.add_document_operation(servant, *definitions)
          else
            @router.add_rpc_operation(servant, *definitions)
          end
        end
        self.mapping_registry = UrnMyAPIMappingRegistry::EncodedRegistry
        self.literal_mapping_registry = UrnMyAPIMappingRegistry::LiteralRegistry
      end
    end

Then use this middleware anywhere you'd use a Rack middleware. It
doubles as a Rack application as well, so you can host it directly using
`run MyAPIMiddleware.new` in your `rackup.ru` file.

### TODO

I guess I could wrap `wsdl2ruby.rb` and make this automatic.

### Wait, This is For Seriously??

Sometimes you just gotta SOAP. Might as well make it suck as little as
possible.
