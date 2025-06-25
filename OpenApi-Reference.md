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

| 名称           | 类型    | 中文名       | 说明                                                                                                                 |
|----------------|---------|------|--------------|----------------------------------------------------------------------------------------------------------------------|
| » access_token | string  | true | 访问令牌     | 调用业务API时需要此访问令牌                                                                                          |
| » expires_in   | integer | true | 令牌过期时间 | 时间单位为秒，默认令牌过期时间为3600秒=1小时。客户端可以缓存此令牌。注意：获取新令牌，老令牌在有效期内仍然可以使用。 |
| » token_type   | string  | true | 令牌类型     | 默认返回Bearer                                                                                                       |
| » scope        | string  | true | 域           | 默认返回 card                                                                                                        |

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

| 状态码 | 状态码含义                                                      | 说明 |
|--------|-----------------------------------------------------------------|------|----------|
| [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   | 名称   | 位置   | 类型   | 必选 | 说明 |
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

| 名称            | 类型     | 约束 | 中文名     | 说明       |
|-----------------|----------|------|------------|------------|
| » data          | [object] | true | none       | none       |
| »» productCode  | string   | true | 产品编码   | none       |
| »» productName  | string   | true | 产品名称   | none       |
| »» cardModels   | [string] | true | 卡模式     | none       |
| »» cardCurrency | [string] | true | 卡结算币种 | none       |
| »» description  | string   | true | 产品描述   | none       |
| » responseId    | string   | true | 响应Id     | none       |
| » hasError      | boolean  | true | 是否有错误 | none       |
| » errorCode     | string   | true | 错误码     | none       |
| » errorMessage  | string   | true | 错误信息   | none       | 名称            | 位置   | 类型   | 必选 | 说明                         |
|-----------------|--------|--------|------|------------------------------|
| OrderType       | query  | string | 是   | 订单类型:                    |
| OrderNo         | query  | string | 是   | 订单号。和客户订单号必选其一 |
| CustomerOrderNo | query  | string | 否   | 客户订单号。和订单号必选其一 |
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
|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 约束 | 中文名         | 说明                                               |
|--------------------|----------|------|----------------|----------------------------------------------------|
| » data             | object   | none |                | none                                               |
| »» orderNo         | string   | none | 订单编号       | none                                               |
| »» productInfo     | object   | none | 产品信息       | none                                               |
| »»» productCode    | string   | none | 产品编码       | none                                               |
| »»» productName    | string   | none | 产品名称       | none                                               |
| »»» cardModel      | string   | none | 卡模式         | none                                               |
| »»» cardCurrency   | string   | none | 卡结算币种     | none                                               |
| »» quantity        | integer  | none | 申请开卡卡数   | none                                               |
| »» maxAuthAmount   | number   | none | 单笔限额       | none                                               |
| »» maxCreditAmount | number   | none | 单卡消费总额度 | 可以为空，为空表示无限额度                         |
| »» totalAmount     | number   | none | 总交易金额     | none                                               |
| »» transAmount     | number   | none | 交易金额       | none                                               |
| »» transFee        | number   | none | 交易手续费     | none                                               |
| »» openedQty       | integer  | none | 已开卡数       | none                                               |
| »» cardInfos       | [object] | none | 已开卡信息     | none                                               |
| »»» cardId         | string   | none | 卡ID           | none                                               |
| »»» productCode    | string   | none | 产品编码       | none                                               |
| »»» productName    | string   | none | 产品名称       | none                                               |
| »»» cardCurrency   | string   | none | 卡结算币种     | none                                               |
| »»» maskCardNumber | string   | none | 脱敏卡号       | none                                               |
| »»» cardModel      | string   | none | 卡模式         | none                                               |
| »» note            | string   | none | 备注           | none                                               |
| »» status          | string   | none | 订单状态       | Pending 处理中，Completed 已完成，Failure 处理失败 |
| »» orderType       | string   | none | 订单类型       | none                                               |
| »» createdOn       | string   | none | 订单创建时间   | none                                               |
| »» modifiedOn      | string   | none | 订单修改时间   | none                                               |
| »» completedOn     | string   | none | 订单完成时间   | none                                               |
| »» customerOrderNo | string   | none | 客户订单号     | none                                               |
| » responseId       | string   | none | 响应ID         | none                                               |
| » hasError         | boolean  | none | 是否出错       | none                                               |
| » errorCode        | null     | none | 错误码         | none                                               |
| » errorMessage     | null     | none | 错误信息       | none                                               |

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

| 名称              | 位置   | 中文名         | 说明                       |
|-------------------|--------|--------|----------------|----------------------------|
| Content-Type      | header | string |                | none                       |
| Accept            | header | string |                | none                       |
| body              | body   | object |                | none                       |
| » productCode     | body   | string | 产品代码       | none                       |
| » cardCurrency    | body   | string | 卡结算币种     | none                       |
| » maxAuthAmount   | body   | string | 单笔限额       | none                       |
| » maxCreditAmount | body   | string | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| » cardAlias       | body   | string | 卡别名         | none                       |
| » customerOrderNo | body   | string | 客户订单号     | none                       |

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

| 名称               | 类型     | 约束 | 中文名         | 说明                       |
|------------------|----------|------|----------------|----------------------------|
| » data             | object   | true | none           | none                       |
| »» orderNo         | string   | true | 订单号         | none                       |
| »» productInfo     | object   | true | 产品信息       | none                       |
| »»» productCode    | string   | true | 产品代码       | none                       |
| »»» productName    | string   | true | 产品名称       | none                       |
| »»» cardModel      | string   | true | 卡模式         | none                       |
| »»» cardCurrency   | string   | true | 卡结算币种     | none                       |
| »» quantity        | integer  | true | 开卡数量       | none                       |
| »» maxAuthAmount   | number   | true | 单笔限额       | none                       |
| »» maxCreditAmount | number   | true | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| »» totalAmount     | number   | true | 总金额         | none                       |
| »» transAmount     | number   | true | 交易实际金额   | none                       |
| »» transFee        | number   | true | 交易手续费     | none                       |
| »» openedQty       | integer  | true | 已开卡数       | none                       |
| »» cardInfos       | [object] | true | 卡信息         | none                       |
| »» note            | string   | true | 备注           | none                       |
| »» status          | string   | true | 订单状态       | none                       |
| »» orderType       | string   | true | 订单类型       | none                       |
| »» createdOn       | string   | true | 订单创建时间   | none                       |
| »» modifiedOn      | string   | true | 订单修改时间   | none                       |
| »» completedOn     | string   | true | 订单完成时间   | none                       |
| »» customerOrderNo | string   | true | 客户订单号     | none                       |
| » responseId       | string   | true | 响应ID         | none                       |
| » hasError         | boolean  | true | 是否出错       | none                       |
| » errorCode        | string   | true | 错误码         | none                       |
| » errorMessage     | string   | true | 错误信息       | none                       |

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
| Content-Type      | header | string | 是   | none           | none                           |
| Accept            | header | string | 是   | none           | none                           |
| body              | body   | object | 否   | none           | none                           |
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

| 状态码 | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 约束 | 中文名       |
|--------------------|---------|------|------|--------------|
| » data             | object  | true | none |              |
| »» orderNo         | string  | true | none | 订单号       |
| »» cardId          | string  | true | none | 卡ID         |
| »» maxAuthAmount   | number  | true | none | 单笔限额     |
| »» maxCreditAmount | number  | true | none | 单卡消费额度 |
| »» status          | string  | true | none | 订单状态     |
| »» orderType       | string  | true | none | 订单类型     |
| »» failureReason   | string  | true | none | 失败原因     |
| »» createdOn       | string  | true | none | 订单创建时间 |
| »» completedOn     | string  | true | none | 订单完成时间 |
| »» customerOrderNo | string  | true | none | 客户订单号   |
| » responseId       | string  | true | none | 响应ID       |
| » hasError         | boolean | true | none | 是否出错     |
| » errorCode        | string  | true | none | 错误码       |
| » errorMessage     | string  | true | none | 错误信息     |

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

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | none |
| »» orderNo         | string  | true | 订单号       | none |
| »» cardInfo        | object  | true | 卡信息       | none |
| »»» cardId         | string  | true | 卡ID         | none |
| »»» productCode    | string  | true | 产品编码     | none |
| »»» productName    | string  | true | 产品名称     | none |
| »»» cardCurrency   | string  | true | 卡结算币种   | none |
| »»» maskCardNumber | string  | true | 脱敏卡号     | none |
| »»» cardModel      | string  | true | 卡模式       | none |
| »» note            | string  | true | 备注         | none |
| »» isBlocked       | boolean | true | 是否被冻结   | none |
| »» status          | string  | true | 订单状态     | none |
| »» failureReason   | string  | true | 错误原因     | none |
| »» orderType       | string  | true | 订单类型     | none |
| »» createdOn       | string  | true | 订单创建时间 | none |
| »» modifiedOn      | string  | true | 订单修改时间 | none |
| »» completedOn     | string  | true | 订单完成时间 | none |
| »» customerOrderNo | string  | true | 客户订单号   | none |
| » responseId       | string  | true | 响应ID       | none |
| » hasError         | boolean | true | 是否出错     | none |
| » errorCode        | string  | true | 错误码       | none |
| » errorMessage     | string  | true | 错误信息     | none |

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

| 名称              | 位置   | 类型   | 说明 |
|-------------------|--------|--------|------|------|
| Content-Type      | header | string | 是   | none |
| Accept            | header | string | 是   | none |
| body              | body   | object | 否   | none |
| » cardId          | body   | string | 是   | none |
| » customerOrderNo | body   | string | 否   | none |

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

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |--------|-----------------------------------------------------------------|------|----------|
| 200    | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 约束 | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | none |
| »» orderNo         | string  | true | 订单号       | none |
| »» cardInfo        | object  | true | 卡信息       | none |
| »»» cardId         | string  | true | 卡ID         | none |
| »»» productCode    | string  | true | 产品编码     | none |
| »»» productName    | string  | true | 产品名称     | none |
| »»» cardCurrency   | string  | true | 卡结算币种   | none |
| »»» maskCardNumber | string  | true | 脱敏卡号     | none |
| »»» cardModel      | string  | true | 卡模式       | none |
| »» note            | string  | true | 备注         | none |
| »» status          | string  | true | 订单状态     | none |
| »» failureReason   | string  | true | 失败原因     | none |
| »» orderType       | string  | true | 订单类型     | none |
| »» createdOn       | string  | true | 订单创建时间 | none |
| »» modifiedOn      | string  | true | 订单修改时间 | none |
| »» completedOn     | string  | true | 订单完成时间 | none |
| »» customerOrderNo | string  | true | 客户订单号   | none |
| » responseId       | string  | true | 响应ID       | none |
| » hasError         | boolean | true | 是否出错     | none |
| » errorCode        | string  | true | 错误码       | none |
| » errorMessage     | string  | true | 错误信息     | none |

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

| 状态码 | 状态码含义                                                      | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none |

### 返回数据结构

状态码 **200**

| 名称                | 类型    | 约束 | 中文名         | 说明 |
|---------------------|---------|------|----------------|------|
| » data              | object  | true | none           | none |
| »» orderNo          | string  | true | 订单号         | none |
| »» cardInfo         | object  | true | 卡信息         | none |
| »»» cardId          | string  | true | 卡ID           | none |
| »»» productCode     | string  | true | 产品编码       | none |
| »»» productName     | string  | true | 产品名称       | none |
| »»» cardCurrency    | string  | true | 卡结算币种     | none |
| »»» maskCardNumber  | string  | true | 脱敏卡号       | none |
| »»» cardModel       | string  | true | 卡模式         | none |
| »» fee              | number  | true | 销卡费         | none |
| »» chargeMethodType | string  | true | 收费方式       | none |
| »» fixedValue       | number  | true | 固定值收费标准 | none |
| »» percent          | number  | true | 百分比收费标准 | none |
| »» note             | string  | true | 备注           | none |
| »» status           | string  | true | 订单状态       | none |
| »» orderType        | string  | true | 订单类型       | none |
| »» settleStatus     | string  | true | 结算状态       | none |
| »» failureReason    | string  | true | 失败原因       | none |
| »» createdOn        | string  | true | 订单创建时间   | none |
| »» completedOn      | string  | true | 订单完成时间   | none |
| » responseId        | string  | true | 响应ID         | none |
| » hasError          | boolean | true | 是否出错       | none |
| » errorCode         | string  | true | 错误码         | none |
| » errorMessage      | string  | true | 错误信息       | none | 名称            | 位置   | 类型   | 必选 | 说明                                                                                                                                             |
|-----------------|--------|--------|------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| OrderType       | query  | string | 是   | 订单类型: ApplyCard 开卡订单、CardTopUp 充值订单、CardCancel 销卡订单、CardBlock 卡冻结订单、CardUnBlock 卡解冻订单、CardWithdraw 卡余额转出订单 |
| OrderNo         | query  | string | 是   | 订单号。和商户订单号至少填写一个                                                                                                                 |
| CustomerOrderNo | query  | string | 否   | 商户订单号。和订单号至少填写一个                                                                                                                 |
| Accept          | header | string | 是   | none                                                                                                                                             |

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
            "amount": 0.1, "currency": "USD"
          },
          {
            "feeType": "TopUpFee",
            "amount": 0.1, "currency": "USD"
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

| 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   | 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 约束 | 说明              |
|---------------------|----------|-------|------|-------------------|
| » data              | object   | true  | none | none              |
| »» orderNo          | string   | true  | none | none              |
| »» productInfo      | object   | true  | none | none              |
| »»» productCode     | string   | true  | none | none              |
| »»» productName     | string   | true  | none | none              |
| »»» cardModel       | string   | true  | none | none              |
| »»» cardCurrency    | string   | true  | none | none              |
| »» totalTopUpAmount | number   | true  | none | none              |
| »» totalFee         | number   | true  | none | none              |
| »» totalPayAmount   | number   | true  | none | 总充值金额+总费用 |
| »» totalCardCount   | integer  | true  | none | none              |
| »» totalOpened      | integer  | true  | none | none              |
| »» orderLines       | [object] | true  | none | none              |
| »»» orderLineNo     | integer  | false | none | none              |
| »»» topUpAmount     | number   | false | none | none              |
| »»» quantity        | integer  | false | none | none              |
| »»» feeItems        | [object] | false | none | none              |
| »»»» feeType        | string   | true  | none | none              |
| »»»» amount         | number   | true  | none | none              |
| »»»» currency       | string   | true  | none | none              |
| »» cardInfos        | [object] | true  | none | none              |
| »»» cardId          | string   | false | none | none              |
| »»» productCode     | string   | false | none | none              |
| »»» productName     | string   | false | none | none              |
| »»» cardCurrency    | string   | false | none | none              |
| »»» maskCardNumber  | string   | false | none | none              |
| »»» cardModel       | string   | false | none | none              |
| »» status           | string   | true  | none | none              |
| »» payMessage       | string   | true  | none | none              |
| »» orderType        | string   | true  | none | none              |
| »» createdOn        | string   | true  | none | none              |
| »» modifiedOn       | string   | true  | none | none              |
| »» paidOn           | string   | true  | none | none              |
| »» completedOn      | string   | true  | none | none              |
| »» customerOrderNo  | string   | true  | none | none              |
| » responseId        | string   | true  | none | none              |
| » hasError          | boolean  | true  | none | none              |
| » errorCode         | string   | true  | none | none              |
| » errorMessage      | string   | true  | none | none              |

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

| 名称              | 位置   | 类型   | 必选 | 中文名 | 说明 |
|-------------------|--------|--------|------|--------|------|
| Content-Type      | header | string | 是   |        | none |
| Accept            | header | string | 是   |        | none |
| body              | body   | object | 否   |        | none |
| » productCode     | body   | string | 是   |        | none |
| » cardCurrency    | body   | string | 是   |        | none |
| » topUpAmount     | body   | string | 是   |        | none |
| » cardAlias       | body   | string | 是   |        | none |
| » customerOrderNo | body   | string | 是   |        | none |

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
            "amount": 0.1, "currency": "USD"
          },
          {
            "feeType": "TopUpFee",
            "amount": 0.1, "currency": "USD"
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
|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 约束 | 中文名       | 说明                                               |
|---------------------|----------|------|--------------|----------------------------------------------------| 
| » data              | object   | true | none         | none                                               |
| »» orderNo          | string   | true | 订单号       | none                                               |
| »» productInfo      | object   | true | 产品信息     | none                                               |
| »»» productCode     | string   | true | 产品编码     | none                                               |
| »»» productName     | string   | true | 产品名称     | none                                               |
| »»» cardModel       | string   | true | 卡模式       | none                                               |
| »»» cardCurrency    | string   | true | 卡结算币种   | none                                               |
| »» totalTopUpAmount | number   | true | 总充值金额   | none                                               |
| »» totalFee         | number   | true | 总费用       | none                                               |
| »» totalPayAmount   | number   | true | 总支付金额   | none                                               |
| »» totalCardCount   | integer  | true | 开卡数量     | none                                               |
| »» totalOpened      | integer  | true | 已开卡数     | none                                               |
| »» orderLines       | [object] | none | 订单明细     | none                                               |
| »»» orderLineNo     | integer  | none | 订单明细编号 | none                                               |
| »»» topUpAmount     | number   | none | 充值金额     | none                                               |
| »»» quantity        | integer  | none | 开卡数       | none                                               |
| »»» feeItems        | [object] | none | 费用明细     | none                                               |
| »»»» feeType        | string   | none | 费用类型     | none                                               |
| »»»» amount         | number   | none | 费用金额     | none                                               |
| »»»» currency       | string   | none | 费用币种     | none                                               |
| »» cardInfos        | [object] | none | 已开卡信息   | none                                               |
| »»» cardId          | string   | none | 卡ID         | none                                               |
| »»» productCode     | string   | none | 产品编码     | none                                               |
| »»» productName     | string   | none | 产品名称     | none                                               |
| »»» cardCurrency    | string   | none | 卡结算币种   | none                                               |
| »»» maskCardNumber  | string   | none | 脱敏卡号     | none                                               |
| »»» cardModel       | string   | none | 卡模式       | none                                               |
| »» status           | string   | none | 订单状态     | 处理中 Pending，已完成 Completed，处理失败 Failure |
| »» payMessage       | string   | none | 支付信息     | none                                               |
| »» orderType        | string   | none | 订单类型     | none                                               |
| »» createdOn        | string   | none | 订单创建时间 | none                                               |
| »» modifiedOn       | string   | none | 订单修改时间 | none                                               |
| »» paidOn           | string   | none | 支付时间     | none                                               |
| »» completedOn      | string   | none | 完成时间     | none                                               |
| »» customerOrderNo  | string   | none | 客户订单号   | none                                               |
| » responseId        | string   | none | 响应ID       | none                                               |
| » hasError          | boolean  | none | 是否有错误   | none                                               |
| » errorCode         | string   | none | 错误编码     | none                                               |
| » errorMessage      | string   | none | 错误信息     | none                                               |

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

| 名称              | 位置   | 中文名     | 说明 |
|-------------------|--------|--------|------------|------|
| Content-Type      | header | string |            | none |
| Accept            | header | string |            | none |
| body              | body   | object |            | none |
| » cardId          | body   | string | 卡ID       | none |
| » topUpAmount     | body   | string | 充值金额   | none |
| » customerOrderNo | body   | string | 客户订单号 | none |

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
            "amount": 0.1, "currency": "USD"
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

| 状态码 | 状态码含义                                                      | 说明 |
|--------|-----------------------------------------------------------------|------|----------|
| [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   | 名称                       | 类型     | 约束 | 中文名           | 说明                                               |
|----------------------------|----------|------|------------------|----------------------------------------------------|
| » data                     | object   | true | none             | none                                               |
| »» orderNo                 | string   | true | 订单号           | none                                               |
| »» productInfo             | object   | true | 产品信息         | none                                               |
| »»» productCode            | string   | true | 产品编号         | none                                               |
| »»» productName            | string   | true | 产品名称         | none                                               |
| »»» cardModel              | string   | true | 卡模式           | none                                               |
| »»» cardCurrency           | string   | true | 卡币种           | none                                               |
| »» totalTopUpAmount        | number   | true | 总充值金额       | none                                               |
| »» totalFee                | number   | true | 总费用           | none                                               |
| »» totalPayAmount          | number   | true | 总支付金额       | none                                               |
| »» totalCardCount          | integer  | true | 总充值卡数       | none                                               |
| »» totalCompletedCardCount | integer  | true | 总完成充值卡数数 | none                                               |
| [object] | true | none | 订单明细行       | none                                               |
| string   | true | none | 订单明细行号     | none                                               |
| object   | true | none | 卡信息           | none                                               |
| string   | true | none | 卡ID             | none                                               |
| string   | true | none | 产品编号         | none                                               |
| string   | true | none | 产品名称         | none                                               |
| string   | true | none | 卡结算币种       | none                                               |
| string   | true | none | 脱敏卡号         | none                                               |
| string   | true | none | 卡模式           | none                                               |
| string   | true | none | 充值金额         | none                                               |
| [object] | true | none | 费用明细         | none                                               |
| string   | true | none | 费用类型         | none                                               |
| number   | true | none | 费用金额         | none                                               |
| string   | true | none | 费用币种         | none                                               |
| string   | true | none | 是否已完充值     | none                                               |
| string   | true | none | 充值完成时间     | none                                               |
| string   | true | none | 订单状态         | 处理中 Pending，已完成 Completed，处理失败 Failure |
| string   | true | none | 支付信息         | none                                               |
| string   | true | none | 订单类型         | none                                               |
| string   | true | none | 订单创建时间     | none                                               |
| string   | true | none | 订单修改时间     | none                                               |
| string   | true | none | 订单支付时间     | none                                               |
| string   | true | none | 订单完成时间     | none                                               |
| string   | true | none | 客户订单号       | none                                               |
| string   | true | none | 响应Id           | none                                               |
| string   | true | none | 是否出错         | none                                               |
| string   | true | none | 错误码           | none                                               |
| string   | true | none | 错误信息         | none                                               |

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

| 位置   | 类型   | 中文名 | 说明 |
|-------------------|--------|------|--------|------|
| Content-Type      | string | 是   |        | none |
| Accept            | string | 是   |        | none |
| body              | object | 否   |        | none |
| » cardId          | string | 是   |        | none |
| » customerOrderNo | string | 否   |        | none |

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

| 状态码 | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 约束 | 中文名         |
|--------------------|--------|------|------|----------------|
| » data             | object | true | none |                |
| »» orderNo         | string | true | none | 订单号         |
| »» cardInfo        | object | true | none | 卡信息         |
| »»» cardId         | string | true | none | 卡ID           |
| »»» productCode    | string | true | none | 产品编号       |
| »»» productName    | string | true | none | 产品名称       |
| »»» cardCurrency   | string | true | none | 卡结算币种     |
| »»» maskCardNumber | string | true | none | 脱敏卡号       |
| »»» cardModel      | string | true | none | 卡模式         |
| »» note            | string | true | none | 备注信息       |
| »» isBlocked       | string | true | none | 卡是否已被锁定 |
| »» status          | string | true | none | 订单状态       |
| »» failureReason   | string | true | none | 失败原因       |
| »» orderType       | string | true | none | 订单类型       |
| »» createdOn       | string | true | none | 订单创建时间   |
| »» modifiedOn      | string | true | none | 订单修改时间   |
| »» completedOn     | string | true | none | 订单完成时间   |
| »» customerOrderNo | string | true | none | 客户订单号     |
| » responseId       | string | true | none | 响应ID         |
| » hasError         | string | true | none | 是否出错       |
| » errorCode        | string | true | none | 错误码         |
| » errorMessage     | string | true | none | 错误信息       |

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

| 名称              | 位置   | 类型   | 中文名 | 说明 |-------------------|--------|--------|------|--------|------| Content-Type      | header | string | 是   |        | none | Accept            | header | string | 是   |        | none | body              | body   | object | 否   |        | none | » cardId          | body   | string | 是   |        | none | » customerOrderNo | body   | string | 否   |        | none | 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | none |
| »» orderNo         | string  | true | 订单号       | none |
| »» cardInfo        | object  | true | 卡信息       | none |
| »»» cardId         | string  | true | 卡ID         | none |
| »»» productCode    | string  | true | 产品编码     | none |
| »»» productName    | string  | true | 产品名称     | none |
| »»» cardCurrency   | string  | true | 卡币种       | none |
| »»» maskCardNumber | string  | true | 脱敏卡号     | none |
| »»» cardModel      | string  | true | 卡模式       | none |
| »» note            | string  | true | 订单备注     | none |
| »» status          | string  | true | 订单状态     | none |
| »» failureReason   | string  | true | 失败原因     | none |
| »» orderType       | string  | true | 订单类型     | none |
| »» createdOn       | string  | true | 订单创建时间 | none |
| »» modifiedOn      | string  | true | 订单修改时间 | none |
| »» completedOn     | string  | true | 订单完成时间 | none |
| »» customerOrderNo | string  | true | 客户订单号   | none |
| » responseId       | string  | true | 响应ID       | none |
| » hasError         | boolean | true | 是否出错     | none |
| » errorCode        | string  | true | 错误码       | none |
| » errorMessage     | string  | true | 错误信息     | none |

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

| 名称              | 位置   | 类型   | 说明 |
|-------------------|--------|--------|------|------|
| Content-Type      | header | string | 是   | none |
| Accept            | header | string | 是   | none |
| body              | body   | object | 否   | none |
| » cardId          | body   | string | 是   | none |
| » customerOrderNo | body   | string | 否   | none |

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

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |--------|-----------------------------------------------------------------|------|----------|
| 200    | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 类型   | 约束 | 中文名         | 说明                                                           |
|---------------------|------|------|----------------|----------------------------------------------------------------|
| » data              | true | none |                | none                                                           |
| »» orderNo          | true | none | 订单号         | none                                                           |
| »» cardInfo         | true | none | 卡信息         | none                                                           |
| »»» cardId          | true | none | 卡ID           | none                                                           |
| »»» productCode     | true | none | 产品编码       | none                                                           |
| »»» productName     | true | none | 产品名称       | none                                                           |
| »»» cardCurrency    | true | none | 卡结算币种     | none                                                           |
| »»» maskCardNumber  | true | none | 脱敏卡号       | none                                                           |
| »»» cardModel       | true | none | 卡模式         | none                                                           |
| »» fee              | true | none | 销卡手续费     | none                                                           |
| »» chargeMethodType | true | none | 收费方式       | 包括：固定值 FixedValue，百分比 Percentage                     |
| »» fixedValue       | true | none | 固定值收费标准 | none                                                           |
| »» percent          | true | none | 百分比收费标准 | none                                                           |
| »» settleAmount     | true | none | 结算金额       | none                                                           |
| »» note             | true | none | 备注           | none                                                           |
| »» status           | true | none | 订单状态       | none                                                           |
| »» settleStatus     | true | none | 结算状态       | 包括：Pending 处理中 ，WaitTransfer 等待划拨，Completed 已完成 |
| »» orderType        | true | none | 订单类型       | none                                                           |
| »» failureReason    | true | none | 失败原因       | none                                                           |
| »» createdOn        | true | none | 订单创建时间   | none                                                           |
| »» completedOn      | true | none | 订单完成时间   | none                                                           |
| »» customerOrderNo  | true | none | 客户订单号     | none                                                           |
| » responseId        | true | none | 响应ID         | none                                                           |
| » hasError          | true | none | 是否出错       | none                                                           |
| » errorCode         | true | none | 错误码         | none                                                           |
| » errorMessage      | true | none | 错误信息       | none                                                           |

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

| 名称              | 类型   | 中文名     | 说明              |
|-------------------|--------|------|------------|-------------------|
| Content-Type      | header | 是   |            | none              |
| Accept            | header | 是   |            | none              |
| body              | body   | 否   |            | none              |
| » cardId          | body   | 是   | 卡ID       | none              |
| » withdrawAmount  | body   | 是   | 转出金额   | 转出金额必须大于0 |
| » customerOrderNo | body   | 否   | 客户订单号 | none              |

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

| 状态码 | 状态码含义                                                      | 数据模型 |
|--------|-----------------------------------------------------------------|------|----------| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 约束 | 中文名       | 说明              |--------------------|--------|-------|------|--------------|-------------------| » data             | object | true  | none |              | none              | »» orderNo         | string | true  | none | 订单号       | none              | »» cardId          | string | true  | none | 卡ID         | none              | »» withdrawAmount  | string | true  | none | 转出金额     | none              | »» withdrawFee     | string | true  | none | 转出费用     | none              | »» totalAmount     | string | true  | none | 总金额       | 转出金额+转出费用 | »» status          | string | true  | none | 订单状态     | none              | »» orderType       | string | true  | none | 订单类型     | none              | »» createdOn       | string | true  | none | 订单创建时间 | none              | »» modifiedOn      | string | true  | none | 订单修改时间 | none              | »» completedOn     | string | false | none | 订单完成时间 | none              | »» customerOrderNo | string | true  | none | 客户订单号   | none              | » responseId       | string | true  | none |              | none              | » hasError         | string | true  | none |              | none              | » errorCode        | string | true  | none |              | none              | » errorMessage     | string | true  | none |              | none              | 名称   | 位置   | 类型   | 中文名 | 说明            |
|--------|--------|------|--------|-----------------|
| path   | string | 是   |        | (Required) 卡ID |
| header | string | 是   |        | none            |

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

| 状态码含义                                                      | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   | 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型   | 约束 | 说明                                                                        |
|---------------------|--------|------|------|-----------------------------------------------------------------------------|
| » data              | object | true | none | none                                                                        |
| »» cardId           | string | true | none | 卡唯一ID                                                                    |
| »» cardModel        | string | true | none | 包括：标准模式 Standard ，共享余额 ShareBalance                             |
| »» productCode      | string | true | none | none                                                                        |
| »» cardNumber       | string | true | none | none                                                                        |
| »» cvv              | string | true | none | none                                                                        |
| »» expirationMMYY   | string | true | none | 例如 04/2028                                                                |
| »» cardCurrency     | string | true | none | none                                                                        |
| »» alias            | string | true | none | none                                                                        |
| »» balanceAmount    | string | true | none | none                                                                        |
| »» status           | string | true | none | 包括：Active 活跃，Blocked 已冻结，Cancel 已注销，Expired 已过期            |
| »» maxAuthAmount    | string | true | none | 仅在共享模式下可用                                                          |
| »» usedCreditAmount | string | true | none | 仅在共享模式下可用                                                          |
| »» maxCreditAmount  | string | true | none | 仅在共享模式下可用。值为空表示无限额度。                                    |
| »» cardOrganization | string | true | none | 包括：Mastercard  万事达卡， VISA ，AmericanExpress 美国运通，UnionPay 银联 |
| »» applyTime        | string | true | none | none                                                                        |
| » responseId        | string | true | none | none                                                                        |
| » hasError          | string | true | none | none                                                                        |
| » errorCode         | string | true | none | none                                                                        |
| » errorMessage      | string | true | none | none                                                                        |

# transactions

## GET 查询交易流水

GET /v1/transactions

### 请求参数

| 名称                | 位置   | 类型   | 中文名 |
|---------------------|--------|--------|------|--------|
| CardId              | query  | string | 是   |        |
| TransactionDateFrom | query  | string | 是   |        |
| TransactionDateTo   | query  | string | 是   |        |
| TransactionStatus   | query  | string | 是   |        |
| PageSize            | query  | string | 是   |        |
| PageCursor          | query  | string | 是   |        |
| Accept              | header | string | 是   |        |

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
|-----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                    | 约束 | 中文名         | 说明                                                                                                                                                                                         |
|-------------------------|----------|------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data                  | object   | none |                | none                                                                                                                                                                                         |
| »» pageCursor           | string   | none |                | none                                                                                                                                                                                         |
| »» pageSize             | string   | none |                | none                                                                                                                                                                                         |
| »» data                 | [object] | none |                | none                                                                                                                                                                                         |
| »»» id                  | string   | none | 交易ID         | none                                                                                                                                                                                         |
| »»» authTime            | string   | none | 预授权时间     | none                                                                                                                                                                                         |
| »»» settleTime          | string   | none | 清算时间       | 入账后，返回清算时间                                                                                                                                                                         |
| »»» transAmount         | object   | none | 原始交易金额   | none                                                                                                                                                                                         |
| »»»» currency           | string   | none | 原始交易币种   | none                                                                                                                                                                                         |
| »»»» amount             | string   | none | 原始交易金额值 | none                                                                                                                                                                                         |
| »»» authAmount          | object   | none | 预授权金额     | none                                                                                                                                                                                         |
| »»»» currency           | string   | none | 预授权币种     | none                                                                                                                                                                                         |
| »»»» amount             | string   | none | 预授权金额值   | none                                                                                                                                                                                         |
| »»» settledAmount       | object   | none | 结算金额       | 入账后，返回结算金额                                                                                                                                                                         |
| »»»» currency           | string   | none | 结算币种       | none                                                                                                                                                                                         |
| »»»» amount             | string   | none | 结算金额值     | none                                                                                                                                                                                         |
| »»» cardInfo            | object   | none | 卡信息         | none                                                                                                                                                                                         |
| »»»» cardId             | string   | none | 卡ID           | none                                                                                                                                                                                         |
| »»»» productCode        | string   | none | 产品编码       | none                                                                                                                                                                                         |
| »»»» productName        | string   | none | 产品名称       | none                                                                                                                                                                                         |
| »»»» cardCurrency       | string   | none | 卡结算币种     | none                                                                                                                                                                                         |
| »»»» maskCardNumber     | string   | none | 脱敏卡号       | none                                                                                                                                                                                         |
| »»»» cardModel          | string   | none | 卡模式         | none                                                                                                                                                                                         |
| »»» cardAlias           | string   | none | 卡别名         | none                                                                                                                                                                                         |
| »»» authCode            | string   | none | 授权码         | none                                                                                                                                                                                         |
| »»» merchantName        | string   | none | 商户名称       | none                                                                                                                                                                                         |
| »»» merchantCountryCode | string   | none | 商户国家代码   | none                                                                                                                                                                                         |
| »»» merchantCity        | string   | none | 商户所在城市   | none                                                                                                                                                                                         |
| »»» merchantState       | string   | none | 商户所在州     | none                                                                                                                                                                                         |
| »»» merchantZipCode     | string   | none | 商户邮编       | none                                                                                                                                                                                         |
| »»» merchantDesc        | string   | none | 商户描述       | none                                                                                                                                                                                         |
| »»» status              | string   | none | 交易状态       | 包括AuthSuccess 预授权成功，AuthFailure 预授权失败，Settled 已入账                                                                                                                           |
| »»» fundsDirection      | string   | none | 资金方向       | Income: 收入 Expenditure: 支出                                                                                                                                                               |
| »»» transactionType     | string   | none | 交易类型       | Consume 消费, ConsumeRefund 消费退款,DisputeRelease 消费争议, DisputeRelease 争议释放,ConsumeReversal 取消消费, ConsumeRefundReversal 消费退款冲正,AuthQuery 预授权查询, TransFee 交易手续费 |
| »»» failureReason       | string   | none | 失败原因       | none                                                                                                                                                                                         |
| »»» failureReasonCn     | string   | none | 中文失败原因   | none                                                                                                                                                                                         |
| »»» note                | string   | none | 备注           | none                                                                                                                                                                                         |
| » responseId            | string   | none | 响应ID         | none                                                                                                                                                                                         |
| » hasError              | string   | none | 是否出错       | none                                                                                                                                                                                         |
| » errorCode             | string   | none | 错误码         | none                                                                                                                                                                                         |
| » errorMessage          | string   | none | 错误信息       | none                                                                                                                                                                                         |

# accounts

## GET 获取客户资金账户余额信息

GET /v1/accounts

### 请求参数

| 名称   | 位置   | 中文名 | 说明 |
|--------|--------|--------|--------|------|
| Accept | header | string |        | none |

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

| 状态码 | 状态码含义                                                      | 说明 |
|--------|-----------------------------------------------------------------|------|----------|
| [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   | 名称           | 类型     | 约束 | 中文名       | 说明 |
|----------|------|------|--------------|------|
| [object] | true | none |              | none |
| string   | true | none | 账户币种     | none |
| string   | true | none | 账户可用金额 | none |
| string   | true | none | 响应ID       | none |
| string   | true | none | 是否出错     | none |
| string   | true | none | 错误码       | none |
| string   | true | none | 错误原因     | none |

# accounts/cardAccountLogs

## GET 【标准模式】分页查询卡资金明细（不含交易流水）

GET /v1/accounts/cardAccountLogs

### 请求参数

| 位置   | 类型   | 中文名 | 说明                              |
|---------------------|--------|------|--------|-----------------------------------|
| CardId              | string | 是   |        | 卡ID                              |
| TransactionDateFrom | string | 是   |        | 开始交易日期                      |
| TransactionDateTo   | string | 是   |        | 结束交易日期                      |
| Limit               | string | 否   |        | 返回数据条数，默认20条            |
| Offset              | string | 否   |        | 偏移数据条数。为空默认为0(第一页) |
| Accept              | string | 是   |        | none                              |

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
            "amount": 0.1, "currency": "USD"
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
            "amount": 0.1, "currency": "USD"
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
            "amount": 0.1, "currency": "USD"
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
            "amount": 0.1, "currency": "USD"
          },
          {
            "feeType": "TopUpFee",
            "amount": 0.1, "currency": "USD"
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

| 状态码 | 说明 | 数据模型 |
|--------|-----------------------------------------------------------------|------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称                   | 类型     | 约束 | 中文名             |
|------------------------|----------|------|------|--------------------|
| » data                 | object   | true | none |                    |
| »» pageNumber          | string   | true | none | 页号               |
| »» pageSize            | string   | true | none | 每页数据行数       |
| »» totalRecords        | string   | true | none | 总记录数           |
| »» totalPages          | string   | true | none | 总页数             |
| »» data                | [object] | true | none |                    |
| »»» accountLogId       | string   | true | none | 账户明细ID         |
| »»» cardOrderNo        | string   | true | none | 批次订单号         |
| »»» cardAccountLogType | string   | true | none | 卡账户交易明细类型 |
| »»» cardInfo           | object   | true | none | 卡信息             |
| »»»» cardId            | string   | true | none | 卡ID               |
| »»»» productCode       | string   | true | none | 产品编码           |
| »»»» productName       | string   | true | none | 产品名称           |
| »»»» cardCurrency      | string   | true | none | 卡结算币种         |
| »»»» maskCardNumber    | string   | true | none | 脱敏卡号           |
| »»»» cardModel         | string   | true | none | 卡模式             |
| »»» fundsDirection     | string   | true | none | 资金方向           |
| »»» transAmount        | object   | true | none | 交易金额信息       |
| »»»» currency          | string   | true | none | 交易币种           |
| »»»» amount            | string   | true | none | 交易金额           |
| »»» totalFee           | object   | true | none | 总手续费信息       |
| »»»» currency          | string   | true | none | 总手续费币种       |
| »»»» amount            | string   | true | none | 总手续费金额       |
| »»» feeItems           | [object] | true | none | 费用明细           |
| »»»» feeType           | string   | true | none | 费用类型           |
| »»»» amount            | number   | true | none | 费用金额           |
| »»»» currency          | string   | true | none | 费用币种           |
| »»» totalAmount        | object   | true | none | 总金额信息         |
| »»»» currency          | string   | true | none | 总金额币种         |
| »»»» amount            | string   | true | none | 总金额金额         |
| »»» status             | string   | true | none | 状态               |
| »»» failureReason      | string   | true | none | 失败原因           |
| »»» transTime          | string   | true | none | 交易时间           |
| »»» completedTime      | string   | true | none | 完成时间           |
| »»» note               | string   | true | none | 备注               |
| » responseId           | string   | true | none | 响应ID             |
| » hasError             | string   | true | none | 是否出错           |
| » errorCode            | string   | true | none | 错误码             |
| » errorMessage         | string   | true | none | 错误信息           |

# accounts/accountLogs

## GET 分页查询 资金账户资金明细

GET /v1/accounts/accountLogs

### 请求参数

| 名称                | 位置   | 类型   | 中文名 | 说明                                |---------------------|--------|--------|------|--------|-------------------------------------| TransactionDateFrom | query  | string | 是   |        | 开始交易日期                        | TransactionDateTo   | query  | string | 是   |        | 结束交易日期                        | Limit               | query  | string | 是   |        | 返回数据条数，为空默认20条          | Offset              | query  | string | 是   |        | 偏移数据条数。为空默认为0（第一页） | Accept              | header | string | 是   |        | none                                | 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | none |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                 | 类型     | 中文名         | 说明                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------|----------|------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data               | object   | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» pageNumber        | string   | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» pageSize          | string   | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» totalRecords      | string   | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» totalPages        | string   | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »» data              | [object] | true |                | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» id               | string   | true | 流水号         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» accountTransType | string   | true | 交易类型       | AccountTopUp 账户转入资金，AccountWithdraw 账户转出资金，AuthBlock  授权冻结，AuthUnBlock 授权解冻，AuthReversal 授权取消，Consume 消费，ConsumeRefund 消费退款，OpenCardFee 开卡手续费，TransFee 交易手续费，CancelCardFee 销卡手续费， Rebate 返利，ReversalRefund 冲账退回，ReversalDeduct 冲账扣除，ConsumeSettlementDiffDeduct 消费清算差额-扣除，ConsumeSettlementDiffRefund 消费清算差额-退回，AccountTopUpFee 账户转入手续费，AccountWithdrawFee 账户转出手续费，CardTopUp 卡转入资金，TopUpFee 卡转入手续费，CardWithdraw 卡转出资金，CancelCardSettleDeduct 销卡结算-扣除，CancelCardSettleRefund 销卡结算-退回，AccountAdjustIncrease 账户调增，AccountAdjustDeduct 账户调减，CardOverdrawDeduct 标准卡透支扣除，<br />CardOverdrawReversal 标准卡透支冲正 |
| »»» fundsDirection   | string   | true | 资金方向       | Income 收入，Expenditure 支出                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| »»» currency         | string   | true | 账户币种       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» transAmount      | string   | true | 交易金额       | 分正负号                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| »»» availableBalance | string   | true | 调整后可用余额 | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» blockedBalance   | string   | true | 调整后冻结余额 | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» orderNo          | string   | true | 关联订单号     | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» note             | string   | true | 备注           | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» cardInfo         | object   | true | 卡信息         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardId          | string   | true | 卡ID           | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» productCode     | string   | true | 产品编码       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» productName     | string   | true | 产品名称       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardCurrency    | string   | true | 卡结算币种     | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» maskCardNumber  | string   | true | 脱敏卡号       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»»» cardModel       | string   | true | 卡模式         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| »»» transTime        | string   | true | 交易时间       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » responseId         | string   | true | 响应ID         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » hasError           | string   | true | 是否出错       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » errorCode          | string   | true | 错误码         | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| » errorMessage       | string   | true | 错误信息       | none                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

# 数据模型

