using Bukdu

struct RESTController <: ApplicationController
    conn::Conn
end

function create(c::RESTController)
    @info :message something(c.params.message, "emtpy")
    render(JSON, "OK")
end

routes() do
    post("/messages", RESTController, create)
    plug(Plug.Parsers, parsers=[:json])
end

Bukdu.start(8080)

# curl -H "Content-Type: application/json" http://127.0.0.1:8080/messages -d '{"message":"Hello Data"}'
