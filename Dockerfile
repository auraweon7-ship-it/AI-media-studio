# 정적 단일 HTML 앱 서빙 (Caddy). Railway가 주입하는 $PORT에 바인딩.
FROM caddy:2-alpine
WORKDIR /srv
# 앱을 루트(index.html)로 서빙
COPY ai-media-studio.html ./index.html
COPY DESIGN-stripe.md ./
COPY README.md ./
# 셸 폼 CMD → ${PORT} 환경변수 확장 (Railway 미설정 시 8080)
CMD caddy file-server --root /srv --listen :${PORT:-8080}
