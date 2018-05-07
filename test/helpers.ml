open OUnit2

let ae exp got _test_ctxt = assert_equal exp got
let puts thing = thing |> Batteries.dump |> print_endline
