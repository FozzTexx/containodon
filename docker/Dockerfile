FROM tootsuite/mastodon:v4.1.3
LABEL maintainer fozztexx@fozztexx.com

RUN set -e \
    ; LIMIT_FILE=/opt/mastodon/config/initializers/rack_attack.rb \
    ; NEW_LIMIT=9999 \
    ; LIMITS="throttle_per_token_api throttle_authenticated_api" \
    ; for limit in ${LIMITS} ; do \
        sed -r -i "s/throttle\\('${limit}', limit: [0-9_]+/throttle('${limit}', limit: ${NEW_LIMIT}/" ${LIMIT_FILE} \
      ; done \
    ;
