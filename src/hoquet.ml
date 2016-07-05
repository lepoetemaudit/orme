(* Hoquet - main module implementation *)

type attribute = | Attribute of string * string

type node = 
| Node of string * (attribute list) * (node list) 
| Text of string

let element name attrs nodes =
  Node (name, attrs, nodes)

let attr k v =
  Attribute (k, v)

(* Elements *)
let div = element "div"

let html = element "html"

let p = element "p"

(* Attributes *)
let style = attr "style"

let text value = Text value

let render_attr attr =
  match attr with 
    Attribute (key, value) ->  key ^ "=\"" ^ value ^ "\"" 

let rec render_html node =
  match node with
  | Node (name, attrs, nodes) ->
    "<" ^ name ^ (match attrs with | hd::[] -> " " | _ -> "") ^
    ((List.map render_attr attrs) |> String.concat " ") ^
    ">" ^ 
    ((List.map render_html nodes) |> String.concat " ") ^
    "</" ^ name ^ ">"
  | Text value -> value