(* Pad the right side of a string to a minimum length *)
val pad_right : int -> string -> string

(* Wrap both sides of a string with another string a number of times *)
val wrap : string -> int -> string -> string

(* Zip two lists together, element-wise *)
val zip : 'a list -> 'b list -> ('a * 'b) list

(* Get the length of the longest string in each column of a 2D list *)
val col_widths : string list list -> int list

(* Render a table row as a string of Markdown with the given cell widths and dividers *)
val md_of_row : int list -> string list -> string -> string

(* Render a header divider row with the given cell widths and dividers *)
val header_row : int list -> string -> string -> string

(* Render a table as a string of Markdown *)
val md_of_table : string list list -> string -> string
