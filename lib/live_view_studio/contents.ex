defmodule LiveViewStudio.Contents do
  alias LiveViewStudio.Contents.Content

  def git_url(branch) do
    "https://github.com/lastobelus/live_view_studio/tree/#{branch}"
  end

  def list_contents do
    [
      %Content{
        route: "/light",
        name: "Button Events",
        branch: "1-button-clicks-begin",
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/3"
      },
      %Content{
        route: "/license",
        name: "Dynamic Form",
        branch: "2-dynamic-form-begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/5"
      },
      %Content{
        route: "/sales-dashboard",
        name: "Auto-refreshing Sales Dashboard",
        branch: "3-sales-dashboard-begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/6"
      },
      %Content{
        route: "/search",
        name: "Live Search",
        branch: " 4-search--begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/7"
      },
      %Content{
        route: "/autocomplete",
        name: "Auto Complete",
        branch: "5-autocomplete-begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/8"
      },
      %Content{
        route: "/filter",
        name: "Search Filters",
        branch: "6-filter-begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/9"
      },
      %Content{
        route: "/servers",
        name: "Master-Detail View (Live Navigation)",
        branch: "7-live-nav-begin"
        lesson_link: "https://online.pragmaticstudio.com/courses/liveview/modules/10"
      }
    ]
  end
end
