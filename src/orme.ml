(* Orme - main module implementation *)

type attribute = | Attribute of string * string

type node = 
| Node of string * (attribute list) * (node list) 
| Text of string

let element name attrs nodes =
  Node (name, attrs, nodes)

let attr k v =
  Attribute (k, v)

(* Elements *)
let html = element "html"

let head = element "head"
let title = element "title"
let link = element "link"
let style = element "style"
let script = attr "script"

let body = element "body"

let div = element "div"
let p = element "p"
let a = element "a"
let form = element "form"

(* Attributes *)
let style = attr "style"
let href = attr "href"
let class' = attr "class"
let id = attr "id"
let name = attr "name"
let value = attr "value"


(* Special "text" node *)
let text value = Text value

(* Conveniences *)
let script' body =
    element "script" [] [ text body ] 

(* Convert attribute to a string *)
let render_attr attr =
  match attr with 
    Attribute (key, value) ->  key ^ "=\"" ^ value ^ "\"" 

(* Convert node to a string *)
let rec render_html node =
  match node with
  | Node (name, attrs, nodes) ->
    "<" ^ name ^ (match attrs with | hd::[] -> " " | _ -> "") ^
    ((List.map render_attr attrs) |> String.concat " ") ^
    ">" ^ 
    ((List.map render_html nodes) |> String.concat " ") ^
    "</" ^ name ^ ">"
  | Text value -> value