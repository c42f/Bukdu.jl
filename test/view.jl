importall Bukdu

type ViewController <: ApplicationController
end

layout(::Layout, body, options) = "<html><body>$body<body></html>"
index(::ViewController) = render(View/Layout; path="page.tpl", contents="hello")

Router() do
    get("/", ViewController, index)
end


using Base.Test
conn = (Router)(index, "/")
@test 200 == conn.status
@test "<html><body><div>hello</div><body></html>" == conn.resp_body

logs = []
Bukdu.before(::Type{View}) = push!(logs, :b)
Bukdu.after(::Type{View}) = push!(logs, :a)
conn = (Router)(index, "/")
@test [:b, :a] == logs

conn = (Router)(index, "/")
@test [:b, :a, :b, :a] == logs

@test "<div>hello</div>" == render(View; path="page.tpl", contents="hello")
@test "<html><body><div>hello</div><body></html>" == render(View/Layout; path="page.tpl", contents="hello")
