defmodule PracticeWeb.ConversationLive do
  use Phoenix.LiveView
  # use Phoenix.HTML

  import Phoenix.HTML
  import Phoenix.HTML.Form
  use PhoenixHTMLHelpers
  alias Practice.{Auth, Chat, Repo}
  alias Practice.Auth.User

  def render(assigns) do
    ~L"""
    <div>
      <b>User name:</b> <%= @user.nickname %>
    </div>
    <div>
      <b>Conversation title:</b> <%= @conversation.title %>
    </div>
    <div>
      <%= form_for :message, "#", [phx_submit: "send_message"], fn f -> %>
        <%= label f, :content %>
        <%= text_input f, :content %>
        <%= submit "Send" %>
      <% end %>
    </div>
    <div>
      <b>Messages:</b>
      <%= for message <- @messages do %>
        <div>
          <b><%= message.user.nickname %></b>: <%= message.content %>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def handle_event(
        "send_message",
        %{"message" => %{"content" => content}},
        %{assigns: %{conversation_id: conversation_id, user_id: user_id, user: user}} = socket
      ) do
    case Chat.create_message(%{
           conversation_id: conversation_id,
           user_id: user_id,
           content: content
         }) do
      {:ok, new_message} ->
        new_message = %{new_message | user: user}
        updated_messages = socket.assigns[:messages] ++ [new_message]

        PracticeWeb.Endpoint.broadcast_from!(
          self(),
          "conversation_#{conversation_id}",
          "new_message",
          new_message
        )

        {:noreply, socket |> assign(:messages, updated_messages)}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_params(%{"conversation_id" => conversation_id, "user_id" => user_id}, _uri, socket) do
    PracticeWeb.Endpoint.subscribe("conversation_#{conversation_id}")

    {:noreply,
     socket
     |> assign(:user_id, user_id)
     |> assign(:conversation_id, conversation_id)
     |> assign_records()}
  end

  defp assign_records(%{assigns: %{user_id: user_id, conversation_id: conversation_id}} = socket) do
    user = Auth.get_user!(user_id)

    # Here we get the conversation with the given id from the database.
    # We use `Repo.preload` to load associated records, which are
    # messages and conversation members.
    #
    # The `:messages` option is used to load the messages associated
    # with the conversation. The `[:user]` is a nested preload, which
    # means we load the user associated with each message.
    #
    # The `:conversation_members` option is used to load the
    # conversation members associated with the conversation. The
    # `[:user]` is a nested preload, which means we load the user
    # associated with each conversation member.
    #
    # The result of this is a conversation struct with preloaded
    # messages and conversation members. We assign it to the socket
    conversation =
      Chat.get_conversation!(conversation_id)
      |> Repo.preload(messages: [:user], conversation_members: [:user])

    IO.puts("Conversation:")
    IO.puts("  Id: #{conversation.id}")
    IO.puts("  Title: #{conversation.title}")
    IO.puts("  Messages:")

    Enum.each(conversation.messages, fn message ->
      IO.puts("    - #{message.content} (#{message.user.nickname})")
    end)

    IO.puts("  Conversation members:")

    Enum.each(conversation.conversation_members, fn conversation_member ->
      IO.puts(
        "    - #{conversation_member.user.nickname} (#{if conversation_member.owner, do: "owner", else: "not owner"})"
      )
    end)

    # IO.inspect(conversation, label: "Conversation")

    # Enum.each(conversation.messages, fn message ->
    #   IO.puts(message.user.nickname)
    # end)

    socket
    |> assign(:user, user)
    |> assign(:conversation, conversation)
    |> assign(:messages, conversation.messages)
  end

  def handle_info(%{event: "new_message", payload: new_message}, socket) do
    updated_messages = socket.assigns[:messages] ++ [new_message]

    {:noreply, socket |> assign(:messages, updated_messages)}
  end
end
