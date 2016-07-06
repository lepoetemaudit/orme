# Hoquet

Elm HTML / Hiccup style HTML generation in standard OCaml.

# Example of Usage

```ocaml

open Hoquet

let () =
  html [] 
      [ body [] 
        [ p [] [ text "Hello, world!" ] ]
      ] |> render_html |> print_string
```