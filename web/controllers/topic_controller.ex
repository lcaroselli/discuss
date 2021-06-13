defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    # struct = Topic%{}
    # params = %{}
    changeset = Topic.changeset(Topic%{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  # def create(conn, params) do
  #   %{"topic" => topic} = params
  # end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(Topic%{}, topic)

    # the repo module comes from Ecto and it is the thing that actually is responsible for
    # making the changes to the database (postgres in this case)
    # changeset and repo both comes from Ecto library
    case Repo.insert(changeset) do
      {:ok, post} ->

      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
      # this is the changeset that was failed for some reason to be inserted
    end
  end
end
