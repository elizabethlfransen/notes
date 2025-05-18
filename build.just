base_href := env("BASE_HREF", "/")

default: web

web:
    just generate
    flutter build web --release --base-href "{{base_href}}"