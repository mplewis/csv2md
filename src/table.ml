open Batteries

let rec pad_right target_len str =
  let curr_len = String.length str in
  let spaces = max 0 (target_len - curr_len) in
  str ^ String.repeat " " spaces

let rec wrap wrapper count body =
  if count <= 0
  then body
  else wrap wrapper (count - 1) (wrapper ^ body ^ wrapper)

let zip a b =
  let rec zipr a b last =
    if a = [] || b = [] then last
    else
      let tuple = Tuple2.make (List.hd a) (List.hd b) in
      zipr (List.tl a) (List.tl b) (last @ [tuple])
  in
  zipr a b []

let col_widths table =
  let longest_in_row row =
    row |> List.map String.length |> List.reduce Int.max in
  table |> List.transpose |> List.map longest_in_row

let md_of_row vertdiv widths cells =
  let padded_cells =
    zip widths cells
    |> List.map (fun t -> pad_right (fst t) (snd t))
  in
  padded_cells
  |> List.map (wrap " " 1)
  |> String.join vertdiv
  |> wrap vertdiv 1

let header_row vertdiv horizdiv widths =
  let horizdiv_cells =
    widths |> List.map (fun count -> String.repeat horizdiv count)
  in
  md_of_row vertdiv widths horizdiv_cells

let md_of_table vertdiv horizdiv table =
  let widths = col_widths table in
  let header = header_row vertdiv horizdiv widths in
  table
  |> List.map (md_of_row vertdiv widths)
  |> (fun rows -> [List.hd rows; header] @ List.tl rows)
  |> String.join "\n"
