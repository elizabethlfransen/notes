default: web

web:
    just generate
    flutter build web \
      --release \
      --wasm \
      --base-href "${BASE_HREF:-"/"}" \
      --dart-define ENVIRONMENT=${ENVIRONMENT:-"gh-pages"}