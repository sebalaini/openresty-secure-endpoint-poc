# OpenResty Secure Endpoint POC

This repository contains a Proof of Concept demonstrating how to secure API endpoints using [OpenResty](https://openresty.org/) while exposing a public-facing PHP application. The PHP application is accessible at the root path (`/`), whereas the API endpoint is protected using custom headers.

## Overview

In this POC, the root path is publicly exposed, but all requests to the API endpoint are secured using OpenResty. OpenResty allows you to enforce custom HTTP headers to control access to the API endpoint.

You can customize the header name and value to secure the API endpoint by setting environment variables in the Docker configuration.

## Environment Variables

The following environment variables can be set to define the custom header for securing the API endpoint:

```yaml
- SECURE_HEADER_KEY=X-Openresty-Auth-Key
- SECURE_HEADER_VALUE=S3cur3Au7h
```

### Explanation:

- `SECURE_HEADER_KEY`: The custom header name that the client must include in API requests to pass authentication.
- `SECURE_HEADER_VALUE`: The required value for the custom header that the client must use for API requests to be considered valid.

### Example

By default, the API endpoint expects the following header to be included in requests:

```
X-Openresty-Auth-Key: S3cur3Au7h
```

Any requests without this header or with incorrect values will be denied access.

## How to Run

1. Clone the repository:

```bash
git clone https://github.com/your-repo/openresty-secure-endpoint-poc.git
cd openresty-secure-endpoint-poc
```

2. Build and run the Docker container:

```bash
docker-compose up --build
```

3. Access the PHP app at `http://localhost`.

To access the secured API endpoint, make sure to include the custom header in your request.

## Customizing Security

You can change the security headers by modifying the values of `SECURE_HEADER_KEY` and `SECURE_HEADER_VALUE` in the Docker configuration (`docker-compose.yml` or Dockerfile).

For example, to change the authentication header:

```yaml
- SECURE_HEADER_KEY=X-Custom-Auth
- SECURE_HEADER_VALUE=mySecureToken
```

Now, the API endpoint will expect the following header:

```
X-Custom-Auth: mySecureToken
```

## Use Case

This POC is ideal for scenarios where you need a simple and lightweight way to secure backend API endpoints without complex authentication mechanisms. OpenResty can be used to enforce these security rules at the server level, providing a flexible and performant solution.
