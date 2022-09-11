defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(filename \\ "report") do
    case String.contains?(filename, ".") do
      true ->
        {:error, "Filename should not contain file extension"}

      false ->
        order_report = "#{filename}.csv"
        items_report = "#{filename}_items.csv"

        lines = build_lines()

        File.write!(order_report, lines.order_lines)
        File.write!(items_report, lines.item_lines)

        {:ok, "Report successfully created"}
    end
  end

  defp build_lines() do
    OrderAgent.list_all()
    |> Enum.map(&create_lines/1)
    |> Enum.reduce(%{order_lines: [], item_lines: []}, fn elem, acc ->
      %{
        order_lines: [acc.order_lines | elem.order_line],
        item_lines: [acc.item_lines | elem.item_line]
      }
    end)
  end

  defp create_lines({order_uuid, %Order{user_cpf: cpf, total_price: total_price, items: items}}) do
    item_line = Enum.map(items, &create_item_line/1)

    %{
      order_line: "#{cpf},#{order_uuid},#{total_price}\n",
      item_line: item_line
    }
  end

  defp create_item_line(%Item{
         category: category,
         quantity: quantity,
         unity_price: unity_price,
         description: description
       }) do
    "#{category},#{description},#{quantity},#{unity_price}\n"
  end
end
