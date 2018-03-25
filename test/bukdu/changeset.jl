using Test
using Bukdu # Assoc Changeset
using Bukdu.HTML5.Form # change

struct User
    name
    age::Int
    salary::Float64
end

changeset = Changeset(User)
@test changeset.changes == NamedTuple()

params = Assoc("user_name" => "Alex", "user_age" => "20")
changeset = change(User, params)
@test changeset.changes == (name="Alex", age=20)

params = Assoc("user_" => "Alex", "user_age" => "20")
changeset = change(User, params)
@test changeset.changes == (age=20,)

params = Assoc("user_id" => "1", "user_name" => "Shen", "user_age" => "20")
changeset = change(User, (id=1, name="Alex", age=20), params, primary_key="id")
@test changeset.changes == (id=1, name="Shen")
