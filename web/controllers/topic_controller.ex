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
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
        # need to re-route user
        # sending user to the index function in the topic controller

      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
      # this is the changeset that was failed for some reason to be inserted
    end
  end

  def edit(conn, %{"id" => topic_id} = params) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic, %{})
    # empty map because no changes being made yet, just grabbing the topic to edit
    # you can also drop the 2nd argument of empty map here since the default argument is an empty map
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    # old_topic is struct which is a record in the database
    # topic is the new/updated attributes of the record we want

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} -> render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, params) do
    :ok
  end
end
