defmodule IgIntranetWeb.Components.FlopConfig do
  @moduledoc """
  Flop Config component Module
  """
  def table_opts do
    [
      table_attrs: [class: "w-[40rem] mt-11 sm:w-full"],
      thead_th_attrs: [class: "text-sm text-left leading-6 text-zinc-500 font-normal"],
      tbody_attrs: [
        class:
          "relative divide-y divide-zinc-100 border-t border-zinc-200 text-sm leading-6 text-zinc-700"
      ],
      tbody_td_attrs: [class: "relative p-0 hover:cursor-pointer"],
      tbody_tr_attrs: [class: "group hover:bg-zinc-50"]
    ]
  end

  def pagination_opts do
    [
      wrapper_attrs: [class: "flex justify-between"],
      pagination_list_attrs: [class: ["flex gap-4 order-2"]],
      previous_link_attrs: [class: "order-1 hero-chevron-left-mini"],
      next_link_attrs: [class: "order-3 hero-chevron-right-mini"],
      page_links: {:ellipsis, 5}
    ]
  end
end
