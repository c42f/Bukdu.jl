importall Bukdu
importall Bukdu.Octo
importall Bukdu.Tag

type User
    name::String
    age::Int
end

form = change(default(User), name="jack")

using Base.Test
@test """<label for="user_name">Name</label>""" == label(form, :name, "Name")
