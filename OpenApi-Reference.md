
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

> Body 请求参数

```yaml
grant_type: client_credentials
client_id: bXMi5vQlIpfbO87SzrHs36Lm
client_secret: fZdMsk6CIUwKGsUlpYbsYNInne4jdcfs
redirect_uri: ""

```

### 请求参数

| 名称            | 位置 | 类型   | 必选 | 说明                                  |
|-----------------|------|--------|------|---------------------------------------|
| body            | body | object | 否   | none                                  |
| » grant_type    | body | string | 是   | 固定值                                |
| » client_id     | body | string | 是   | client_id 请联系cardepass 获取        |
| » client_secret | body | string | 是   | client_secret 秘钥请联系cardepass获取 |
| » redirect_uri  | body | string | 否   | none                                  |

> 返回示例

> 200 Response

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjczNUQ5MEQzOUIzMjdCQzYxQzlBOTFDQkU0QzQ2RDYwRTEzOTY3RTRSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6ImMxMlEwNXN5ZThZY21wSEw1TVJ0WU9FNVotUSJ9.eyJuYmYiOjE3NDUyMjc4MTMsImV4cCI6MTc0NTIzMTQxMywiaXNzIjoiaHR0cHM6Ly90ZXN0LmNhcmRlcGFzcy5jb20vb3BlbmFwaSIsImNsaWVudF9pZCI6ImJYTWk1dlFsSXBmYk84N1N6ckhzMzZMbSIsInN1YiI6IjY3ZDA2ZGNiZjg0ZTk1NTQyNGQwZmI1ZiIsInByZWZlcnJlZF91c2VybmFtZSI6ImxlbyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJobmhsQDE2My5jb20iLCJ0ZW5hbnRfY29kZSI6IkMxMDAwIiwidGVuYW50X25hbWUiOiLkuK3lm73liLbpgKDmnInpmZDlhazlj7giLCJ0ZW5hbnRfc291cmNlIjoiTG9jYWxSZWdpc3RlciIsImZ1bGxfbmFtZSI6ImxlbyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImhuaGxAMTYzLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJwaG9uZV9udW1iZXIiOiIiLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOmZhbHNlLCJpYXQiOjE3NDUyMjc4MTMsInNjb3BlIjpbImNhcmQiXX0.d1YCoGdN2P-5qh-9SxrCUKYg4iq-C_n5Pd5Ry41NQKYegi-fty9W-RyYYhpEWzIl7_kZ0VgXbGp4oHzpkZezhylCIxC5sxr2WTyC2NCLp9AM3hZoQN-gHQq6IUSHbQ5OS5JPtMuPsUW1uP7rNQPD_ojP6RyL4nD-zNljZXxc5VIi9G9xQyzGyYuyftsywzCDYyU2_crETBIjaYG5ht2FjC37WM-JSAnnfyrM7SFIxyTMUHyka8tvtTgpiDF1TXONlkxLlGgUC35RezuRmHFKY1JZrtPuoKgRa_o7yTa4uLRLD9xxDsbPV5nGCx2kcAsiIABcHzg_imEjqz84sNW0gQ",
  "expires_in": 3600,
  "token_type": "Bearer",
  "scope": "card"
}
```

### 返回结果

| 状态码 | 状态码含义                                              | 说明 | 数据模型 |
|--------|---------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1) | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称           | 类型    | 必选 | 约束 | 中文名       | 说明                                                                                                                 |
|----------------|---------|------|------|--------------|----------------------------------------------------------------------------------------------------------------------|
| » access_token | string  | true | none | 访问令牌     | 调用业务API时需要此访问令牌                                                                                          |
| » expires_in   | integer | true | none | 令牌过期时间 | 时间单位为秒，默认令牌过期时间为3600秒=1小时。客户端可以缓存此令牌。注意：获取新令牌，老令牌在有效期内仍然可以使用。 |
| » token_type   | string  | true | none | 令牌类型     | 默认返回Bearer                                                                                                       |
| » scope        | string  | true | none | 域           | 默认返回 card                                                                                                        |

# ping

## GET Ping

GET /v1/ping

获取Access_Token后，可以通过调用Ping接口，验证接口是否连通。

> 返回示例

> 200 Response

```
"Ping Success"
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

# products

## GET 查询客户可用产品列表

GET /v1/products

### 请求参数

| 名称   | 位置   | 类型   | 必选 | 说明 |
|--------|--------|--------|------|------|
| Accept | header | string | 是   | none |

> 返回示例

> 200 Response

```json
{
  "data": [
    {
      "productCode": "DGG0C4JD",
      "productName": "通用卡",
      "cardModels": [
        "ShareBalance",
        "Standard"
      ],
      "cardCurrency": [
        "USD"
      ],
      "description": "通用卡-测试使用"
    },
    {
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardModels": [
        "Standard"
      ],
      "cardCurrency": [
        "USD"
      ],
      "description": "通用测试2卡"
    }
  ],
  "responseId": "1888160a-bb9a-4c06-9a0d-07c2a3177558",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称            | 类型     | 必选 | 约束 | 中文名 | 说明       |
|-----------------|----------|------|------|--------|------------|
| » data          | [object] | true | none |        | none       |
| »» productCode  | string   | true | none |        | 产品编码   |
| »» productName  | string   | true | none |        | 产品名称   |
| »» cardModels   | [string] | true | none |        | 卡模式     |
| »» cardCurrency | [string] | true | none |        | 卡结算币种 |
| »» description  | string   | true | none |        | 产品描述   |
| » responseId    | string   | true | none |        | 响应Id     |
| » hasError      | boolean  | true | none |        | 是否有错误 |
| » errorCode     | null     | true | none |        | 错误码     |
| » errorMessage  | null     | true | none |        | 错误信息   |

# orders/sharebalance

## GET 【共享余额模式】订单查询。
包括：开卡、修改限额、冻结、解冻、销卡

GET /v1/orders/sharebalance

### 请求参数

| 名称            | 位置   | 类型   | 必选 | 说明                         |
|-----------------|--------|--------|------|------------------------------|
| OrderType       | query  | string | 是   | 订单类型:                    |
| OrderNo         | query  | string | 是   | 订单号。和客户订单号必选其一 |
| CustomerOrderNo | query  | string | 是   | 客户订单号。和订单号必选其一 |
| Accept          | header | string | 是   | none                         |

#### 详细说明

**OrderType**: 订单类型:
ApplyCard 申请开卡、CreditLimit 调整限额、CardCancel 销卡、CardBlock 卡冻结、CardUnBlock 卡解冻

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250423-2RJI",
    "productInfo": {
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardModel": "ShareBalance",
      "cardCurrency": "USD"
    },
    "quantity": 1,
    "maxAuthAmount": 10,
    "maxCreditAmount": null,
    "totalAmount": 0.1,
    "transAmount": 0,
    "transFee": 0.1,
    "openedQty": 1,
    "cardInfos": [
      {
        "cardId": "68085ad8b85b8cf3d3f3087e",
        "productCode": "A5GGCYNQ",
        "productName": "通用卡-共享测试产品",
        "cardCurrency": "USD",
        "maskCardNumber": "436797******9343",
        "cardModel": "ShareBalance"
      }
    ],
    "note": "",
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2025-04-23T03:13:17.668Z",
    "modifiedOn": "2025-04-23T03:13:28.544Z",
    "completedOn": "2025-04-23T03:13:28.544Z",
    "customerOrderNo": "T20250423001"
  },
  "responseId": "f6b66ccb-a22f-4778-ad04-6cdac93173ed",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型     | 必选  | 约束 | 中文名         | 说明                                               |
|--------------------|----------|-------|------|----------------|----------------------------------------------------|
| » data             | object   | true  | none |                | none                                               |
| »» orderNo         | string   | true  | none | 订单编号       | none                                               |
| »» productInfo     | object   | true  | none | 产品信息       | none                                               |
| »»» productCode    | string   | true  | none | 产品编码       | none                                               |
| »»» productName    | string   | true  | none | 产品名称       | none                                               |
| »»» cardModel      | string   | true  | none | 卡模式         | none                                               |
| »»» cardCurrency   | string   | true  | none | 卡结算币种     | none                                               |
| »» quantity        | integer  | true  | none | 申请开卡卡数   | none                                               |
| »» maxAuthAmount   | integer  | true  | none | 单笔限额       | none                                               |
| »» maxCreditAmount | null     | true  | none | 单卡消费总额度 | 可以为空，为空表示无限额度                         |
| »» totalAmount     | number   | true  | none | 总交易金额     | none                                               |
| »» transAmount     | integer  | true  | none | 交易金额       | none                                               |
| »» transFee        | number   | true  | none | 交易手续费     | none                                               |
| »» openedQty       | integer  | true  | none | 已开卡数       | none                                               |
| »» cardInfos       | [object] | true  | none | 已开卡信息     | none                                               |
| »»» cardId         | string   | false | none | 卡ID           | none                                               |
| »»» productCode    | string   | false | none | 产品编码       | none                                               |
| »»» productName    | string   | false | none | 产品名称       | none                                               |
| »»» cardCurrency   | string   | false | none | 卡结算币种     | none                                               |
| »»» maskCardNumber | string   | false | none | 脱敏卡号       | none                                               |
| »»» cardModel      | string   | false | none | 卡模式         | none                                               |
| »» note            | string   | true  | none | 备注           | none                                               |
| »» status          | string   | true  | none | 订单状态       | Pending 处理中，Completed 已完成，Failure 处理失败 |
| »» orderType       | string   | true  | none | 订单类型       | none                                               |
| »» createdOn       | string   | true  | none | 订单创建时间   | none                                               |
| »» modifiedOn      | string   | true  | none | 订单修改时间   | none                                               |
| »» completedOn     | string   | true  | none | 订单完成时间   | none                                               |
| »» customerOrderNo | string   | true  | none | 客户订单号     | none                                               |
| » responseId       | string   | true  | none | 响应ID         | none                                               |
| » hasError         | boolean  | true  | none | 是否出错       | none                                               |
| » errorCode        | null     | true  | none | 错误码         | none                                               |
| » errorMessage     | null     | true  | none | 错误信息       | none                                               |

# orders/sharebalance/apply

## POST 【共享余额模式】开卡申请

POST /v1/orders/sharebalance/apply

> Body 请求参数

```json
{
  "productCode": "A5GGCYNQ",
  "cardCurrency": "USD",
  "maxAuthAmount": "10",
  "maxCreditAmount": "",
  "cardAlias": "共享卡测试01",
  "customerOrderNo": "T20250423001"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名         | 说明                       |
|-------------------|--------|--------|------|----------------|----------------------------|
| Content-Type      | header | string | 是   |                | none                       |
| Accept            | header | string | 是   |                | none                       |
| body              | body   | object | 否   |                | none                       |
| » productCode     | body   | string | 是   | 产品代码       | none                       |
| » cardCurrency    | body   | string | 是   | 卡结算币种     | none                       |
| » maxAuthAmount   | body   | string | 是   | 单笔限额       | none                       |
| » maxCreditAmount | body   | string | 否   | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| » cardAlias       | body   | string | 否   | 卡别名         | none                       |
| » customerOrderNo | body   | string | 否   | 客户订单号     | none                       |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250423-2RJI",
    "productInfo": {
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardModel": "ShareBalance",
      "cardCurrency": "USD"
    },
    "quantity": 1,
    "maxAuthAmount": 10,
    "maxCreditAmount": null,
    "totalAmount": 0.1,
    "transAmount": 0,
    "transFee": 0.1,
    "openedQty": 0,
    "cardInfos": [],
    "note": "",
    "status": "Pending",
    "orderType": "ApplyCard",
    "createdOn": "2025-04-23T03:13:17.668Z",
    "modifiedOn": "2025-04-23T11:13:17.6917032+08:00",
    "completedOn": null,
    "customerOrderNo": "T20250423001"
  },
  "responseId": "01fa02d3-20dd-4ce7-84ea-ca6c9884a485",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型     | 必选 | 约束 | 中文名         | 说明                       |
|--------------------|----------|------|------|----------------|----------------------------|
| » data             | object   | true | none |                | none                       |
| »» orderNo         | string   | true | none | 订单号         | none                       |
| »» productInfo     | object   | true | none | 产品信息       | none                       |
| »»» productCode    | string   | true | none | 产品代码       | none                       |
| »»» productName    | string   | true | none | 产品名称       | none                       |
| »»» cardModel      | string   | true | none | 卡模式         | none                       |
| »»» cardCurrency   | string   | true | none | 卡结算币种     | none                       |
| »» quantity        | integer  | true | none | 开卡数量       | none                       |
| »» maxAuthAmount   | integer  | true | none | 单笔限额       | none                       |
| »» maxCreditAmount | null     | true | none | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| »» totalAmount     | number   | true | none | 总金额         | none                       |
| »» transAmount     | integer  | true | none | 交易实际金额   | none                       |
| »» transFee        | number   | true | none | 交易手续费     | none                       |
| »» openedQty       | integer  | true | none | 已开卡数       | none                       |
| »» cardInfos       | [string] | true | none | 卡信息         | none                       |
| »» note            | string   | true | none | 备注           | none                       |
| »» status          | string   | true | none | 订单状态       | none                       |
| »» orderType       | string   | true | none | 订单类型       | none                       |
| »» createdOn       | string   | true | none | 订单创建时间   | none                       |
| »» modifiedOn      | string   | true | none | 订单修改时间   | none                       |
| »» completedOn     | null     | true | none | 订单完成时间   | none                       |
| »» customerOrderNo | string   | true | none | 客户订单号     | none                       |
| » responseId       | string   | true | none | 响应ID         | none                       |
| » hasError         | boolean  | true | none | 是否出错       | none                       |
| » errorCode        | null     | true | none | 错误码         | none                       |
| » errorMessage     | null     | true | none | 错误信息       | none                       |

# orders/sharebalance/creditLimit

## POST 【共享余额模式】调整限额

POST /v1/orders/sharebalance/creditLimit

> Body 请求参数

```json
{
  "cardId": "68085ad8b85b8cf3d3f3087e",
  "customerOrderNo": "T20250423002",
  "maxAuthAmount": "20",
  "maxCreditAmount": ""
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名         | 说明                           |
|-------------------|--------|--------|------|----------------|--------------------------------|
| Content-Type      | header | string | 是   |                | none                           |
| Accept            | header | string | 是   |                | none                           |
| body              | body   | object | 否   |                | none                           |
| » cardId          | body   | string | 是   | 卡ID           | none                           |
| » customerOrderNo | body   | string | 否   | 客户订单号     | none                           |
| » maxAuthAmount   | body   | string | 是   | 单笔限额       | none                           |
| » maxCreditAmount | body   | string | 否   | 单卡消费总额度 | 可以为空，额度为空表示无限额度 |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "680866cbb85b8cf3d3f30882",
    "cardId": "68085ad8b85b8cf3d3f3087e",
    "maxAuthAmount": 20,
    "maxCreditAmount": null,
    "status": "Pending",
    "orderType": "CreditLimit",
    "failureReason": null,
    "createdOn": "2025-04-23T04:04:27.2295925Z",
    "completedOn": null,
    "customerOrderNo": "T20250423002"
  },
  "responseId": "551871aa-afb3-49ae-82a1-30b2bf882a79",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 必选 | 约束 | 中文名       | 说明 |
|--------------------|---------|------|------|--------------|------|
| » data             | object  | true | none |              | none |
| »» orderNo         | string  | true | none | 订单号       | none |
| »» cardId          | string  | true | none | 卡ID         | none |
| »» maxAuthAmount   | integer | true | none | 单笔限额     | none |
| »» maxCreditAmount | null    | true | none | 单卡消费额度 | none |
| »» status          | string  | true | none | 订单状态     | none |
| »» orderType       | string  | true | none | 订单类型     | none |
| »» failureReason   | null    | true | none | 失败原因     | none |
| »» createdOn       | string  | true | none | 订单创建时间 | none |
| »» completedOn     | null    | true | none | 订单完成时间 | none |
| »» customerOrderNo | string  | true | none | 客户订单号   | none |
| » responseId       | string  | true | none | 响应ID       | none |
| » hasError         | boolean | true | none | 是否出错     | none |
| » errorCode        | null    | true | none | 错误码       | none |
| » errorMessage     | null    | true | none | 错误信息     | none |

# orders/sharebalance/block

## POST 【共享余额模式】冻结卡

POST /v1/orders/sharebalance/block

> Body 请求参数

```json
{
  "cardId": "<string>",
  "customerOrderNo": "<string>"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明 |
|-------------------|--------|--------|------|------------|------|
| Content-Type      | header | string | 是   |            | none |
| Accept            | header | string | 是   |            | none |
| body              | body   | object | 否   |            | none |
| » cardId          | body   | string | 是   | 卡ID       | none |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250423-FTO8",
    "cardInfo": {
      "cardId": "68085ad8b85b8cf3d3f3087e",
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******9343",
      "cardModel": "ShareBalance"
    },
    "note": "",
    "isBlocked": false,
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardBlock",
    "createdOn": "2025-04-23T08:34:44.273985Z",
    "modifiedOn": "2025-04-23T08:34:44.2739932Z",
    "completedOn": null,
    "customerOrderNo": "T20250423002"
  },
  "responseId": "495451b7-e43d-4ab4-ab92-b6b4afd7eb97",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 必选 | 约束 | 中文名       | 说明 |
|--------------------|---------|------|------|--------------|------|
| » data             | object  | true | none |              | none |
| »» orderNo         | string  | true | none | 订单号       | none |
| »» cardInfo        | object  | true | none | 卡信息       | none |
| »»» cardId         | string  | true | none | 卡ID         | none |
| »»» productCode    | string  | true | none | 产品编码     | none |
| »»» productName    | string  | true | none | 产品名称     | none |
| »»» cardCurrency   | string  | true | none | 卡结算币种   | none |
| »»» maskCardNumber | string  | true | none | 脱敏卡号     | none |
| »»» cardModel      | string  | true | none | 卡模式       | none |
| »» note            | string  | true | none | 备注         | none |
| »» isBlocked       | boolean | true | none | 是否被冻结   | none |
| »» status          | string  | true | none | 订单状态     | none |
| »» failureReason   | null    | true | none | 错误原因     | none |
| »» orderType       | string  | true | none | 订单类型     | none |
| »» createdOn       | string  | true | none | 订单创建时间 | none |
| »» modifiedOn      | string  | true | none | 订单修改时间 | none |
| »» completedOn     | null    | true | none | 订单完成时间 | none |
| »» customerOrderNo | string  | true | none | 客户订单号   | none |
| » responseId       | string  | true | none | 响应ID       | none |
| » hasError         | boolean | true | none | 是否出错     | none |
| » errorCode        | null    | true | none | 错误码       | none |
| » errorMessage     | null    | true | none | 错误信息     | none |

# orders/sharebalance/unblock

## POST 【共享余额模式】解冻卡

POST /v1/orders/sharebalance/unblock

> Body 请求参数

```json
{
  "cardId": "<string>",
  "customerOrderNo": "<string>"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明 |
|-------------------|--------|--------|------|------------|------|
| Content-Type      | header | string | 是   |            | none |
| Accept            | header | string | 是   |            | none |
| body              | body   | object | 否   |            | none |
| » cardId          | body   | string | 是   | 卡ID       | none |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250423-CCDN",
    "cardInfo": {
      "cardId": "68085ad8b85b8cf3d3f3087e",
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******9343",
      "cardModel": "ShareBalance"
    },
    "note": "",
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardUnblock",
    "createdOn": "2025-04-23T08:45:40.8081231Z",
    "modifiedOn": "2025-04-23T08:45:40.8081233Z",
    "completedOn": null,
    "customerOrderNo": "T20250423004"
  },
  "responseId": "5a9ae164-00d0-41ae-a6a5-b1de82b4f56a",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 必选 | 约束 | 中文名       | 说明 |
|--------------------|---------|------|------|--------------|------|
| » data             | object  | true | none |              | none |
| »» orderNo         | string  | true | none | 订单号       | none |
| »» cardInfo        | object  | true | none | 卡信息       | none |
| »»» cardId         | string  | true | none | 卡ID         | none |
| »»» productCode    | string  | true | none | 产品编码     | none |
| »»» productName    | string  | true | none | 产品名称     | none |
| »»» cardCurrency   | string  | true | none | 卡结算币种   | none |
| »»» maskCardNumber | string  | true | none | 脱敏卡号     | none |
| »»» cardModel      | string  | true | none | 卡模式       | none |
| »» note            | string  | true | none | 备注         | none |
| »» status          | string  | true | none | 订单状态     | none |
| »» failureReason   | null    | true | none | 失败原因     | none |
| »» orderType       | string  | true | none | 订单类型     | none |
| »» createdOn       | string  | true | none | 订单创建时间 | none |
| »» modifiedOn      | string  | true | none | 订单修改时间 | none |
| »» completedOn     | null    | true | none | 订单完成时间 | none |
| »» customerOrderNo | string  | true | none | 客户订单号   | none |
| » responseId       | string  | true | none | 响应ID       | none |
| » hasError         | boolean | true | none | 是否出错     | none |
| » errorCode        | null    | true | none | 错误码       | none |
| » errorMessage     | null    | true | none | 错误信息     | none |

# orders/sharebalance/cancel

## POST 【共享余额模式】销卡

POST /v1/orders/sharebalance/cancel

> Body 请求参数

```json
{
  "cardId": "<string>",
  "customerOrderNo": "<string>"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明 |
|-------------------|--------|--------|------|------------|------|
| Content-Type      | header | string | 是   |            | none |
| Accept            | header | string | 是   |            | none |
| body              | body   | object | 否   |            | none |
| » cardId          | body   | string | 是   | 卡ID       | none |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250423-D2LA",
    "cardInfo": {
      "cardId": "68085ad8b85b8cf3d3f3087e",
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******9343",
      "cardModel": "ShareBalance"
    },
    "fee": null,
    "chargeMethodType": "FixedValue",
    "fixedValue": 0,
    "percent": null,
    "note": "",
    "status": "Pending",
    "orderType": "CardCancel",
    "settleStatus": "Pending",
    "failureReason": null,
    "createdOn": "2025-04-23T08:52:56.0021638Z",
    "completedOn": null
  },
  "responseId": "89c120cc-e0b4-4498-ae45-56aa7c2331aa",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型    | 必选 | 约束 | 中文名         | 说明 |
|---------------------|---------|------|------|----------------|------|
| » data              | object  | true | none |                | none |
| »» orderNo          | string  | true | none | 订单号         | none |
| »» cardInfo         | object  | true | none | 卡信息         | none |
| »»» cardId          | string  | true | none | 卡ID           | none |
| »»» productCode     | string  | true | none | 产品编码       | none |
| »»» productName     | string  | true | none | 产品名称       | none |
| »»» cardCurrency    | string  | true | none | 卡结算币种     | none |
| »»» maskCardNumber  | string  | true | none | 脱敏卡号       | none |
| »»» cardModel       | string  | true | none | 卡模式         | none |
| »» fee              | null    | true | none | 销卡费         | none |
| »» chargeMethodType | string  | true | none | 收费方式       | none |
| »» fixedValue       | integer | true | none | 固定值收费标准 | none |
| »» percent          | null    | true | none | 百分比收费标准 | none |
| »» note             | string  | true | none | 备注           | none |
| »» status           | string  | true | none | 订单状态       | none |
| »» orderType        | string  | true | none | 订单类型       | none |
| »» settleStatus     | string  | true | none | 结算状态       | none |
| »» failureReason    | null    | true | none | 失败原因       | none |
| »» createdOn        | string  | true | none | 订单创建时间   | none |
| »» completedOn      | null    | true | none | 订单完成时间   | none |
| » responseId        | string  | true | none | 响应ID         | none |
| » hasError          | boolean | true | none | 是否出错       | none |
| » errorCode         | null    | true | none | 错误码         | none |
| » errorMessage      | null    | true | none | 错误信息       | none |

# orders/standard

## GET 标准模式类型的订单查询。
包括：开卡、充值、冻结、解冻、销卡、卡余额转出

GET /v1/orders/standard

### 请求参数

| 名称            | 位置   | 类型   | 必选 | 中文名 | 说明                                                                                                                                             |
|-----------------|--------|--------|------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| OrderType       | query  | string | 是   |        | 订单类型: ApplyCard 开卡订单、CardTopUp 充值订单、CardCancel 销卡订单、CardBlock 卡冻结订单、CardUnBlock 卡解冻订单、CardWithdraw 卡余额转出订单 |
| OrderNo         | query  | string | 是   |        | 订单号。和商户订单号至少填写一个                                                                                                                 |
| CustomerOrderNo | query  | string | 是   |        | 商户订单号。和订单号至少填写一个                                                                                                                 |
| Accept          | header | string | 是   |        | none                                                                                                                                             |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250421-E971",
    "productInfo": {
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "totalTopUpAmount": 3,
    "totalFee": 0.2,
    "totalPayAmount": 3.2,
    "totalCardCount": 1,
    "totalOpened": 1,
    "orderLines": [
      {
        "orderLineNo": 1,
        "topUpAmount": 3,
        "quantity": 1,
        "feeItems": [
          {
            "feeType": "OpenCardFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          },
          {
            "feeType": "TopUpFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ]
      }
    ],
    "cardInfos": [
      {
        "cardId": "6805b2caa94783c5566f9397",
        "productCode": "0BN03HNK",
        "productName": "通用测试2卡",
        "cardCurrency": "USD",
        "maskCardNumber": "436797******2419",
        "cardModel": "Standard"
      }
    ],
    "status": "Completed",
    "payMessage": "扣款成功",
    "orderType": "ApplyCard",
    "createdOn": "2025-04-21T02:51:43.027Z",
    "modifiedOn": "2025-04-21T02:51:54.827Z",
    "paidOn": "2025-04-21T02:51:43.144Z",
    "completedOn": "2025-04-21T02:51:54.826Z",
    "customerOrderNo": "T2025042101"
  },
  "responseId": "64fcc91b-8947-4c37-943c-991a62496801",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 必选  | 约束 | 中文名       | 说明              |
|---------------------|----------|-------|------|--------------|-------------------|
| » data              | object   | true  | none |              | none              |
| »» orderNo          | string   | true  | none | 订单号       | none              |
| »» productInfo      | object   | true  | none | 产品信息     | none              |
| »»» productCode     | string   | true  | none | 产品编码     | none              |
| »»» productName     | string   | true  | none | 产品名称     | none              |
| »»» cardModel       | string   | true  | none | 卡模式       | none              |
| »»» cardCurrency    | string   | true  | none | 卡结算币种   | none              |
| »» totalTopUpAmount | integer  | true  | none | 总充值金额   | none              |
| »» totalFee         | number   | true  | none | 总费用       | none              |
| »» totalPayAmount   | number   | true  | none | 总支付金额   | 总充值金额+总费用 |
| »» totalCardCount   | integer  | true  | none | 总开卡数     | none              |
| »» totalOpened      | integer  | true  | none | 已开卡数     | none              |
| »» orderLines       | [object] | true  | none | 订单行       | none              |
| »»» orderLineNo     | integer  | false | none | 订单行号     | none              |
| »»» topUpAmount     | integer  | false | none | 充值金额     | none              |
| »»» quantity        | integer  | false | none | 开卡数量     | none              |
| »»» feeItems        | [object] | false | none | 费用明细     | none              |
| »»»» feeType        | string   | true  | none | 费用类型     | none              |
| »»»» feeAmount      | object   | true  | none | 费用         | none              |
| »»»»» currency      | string   | true  | none | 费用币种     | none              |
| »»»»» amount        | number   | true  | none | 费用金额     | none              |
| »» cardInfos        | [object] | true  | none | 卡信息       | none              |
| »»» cardId          | string   | false | none | 卡ID         | none              |
| »»» productCode     | string   | false | none | 产品编码     | none              |
| »»» productName     | string   | false | none | 产品名称     | none              |
| »»» cardCurrency    | string   | false | none | 卡结算币种   | none              |
| »»» maskCardNumber  | string   | false | none | 脱敏卡号     | none              |
| »»» cardModel       | string   | false | none | 卡模式       | none              |
| »» status           | string   | true  | none | 订单状态     | none              |
| »» payMessage       | string   | true  | none | 支付信息     | none              |
| »» orderType        | string   | true  | none | 订单类型     | none              |
| »» createdOn        | string   | true  | none | 订单创建时间 | none              |
| »» modifiedOn       | string   | true  | none | 订单修改时间 | none              |
| »» paidOn           | string   | true  | none | 订单支付时间 | none              |
| »» completedOn      | string   | true  | none | 订单完成时间 | none              |
| »» customerOrderNo  | string   | true  | none | 客户订单号   | none              |
| » responseId        | string   | true  | none | 响应ID       | none              |
| » hasError          | boolean  | true  | none | 是否出错     | none              |
| » errorCode         | null     | true  | none | 错误码       | none              |
| » errorMessage      | null     | true  | none | 错误信息     | none              |

# orders/standard/apply

## POST 【标准模式】开卡申请

POST /v1/orders/standard/apply

> Body 请求参数

```json
{
  "productCode": "0BN03HNK",
  "cardCurrency": "USD",
  "topUpAmount": "3",
  "cardAlias": "测试卡01",
  "customerOrderNo": "T2025042101"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名 | 说明                     |
|-------------------|--------|--------|------|--------|--------------------------|
| Content-Type      | header | string | 是   |        | none                     |
| Accept            | header | string | 是   |        | none                     |
| body              | body   | object | 否   |        | none                     |
| » productCode     | body   | string | 是   |        | 产品编码                 |
| » cardCurrency    | body   | string | 是   |        | 卡结算币种               |
| » topUpAmount     | body   | string | 是   |        | 开卡初始充值金额         |
| » cardAlias       | body   | string | 是   |        | 卡别名                   |
| » customerOrderNo | body   | string | 是   |        | 客户订单号，保持唯一性。 |

> 返回示例

```json
{
  "data": null,
  "responseId": "8545f945-d7ac-45c2-85c1-28604f41e88f",
  "hasError": true,
  "errorCode": "applyCard_availableBalance__not_enough",
  "errorMessage": "您的资金账户资金不足，请转入资金后使用，谢谢！"
}
```

```json
{
  "data": {
    "orderNo": "C1000-20250421-E971",
    "productInfo": {
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "totalTopUpAmount": 3,
    "totalFee": 0.2,
    "totalPayAmount": 3.2,
    "totalCardCount": 1,
    "totalOpened": 0,
    "orderLines": [
      {
        "orderLineNo": 1,
        "topUpAmount": 3,
        "quantity": 1,
        "feeItems": [
          {
            "feeType": "OpenCardFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          },
          {
            "feeType": "TopUpFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ]
      }
    ],
    "cardInfos": [],
    "status": "Pending",
    "payMessage": null,
    "orderType": "ApplyCard",
    "createdOn": "2025-04-21T02:51:43.0273684Z",
    "modifiedOn": "2025-04-21T02:51:43.0294915Z",
    "paidOn": null,
    "completedOn": null,
    "customerOrderNo": "T2025042101"
  },
  "responseId": "c856dc0a-c707-4e27-aca4-e175fe2637be",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 必选 | 约束 | 中文名       | 说明                                               |
|---------------------|----------|------|------|--------------|----------------------------------------------------|
| » data              | object   | true | none |              | none                                               |
| »» orderNo          | string   | true | none | 订单号       | none                                               |
| »» productInfo      | object   | true | none | 产品信息     | none                                               |
| »»» productCode     | string   | true | none | 产品编码     | none                                               |
| »»» productName     | string   | true | none | 产品名称     | none                                               |
| »»» cardModel       | string   | true | none | 卡模式       | none                                               |
| »»» cardCurrency    | string   | true | none | 卡结算币种   | none                                               |
| »» totalTopUpAmount | string   | true | none | 总充值金额   | none                                               |
| »» totalFee         | string   | true | none | 总费用       | none                                               |
| »» totalPayAmount   | string   | true | none | 总支付金额   | none                                               |
| »» totalCardCount   | string   | true | none | 开卡数量     | none                                               |
| »» totalOpened      | string   | true | none | 已开卡数     | none                                               |
| »» orderLines       | [object] | true | none | 订单明细     | none                                               |
| »»» orderLineNo     | string   | true | none | 订单明细编号 | none                                               |
| »»» topUpAmount     | string   | true | none | 充值金额     | none                                               |
| »»» quantity        | string   | true | none | 开卡数       | none                                               |
| »»» feeItems        | [object] | true | none | 费用明细     | none                                               |
| »»»» feeType        | string   | true | none | 费用类型     | none                                               |
| »»»» feeAmount      | object   | true | none | 费用         | none                                               |
| »»»»» currency      | string   | true | none | 费用币种     | none                                               |
| »»»»» amount        | string   | true | none | 费用金额     | none                                               |
| »» cardInfos        | [object] | true | none | 已开卡信息   | none                                               |
| »»» cardId          | string   | true | none | 卡ID         | none                                               |
| »»» productCode     | string   | true | none | 产品编码     | none                                               |
| »»» productName     | string   | true | none | 产品名称     | none                                               |
| »»» cardCurrency    | string   | true | none | 卡结算币种   | none                                               |
| »»» maskCardNumber  | string   | true | none | 脱敏卡号     | none                                               |
| »»» cardModel       | string   | true | none | 卡模式       | none                                               |
| »» status           | string   | true | none | 订单状态     | 处理中 Pending，已完成 Completed，处理失败 Failure |
| »» payMessage       | string   | true | none | 支付信息     | none                                               |
| »» orderType        | string   | true | none | 订单类型     | none                                               |
| »» createdOn        | string   | true | none | 订单创建时间 | none                                               |
| »» modifiedOn       | string   | true | none | 订单修改时间 | none                                               |
| »» paidOn           | string   | true | none | 支付时间     | none                                               |
| »» completedOn      | string   | true | none | 完成时间     | none                                               |
| »» customerOrderNo  | string   | true | none | 客户订单号   | none                                               |
| » responseId        | string   | true | none | 响应ID       | none                                               |
| » hasError          | string   | true | none | 是否有错误   | none                                               |
| » errorCode         | string   | true | none | 错误编码     | none                                               |
| » errorMessage      | string   | true | none | 错误信息     | none                                               |

# orders/standard/topup

## POST 【标准模式】卡充值

POST /v1/orders/standard/topup

> Body 请求参数

```json
{
  "cardId": "6805b2caa94783c5566f9397",
  "topUpAmount": "2",
  "customerOrderNo": "T20250421002"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明 |
|-------------------|--------|--------|------|------------|------|
| Content-Type      | header | string | 是   |            | none |
| Accept            | header | string | 是   |            | none |
| body              | body   | object | 否   |            | none |
| » cardId          | body   | string | 是   | 卡ID       | none |
| » topUpAmount     | body   | string | 是   | 充值金额   | none |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250421-YRX3",
    "productInfo": {
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "totalTopUpAmount": 2,
    "totalFee": 0.1,
    "totalPayAmount": 2.1,
    "totalCardCount": 1,
    "totalCompletedCardCount": 0,
    "orderLines": [
      {
        "orderLineNo": 1,
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "topUpAmount": 2,
        "feeItems": [
          {
            "feeType": "TopUpFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ],
        "isCompleted": false,
        "completedOn": null
      }
    ],
    "status": "Pending",
    "payMessage": null,
    "orderType": "CardTopUp",
    "createdOn": "2025-04-21T09:56:49.6061173Z",
    "modifiedOn": "2025-04-21T09:56:49.6502084Z",
    "paidOn": null,
    "completedOn": null,
    "customerOrderNo": "T20250421002"
  },
  "responseId": "a3f12c27-e3b2-4558-a7b7-d4869be74e1e",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                       | 类型     | 必选 | 约束 | 中文名           | 说明                                               |
|----------------------------|----------|------|------|------------------|----------------------------------------------------|
| » data                     | object   | true | none |                  | none                                               |
| »» orderNo                 | string   | true | none | 订单号           | none                                               |
| »» productInfo             | object   | true | none | 产品信息         | none                                               |
| »»» productCode            | string   | true | none | 产品编号         | none                                               |
| »»» productName            | string   | true | none | 产品名称         | none                                               |
| »»» cardModel              | string   | true | none | 卡模式           | none                                               |
| »»» cardCurrency           | string   | true | none | 卡币种           | none                                               |
| »» totalTopUpAmount        | string   | true | none | 总充值金额       | none                                               |
| »» totalFee                | string   | true | none | 总费用           | none                                               |
| »» totalPayAmount          | string   | true | none | 总支付金额       | none                                               |
| »» totalCardCount          | string   | true | none | 总充值卡数       | none                                               |
| »» totalCompletedCardCount | string   | true | none | 总完成充值卡数数 | none                                               |
| »» orderLines              | [object] | true | none | 订单明细行       | none                                               |
| »»» orderLineNo            | string   | true | none | 订单明细行号     | none                                               |
| »»» cardInfo               | object   | true | none | 卡信息           | none                                               |
| »»»» cardId                | string   | true | none | 卡ID             | none                                               |
| »»»» productCode           | string   | true | none | 产品编号         | none                                               |
| »»»» productName           | string   | true | none | 产品名称         | none                                               |
| »»»» cardCurrency          | string   | true | none | 卡结算币种       | none                                               |
| »»»» maskCardNumber        | string   | true | none | 脱敏卡号         | none                                               |
| »»»» cardModel             | string   | true | none | 卡模式           | none                                               |
| »»» topUpAmount            | string   | true | none | 充值金额         | none                                               |
| »»» feeItems               | [object] | true | none | 费用明细         | none                                               |
| »»»» feeType               | string   | true | none | 费用类型         | none                                               |
| »»»» feeAmount             | object   | true | none | 费用             | none                                               |
| »»»»» currency             | string   | true | none | 费用币种         | none                                               |
| »»»»» amount               | string   | true | none | 费用金额         | none                                               |
| »»» isCompleted            | string   | true | none | 是否已完充值     | none                                               |
| »»» completedOn            | string   | true | none | 充值完成时间     | none                                               |
| »» status                  | string   | true | none | 订单状态         | 处理中 Pending，已完成 Completed，处理失败 Failure |
| »» payMessage              | string   | true | none | 支付信息         | none                                               |
| »» orderType               | string   | true | none | 订单类型         | none                                               |
| »» createdOn               | string   | true | none | 订单创建时间     | none                                               |
| »» modifiedOn              | string   | true | none | 订单修改时间     | none                                               |
| »» paidOn                  | string   | true | none | 订单支付时间     | none                                               |
| »» completedOn             | string   | true | none | 订单完成时间     | none                                               |
| »» customerOrderNo         | string   | true | none | 客户订单号       | none                                               |
| » responseId               | string   | true | none | 响应Id           | none                                               |
| » hasError                 | string   | true | none | 是否出错         | none                                               |
| » errorCode                | string   | true | none | 错误码           | none                                               |
| » errorMessage             | string   | true | none | 错误信息         | none                                               |

# orders/standard/block

## POST 【标准模式】卡冻结

POST /v1/orders/standard/block

> Body 请求参数

```json
{
  "cardId": "6805b2caa94783c5566f9397",
  "customerOrderNo": "T20250421003"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名 | 说明 |
|-------------------|--------|--------|------|--------|------|
| Content-Type      | header | string | 是   |        | none |
| Accept            | header | string | 是   |        | none |
| body              | body   | object | 否   |        | none |
| » cardId          | body   | string | 是   |        | none |
| » customerOrderNo | body   | string | 否   |        | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250421-5XDY",
    "cardInfo": {
      "cardId": "6805b2caa94783c5566f9397",
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******2419",
      "cardModel": "Standard"
    },
    "note": "",
    "isBlocked": false,
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardBlock",
    "createdOn": "2025-04-21T10:01:34.5989328Z",
    "modifiedOn": "2025-04-21T10:01:34.5989331Z",
    "completedOn": null,
    "customerOrderNo": "T20250421003"
  },
  "responseId": "94a9d2d0-24a1-4f29-93dd-ff1f02ae6d2f",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 必选 | 约束 | 中文名         | 说明 |
|--------------------|--------|------|------|----------------|------|
| » data             | object | true | none |                | none |
| »» orderNo         | string | true | none | 订单号         | none |
| »» cardInfo        | object | true | none | 卡信息         | none |
| »»» cardId         | string | true | none | 卡ID           | none |
| »»» productCode    | string | true | none | 产品编号       | none |
| »»» productName    | string | true | none | 产品名称       | none |
| »»» cardCurrency   | string | true | none | 卡结算币种     | none |
| »»» maskCardNumber | string | true | none | 脱敏卡号       | none |
| »»» cardModel      | string | true | none | 卡模式         | none |
| »» note            | string | true | none | 备注信息       | none |
| »» isBlocked       | string | true | none | 卡是否已被锁定 | none |
| »» status          | string | true | none | 订单状态       | none |
| »» failureReason   | string | true | none | 失败原因       | none |
| »» orderType       | string | true | none | 订单类型       | none |
| »» createdOn       | string | true | none | 订单创建时间   | none |
| »» modifiedOn      | string | true | none | 订单修改时间   | none |
| »» completedOn     | string | true | none | 订单完成时间   | none |
| »» customerOrderNo | string | true | none | 客户订单号     | none |
| » responseId       | string | true | none | 响应ID         | none |
| » hasError         | string | true | none | 是否出错       | none |
| » errorCode        | string | true | none | 错误码         | none |
| » errorMessage     | string | true | none | 错误信息       | none |

# orders/standard/unblock

## POST 【标准模式】卡解冻

POST /v1/orders/standard/unblock

> Body 请求参数

```json
{
  "cardId": "6805b2caa94783c5566f9397",
  "customerOrderNo": "T20250421004"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名 | 说明 |
|-------------------|--------|--------|------|--------|------|
| Content-Type      | header | string | 是   |        | none |
| Accept            | header | string | 是   |        | none |
| body              | body   | object | 否   |        | none |
| » cardId          | body   | string | 是   |        | none |
| » customerOrderNo | body   | string | 否   |        | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250421-9F4Q",
    "cardInfo": {
      "cardId": "6805b2caa94783c5566f9397",
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******2419",
      "cardModel": "Standard"
    },
    "note": "",
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardUnblock",
    "createdOn": "2025-04-21T10:18:59.7305539Z",
    "modifiedOn": "2025-04-21T10:18:59.7305658Z",
    "completedOn": null,
    "customerOrderNo": null
  },
  "responseId": "24f20a23-d9e5-43f2-b577-d8d4d4b3fee6",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 必选 | 约束 | 中文名       | 说明 |
|--------------------|---------|------|------|--------------|------|
| » data             | object  | true | none |              | none |
| »» orderNo         | string  | true | none | 订单号       | none |
| »» cardInfo        | object  | true | none | 卡信息       | none |
| »»» cardId         | string  | true | none | 卡ID         | none |
| »»» productCode    | string  | true | none | 产品编码     | none |
| »»» productName    | string  | true | none | 产品名称     | none |
| »»» cardCurrency   | string  | true | none | 卡币种       | none |
| »»» maskCardNumber | string  | true | none | 脱敏卡号     | none |
| »»» cardModel      | string  | true | none | 卡模式       | none |
| »» note            | string  | true | none | 订单备注     | none |
| »» status          | string  | true | none | 订单状态     | none |
| »» failureReason   | null    | true | none | 失败原因     | none |
| »» orderType       | string  | true | none | 订单类型     | none |
| »» createdOn       | string  | true | none | 订单创建时间 | none |
| »» modifiedOn      | string  | true | none | 订单修改时间 | none |
| »» completedOn     | null    | true | none | 订单完成时间 | none |
| »» customerOrderNo | null    | true | none | 客户订单号   | none |
| » responseId       | string  | true | none | 响应ID       | none |
| » hasError         | boolean | true | none | 是否出错     | none |
| » errorCode        | null    | true | none | 错误码       | none |
| » errorMessage     | null    | true | none | 错误信息     | none |

# orders/standard/cancel

## POST 【标准模式】销卡

POST /v1/orders/standard/cancel

> Body 请求参数

```json
{
  "cardId": "<string>",
  "customerOrderNo": "<string>"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明 |
|-------------------|--------|--------|------|------------|------|
| Content-Type      | header | string | 是   |            | none |
| Accept            | header | string | 是   |            | none |
| body              | body   | object | 否   |            | none |
| » cardId          | body   | string | 是   | 卡ID       | none |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250422-5VMO",
    "cardInfo": {
      "cardId": "6805b2caa94783c5566f9397",
      "productCode": "0BN03HNK",
      "productName": "通用测试2卡",
      "cardCurrency": "USD",
      "maskCardNumber": "436797******2419",
      "cardModel": "Standard"
    },
    "fee": null,
    "chargeMethodType": "FixedValue",
    "fixedValue": null,
    "percent": null,
    "settleAmount": null,
    "note": "",
    "status": "Pending",
    "settleStatus": "Pending",
    "orderType": "CardCancel",
    "failureReason": null,
    "createdOn": "2025-04-22T09:00:34.0682329Z",
    "completedOn": null,
    "customerOrderNo": "T20250422001"
  },
  "responseId": "92deead2-69fd-4505-93b3-429cf480e7bc",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型   | 必选 | 约束 | 中文名         | 说明                                                           |
|---------------------|--------|------|------|----------------|----------------------------------------------------------------|
| » data              | object | true | none |                | none                                                           |
| »» orderNo          | string | true | none | 订单号         | none                                                           |
| »» cardInfo         | object | true | none | 卡信息         | none                                                           |
| »»» cardId          | string | true | none | 卡ID           | none                                                           |
| »»» productCode     | string | true | none | 产品编码       | none                                                           |
| »»» productName     | string | true | none | 产品名称       | none                                                           |
| »»» cardCurrency    | string | true | none | 卡结算币种     | none                                                           |
| »»» maskCardNumber  | string | true | none | 脱敏卡号       | none                                                           |
| »»» cardModel       | string | true | none | 卡模式         | none                                                           |
| »» fee              | string | true | none | 销卡手续费     | none                                                           |
| »» chargeMethodType | string | true | none | 收费方式       | 包括：固定值 FixedValue，百分比 Percentage                     |
| »» fixedValue       | string | true | none | 固定值收费标准 | none                                                           |
| »» percent          | string | true | none | 百分比收费标准 | none                                                           |
| »» settleAmount     | string | true | none | 结算金额       | none                                                           |
| »» note             | string | true | none | 备注           | none                                                           |
| »» status           | string | true | none | 订单状态       | none                                                           |
| »» settleStatus     | string | true | none | 结算状态       | 包括：Pending 处理中 ，WaitTransfer 等待划拨，Completed 已完成 |
| »» orderType        | string | true | none | 订单类型       | none                                                           |
| »» failureReason    | string | true | none | 失败原因       | none                                                           |
| »» createdOn        | string | true | none | 订单创建时间   | none                                                           |
| »» completedOn      | string | true | none | 订单完成时间   | none                                                           |
| »» customerOrderNo  | string | true | none | 客户订单号     | none                                                           |
| » responseId        | string | true | none | 响应ID         | none                                                           |
| » hasError          | string | true | none | 是否出错       | none                                                           |
| » errorCode         | string | true | none | 错误码         | none                                                           |
| » errorMessage      | string | true | none | 错误信息       | none                                                           |

# orders/standard/withdraw

## POST 【标准模式】卡余额转出

POST /v1/orders/standard/withdraw

> Body 请求参数

```json
{
  "cardId": "<string>",
  "withdrawAmount": "<double>",
  "customerOrderNo": "<string>"
}
```

### 请求参数

| 名称              | 位置   | 类型   | 必选 | 中文名     | 说明              |
|-------------------|--------|--------|------|------------|-------------------|
| Content-Type      | header | string | 是   |            | none              |
| Accept            | header | string | 是   |            | none              |
| body              | body   | object | 否   |            | none              |
| » cardId          | body   | string | 是   | 卡ID       | none              |
| » withdrawAmount  | body   | string | 是   | 转出金额   | 转出金额必须大于0 |
| » customerOrderNo | body   | string | 否   | 客户订单号 | none              |

> 返回示例

> 200 Response

```json
{
  "data": {
    "orderNo": "C1000-20250421-SGOK",
    "cardId": null,
    "withdrawAmount": 1,
    "withdrawFee": 0,
    "totalAmount": 1.1,
    "status": "Pending",
    "orderType": "CardWithdraw",
    "createdOn": "2025-04-21T11:12:00.9878605Z",
    "modifiedOn": "2025-04-21T19:12:01.04712+08:00",
    "completedOn": "2025-04-21T19:12:01.04712+08:00",
    "customerOrderNo": "T20250421005"
  },
  "responseId": "9600cb4f-12e3-4a73-8fb4-f0448e3c2401",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 必选  | 约束 | 中文名       | 说明              |
|--------------------|--------|-------|------|--------------|-------------------|
| » data             | object | true  | none |              | none              |
| »» orderNo         | string | true  | none | 订单号       | none              |
| »» cardId          | string | true  | none | 卡ID         | none              |
| »» withdrawAmount  | string | true  | none | 转出金额     | none              |
| »» withdrawFee     | string | true  | none | 转出费用     | none              |
| »» totalAmount     | string | true  | none | 总金额       | 转出金额+转出费用 |
| »» status          | string | true  | none | 订单状态     | none              |
| »» orderType       | string | true  | none | 订单类型     | none              |
| »» createdOn       | string | true  | none | 订单创建时间 | none              |
| »» modifiedOn      | string | true  | none | 订单修改时间 | none              |
| »» completedOn     | string | false | none | 订单完成时间 | none              |
| »» customerOrderNo | string | true  | none | 客户订单号   | none              |
| » responseId       | string | true  | none |              | none              |
| » hasError         | string | true  | none |              | none              |
| » errorCode        | string | true  | none |              | none              |
| » errorMessage     | string | true  | none |              | none              |

# cards/{cardId}

## GET 查询卡信息

GET /v1/cards/{cardId}

获取卡信息

### 请求参数

| 名称   | 位置   | 类型   | 必选 | 中文名 | 说明            |
|--------|--------|--------|------|--------|-----------------|
| cardId | path   | string | 是   |        | (Required) 卡ID |
| Accept | header | string | 是   |        | none            |

> 返回示例

> 200 Response

```json
{
  "data": {
    "cardId": "6805b2caa94783c5566f9397",
    "cardModel": "Standard",
    "productCode": "0BN03HNK",
    "cardNumber": "4367970137672419",
    "cvv": "962",
    "expirationMMYY": "04/2028",
    "cardCurrency": "USD",
    "alias": "测试卡01",
    "balanceAmount": 3,
    "status": "Active",
    "maxAuthAmount": 0,
    "usedCreditAmount": 0,
    "maxCreditAmount": null,
    "cardOrganization": "Mastercard",
    "applyTime": "2025-04-21T02:51:54.812Z"
  },
  "responseId": "743f2256-6e02-46d2-ac7a-1440a4024da3",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型   | 必选 | 约束 | 中文名                     | 说明                                                                        |
|---------------------|--------|------|------|----------------------------|-----------------------------------------------------------------------------|
| » data              | object | true | none |                            | none                                                                        |
| »» cardId           | string | true | none | 卡ID                       | 卡唯一ID                                                                    |
| »» cardModel        | string | true | none | 卡模式                     | 包括：标准模式 Standard ，共享余额 ShareBalance                             |
| »» productCode      | string | true | none | 产品编码                   | none                                                                        |
| »» cardNumber       | string | true | none | 卡号                       | none                                                                        |
| »» cvv              | string | true | none | cvv信息                    | none                                                                        |
| »» expirationMMYY   | string | true | none | 卡面过期年月信息           | 例如 04/2028                                                                |
| »» cardCurrency     | string | true | none | 卡结算币种                 | none                                                                        |
| »» alias            | string | true | none | 卡别名                     | none                                                                        |
| »» balanceAmount    | string | true | none | 可用余额                   | none                                                                        |
| »» status           | string | true | none | 卡状态                     | 包括：Active 活跃，Blocked 已冻结，Cancel 已注销，Expired 已过期            |
| »» maxAuthAmount    | string | true | none | 单笔限额（最大预授权金额） | 仅在共享模式下可用                                                          |
| »» usedCreditAmount | string | true | none | 已消费的额度               | 仅在共享模式下可用                                                          |
| »» maxCreditAmount  | string | true | none | 单卡总额度上限             | 仅在共享模式下可用。值为空表示无限额度。                                    |
| »» cardOrganization | string | true | none | 卡组织                     | 包括：Mastercard  万事达卡， VISA ，AmericanExpress 美国运通，UnionPay 银联 |
| »» applyTime        | string | true | none | 申请时间                   | none                                                                        |
| » responseId        | string | true | none | 响应Id                     | none                                                                        |
| » hasError          | string | true | none | 是否出错                   | none                                                                        |
| » errorCode         | string | true | none | 错误码                     | none                                                                        |
| » errorMessage      | string | true | none | 错误信息                   | none                                                                        |

# transactions

## GET 查询交易流水

GET /v1/transactions

### 请求参数

| 名称                | 位置   | 类型   | 必选 | 中文名 | 说明                                                                         |
|---------------------|--------|--------|------|--------|------------------------------------------------------------------------------|
| CardId              | query  | string | 是   |        | 卡ID                                                                         |
| TransactionDateFrom | query  | string | 是   |        | 预授权开始日期：格式 YYYY-MM-DD                                              |
| TransactionDateTo   | query  | string | 是   |        | 预授权结束日期: 格式 YYYY-MM-DD                                              |
| TransactionStatus   | query  | string | 是   |        | 交易状态  包括AuthSuccess 预授权成功，AuthFailure 预授权失败，Settled 已入账 |
| PageSize            | query  | string | 是   |        | 每一页数据条数，默认20条                                                     |
| PageCursor          | query  | string | 是   |        | 上一页最后一条记录的ID， 首次查询赋值空，翻页查询赋值上一页最后一条记录的ID  |
| Accept              | header | string | 是   |        | none                                                                         |

> 返回示例

> 200 Response

```json
{
  "data": {
    "pageCursor": "<string>",
    "pageSize": "<integer>",
    "data": [
      {
        "id": "<string>",
        "authTime": "<dateTime>",
        "settleTime": "<dateTime>",
        "transAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "authAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "settledAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "cardInfo": {
          "cardId": "<string>",
          "productCode": "<string>",
          "productName": "<string>",
          "cardCurrency": "HNL",
          "maskCardNumber": "<string>",
          "cardModel": "Standard"
        },
        "cardAlias": "<string>",
        "authCode": "<string>",
        "merchantName": "<string>",
        "merchantCountryCode": "<string>",
        "merchantCity": "<string>",
        "merchantState": "<string>",
        "merchantZipCode": "<string>",
        "merchantDesc": "<string>",
        "status": "AuthSuccess",
        "fundsDirection": "Income",
        "transactionType": "ConsumeRefundReversal",
        "failureReason": "<string>",
        "failureReasonCn": "<string>",
        "note": "<string>"
      },
      {
        "id": "<string>",
        "authTime": "<dateTime>",
        "settleTime": "<dateTime>",
        "transAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "authAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "settledAmount": {
          "currency": "<string>",
          "amount": "<double>"
        },
        "cardInfo": {
          "cardId": "<string>",
          "productCode": "<string>",
          "productName": "<string>",
          "cardCurrency": "DZD",
          "maskCardNumber": "<string>",
          "cardModel": "ShareBalance"
        },
        "cardAlias": "<string>",
        "authCode": "<string>",
        "merchantName": "<string>",
        "merchantCountryCode": "<string>",
        "merchantCity": "<string>",
        "merchantState": "<string>",
        "merchantZipCode": "<string>",
        "merchantDesc": "<string>",
        "status": "AuthSuccess",
        "fundsDirection": "Income",
        "transactionType": "DisputeRelease",
        "failureReason": "<string>",
        "failureReasonCn": "<string>",
        "note": "<string>"
      }
    ]
  },
  "responseId": "<string>",
  "hasError": "<boolean>",
  "errorCode": "<string>",
  "errorMessage": "<string>"
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                    | 类型     | 必选  | 约束 | 中文名         | 说明                                                                                                                                                                                         |
|-------------------------|----------|-------|------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data                  | object   | true  | none |                | none                                                                                                                                                                                         |
| »» pageCursor           | string   | true  | none |                | none                                                                                                                                                                                         |
| »» pageSize             | string   | true  | none |                | none                                                                                                                                                                                         |
| »» data                 | [object] | true  | none |                | none                                                                                                                                                                                         |
| »»» id                  | string   | true  | none | 交易ID         | none                                                                                                                                                                                         |
| »»» authTime            | string   | true  | none | 预授权时间     | none                                                                                                                                                                                         |
| »»» settleTime          | string   | false | none | 清算时间       | 入账后，返回清算时间                                                                                                                                                                         |
| »»» transAmount         | object   | true  | none | 原始交易金额   | none                                                                                                                                                                                         |
| »»»» currency           | string   | true  | none | 原始交易币种   | none                                                                                                                                                                                         |
| »»»» amount             | string   | true  | none | 原始交易金额值 | none                                                                                                                                                                                         |
| »»» authAmount          | object   | true  | none | 预授权金额     | none                                                                                                                                                                                         |
| »»»» currency           | string   | true  | none | 预授权币种     | none                                                                                                                                                                                         |
| »»»» amount             | string   | true  | none | 预授权金额值   | none                                                                                                                                                                                         |
| »»» settledAmount       | object   | false | none | 结算金额       | 入账后，返回结算金额                                                                                                                                                                         |
| »»»» currency           | string   | true  | none | 结算币种       | none                                                                                                                                                                                         |
| »»»» amount             | string   | true  | none | 结算金额值     | none                                                                                                                                                                                         |
| »»» cardInfo            | object   | true  | none | 卡信息         | none                                                                                                                                                                                         |
| »»»» cardId             | string   | true  | none | 卡ID           | none                                                                                                                                                                                         |
| »»»» productCode        | string   | true  | none | 产品编码       | none                                                                                                                                                                                         |
| »»»» productName        | string   | true  | none | 产品名称       | none                                                                                                                                                                                         |
| »»»» cardCurrency       | string   | true  | none | 卡结算币种     | none                                                                                                                                                                                         |
| »»»» maskCardNumber     | string   | true  | none | 脱敏卡号       | none                                                                                                                                                                                         |
| »»»» cardModel          | string   | true  | none | 卡模式         | none                                                                                                                                                                                         |
| »»» cardAlias           | string   | false | none | 卡别名         | none                                                                                                                                                                                         |
| »»» authCode            | string   | false | none | 授权码         | none                                                                                                                                                                                         |
| »»» merchantName        | string   | false | none | 商户名称       | none                                                                                                                                                                                         |
| »»» merchantCountryCode | string   | false | none | 商户国家代码   | none                                                                                                                                                                                         |
| »»» merchantCity        | string   | false | none | 商户所在城市   | none                                                                                                                                                                                         |
| »»» merchantState       | string   | false | none | 商户所在州     | none                                                                                                                                                                                         |
| »»» merchantZipCode     | string   | false | none | 商户邮编       | none                                                                                                                                                                                         |
| »»» merchantDesc        | string   | false | none | 商户描述       | none                                                                                                                                                                                         |
| »»» status              | string   | true  | none | 交易状态       | 包括AuthSuccess 预授权成功，AuthFailure 预授权失败，Settled 已入账                                                                                                                           |
| »»» fundsDirection      | string   | true  | none | 资金方向       | Income: 收入 Expenditure: 支出                                                                                                                                                               |
| »»» transactionType     | string   | true  | none | 交易类型       | Consume 消费, ConsumeRefund 消费退款,DisputeRelease 消费争议, DisputeRelease 争议释放,ConsumeReversal 取消消费, ConsumeRefundReversal 消费退款冲正,AuthQuery 预授权查询, TransFee 交易手续费 |
| »»» failureReason       | string   | true  | none | 失败原因       | none                                                                                                                                                                                         |
| »»» failureReasonCn     | string   | true  | none | 中文失败原因   | none                                                                                                                                                                                         |
| »»» note                | string   | true  | none | 备注           | none                                                                                                                                                                                         |
| » responseId            | string   | true  | none | 响应ID         | none                                                                                                                                                                                         |
| » hasError              | string   | true  | none | 是否出错       | none                                                                                                                                                                                         |
| » errorCode             | string   | true  | none | 错误码         | none                                                                                                                                                                                         |
| » errorMessage          | string   | true  | none | 错误信息       | none                                                                                                                                                                                         |

# accounts

## GET 获取客户资金账户余额信息

GET /v1/accounts

### 请求参数

| 名称   | 位置   | 类型   | 必选 | 中文名 | 说明 |
|--------|--------|--------|------|--------|------|
| Accept | header | string | 是   |        | none |

> 返回示例

> 200 Response

```json
{
  "data": [
    {
      "currency": "USD",
      "amount": 9999.3
    },
    {
      "currency": "HKD",
      "amount": 0
    }
  ],
  "responseId": "cf276595-6e3f-408c-a17f-6c69bc822543",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称           | 类型     | 必选 | 约束 | 中文名       | 说明 |
|----------------|----------|------|------|--------------|------|
| » data         | [object] | true | none |              | none |
| »» currency    | string   | true | none | 账户币种     | none |
| »» amount      | string   | true | none | 账户可用金额 | none |
| » responseId   | string   | true | none | 响应ID       | none |
| » hasError     | string   | true | none | 是否出错     | none |
| » errorCode    | string   | true | none | 错误码       | none |
| » errorMessage | string   | true | none | 错误原因     | none |

# accounts/cardAccountLogs

## GET 【标准模式】分页查询卡资金明细（不含交易流水）

GET /v1/accounts/cardAccountLogs

### 请求参数

| 名称                | 位置   | 类型   | 必选 | 中文名 | 说明                              |
|---------------------|--------|--------|------|--------|-----------------------------------|
| CardId              | query  | string | 是   |        | 卡ID                              |
| TransactionDateFrom | query  | string | 是   |        | 开始交易日期                      |
| TransactionDateTo   | query  | string | 是   |        | 结束交易日期                      |
| Limit               | query  | string | 否   |        | 返回数据条数，默认20条            |
| Offset              | query  | string | 否   |        | 偏移数据条数。为空默认为0(第一页) |
| Accept              | header | string | 是   |        | none                              |

> 返回示例

> 200 Response

```json
{
  "data": {
    "pageNumber": 1,
    "pageSize": 20,
    "totalRecords": 4,
    "totalPages": 1,
    "data": [
      {
        "accountLogId": "68075ab282145abca90c06a0",
        "cardOrderNo": "C1000-20250422-5VMO",
        "cardAccountLogType": "CardCancel",
        "accountInfo": {
          "id": null,
          "accountSource": "Card",
          "cardId": null,
          "accountName": "中国制造有限公司",
          "currency": "USD"
        },
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "fundsDirection": "Income",
        "transAmount": {
          "currency": "USD",
          "amount": -3.9
        },
        "totalFee": {
          "currency": "USD",
          "amount": 0.1
        },
        "feeItems": [
          {
            "feeType": "CancelCardFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ],
        "totalAmount": {
          "currency": "USD",
          "amount": -3.8
        },
        "status": "Completed",
        "failureReason": "",
        "transTime": "2025-04-22T09:00:34.117Z",
        "completedTime": "2025-04-23T01:00:01.211Z",
        "note": ""
      },
      {
        "accountLogId": "680628014e1dc896a2a14bab",
        "cardOrderNo": "C1000-20250421-SGOK",
        "cardAccountLogType": "BalanceRefund",
        "accountInfo": {
          "id": null,
          "accountSource": "Card",
          "cardId": "6805b2caa94783c5566f9397",
          "accountName": "436797******2419",
          "currency": "USD"
        },
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "fundsDirection": "Income",
        "transAmount": {
          "currency": "USD",
          "amount": 1
        },
        "totalFee": {
          "currency": "USD",
          "amount": 0.1
        },
        "feeItems": [
          {
            "feeType": "CardWithdrawFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ],
        "totalAmount": {
          "currency": "USD",
          "amount": 1.1
        },
        "status": "Completed",
        "failureReason": "",
        "transTime": "2025-04-21T11:12:01.034Z",
        "completedTime": "2025-04-21T11:14:15.604Z",
        "note": null
      },
      {
        "accountLogId": "68061661fd6d9af033a2d1f2",
        "cardOrderNo": "C1000-20250421-YRX3",
        "cardAccountLogType": "CardTopUp",
        "accountInfo": {
          "id": null,
          "accountSource": "Card",
          "cardId": null,
          "accountName": "中国制造有限公司",
          "currency": "USD"
        },
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "fundsDirection": "Expenditure",
        "transAmount": {
          "currency": "USD",
          "amount": 2
        },
        "totalFee": {
          "currency": "USD",
          "amount": 0.1
        },
        "feeItems": [
          {
            "feeType": "TopUpFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ],
        "totalAmount": {
          "currency": "USD",
          "amount": 2.1
        },
        "status": "Completed",
        "failureReason": null,
        "transTime": "2025-04-21T09:56:49.889Z",
        "completedTime": "2025-04-21T09:57:01.561Z",
        "note": null
      },
      {
        "accountLogId": "6805b2bfff45c13c270fd6f6",
        "cardOrderNo": "C1000-20250421-E971",
        "cardAccountLogType": "ApplyCard",
        "accountInfo": {
          "id": null,
          "accountSource": "Card",
          "cardId": null,
          "accountName": "中国制造有限公司",
          "currency": "USD"
        },
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "fundsDirection": "Expenditure",
        "transAmount": {
          "currency": "USD",
          "amount": 3
        },
        "totalFee": {
          "currency": "USD",
          "amount": 0.2
        },
        "feeItems": [
          {
            "feeType": "OpenCardFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          },
          {
            "feeType": "TopUpFee",
            "feeAmount": {
              "currency": "USD",
              "amount": 0.1
            }
          }
        ],
        "totalAmount": {
          "currency": "USD",
          "amount": 3.2
        },
        "status": "Completed",
        "failureReason": null,
        "transTime": "2025-04-21T02:51:43.165Z",
        "completedTime": "2025-04-21T02:51:54.877Z",
        "note": ""
      }
    ]
  },
  "responseId": "072e38f0-e72a-48a0-983a-247ad28419af",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                   | 类型     | 必选 | 约束 | 中文名             | 说明                                                                                                     |
|------------------------|----------|------|------|--------------------|----------------------------------------------------------------------------------------------------------|
| » data                 | object   | true | none |                    | none                                                                                                     |
| »» pageNumber          | string   | true | none | 页号               | none                                                                                                     |
| »» pageSize            | string   | true | none | 每页数据行数       | none                                                                                                     |
| »» totalRecords        | string   | true | none | 总记录数           | none                                                                                                     |
| »» totalPages          | string   | true | none | 总页数             | none                                                                                                     |
| »» data                | [object] | true | none |                    | none                                                                                                     |
| »»» accountLogId       | string   | true | none | 账户明细ID         | none                                                                                                     |
| »»» cardOrderNo        | string   | true | none | 批次订单号         | none                                                                                                     |
| »»» cardAccountLogType | string   | true | none | 卡账户交易明细类型 | ApplyCard 申请开卡, CardTopUp  卡充值，CardCancel 卡注销，TransCharge 交易收费，BalanceRefund 卡转出资金 |
| »»» cardInfo           | object   | true | none | 卡信息             | none                                                                                                     |
| »»»» cardId            | string   | true | none | 卡ID               | none                                                                                                     |
| »»»» productCode       | string   | true | none | 产品编码           | none                                                                                                     |
| »»»» productName       | string   | true | none | 产品名称           | none                                                                                                     |
| »»»» cardCurrency      | string   | true | none | 卡结算币种         | none                                                                                                     |
| »»»» maskCardNumber    | string   | true | none | 脱敏卡号           | none                                                                                                     |
| »»»» cardModel         | string   | true | none | 卡模式             | none                                                                                                     |
| »»» fundsDirection     | string   | true | none | 资金方向           | 相对于卡余额账户，Income 收入，Expenditure 支出                                                          |
| »»» transAmount        | object   | true | none | 交易金额信息       | none                                                                                                     |
| »»»» currency          | string   | true | none | 交易币种           | none                                                                                                     |
| »»»» amount            | string   | true | none | 交易金额           | none                                                                                                     |
| »»» totalFee           | object   | true | none | 总手续费信息       | none                                                                                                     |
| »»»» currency          | string   | true | none | 总手续费币种       | none                                                                                                     |
| »»»» amount            | string   | true | none | 总手续费金额       | none                                                                                                     |
| »»» feeItems           | [object] | true | none | 费用明细           | none                                                                                                     |
| »»»» feeType           | string   | true | none | 费用类型           | none                                                                                                     |
| »»»» feeAmount         | object   | true | none | 费用金额信息       | none                                                                                                     |
| »»»»» currency         | string   | true | none | 费用币种           | none                                                                                                     |
| »»»»» amount           | string   | true | none | 费用金额           | none                                                                                                     |
| »»» totalAmount        | object   | true | none | 总金额信息         | 总金额= 交易金额+总手续费                                                                                |
| »»»» currency          | string   | true | none | 总金额币种         | none                                                                                                     |
| »»»» amount            | string   | true | none | 总金额金额         | none                                                                                                     |
| »»» status             | string   | true | none | 状态               | Pending 处理中，Completed 已完成，Failure 处理失败， Reversed 已退回，ReverseFailure 退回失败            |
| »»» failureReason      | string   | true | none | 失败原因           | none                                                                                                     |
| »»» transTime          | string   | true | none | 交易时间           | none                                                                                                     |
| »»» completedTime      | string   | true | none | 完成时间           | none                                                                                                     |
| »»» note               | string   | true | none | 备注               | none                                                                                                     |
| » responseId           | string   | true | none | 响应ID             | none                                                                                                     |
| » hasError             | string   | true | none | 是否出错           | none                                                                                                     |
| » errorCode            | string   | true | none | 错误码             | none                                                                                                     |
| » errorMessage         | string   | true | none | 错误信息           | none                                                                                                     |

# accounts/accountLogs

## GET 分页查询 资金账户资金明细

GET /v1/accounts/accountLogs

### 请求参数

| 名称                | 位置   | 类型   | 必选 | 中文名 | 说明                                |
|---------------------|--------|--------|------|--------|-------------------------------------|
| TransactionDateFrom | query  | string | 是   |        | 开始交易日期                        |
| TransactionDateTo   | query  | string | 是   |        | 结束交易日期                        |
| Limit               | query  | string | 是   |        | 返回数据条数，为空默认20条          |
| Offset              | query  | string | 是   |        | 偏移数据条数。为空默认为0（第一页） |
| Accept              | header | string | 是   |        | none                                |

> 返回示例

> 200 Response

```json
{
  "data": {
    "pageNumber": 1,
    "pageSize": 20,
    "totalRecords": 11,
    "totalPages": 1,
    "data": [
      {
        "id": "6808b15f2164bb294aae83b2",
        "accountTransType": "CancelCardFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9999.3,
        "blockedBalance": 0,
        "orderNo": "C1000-20250423-D2LA",
        "note": "",
        "cardInfo": {
          "cardId": "68085ad8b85b8cf3d3f3087e",
          "productCode": "A5GGCYNQ",
          "productName": "通用卡-共享测试产品",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******9343",
          "cardModel": "ShareBalance"
        },
        "transTime": "2025-04-23T09:22:39.511Z"
      },
      {
        "id": "68085acdb85b8cf3d3f3087b",
        "accountTransType": "OpenCardFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9999.4,
        "blockedBalance": 0,
        "orderNo": "C1000-20250423-2RJI",
        "note": "",
        "cardInfo": null,
        "transTime": "2025-04-23T03:13:17.69Z"
      },
      {
        "id": "68083b91b85b8cf3d3f30875",
        "accountTransType": "CancelCardFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9999.5,
        "blockedBalance": 0,
        "orderNo": "C1000-20250422-5VMO",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-23T01:00:01.147Z"
      },
      {
        "id": "68083b91b85b8cf3d3f30873",
        "accountTransType": "CancelCardSettleRefund",
        "fundsDirection": "Income",
        "currency": "USD",
        "transAmount": 3.9,
        "availableBalance": 9999.6,
        "blockedBalance": 0,
        "orderNo": "C1000-20250422-5VMO",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-23T01:00:01.123Z"
      },
      {
        "id": "680628876d2e4f5a38719b82",
        "accountTransType": "CardWithdraw",
        "fundsDirection": "Income",
        "currency": "USD",
        "transAmount": 1,
        "availableBalance": 9995.7,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-SGOK",
        "note": null,
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T11:14:15.574Z"
      },
      {
        "id": "68061661fd6d9af033a2d1ef",
        "accountTransType": "TopUpFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9994.7,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-YRX3",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T09:56:49.838Z"
      },
      {
        "id": "68061661fd6d9af033a2d1ee",
        "accountTransType": "CardTopUp",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -2,
        "availableBalance": 9994.8,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-YRX3",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T09:56:49.834Z"
      },
      {
        "id": "6805b2bfff45c13c270fd6f2",
        "accountTransType": "OpenCardFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9996.9,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-E971",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T02:51:43.127Z"
      },
      {
        "id": "6805b2bfff45c13c270fd6f3",
        "accountTransType": "TopUpFee",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -0.1,
        "availableBalance": 9996.8,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-E971",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T02:51:43.127Z"
      },
      {
        "id": "6805b2bfff45c13c270fd6f1",
        "accountTransType": "CardTopUp",
        "fundsDirection": "Expenditure",
        "currency": "USD",
        "transAmount": -3,
        "availableBalance": 9997,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-E971",
        "note": "",
        "cardInfo": {
          "cardId": "6805b2caa94783c5566f9397",
          "productCode": "0BN03HNK",
          "productName": "通用测试2卡",
          "cardCurrency": "USD",
          "maskCardNumber": "436797******2419",
          "cardModel": "Standard"
        },
        "transTime": "2025-04-21T02:51:43.126Z"
      },
      {
        "id": "6805b035ff45c13c270fd6ea",
        "accountTransType": "AccountAdjustIncrease",
        "fundsDirection": "Income",
        "currency": "USD",
        "transAmount": 10000,
        "availableBalance": 10000,
        "blockedBalance": 0,
        "orderNo": "C1000-20250421-CLDF",
        "note": "入金",
        "cardInfo": null,
        "transTime": "2025-04-21T02:40:53.088Z"
      }
    ]
  },
  "responseId": "a9fd6b12-bcfb-4143-8291-811114f8dc97",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
```

> 401 Response

```
{}
```

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                 | 类型     | 必选 | 约束 | 中文名         | 说明                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------|----------|------|------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data               | object   | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» pageNumber        | string   | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» pageSize          | string   | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» totalRecords      | string   | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» totalPages        | string   | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» data              | [object] | true | none |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» id               | string   | true | none | 流水号         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» accountTransType | string   | true | none | 交易类型       | AccountTopUp 账户转入资金，AccountWithdraw 账户转出资金，AuthBlock  授权冻结，AuthUnBlock 授权解冻，AuthReversal 授权取消，Consume 消费，ConsumeRefund 消费退款，OpenCardFee 开卡手续费，TransFee 交易手续费，CancelCardFee 销卡手续费， Rebate 返利，ReversalRefund 冲账退回，ReversalDeduct 冲账扣除，ConsumeSettlementDiffDeduct 消费清算差额-扣除，ConsumeSettlementDiffRefund 消费清算差额-退回，AccountTopUpFee 账户转入手续费，AccountWithdrawFee 账户转出手续费，CardTopUp 卡转入资金，TopUpFee 卡转入手续费，CardWithdraw 卡转出资金，CancelCardSettleDeduct 销卡结算-扣除，CancelCardSettleRefund 销卡结算-退回，AccountAdjustIncrease 账户调增，AccountAdjustDeduct 账户调减，CardOverdrawDeduct 标准卡透支扣除，<br />CardOverdrawReversal 标准卡透支冲正 |
| »»» fundsDirection   | string   | true | none | 资金方向       | Income 收入，Expenditure 支出                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| »»» currency         | string   | true | none | 账户币种       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» transAmount      | string   | true | none | 交易金额       | 分正负号                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| »»» availableBalance | string   | true | none | 调整后可用余额 | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» blockedBalance   | string   | true | none | 调整后冻结余额 | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» orderNo          | string   | true | none | 关联订单号     | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» note             | string   | true | none | 备注           | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» cardInfo         | object   | true | none | 卡信息         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardId          | string   | true | none | 卡ID           | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» productCode     | string   | true | none | 产品编码       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» productName     | string   | true | none | 产品名称       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardCurrency    | string   | true | none | 卡结算币种     | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» maskCardNumber  | string   | true | none | 脱敏卡号       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardModel       | string   | true | none | 卡模式         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» transTime        | string   | true | none | 交易时间       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » responseId         | string   | true | none | 响应ID         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » hasError           | string   | true | none | 是否出错       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » errorCode          | string   | true | none | 错误码         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » errorMessage       | string   | true | none | 错误信息       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

# 数据模型

