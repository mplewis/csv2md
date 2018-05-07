open Batteries
open Heredoc

type arg_desc = string * string * string
type validator = string -> bool
type handler = string -> unit

type arg =
  | Flag of arg_desc
  | Param of arg_desc * validator * handler

let is_int raw = raw |> int_of_string_opt |> Option.is_some
let is_single_char raw = (raw |> String.to_list |> List.length) = 1

let set_int dest raw =
  let _ = dest.contents = Int.of_string raw in ()
let set_char dest raw =
  let _ = dest.contents = (raw |> String.to_list |> List.first) in ()

let padding: int ref = {contents = 1}
let delimiter: char ref = {contents = ','}

let json =
  `O [ "name", `String "OCaml"
     ; "qualities", `A [ `O ["name", `String "awesome"]
                       ; `O ["name", `String "simple"]
                       ; `O ["name", `String "fun"]
                       ]
     ]

let describe_args (arg_descs: arg_desc list) =
  let describe_arg (arg_desc: arg_desc) =
    let (long, short, desc) = arg_desc in
    `O [
      "long", `String long;
      "short", `String short;
      "desc", `String desc;
    ]
  in
  `A (arg_descs |> List.map describe_arg)

let help_message name version desc args =
  let data =
    `O [
      "name", `String name;
      "version", `String version;
      "desc", `String desc;
      "args", describe_args args;
    ]
  in
  let format_string = (heredoc "
    {{name}} {{version}}

    {{desc}}

    Usage:
    {{#args}}
        {{long}}, {{short}}: {{desc}}
    {{/args}}
  ") in
  let template = Mustache.of_string format_string in
  Mustache.render template data

let args = [
  Param(
    ("padding", "p", "The amount of padding to add (default: 1)"),
    is_int,
    set_int padding
  );
  Param(
    ("delimiter", "d", "The delimiter to use when parsing CSVs (default: ,)"),
    is_single_char,
    set_char delimiter
  );
  Flag("no-filenames", "n", "Do not print filenames when processing multiple CSVs");
]
