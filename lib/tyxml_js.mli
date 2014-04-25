module Xml : Xml_sigs.Wrapped
  with type uri = string
   and type event_handler = Dom_html.event Js.t -> bool
   and type elt = Dom.node Js.t

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

module Svg : Svg_sigs.T
  with type Xml.uri = Xml.uri
   and type Xml.event_handler = Xml.event_handler
   and type Xml.attrib = Xml.attrib
   and type Xml.elt = Xml.elt
   and type 'a Xml.wrap = 'a
   and type 'a wrap = 'a

module D : sig
  module Raw : Html5_sigs.T
    with type Xml.uri = Xml.uri
     and type Xml.event_handler = Xml.event_handler
     and type Xml.attrib = Xml.attrib
     and type Xml.elt = Xml.elt
     and type 'a Xml.wrap = 'a
     and type 'a wrap = 'a
     and type +'a attrib = Xml.attrib
     and module Svg := Svg
  include module type of Raw
  include EventHandler
    with type 'a event_handler_fun = 'a attrib
end

module R: sig
  module Raw : Html5_sigs.T
    with type Xml.uri = Xml.uri
     and type Xml.event_handler = Xml.event_handler
     and type Xml.attrib = Xml.attrib
     and type Xml.elt = Xml.elt
     and module Svg := Svg
     and type 'a elt = 'a D.elt
     and type 'a Xml.wrap = 'a React.signal
     and type 'a wrap = 'a React.signal
     and type 'a attrib = 'a D.attrib
     and type uri = D.uri
  include module type of Raw
  include EventHandler
    with type 'a event_handler_fun = 'a attrib
end

module To : sig
  val element : 'a D.elt -> Dom_html.element Js.t
  val elt : 'a D.elt -> Dom_html.element Js.t
  val node : 'a D.elt -> Dom.node Js.t
  val text : [`Pcdata] D.elt -> Dom.text Js.t

  val head : Html5_types.head D.elt -> Dom_html.headElement Js.t
  val link : Html5_types.link D.elt -> Dom_html.linkElement Js.t
  val title : Html5_types.title D.elt -> Dom_html.titleElement Js.t
  val meta : Html5_types.meta D.elt -> Dom_html.metaElement Js.t
  val base : Html5_types.base D.elt -> Dom_html.baseElement Js.t
  val style : Html5_types.style D.elt -> Dom_html.styleElement Js.t
  val form : Html5_types.form D.elt -> Dom_html.formElement Js.t
  val optgroup : Html5_types.optgroup D.elt -> Dom_html.optGroupElement Js.t
  val option : Html5_types.selectoption D.elt -> Dom_html.optionElement Js.t
  val select : Html5_types.select D.elt -> Dom_html.selectElement Js.t
  val input : Html5_types.input D.elt -> Dom_html.inputElement Js.t
  val textarea : Html5_types.textarea D.elt -> Dom_html.textAreaElement Js.t
  val button : Html5_types.button D.elt -> Dom_html.buttonElement Js.t
  val label : Html5_types.label D.elt -> Dom_html.labelElement Js.t
  val fieldset : Html5_types.fieldset D.elt -> Dom_html.fieldSetElement Js.t
  val legend : Html5_types.legend D.elt -> Dom_html.legendElement Js.t
  val blockquote : Html5_types.blockquote D.elt -> Dom_html.quoteElement Js.t
  val a : 'a Html5_types.a D.elt -> Dom_html.anchorElement Js.t
  val img : [`Img] D.elt -> Dom_html.imageElement Js.t
  val object_ : 'a Html5_types.object_ D.elt -> Dom_html.objectElement Js.t
  val param : Html5_types.param D.elt -> Dom_html.paramElement Js.t
  val area : Html5_types.area D.elt -> Dom_html.areaElement Js.t
  val map : 'a Html5_types.map D.elt -> Dom_html.mapElement Js.t
  val script : Html5_types.script D.elt -> Dom_html.scriptElement Js.t
  val td : [ Html5_types.td | Html5_types.td ] D.elt -> Dom_html.tableCellElement Js.t
  val tr : Html5_types.tr D.elt -> Dom_html.tableRowElement Js.t
  val col : Html5_types.col D.elt -> Dom_html.tableColElement Js.t
  val tfoot : Html5_types.tfoot D.elt -> Dom_html.tableSectionElement Js.t
  val thead : Html5_types.thead D.elt -> Dom_html.tableSectionElement Js.t
  val tbody : Html5_types.tbody D.elt -> Dom_html.tableSectionElement Js.t
  val table : Html5_types.table D.elt -> Dom_html.tableElement Js.t
  val canvas : 'a Html5_types.canvas D.elt -> Dom_html.canvasElement Js.t
  val iframe : Html5_types.iframe D.elt -> Dom_html.iFrameElement Js.t
end
