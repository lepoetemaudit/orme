open OUnit2
open Hoquet

let identity a = a

let test_attributes test_ctx =
  assert_equal 
    ~printer: identity
    "<div style=\"color: red\"></div>"    
    (div [ style "color: red" ] [] |> render_html)

let test_suite =
  "hoquet_tests" >:::
      [ "test_attributes" >:: test_attributes]

let () =
  run_test_tt_main test_suite