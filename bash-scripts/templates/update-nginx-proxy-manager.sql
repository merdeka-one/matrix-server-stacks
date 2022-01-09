UPDATE proxy_host SET domain_names = '["SERVER_NAME"]',  advanced_config = replace(replace('listen 8443;\r\n\r\nset   $telegramPrefix   /TELEGRAM_PREFIX;\r\n\r\nlocation /_matrix/client/r0/login {\r\n    set              $targetUri http://id-ma1sd:8090;\r\n    if ($request_uri != /){\r\n      set            $targetUri $targetUri$request_uri;\r\n    }\r\n\r\n    proxy_set_header Host $host;\r\n    proxy_set_header X-Forwarded-For $remote_addr;\r\n\r\n    proxy_set_header X-Forwarded-Scheme $scheme;\r\n    proxy_set_header X-Forwarded-Proto  $scheme;\r\n    proxy_set_header X-Real-IP          $remote_addr;\r\n\r\n    proxy_pass http://id-ma1sd:8090;\r\n}\r\n    \r\nlocation /_matrix/identity {\r\n#    proxy_pass http://id-ma1sd:8090/_matrix/identity;\r\n    proxy_set_header Host $host;\r\n    proxy_set_header X-Forwarded-For $remote_addr;\r\n\r\n    proxy_set_header X-Forwarded-Scheme $scheme;\r\n    proxy_set_header X-Forwarded-Proto  $scheme;\r\n    proxy_set_header X-Real-IP          $remote_addr;\r\n\r\n    proxy_pass http://id-ma1sd:8090/_matrix/identity;\r\n}\r\n    \r\nlocation /_matrix {\r\n#    proxy_pass http://synapse:8008/_matrix;\r\n    proxy_set_header Host $host;\r\n    proxy_set_header X-Forwarded-For $remote_addr;\r\n\r\n    proxy_set_header X-Forwarded-Scheme $scheme;\r\n    proxy_set_header X-Forwarded-Proto  $scheme;\r\n    proxy_set_header X-Real-IP          $remote_addr;\r\n\r\n    proxy_pass http://synapse:8008/_matrix;\r\n}\r\n\r\nlocation /_synapse/client {\r\n#    proxy_pass http://synapse:8008/_synapse/client;\r\n    proxy_set_header Host $host;\r\n    proxy_set_header X-Forwarded-For $remote_addr;\r\n\r\n    proxy_set_header X-Forwarded-Scheme $scheme;\r\n    proxy_set_header X-Forwarded-Proto  $scheme;\r\n    proxy_set_header X-Real-IP          $remote_addr;\r\n\r\n    proxy_pass http://synapse:8008/_synapse/client;\r\n}\r\n\r\nlocation /.well-known/matrix/client {\r\n    return 200 ''{"m.homeserver": {"base_url": "https://$host"}}'';\r\n    default_type application/json;\r\n    add_header Access-Control-Allow-Origin *;\r\n}\r\n\r\n\r\nlocation /TELEGRAM_PREFIX {\r\n#location $telegramPrefix {\r\n#    proxy_pass http://mautrix-telegram:29317;\r\n    proxy_set_header Host $host;\r\n    proxy_set_header X-Forwarded-For $remote_addr;\r\n\r\n    proxy_set_header X-Forwarded-Scheme $scheme;\r\n    proxy_set_header X-Forwarded-Proto  $scheme;\r\n    proxy_set_header X-Real-IP          $remote_addr;\r\n\r\n    proxy_pass http://mautrix-telegram:29317;\r\n}','\r',char(13)),'\n',char(10))  WHERE id = 1;