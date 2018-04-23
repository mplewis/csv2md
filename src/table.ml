open Batteries

let rec pad_right str len =
  if String.length str >= len
  then str
  else pad_right (str ^ " ") (len - 1)

(* https://stackoverflow.com/a/3989823/254187 *)
let rec transpose list = match list with
  | [] -> []
  | [] :: xss -> transpose xss
  | (x::xs) :: xss ->
    (x :: List.map List.hd xss) :: transpose (xs :: List.map List.tl xss)

let col_widths (table: string list list): int list =
  let longest_in_row (row: string list) =
    row |> List.map String.length |> List.reduce Int.max in
  table |> transpose |> List.map longest_in_row
