base_href := env("BASE_HREF", "/")

default: web

web:
    flutter build web --release --base-href "{{base_href}}"