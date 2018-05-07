open Batteries
open OUnit2
open Heredoc

let ae exp got _test_ctxt = assert_equal exp got
let puts thing = thing |> Batteries.dump |> print_endline

let heredoc_tests =
  let subject = heredoc in
  [
    "renders properly" >:: ae
      (subject {msg|

        this is a heredoc

        it has a blank line in it
            and some complex indentation
        that gets handled properly!

        it also starts and ends with blank lines that should be stripped


      |msg})
      "this is a heredoc\n\nit has a blank line in it\n    and some complex indentation\nthat gets handled properly!\n\nit also starts and ends with blank lines that should be stripped";
  ]

let () =
  run_test_tt_main (
    "table tests" >:::
    List.concat [
      heredoc_tests;
    ]
  )
