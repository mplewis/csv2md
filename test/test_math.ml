open OUnit2
open Math

let ae exp got _test_ctxt = assert_equal exp got

let math_tests = [
  "addition" >::
  ae 2 (Math.add 1 1);
  "subtraction" >::
  ae (-1) (Math.sub 1 2);
]

let () =
  run_test_tt_main (
    "difference of squares tests" >:::
    List.concat [math_tests]
  )
