# Hoquet

![Build status](https://travis-ci.org/lepoetemaudit/hoquet.svg)

Elm HTML / Hiccup style HTML generation in standard OCaml.

Unlike Elm HTML this does not implement a virtual dom. It is mostly
intended for server-side rendering of templates.

# Example of Usage

```ocaml

open Hoquet

let person name =
  div [] [ text name ]

let () =
  html [] 
    [ body []       
      [ p [] [ text "Hello, world!" ];
        div [] (List.map person ["Bob"; "Jim"]) ]
    ] |> render_html |> print_string
```
