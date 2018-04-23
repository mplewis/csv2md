open OUnit2
open Table

let ae exp got _test_ctxt = assert_equal exp got

let pad_left_tests = [
  "pads shorter strings" >::
  ae (pad_right "baz" 4) "baz ";

  "does not pad equal-length strings" >::
  ae (pad_right "quux" 4) "quux";

  "does not pad longer strings" >::
  ae (pad_right "foobar" 4) "foobar";
]

let transpose_tests = [
  "transposes correctly" >::
  (ae
     (transpose
        [[1; 2; 3];
         [4; 5; 6];
         [7; 8; 9]])
     [[1; 4; 7];
      [2; 5; 8];
      [3; 6; 9]]);
]


let col_widths_tests = [
  "gets the max width of each column 1" >::
  (ae
     (col_widths
        [["foo"; "bar"; "baz"];
         ["alpha"; "b"; "charlie"]])
     [5; 3; 7]
  );

  "gets the max width of each column 2" >::
  (ae
     (col_widths
        [["Kara"; "Thrace"];
         ["William"; "Adama"];
         ["Gaius"; "Baltar"]])
     [7; 6]
  )
]


let () =
  run_test_tt_main (
    "table tests" >:::
    List.concat [
      pad_left_tests;
      transpose_tests;
      col_widths_tests;
    ]
  )
