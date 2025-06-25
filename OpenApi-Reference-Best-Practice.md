# 卡系统API文档

cardepass.com 卡系统API文档

Base URLs:

* <a href="https://test.cardepass.com/openapi">测试环境: https://test.cardepass.com/openapi</a>
* <a href="https://cardepass.com/openapi">生产环境: https://cardepass.com/openapi</a>

# Authentication

- HTTP Authentication, scheme: bearer

# Token

## POST 获取Access_Token

POST /connect/token

获取Access_Token

### 请求参数

| 名称            | 位置 | 类型   | 说明                                  |
|-----------------|------|--------|---------------------------------------|
| body | body | object | HTTP请求的主体内容 |
| » grant_type    | body | string | 固定值：client_credentials                                |
| » client_id     | body | string | 客户端ID，请联系cardepass 获取        |
| » client_secret | body | string | 客户端密钥，请联系cardepass获取 |
| » redirect_uri  | body | string | 重定向地址（可选） |

### 返回结果

| 状态码 | 状态码含义                                              | 说明 | 数据模型 |
|--------|---------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1) | 请求成功 | Inline   |

### 返回数据结构

状态码 **200**

| 名称           | 类型    | 中文名       | 说明                                                                                                                 |
|----------------|---------|--------------|----------------------------------------------------------------------------------------------------------------------|
| » access_token | string  | 访问令牌     | 调用业务API时需要此访问令牌                                                                                          |
| » expires_in   | integer | 令牌过期时间 | 时间单位为秒，默认令牌过期时间为3600秒=1小时。客户端可以缓存此令牌。注意：获取新令牌，老令牌在有效期内仍然可以使用。 |
| » token_type   | string  | 令牌类型     | 默认返回Bearer                                                                                                       |
| » scope        | string  | 权限范围     | 默认返回 card                                                                                                        |

# ping

## GET Ping

GET /v1/ping

获取Access_Token后，可以通过调用Ping接口，验证接口是否连通。

### 请求参数

| 名称   | 位置   | 类型   | 必选 | 中文名 | 说明 |
|--------|--------|--------|------|--------|------|
| Accept | header | string | 否   | 接受类型 | 客户端可接受的响应媒体类型 |

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1) | 请求成功 | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 未授权访问，需要有效的访问令牌 | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 访问被禁止，权限不足 | Inline   |

