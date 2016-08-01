open OUnit2
open Orme

let identity a = a

let test_attributes test_ctx =
  assert_equal 
    ~printer: identity
    "<div style=\"color: red\"></div>"    
    (div [ style "color: red" ] [] |> render_html)

let test_script' test_ctx =
   assert_equal 
    ~printer: identity
    "<script>alert('Hello, world!');</script>"
    ((script' "alert('Hello, world!');") |> render_html)

let test_nested test_ctx =
  assert_equal 
    ~printer: identity
    (html [] 
       [ body [] 
         [ p [] [ text "Hello, world!" ] ]
       ] |> render_html)
    "<html><body><p>Hello, world!</p></html>" 
    
let test_escape_attr test_ctx =
  assert_equal
    ~printer: identity
    "<p class=\"This should be &quot;escaped&quot;\"></p>"
    (p [class' "This should be \"escaped\""] [] |> render_html)

let test_suite =
  "hoquet_tests" >:::
    [ "test_attributes" >:: test_attributes;
      "test_script'"     >:: test_script';
      "test_escape_attr" >:: test_escape_attr ]

let () =
  run_test_tt_main test_suite