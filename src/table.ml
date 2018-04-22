open Batteries

let rec pad_right str len =
  if String.length str >= len
  then str
  else pad_right (str ^ " ") (len - 1)
