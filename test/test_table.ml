open OUnit2
open Table

let ae exp got _test_ctxt = assert_equal exp got
let puts thing = thing |> Batteries.dump |> print_endline

let pad_right_tests =
  let subject = pad_right in
  [
    "pads shorter strings 1" >:: ae
      (subject 4 "baz")
      "baz ";

    "pads shorter strings 2" >:: ae
      (subject 10 "baz")
      "baz       ";

    "does not pad equal-length strings" >:: ae
      (subject 4 "quux")
      "quux";

    "does not pad longer strings" >:: ae
      (subject 4 "foobar")
      "foobar";
  ]

let wrap_tests =
  let subject = wrap in
  [
    "wraps strings 1" >:: ae
      (subject " " 2 "foo")
      "  foo  ";

    "wraps strings 2" >:: ae
      (subject "!" 3 "alert")
      "!!!alert!!!";

    "does not wrap with zero" >:: ae
      (subject " " 0 "baz")
      "baz";
  ]

let zip_tests =
  let subject = zip in
  [
    "zips two lists of equal length" >:: ae
      (subject [1; 2; 3] ["a"; "b"; "c"])
      [(1, "a"); (2, "b"); (3, "c")];
  ]

let col_widths_tests =
  let subject = col_widths in
  [
    "gets the max width of each column 1" >:: ae
      (subject
         [["foo"; "bar"; "baz"];
          ["alpha"; "b"; "charlie"]])
      [5; 3; 7];

    "gets the max width of each column 2" >:: ae
      (subject
         [["Kara"; "Thrace"];
          ["William"; "Adama"];
          ["Gaius"; "Baltar"]])
      [7; 6];
  ]

let md_of_table_tests = [
  "renders a table as a string" >::
  let subject = md_of_table in
  ae
    (subject
       [["Kara"; "Thrace"];
        ["William"; "Adama"];
        ["Gaius"; "Baltar"]]
       " | ")
    "Kara    | Thrace
William | Adama
Gaius   | Baltar";
]

let () =
  run_test_tt_main (
    "table tests" >:::
    List.concat [
      pad_right_tests;
      wrap_tests;
      zip_tests;
      col_widths_tests;
      (* md_of_table_tests; *)
    ]
  )
