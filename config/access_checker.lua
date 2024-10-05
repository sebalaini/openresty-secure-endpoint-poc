local authHeaderName = os.getenv("SECURE_HEADER_KEY") or "X-Openresty-Auth-Key"
local authHeaderValue = os.getenv("SECURE_HEADER_VALUE") or "_Fail_"
local secureVal = ngx.req.get_headers()[authHeaderName]

if secureVal and secureVal == authHeaderValue then
    return
end

-- fail with 403 if not set with auth header
ngx.exit(ngx.HTTP_FORBIDDEN)
