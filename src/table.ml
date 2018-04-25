open Batteries

let rec pad_right target_len str =
  let curr_len = String.length str in
  let spaces = max 0 (target_len - curr_len) in
  str ^ String.repeat " " spaces

let rec wrap middle outer count =
  if count <= 0
  then middle
  else wrap (outer ^ middle ^ outer) outer (count - 1)

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

let equalize_col_widths table =
  let widths = col_widths table in
  let pad_cells (row: string list): string list =
    (zip widths row)
    |> List.map (fun (t: int * string) -> pad_right (fst t) (snd t))
  in
  table |> List.map pad_cells

let md_of_table table divider =
  table |> List.map (String.join divider) |> String.join "\n"
