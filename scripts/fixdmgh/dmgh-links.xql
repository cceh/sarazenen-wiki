declare namespace http="http://expath.org/ns/http-client";
declare namespace exerr="http://expath.org/ns/error";

declare function local:makeApiCall($term, $params as xs:string*) {
  let $method := <http:request method="get"/>
  let $api := "http://www.mgh.de/dmgh/services/rest?"
  let $url := $api || $term || "&#38;" || string-join($params, "&#38;")
  let $response := http:send-request($method, $url)
  return
    let $http-status := $response[1]/data(@status)
    let $api-error := $response[2]/dmgh_result/error
    return 
    
    if ($http-status = 200 and empty($api-error)) then
         $response[2]
    else if (not($http-status = 200)) then
      error((), "http-error: " || $http-status)
    else 
      (: error((), "api-error: " || $api-error/text() || " " || $term || " "|| string-join($params, " ") ) :)
      $api-error
};

declare function local:resolve($searchterm) {
  let $s := replace($searchterm," ","+")
  let $result := local:makeApiCall("method=resolve","s=" || $s)
  return 
    $result/dmgh_result/list/int/text()
};

declare function local:getImgNum($bsb,$page) {
  let $result := local:makeApiCall("method=get_img_num",("bsb=" || $bsb, "page=" || $page))
  return 
    $result/dmgh_result/int/text()
};

declare function local:getLink($id as xs:integer) {
  local:getLink($id,())
};

declare function local:getLink($id as xs:integer, $img as xs:integer?) {
  let $result := local:makeApiCall("method=create_link", ("bsb=" || $id, "img=" || $img))
  return
    $result/dmgh_result/string/text()
};

declare function local:lines ($arg as xs:string?)  as xs:string* {
   tokenize($arg, '(\r\n?|\n\r?)')
};

declare function local:setStatus($ids) {
  let $count := count($ids)
  return
  if ($count = 0) then 0
  else if ($count = 1) then 1
  else 2
};

declare function local:normalizeKurztitel($mgh) {
  let $normalize := $mgh
    => replace("in: |\[|\]","")
    => replace("SS\.|Script\.","SS")
    => replace("N.S.","N. S.")
  return $normalize
};

declare function local:normalizeSeitenzahl($s) {
  let $string := normalize-space($s)
  return
    if(starts-with($string,"S.")) then
      (replace($string,"S\. |\.","") => tokenize("-|–| "))[1]
    else 
      ()
};

declare function local:process() {
let $data := db:open("sarazenen-wiki","/")
for $e in (for $i in $data//Editionshinweise/local:lines(text()) return tokenize($i,";|Teilweise auch ediert in:"))
let $split := tokenize($e,", |\(|\)")
let $normalize := for $i in $split return normalize-space($i)
let $author := $normalize[1]
let $title := $normalize[2]
let $volume := for $i in $normalize where starts-with($i, "MGH") or starts-with($i, "in: MGH") return local:normalizeKurztitel($i)
let $byauthor := local:resolve($author)
let $byvolume := local:resolve($volume)
let $bytitle := local:resolve($title)
let $status-author := local:setStatus($byauthor)
let $status-volume := local:setStatus($byvolume)
let $status-title := local:setStatus($bytitle)
let $seite := local:normalizeSeitenzahl($normalize[last()])
let $id := if ($status-volume = 1) then $byvolume
      else if ($status-author = 1) then $byauthor
      else if ($status-title = 1) then $bytitle
      else ()
let $imgnum := if ($seite and $id) then local:getImgNum($id,$seite) else ()
let $create_link := if ($id and $imgnum)
                  then local:getLink($id, $imgnum)
                  else if ($id) then local:getLink($id)
                  else ()
let $alternative := if (empty($create_link)) then
            let $append_vol := replace($volume," ","_")
            let $append_page := if ($seite) then "_S._" || $seite else ""
            return
            "http://www.mgh.de/dmgh/resolving/" || $append_vol || $append_page
where contains($e, "MGH")
return 
(:
<item>
  <status-author>{$status-author}</status-author>
  <status-title>{$status-title}</status-title>
  <status-volume>{$status-volume}</status-volume>
  <author>{$author}</author>
  <title>{$title}</title>
  <volume>{$volume}</volume>
  <seite>{$seite}</seite>
  <string>{string-join($normalize, " | ")}</string>
  <id>{$id}</id>
  <imgnum>{$imgnum}</imgnum>
  <create_link>{$create_link}</create_link>
</item> :)
  ($e ||";"|| $volume ||";"|| $id ||";"|| $seite ||";"|| $create_link ||";"|| $alternative)
};

("String;Band;BsbId;Seite;Link;alternativ",local:process())
