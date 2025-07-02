defmodule Person do
  defstruct name: "Pasha", age: 21
end

defmodule Plus do
  def person(%Person{} = person) do
    %{person | age: person.age + 1}
  end
end

# user = %Person{}
# IO.inspect(user)

# user = Plus.person(user)
# IO.inspect(user)
