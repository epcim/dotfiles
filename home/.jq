def yamlify:
    (objects | to_entries[] | (.value | type) as $type |
        if $type == "array" then
            "\(.key):", (.value | yamlify)
        elif $type == "object" then
            "\(.key):", "    \(.value | yamlify)"
        else
            "\(.key):\t\(.value)"
        end
    )
    // (arrays | select(length > 0)[] | [yamlify] |
        "  - \(.[0])", "    \(.[1:][])"
    )
    // .
    ;

def yamlify2:
    (objects | to_entries | (map(.key | length) | max + 2) as $w |
        .[] | (.value | type) as $type |
        if $type == "array" then
            "\(.key):", (.value | yamlify2)
        elif $type == "object" then
            "\(.key):", "    \(.value | yamlify2)"
        else
            "\(.key):\(" " * (.key | $w - length))\(.value)"
        end
    )
    // (arrays | select(length > 0)[] | [yamlify2] |
        "  - \(.[0])", "    \(.[1:][])"
    )
    // .
    ;

def camel:
  gsub( "_(?<a>[a-z])"; .a|ascii_upcase);

def camel2:
  gsub( " (?<a>[a-z])"; .a|ascii_upcase);

def head:
  .[0:1];

def tail:
  .[1:];

def capitalize:
  (head | ascii_upcase) + tail;

def snake_to_camel:
  split("_") |
  head + (tail | map(capitalize)) |
  join("");

def map_keys(mapper):
  walk(if type == "object" then with_entries(.key |= mapper) else . end);

def walkBelowJq16(f):
  . as $in
  | if type == "object" then
      reduce keys_unsorted[] as $key
        ( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
  elif type == "array" then map( walk(f) ) | f
  else f
  end;

def trimStr:
  if type == "string" then
    (sub("^[[:space:]]+"; "") | sub("[[:space:]]+$"; ""))
  else . end;


