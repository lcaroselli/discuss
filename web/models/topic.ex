defmodule Discuss.Topic do
  Use Discuss.Web, :model

  # model relates phoenix app to postgres database; tell phoenix wha to expect in our database
  # validation will also go here - validate a model BEFORE it gets to the database

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

# Struct - hashes that contain a finite set of properties; cannot add new properties outside of struct,
# but can update property values. Represents a RECORD in our database.
# WHAT IT IS RIGHT NOW

# Params - hash, description of the new properties that we want to update our model with
# (will usually have same properties as the struct) -- params just has what we want to update
# WHAT IT NEEDS TO BE

# Cast - produces a changeset; the changeset is the object that records the changes
# we need to make in our database
# WHAT PRODUCES A CHANGESET

# Changeset - DESCRIBES HOW WE GET FROM WHERE WE ARE TO WHERE WE NEED TO BE and applies validations
# adds errors to changeset

# Final changeset we get is what represents how we're trying to update the databasec
