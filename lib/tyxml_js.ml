module Xml = struct

  type 'a wrap = 'a

  type uri = string
  let uri_of_string s = s
  let string_of_uri s = s
  type aname = string
  type event_handler = Dom_html.event Js.t -> bool
  type opaque
  type attrib_k =
    | Event of event_handler
    | Attr of Dom.attr Js.t
  type attrib = aname * attrib_k

  let attr name v =
    let a = Dom_html.document##createAttribute(Js.string name) in
    a##value <- v;
    name,Attr a

  let event name v =
    name,Event v

  let event_handler_of_function f =
    (fun e -> f (Js.Unsafe.coerce e))

  let float_attrib name value : attrib = attr name (Obj.magic value)
  let int_attrib name value = attr name (Obj.magic value)
  let string_attrib name value = attr name (Js.string value)
  let space_sep_attrib name values = attr name (Js.string (String.concat " " values))
  let comma_sep_attrib name values = attr name (Js.string (String.concat "," values))
  let event_handler_attrib name value = event name value
  let uri_attrib name value = attr name (Js.string value)
  let uris_attrib name values = attr name (Js.string (String.concat " " values))

  (** Element *)

  type elt = Dom.node Js.t
  type ename = string

  let empty () = (Dom_html.document##createDocumentFragment() :> Dom.node Js.t)

  let comment c = (Dom_html.document##createComment (Js.string c) :> Dom.node Js.t)

  let pcdata s = (Dom_html.document##createTextNode (Js.string s) :> Dom.node Js.t)
  let encodedpcdata s = (Dom_html.document##createTextNode (Js.string s) :> Dom.node Js.t)
  let entity e =
    let entity = Dom_html.decode_html_entities (Js.string ("&" ^ e ^ ";")) in
    (Dom_html.document##createTextNode(entity) :> Dom.node Js.t)

  let leaf ?(a=[]) name =
    let e = Dom_html.document##createElement(Js.string name) in
    List.iter (fun (_,att) -> (Obj.magic e)##setAttributeNode(att)) a;
    (e :> Dom.node Js.t)


  let attach_attribs e l =
    List.iter (fun (n,att) ->
        match att with
        | Attr a -> (Obj.magic e)##setAttributeNode(a)
        | Event h -> Js.Unsafe.set e (Js.string n) (fun ev -> Js.bool (h ev))
      ) l

  let node ?(a=[]) name children =
    let e = Dom_html.document##createElement(Js.string name) in
    attach_attribs e a;
    List.iter (fun c -> ignore (e##appendChild(c))) children;
    (e :> Dom.node Js.t)

  let cdata s = assert false
  let cdata_script s = assert false
  let cdata_style s = assert false
end

module type EventHandler = sig
  type 'a event_handler_fun
  type event = Dom_html.event Js.t -> bool
  type mouseEvent = Dom_html.mouseEvent Js.t -> bool
  type keyboardEvent = Dom_html.keyboardEvent Js.t -> bool

  val a_onabort : event -> [> | `OnAbort] event_handler_fun
  val a_onafterprint : event -> [> | `OnAfterPrint] event_handler_fun
  val a_onbeforeprint : event -> [> | `OnBeforePrint] event_handler_fun
  val a_onbeforeunload : event -> [> | `OnBeforeUnload] event_handler_fun
  val a_onblur : event -> [> | `OnBlur] event_handler_fun
  val a_oncanplay : event -> [> | `OnCanPlay] event_handler_fun
  val a_oncanplaythrough : event -> [> | `OnCanPlayThrough] event_handler_fun
  val a_onchange : event -> [> | `OnChange] event_handler_fun
  val a_onclick : mouseEvent -> [> | `OnClick] event_handler_fun
  val a_oncontextmenu : mouseEvent -> [> | `OnContextMenu] event_handler_fun
  val a_ondblclick : mouseEvent -> [> | `OnDblClick] event_handler_fun
  val a_ondrag : mouseEvent -> [> | `OnDrag] event_handler_fun
  val a_ondragend : mouseEvent -> [> | `OnDragEnd] event_handler_fun
  val a_ondragenter : mouseEvent -> [> | `OnDragEnter] event_handler_fun
  val a_ondragleave : mouseEvent -> [> | `OnDragLeave] event_handler_fun
  val a_ondragover : mouseEvent -> [> | `OnDragOver] event_handler_fun
  val a_ondragstart : mouseEvent -> [> | `OnDragStart] event_handler_fun
  val a_ondrop : mouseEvent -> [> | `OnDrop] event_handler_fun
  val a_ondurationchange : event -> [> | `OnDurationChange] event_handler_fun
  val a_onemptied : event -> [> | `OnEmptied] event_handler_fun
  val a_onended : event -> [> | `OnEnded] event_handler_fun
  val a_onerror : event -> [> | `OnError] event_handler_fun
  val a_onfocus : event -> [> | `OnFocus] event_handler_fun
  val a_onformchange : event -> [> | `OnFormChange] event_handler_fun
  val a_onforminput : event -> [> | `OnFormInput] event_handler_fun
  val a_onhashchange : event -> [> | `OnHashChange] event_handler_fun
  val a_oninput : event -> [> | `OnInput] event_handler_fun
  val a_oninvalid : event -> [> | `OnInvalid] event_handler_fun
  val a_onmousedown : mouseEvent -> [> | `OnMouseDown] event_handler_fun
  val a_onmouseup : mouseEvent -> [> | `OnMouseUp] event_handler_fun
  val a_onmouseover : mouseEvent -> [> | `OnMouseOver] event_handler_fun
  val a_onmousemove : mouseEvent -> [> | `OnMouseMove] event_handler_fun
  val a_onmouseout : mouseEvent -> [> | `OnMouseOut] event_handler_fun
  val a_onmousewheel : event -> [> | `OnMouseWheel] event_handler_fun
  val a_onoffline : event -> [> | `OnOffLine] event_handler_fun
  val a_ononline : event -> [> | `OnOnLine] event_handler_fun
  val a_onpause : event -> [> | `OnPause] event_handler_fun
  val a_onplay : event -> [> | `OnPlay] event_handler_fun
  val a_onplaying : event -> [> | `OnPlaying] event_handler_fun
  val a_onpagehide : event -> [> | `OnPageHide] event_handler_fun
  val a_onpageshow : event -> [> | `OnPageShow] event_handler_fun
  val a_onpopstate : event -> [> | `OnPopState] event_handler_fun
  val a_onprogress : event -> [> | `OnProgress] event_handler_fun
  val a_onratechange : event -> [> | `OnRateChange] event_handler_fun
  val a_onreadystatechange : event -> [> | `OnReadyStateChange] event_handler_fun
  val a_onredo : event -> [> | `OnRedo] event_handler_fun
  val a_onresize : event -> [> | `OnResize] event_handler_fun
  val a_onscroll : event -> [> | `OnScroll] event_handler_fun
  val a_onseeked : event -> [> | `OnSeeked] event_handler_fun
  val a_onseeking : event -> [> | `OnSeeking] event_handler_fun
  val a_onselect : event -> [> | `OnSelect] event_handler_fun
  val a_onshow : event -> [> | `OnShow] event_handler_fun
  val a_onstalled : event -> [> | `OnStalled] event_handler_fun
  val a_onstorage : event -> [> | `OnStorage] event_handler_fun
  val a_onsubmit : event -> [> | `OnSubmit] event_handler_fun
  val a_onsuspend : event -> [> | `OnSuspend] event_handler_fun
  val a_ontimeupdate : event -> [> | `OnTimeUpdate] event_handler_fun
  val a_onundo : event -> [> | `OnUndo] event_handler_fun
  val a_onunload : event -> [> | `OnUnload] event_handler_fun
  val a_onvolumechange : event -> [> | `OnVolumeChange] event_handler_fun
  val a_onwaiting : event -> [> | `OnWaiting] event_handler_fun
  val a_onkeypress : keyboardEvent -> [> | `OnKeyPress] event_handler_fun
  val a_onkeydown : keyboardEvent -> [> | `OnKeyDown] event_handler_fun
  val a_onkeyup : keyboardEvent -> [> | `OnKeyUp] event_handler_fun
  val a_onload : event -> [> | `OnLoad] event_handler_fun
  val a_onloadeddata : event -> [> | `OnLoadedData] event_handler_fun
  val a_onloadedmetadata : event -> [> | `OnLoadedMetaData] event_handler_fun
  val a_onloadstart : event -> [> | `OnLoadStart] event_handler_fun
  val a_onmessage : event -> [> | `OnMessage] event_handler_fun
end

module Svg = Svg_f.Make(Xml)
module D = struct
  module Raw = Html5_f.Make(Xml)(Svg)
  module X = Xml
  open Raw
  module EH = struct
    type 'a event_handler_fun = 'a attrib
    type event = Dom_html.event Js.t -> bool
    type mouseEvent = Dom_html.mouseEvent Js.t -> bool
    type keyboardEvent = Dom_html.keyboardEvent Js.t -> bool

    let a_onabort ev = a_onabort (X.event_handler_of_function ev)
    let a_onafterprint ev = a_onafterprint (X.event_handler_of_function ev)
    let a_onbeforeprint ev = a_onbeforeprint (X.event_handler_of_function ev)
    let a_onbeforeunload ev = a_onbeforeunload (X.event_handler_of_function ev)
    let a_onblur ev = a_onblur (X.event_handler_of_function ev)
    let a_oncanplay ev = a_oncanplay (X.event_handler_of_function ev)
    let a_oncanplaythrough ev = a_oncanplaythrough (X.event_handler_of_function ev)
    let a_onchange ev = a_onchange (X.event_handler_of_function ev)
    let a_onclick ev = a_onclick (X.event_handler_of_function ev)
    let a_oncontextmenu ev = a_oncontextmenu (X.event_handler_of_function ev)
    let a_ondblclick ev = a_ondblclick (X.event_handler_of_function ev)
    let a_ondrag ev = a_ondrag (X.event_handler_of_function ev)
    let a_ondragend ev = a_ondragend (X.event_handler_of_function ev)
    let a_ondragenter ev = a_ondragenter (X.event_handler_of_function ev)
    let a_ondragleave ev = a_ondragleave (X.event_handler_of_function ev)
    let a_ondragover ev = a_ondragover (X.event_handler_of_function ev)
    let a_ondragstart ev = a_ondragstart (X.event_handler_of_function ev)
    let a_ondrop ev = a_ondrop (X.event_handler_of_function ev)
    let a_ondurationchange ev = a_ondurationchange (X.event_handler_of_function ev)
    let a_onemptied ev = a_onemptied (X.event_handler_of_function ev)
    let a_onended ev = a_onended (X.event_handler_of_function ev)
    let a_onerror ev = a_onerror (X.event_handler_of_function ev)
    let a_onfocus ev = a_onfocus (X.event_handler_of_function ev)
    let a_onformchange ev = a_onformchange (X.event_handler_of_function ev)
    let a_onforminput ev = a_onforminput (X.event_handler_of_function ev)
    let a_onhashchange ev = a_onhashchange (X.event_handler_of_function ev)
    let a_oninput ev = a_oninput (X.event_handler_of_function ev)
    let a_oninvalid ev = a_oninvalid (X.event_handler_of_function ev)
    let a_onmousedown ev = a_onmousedown (X.event_handler_of_function ev)
    let a_onmouseup ev = a_onmouseup (X.event_handler_of_function ev)
    let a_onmouseover ev = a_onmouseover (X.event_handler_of_function ev)
    let a_onmousemove ev = a_onmousemove (X.event_handler_of_function ev)
    let a_onmouseout ev = a_onmouseout (X.event_handler_of_function ev)
    let a_onmousewheel ev = a_onmousewheel (X.event_handler_of_function ev)
    let a_onoffline ev = a_onoffline (X.event_handler_of_function ev)
    let a_ononline ev = a_ononline (X.event_handler_of_function ev)
    let a_onpause ev = a_onpause (X.event_handler_of_function ev)
    let a_onplay ev = a_onplay (X.event_handler_of_function ev)
    let a_onplaying ev = a_onplaying (X.event_handler_of_function ev)
    let a_onpagehide ev = a_onpagehide (X.event_handler_of_function ev)
    let a_onpageshow ev = a_onpageshow (X.event_handler_of_function ev)
    let a_onpopstate ev = a_onpopstate (X.event_handler_of_function ev)
    let a_onprogress ev = a_onprogress (X.event_handler_of_function ev)
    let a_onratechange ev = a_onratechange (X.event_handler_of_function ev)
    let a_onreadystatechange ev = a_onreadystatechange (X.event_handler_of_function ev)
    let a_onredo ev = a_onredo (X.event_handler_of_function ev)
    let a_onresize ev = a_onresize (X.event_handler_of_function ev)
    let a_onscroll ev = a_onscroll (X.event_handler_of_function ev)
    let a_onseeked ev = a_onseeked (X.event_handler_of_function ev)
    let a_onseeking ev = a_onseeking (X.event_handler_of_function ev)
    let a_onselect ev = a_onselect (X.event_handler_of_function ev)
    let a_onshow ev = a_onshow (X.event_handler_of_function ev)
    let a_onstalled ev = a_onstalled (X.event_handler_of_function ev)
    let a_onstorage ev = a_onstorage (X.event_handler_of_function ev)
    let a_onsubmit ev = a_onsubmit (X.event_handler_of_function ev)
    let a_onsuspend ev = a_onsuspend (X.event_handler_of_function ev)
    let a_ontimeupdate ev = a_ontimeupdate (X.event_handler_of_function ev)
    let a_onundo ev = a_onundo (X.event_handler_of_function ev)
    let a_onunload ev = a_onunload (X.event_handler_of_function ev)
    let a_onvolumechange ev = a_onvolumechange (X.event_handler_of_function ev)
    let a_onwaiting ev = a_onwaiting (X.event_handler_of_function ev)
    let a_onkeypress ev = a_onkeypress (X.event_handler_of_function ev)
    let a_onkeydown ev = a_onkeydown (X.event_handler_of_function ev)
    let a_onkeyup ev = a_onkeyup (X.event_handler_of_function ev)
    let a_onload ev = a_onload (X.event_handler_of_function ev)
    let a_onloadeddata ev = a_onloadeddata (X.event_handler_of_function ev)
    let a_onloadedmetadata ev = a_onloadedmetadata (X.event_handler_of_function ev)
    let a_onloadstart ev = a_onloadstart (X.event_handler_of_function ev)
    let a_onmessage ev = a_onmessage (X.event_handler_of_function ev)
  end
  include Raw
  include EH
end


module R = struct

  module Xml_w = struct
    type 'a t = 'a React.signal
    let return x = Lwt_react.S.return x
    let bind x = Lwt_react.S.bind x
    let fmap x = React.S.map x
    let fmap2 x = React.S.l2 x
    let fmap3 x = React.S.l3 x
    let fmap4 x = React.S.l4 x
    let fmap5 x = React.S.l5 x
  end
  module Xml_wed =
  struct
    type 'a wrap = 'a Xml_w.t
    type uri = Xml.uri
    let string_of_uri = Xml.string_of_uri
    let uri_of_string = Xml.uri_of_string
    type aname = Xml.aname
    type event_handler = Xml.event_handler
    type attrib = Xml.attrib

    let attr name f s =
      let a = Dom_html.document##createAttribute(Js.string name) in
      let _ = Xml_w.fmap (fun s -> match f s with
          | None -> ()
          | Some v -> a##value <- v) s in
      name,Xml.Attr a

    let float_attrib name s = attr name (fun f -> Some (Obj.magic f)) s
    let int_attrib name s = attr name (fun f -> Some (Obj.magic f)) s
    let string_attrib name s = attr name (fun f -> Some (Js.string f)) s
    let space_sep_attrib name s = attr name (fun f -> Some (Js.string (String.concat " " f))) s
    let comma_sep_attrib name s = attr name (fun f -> Some (Js.string (String.concat "," f))) s
    let event_handler_attrib name s = Xml.event_handler_attrib name s
    let string_attrib name s = attr name (fun f -> Some (Js.string f)) s
    let uri_attrib name s = attr name (fun f -> Some (Js.string f)) s
    let uris_attrib name s = attr name (fun f -> Some (Js.string (String.concat " " f))) s


    type elt = Xml.elt
    type ename = Xml.ename

    let empty = Xml.empty
    let comment = Xml.comment
    let pcdata s =
      let e = Dom_html.document##createTextNode(Js.string "") in
      let _ = React.S.map (fun s -> e##data <- Js.string s) s in
      (e :> Dom.node Js.t)
    let encodedpcdata s = pcdata s
    let entity s = Xml.entity s
    let leaf = Xml.leaf
    let node ?(a=[]) name l =
      let e = Dom_html.document##createElement(Js.string name) in
      Xml.attach_attribs e a;
      let _ = React.S.map (fun c ->
          while Js.to_bool e##hasChildNodes() do
            Js.Opt.iter (e##lastChild) (fun f -> ignore (e##removeChild(f)))
          done;
          List.iter (fun c -> ignore (e##appendChild(c))) c
        ) l in
      (e :> Dom.node Js.t)
    let cdata = Xml.cdata
    let cdata_script = Xml.cdata_script
    let cdata_style = Xml.cdata_style
  end

  module Svg_w = Svg_f.MakeWrapped(Xml_w)(Xml_wed)
  module Raw = Html5_f.MakeWrapped(Xml_w)(Xml_wed)(Svg_w)
  include Raw
  include D.EH
end

module To = struct
  let coerce x = Js.Unsafe.coerce x
  let element = coerce
  let elt = coerce
  let node x = x
  let text = coerce
  let head = coerce
  let link = coerce
  let title = coerce
  let meta = coerce
  let base = coerce
  let style = coerce
  let form = coerce
  let optgroup = coerce
  let option = coerce
  let select = coerce
  let input = coerce
  let textarea = coerce
  let button = coerce
  let label = coerce
  let fieldset = coerce
  let legend = coerce
  let blockquote = coerce
  let a = coerce
  let img = coerce
  let object_ = coerce
  let param = coerce
  let area = coerce
  let map = coerce
  let script = coerce
  let td = coerce
  let tr = coerce
  let col = coerce
  let tfoot = coerce
  let tbody = coerce
  let thead = coerce
  let table = coerce
  let canvas = coerce
  let iframe = coerce
end
