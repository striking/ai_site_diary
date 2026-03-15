defmodule SiteReport.Reports do
  @moduledoc """
  The Reports context.
  """

  alias SiteReport.Repo
  alias SiteReport.Reports.DailyReport

  def list_daily_reports do
    Repo.all(DailyReport)
  end

  def get_daily_report!(id), do: Repo.get!(DailyReport, id)

  def create_daily_report(attrs \\ %{}) do
    attrs
    |> normalize_report_attrs()
    |> then(fn normalized_attrs ->
      %DailyReport{}
      |> DailyReport.changeset(normalized_attrs)
      |> Repo.insert()
    end)
  end

  def extract_report_attrs(description) when is_binary(description) do
    cleaned_description = String.trim(description)
    summary = cleaned_description

    title =
      cleaned_description
      |> String.split(~r/[.!?\n]+/, trim: true)
      |> List.first("Site activity update")
      |> String.trim()
      |> String.slice(0, 80)

    %{
      title: title,
      summary: summary,
      date: Date.utc_today()
    }
  end

  def delete_daily_report(%DailyReport{} = daily_report) do
    Repo.delete(daily_report)
  end

  defp normalize_report_attrs(%{"description" => description}) do
    extract_report_attrs(description)
  end

  defp normalize_report_attrs(%{description: description}) do
    extract_report_attrs(description)
  end

  defp normalize_report_attrs(attrs), do: attrs
end
