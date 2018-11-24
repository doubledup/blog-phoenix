defmodule TeacherWeb.CommentController do
  use TeacherWeb, :controller

  alias Teacher.Blog
  alias Teacher.Blog.Comment

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Blog.get_post!(post_id)
    comment_changeset = Ecto.build_assoc(post, :comments, body: comment_params["body"])

    Teacher.Repo.insert(comment_changeset)

    conn
    |> put_flash(:info, "Comment created successfully.")
    |> redirect(to: TeacherWeb.Router.Helpers.post_path(conn, :show, post))
  end
end
