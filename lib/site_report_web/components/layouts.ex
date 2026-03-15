defmodule SiteReportWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use SiteReportWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-b from-zinc-50 via-white to-amber-50 text-zinc-950">
      <header class="border-b border-white/70 bg-white/80 backdrop-blur">
        <div class="mx-auto flex max-w-6xl items-center justify-between gap-6 px-4 py-5 sm:px-6 lg:px-8">
          <a href="/" class="flex items-center gap-4">
            <div class="flex size-11 items-center justify-center rounded-2xl bg-zinc-950 text-sm font-semibold text-white shadow-sm shadow-zinc-300/60">
              SR
            </div>
            <div>
              <p class="text-xs font-semibold uppercase tracking-[0.3em] text-amber-600">
                Daily reporting
              </p>
              <h1 class="text-lg font-semibold tracking-tight text-zinc-950">Site Report AI</h1>
            </div>
          </a>

          <div class="flex items-center gap-3">
            <.link
              navigate={~p"/reports"}
              class="hidden rounded-full px-4 py-2 text-sm font-medium text-zinc-600 transition hover:bg-zinc-100 hover:text-zinc-900 sm:inline-flex"
            >
              Reports
            </.link>
            <.link
              navigate={~p"/reports/new"}
              class="inline-flex items-center rounded-full bg-zinc-950 px-4 py-2 text-sm font-semibold text-white transition hover:bg-zinc-800"
            >
              New report
            </.link>
            <.theme_toggle />
          </div>
        </div>
      </header>

      <main class="px-4 py-10 sm:px-6 lg:px-8">
        <div class="mx-auto max-w-6xl space-y-4">
          {render_slot(@inner_block)}
        </div>
      </main>

      <.flash_group flash={@flash} />
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="relative flex flex-row items-center rounded-full border border-zinc-200 bg-white p-1 shadow-sm">
      <div class="absolute left-1 h-9 w-9 rounded-full bg-zinc-100 transition-[left] [[data-theme=light]_&]:left-10 [[data-theme=dark]_&]:left-[4.75rem]" />

      <button
        class="relative z-10 flex size-9 cursor-pointer items-center justify-center rounded-full text-zinc-500 transition hover:text-zinc-950"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        type="button"
      >
        <.icon name="hero-computer-desktop" class="size-4" />
      </button>

      <button
        class="relative z-10 flex size-9 cursor-pointer items-center justify-center rounded-full text-zinc-500 transition hover:text-zinc-950"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
        type="button"
      >
        <.icon name="hero-sun" class="size-4" />
      </button>

      <button
        class="relative z-10 flex size-9 cursor-pointer items-center justify-center rounded-full text-zinc-500 transition hover:text-zinc-950"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
        type="button"
      >
        <.icon name="hero-moon" class="size-4" />
      </button>
    </div>
    """
  end
end
