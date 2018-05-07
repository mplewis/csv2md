open Batteries

let puts thing = thing |> Batteries.dump |> print_endline

let count_leading_spaces str =
  let rec helper chars count =
    if List.is_empty chars || List.hd chars != ' ' then count
    else helper (List.tl chars) (count + 1)
  in
  helper (String.to_list str) 0

let is_blank str = str |> String.trim |> String.length = 0
let not_blank str = str |> is_blank |> not

let rec drop_head_whitespace_lines lines =
  if is_blank (List.hd lines) then drop_head_whitespace_lines (List.tl lines) else lines

let drop_surrounding_whitespace_lines lines =
  lines |> drop_head_whitespace_lines |> List.rev |> drop_head_whitespace_lines |> List.rev

let heredoc str =
  let lines = String.split_on_char '\n' str |> drop_surrounding_whitespace_lines in
  let padding = lines |> List.filter not_blank |> List.map count_leading_spaces |> List.min in
  let drop_padding str = str |> String.to_list |> List.drop padding |> String.of_list in
  lines |> List.map drop_padding |> String.join "\n"
