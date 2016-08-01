# Orme

![Build status](https://travis-ci.org/lepoetemaudit/hoquet.svg)

Elm HTML / Hiccup style HTML generation in standard OCaml.

Unlike Elm HTML this does not implement a virtual dom. It is mostly
intended for server-side rendering of templates.

# Example of Usage

```ocaml

open Orme

let person name =
  div [] [ text name ]

let () =
  html [] 
    [ body []       
      [ p [] [ text "Hello, world!" ];
        div [] (List.map person ["Bob"; "Jim"]) ]
    ] |> render_html |> print_string
```

Here's an example returning as part of an HTTP response using Cohttp:

```ocaml
open Lwt
open Cohttp
open Cohttp_lwt_unix

let view url =
  let open Orme in
    html [] 
      [ body [] 
        [ h1 [] [ text "Welcome" ]
        ; p [] [ text ("Url is: " ^ url) ] ]
      ]

let server =
  let callback _conn req body =
    let uri = req |> Request.uri |> Uri.to_string in
    Server.respond_string 
      ~status:`OK 
      ~body:(view uri |> Orme.render_html) 
      ()  
  in
  Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ())
```  

let () = ignore (Lwt_main.run server)
