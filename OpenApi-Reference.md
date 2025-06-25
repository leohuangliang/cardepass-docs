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

| 名称            | 位置 | 类型   | 说明                                  |
|-----------------|------|--------|---------------------------------------|
| body | body | object | HTTP请求的主体内容 |
| » grant_type    | body | string | 固定值                                |
| » client_id     | body | string | client_id 请联系cardepass 获取        |
| » client_secret | body | string | client_secret 秘钥请联系cardepass获取 |
| » redirect_uri  | body | string | 请参考API文档 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1) | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称           | 类型    | 中文名       | 说明                                                                                                                 |
|----------------|---------|--------------|----------------------------------------------------------------------------------------------------------------------|
| » access_token | string  | 访问令牌     | 调用业务API时需要此访问令牌                                                                                          |
| » expires_in   | integer | 令牌过期时间 | 时间单位为秒，默认令牌过期时间为3600秒=1小时。客户端可以缓存此令牌。注意：获取新令牌，老令牌在有效期内仍然可以使用。 |
| » token_type   | string  | 令牌类型     | 默认返回Bearer                                                                                                       |
| » scope        | string  | 域           | 默认返回 card                                                                                                        |

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
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 请求参数

| 名称   | 位置   | 类型   | 说明 |
|--------|--------|--------|------|
| Accept | header | string | 客户端可接受的响应媒体类型 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称            | 类型     | 中文名     | 说明       |
|-----------------|----------|------------|------------|
| » data          | [object] | 请参考API文档 | 请参考API文档 |
| »» productCode  | string   | 产品编码 | 卡片产品的代码标识 |
| »» productName  | string   | 产品名称 | 卡片产品的名称描述 |
| »» cardModels   | [string] | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» cardCurrency | [string] | 卡结算币种 | 卡片使用的货币类型 |
| »» description  | string   | 产品描述   | 请参考API文档 |
| » responseId    | string   | 响应Id     | 请参考API文档 |
| » hasError      | boolean  | 是否有错误 | 请参考API文档 |
| » errorCode     | string   | 错误码 | 具体的错误代码标识 |
| » errorMessage  | string   | 错误信息 | 详细的错误描述信息 |

### 请求参数

| 名称            | 位置   | 类型   | 说明                         |
|-----------------|--------|--------|------------------------------|
| OrderType       | query  | string | 订单类型:                    |
| OrderNo         | query  | string | 订单号。和客户订单号必选其一 |
| CustomerOrderNo | query  | string | 客户订单号。和订单号必选其一 |
| Accept | header | string | 客户端可接受的响应媒体类型 |

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
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型     | 中文名         | 说明                                               |
|--------------------|----------|----------------|----------------------------------------------------|
| » data             | object   |                | 请参考API文档 |
| »» orderNo         | string   | 订单编号 | 系统生成的订单编号 |
| »» productInfo     | object   | 产品信息 | 卡片产品的详细信息 |
| »»» productCode    | string   | 产品编码 | 卡片产品的代码标识 |
| »»» productName    | string   | 产品名称 | 卡片产品的名称描述 |
| »»» cardModel      | string   | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» cardCurrency   | string   | 卡结算币种 | 卡片使用的货币类型 |
| »» quantity        | integer  | 申请开卡卡数 | 申请开卡的数量 |
| »» maxAuthAmount   | number   | 单笔限额 | 单次交易的最大金额限制 |
| »» maxCreditAmount | number   | 单卡消费总额度 | 可以为空，为空表示无限额度                         |
| »» totalAmount     | number   | 总交易金额 | 订单的总金额 |
| »» transAmount     | number   | 交易金额 | 实际交易金额 |
| »» transFee        | number   | 交易手续费 | 交易产生的手续费 |
| »» openedQty       | integer  | 已开卡数 | 已成功开卡的数量 |
| »» cardInfos       | [object] | 已开卡信息 | 多张卡片的信息列表 |
| »»» cardId         | string   | 卡ID | 卡片的唯一标识符 |
| »»» productCode    | string   | 产品编码 | 卡片产品的代码标识 |
| »»» productName    | string   | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency   | string   | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber | string   | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel      | string   | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» note            | string   | 备注           | 请参考API文档 |
| »» status          | string   | 订单状态       | Pending 处理中，Completed 已完成，Failure 处理失败 |
| »» orderType       | string   | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn       | string   | 订单创建时间   | 请参考API文档 |
| »» modifiedOn      | string   | 订单修改时间   | 请参考API文档 |
| »» completedOn     | string   | 订单完成时间   | 请参考API文档 |
| »» customerOrderNo | string   | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId       | string   | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError         | boolean  | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode        | string   | 错误码 | 具体的错误代码标识 |
| » errorMessage     | string   | 错误信息 | 详细的错误描述信息 |

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

| 名称              | 位置   | 类型   | 中文名         | 说明                       |
|-------------------|--------|--------|----------------|----------------------------|
| Content-Type      | header | string |                | 请参考API文档 |
| Accept            | header | string |                | 请参考API文档 |
| body              | body | object |                | HTTP请求的主体内容 |
| » productCode     | body | string | 产品代码       | HTTP请求的主体内容 |
| » cardCurrency    | body | string | 卡结算币种     | HTTP请求的主体内容 |
| » maxAuthAmount   | body | string | 单笔限额       | HTTP请求的主体内容 |
| » maxCreditAmount | body   | string | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| » cardAlias       | body | string | 卡别名         | HTTP请求的主体内容 |
| » customerOrderNo | body | string | 客户订单号     | HTTP请求的主体内容 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型     | 中文名         | 说明                       |
|------------------|----------|----------------|----------------------------|
| » data             | object   | 请参考API文档 | 请参考API文档 |
| »» orderNo         | string   | 订单号         | 请参考API文档 |
| »» productInfo     | object   | 产品信息 | 卡片产品的详细信息 |
| »»» productCode    | string   | 产品代码       | 请参考API文档 |
| »»» productName    | string   | 产品名称 | 卡片产品的名称描述 |
| »»» cardModel      | string   | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» cardCurrency   | string   | 卡结算币种 | 卡片使用的货币类型 |
| »» quantity        | integer  | 开卡数量       | 请参考API文档 |
| »» maxAuthAmount   | number   | 单笔限额 | 单次交易的最大金额限制 |
| »» maxCreditAmount | number   | 单卡消费总额度 | 可以为空，为空表示无限额度 |
| »» totalAmount     | number   | 总金额         | 请参考API文档 |
| »» transAmount     | number   | 交易实际金额   | 请参考API文档 |
| »» transFee        | number   | 交易手续费 | 交易产生的手续费 |
| »» openedQty       | integer  | 已开卡数 | 已成功开卡的数量 |
| »» cardInfos       | [object] | 卡信息         | 请参考API文档 |
| »» note            | string   | 备注           | 请参考API文档 |
| »» status          | string   | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» orderType       | string   | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn       | string   | 订单创建时间   | 请参考API文档 |
| »» modifiedOn      | string   | 订单修改时间   | 请参考API文档 |
| »» completedOn     | string   | 订单完成时间   | 请参考API文档 |
| »» customerOrderNo | string   | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId       | string   | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError         | boolean  | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode        | string   | 错误码 | 具体的错误代码标识 |
| » errorMessage     | string   | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | string | 是   | 请参考API文档 | 请参考API文档 |
| Accept            | header | string | 是   | 请参考API文档 | 请参考API文档 |
| body              | body | object | 否   | HTTP请求的主体内容 | 请参考API文档 |
| » cardId          | body   | string | 是   | 卡ID | 卡片的唯一标识符 |
| » customerOrderNo | body   | string | 否   | 客户订单号 | 客户系统生成的订单编号（可选） |
| » maxAuthAmount   | body   | string | 是   | 单笔限额 | 单次交易的最大金额限制 |
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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 约束 | 中文名       |
|--------------------|---------|------|------|--------------|
| » data             | object  | true | 请参考API文档 |              |
| »» orderNo         | string  | true | 请参考API文档 | 订单号       |
| »» cardId          | string  | true | 请参考API文档 | 卡ID         |
| »» maxAuthAmount   | number  | true | 请参考API文档 | 单笔限额     |
| »» maxCreditAmount | number  | true | 请参考API文档 | 单卡消费额度 |
| »» status          | string  | true | 请参考API文档 | 订单状态     |
| »» orderType       | string  | true | 请参考API文档 | 订单类型     |
| »» failureReason   | string  | true | 请参考API文档 | 失败原因     |
| »» createdOn       | string  | true | 请参考API文档 | 订单创建时间 |
| »» completedOn     | string  | true | 请参考API文档 | 订单完成时间 |
| »» customerOrderNo | string  | true | 请参考API文档 | 客户订单号   |
| » responseId       | string  | true | 请参考API文档 | 响应ID       |
| » hasError         | boolean | true | 请参考API文档 | 是否出错     |
| » errorCode        | string  | true | 请参考API文档 | 错误码       |
| » errorMessage     | string  | true | 请参考API文档 | 错误信息     |

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
| Content-Type      | header | string | 是   |            | 请参考API文档 |
| Accept            | header | string | 是   |            | 请参考API文档 |
| body              | body   | object | 否   |            | 请参考API文档 |
| » cardId          | body   | string | 是   | 卡ID | 卡片的唯一标识符 |
| » customerOrderNo | body   | string | 否   | 客户订单号 | 客户系统生成的订单编号（可选） |

### 返回结果

| 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|----------------------------------------------------------------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | 请参考API文档 |
| »» orderNo         | string  | true | 订单号       | 请参考API文档 |
| »» cardInfo        | object  | true | 卡信息       | 请参考API文档 |
| »»» cardId         | string  | true | 卡ID | 卡片的唯一标识符 |
| »»» productCode    | string  | true | 产品编码 | 卡片产品的代码标识 |
| »»» productName    | string  | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency   | string  | true | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber | string  | true | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel      | string  | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» note            | string  | true | 备注         | 请参考API文档 |
| »» isBlocked       | boolean | true | 是否被冻结   | 请参考API文档 |
| »» status          | string  | true | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» failureReason   | string  | true | 错误原因     | 请参考API文档 |
| »» orderType       | string  | true | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn       | string  | true | 订单创建时间 | 请参考API文档 |
| »» modifiedOn      | string  | true | 订单修改时间 | 请参考API文档 |
| »» completedOn     | string  | true | 订单完成时间 | 请参考API文档 |
| »» customerOrderNo | string  | true | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId       | string  | true | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError         | boolean | true | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode        | string  | true | 错误码 | 具体的错误代码标识 |
| » errorMessage     | string  | true | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | string | 是   | 请参考API文档 |
| Accept            | header | string | 是   | 请参考API文档 |
| body              | body | object | 否   | HTTP请求的主体内容 |
| » cardId          | body | string | 是   | HTTP请求的主体内容 |
| » customerOrderNo | body | string | 否   | HTTP请求的主体内容 |

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
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 约束 | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | 请参考API文档 |
| »» orderNo         | string  | true | 订单号       | 请参考API文档 |
| »» cardInfo        | object  | true | 卡信息       | 请参考API文档 |
| »»» cardId         | string  | true | 卡ID | 卡片的唯一标识符 |
| »»» productCode    | string  | true | 产品编码 | 卡片产品的代码标识 |
| »»» productName    | string  | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency   | string  | true | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber | string  | true | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel      | string  | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» note            | string  | true | 备注         | 请参考API文档 |
| »» status          | string  | true | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» failureReason   | string  | true | 失败原因     | 请参考API文档 |
| »» orderType       | string  | true | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn       | string  | true | 订单创建时间 | 请参考API文档 |
| »» modifiedOn      | string  | true | 订单修改时间 | 请参考API文档 |
| »» completedOn     | string  | true | 订单完成时间 | 请参考API文档 |
| »» customerOrderNo | string  | true | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId       | string  | true | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError         | boolean | true | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode        | string  | true | 错误码 | 具体的错误代码标识 |
| » errorMessage     | string  | true | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | string | 是   |            | 请参考API文档 |
| Accept            | header | string | 是   |            | 请参考API文档 |
| body              | body   | object | 否   |            | 请参考API文档 |
| » cardId          | body   | string | 是   | 卡ID | 卡片的唯一标识符 |
| » customerOrderNo | body   | string | 否   | 客户订单号 | 客户系统生成的订单编号（可选） |

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
|--------|-----------------------------------------------------------------|------|----------| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| 401    | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 |

### 返回数据结构

状态码 **200**

| 名称                | 类型    | 约束 | 中文名         | 说明 |
|---------------------|---------|------|----------------|------|
| » data              | object  | true | 请参考API文档 | 请参考API文档 |
| »» orderNo          | string  | true | 订单号         | 请参考API文档 |
| »» cardInfo         | object  | true | 卡信息         | 请参考API文档 |
| »»» cardId          | string  | true | 卡ID | 卡片的唯一标识符 |
| »»» productCode     | string  | true | 产品编码 | 卡片产品的代码标识 |
| »»» productName     | string  | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency    | string  | true | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber  | string  | true | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel       | string  | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» fee              | number  | true | 销卡费         | 请参考API文档 |
| »» chargeMethodType | string  | true | 收费方式       | 请参考API文档 |
| »» fixedValue       | number  | true | 固定值收费标准 | 请参考API文档 |
| »» percent          | number  | true | 百分比收费标准 | 请参考API文档 |
| »» note             | string  | true | 备注           | 请参考API文档 |
| »» status           | string  | true | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» orderType        | string  | true | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» settleStatus     | string  | true | 结算状态       | 请参考API文档 |
| »» failureReason    | string  | true | 失败原因       | 请参考API文档 |
| »» createdOn        | string  | true | 订单创建时间   | 请参考API文档 |
| »» completedOn      | string  | true | 订单完成时间   | 请参考API文档 |
| » responseId        | string  | true | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError          | boolean | true | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode         | string  | true | 错误码 | 具体的错误代码标识 |
| » errorMessage      | string  | true | 错误信息 | 详细的错误描述信息 | 名称            | 位置   | 类型   | 必选 | 说明                                                                                                                                             |
|-----------------|--------|--------|------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| OrderType       | query  | string | 是   | 订单类型: ApplyCard 开卡订单、CardTopUp 充值订单、CardCancel 销卡订单、CardBlock 卡冻结订单、CardUnBlock 卡解冻订单、CardWithdraw 卡余额转出订单 |
| OrderNo         | query  | string | 是   | 订单号。和商户订单号至少填写一个                                                                                                                 |
| CustomerOrderNo | query  | string | 否   | 商户订单号。和订单号至少填写一个                                                                                                                 |
| Accept          | header | string | 是   | 请参考API文档 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   | 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| 403    | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 约束 | 说明              |
|---------------------|----------|-------|------|-------------------|
| » data              | object   | true  | 请参考API文档 | 请参考API文档 |
| »» orderNo          | string   | true  | 请参考API文档 | 请参考API文档 |
| »» productInfo      | object   | true  | 请参考API文档 | 请参考API文档 |
| »»» productCode     | string   | true  | 请参考API文档 | 请参考API文档 |
| »»» productName     | string   | true  | 请参考API文档 | 请参考API文档 |
| »»» cardModel       | string   | true  | 请参考API文档 | 请参考API文档 |
| »»» cardCurrency    | string   | true  | 请参考API文档 | 请参考API文档 |
| »» totalTopUpAmount | number   | true  | 请参考API文档 | 请参考API文档 |
| »» totalFee         | number   | true  | 请参考API文档 | 请参考API文档 |
| »» totalPayAmount   | number   | true  | 请参考API文档 | 总充值金额+总费用 |
| »» totalCardCount   | integer  | true  | 请参考API文档 | 请参考API文档 |
| »» totalOpened      | integer  | true  | 请参考API文档 | 请参考API文档 |
| »» orderLines       | [object] | true  | 请参考API文档 | 请参考API文档 |
| »»» orderLineNo     | integer  | false | 请参考API文档 | 请参考API文档 |
| »»» topUpAmount     | number   | false | 请参考API文档 | 请参考API文档 |
| »»» quantity        | integer  | false | 请参考API文档 | 请参考API文档 |
| »»» feeItems        | [object] | false | 请参考API文档 | 请参考API文档 |
| »»»» feeType        | string   | true  | 请参考API文档 | 请参考API文档 |
| »»»» amount         | number   | true  | 请参考API文档 | 请参考API文档 |
| »»»» currency       | string   | true  | 请参考API文档 | 请参考API文档 |
| »» cardInfos        | [object] | true  | 请参考API文档 | 请参考API文档 |
| »»» cardId          | string   | false | 请参考API文档 | 请参考API文档 |
| »»» productCode     | string   | false | 请参考API文档 | 请参考API文档 |
| »»» productName     | string   | false | 请参考API文档 | 请参考API文档 |
| »»» cardCurrency    | string   | false | 请参考API文档 | 请参考API文档 |
| »»» maskCardNumber  | string   | false | 请参考API文档 | 请参考API文档 |
| »»» cardModel       | string   | false | 请参考API文档 | 请参考API文档 |
| »» status           | string   | true  | 请参考API文档 | 请参考API文档 |
| »» payMessage       | string   | true  | 请参考API文档 | 请参考API文档 |
| »» orderType        | string   | true  | 请参考API文档 | 请参考API文档 |
| »» createdOn        | string   | true  | 请参考API文档 | 请参考API文档 |
| »» modifiedOn       | string   | true  | 请参考API文档 | 请参考API文档 |
| »» paidOn           | string   | true  | 请参考API文档 | 请参考API文档 |
| »» completedOn      | string   | true  | 请参考API文档 | 请参考API文档 |
| »» customerOrderNo  | string   | true  | 请参考API文档 | 请参考API文档 |
| » responseId        | string   | true  | 请参考API文档 | 请参考API文档 |
| » hasError          | boolean  | true  | 请参考API文档 | 请参考API文档 |
| » errorCode         | string   | true  | 请参考API文档 | 请参考API文档 |
| » errorMessage      | string   | true  | 请参考API文档 | 请参考API文档 |

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
| Content-Type      | header | string | 是   |        | 请参考API文档 |
| Accept            | header | string | 是   |        | 请参考API文档 |
| body              | body   | object | 否   |        | 请参考API文档 |
| » productCode     | body   | string | 是   |        | 请参考API文档 |
| » cardCurrency    | body   | string | 是   |        | 请参考API文档 |
| » topUpAmount     | body   | string | 是   |        | 请参考API文档 |
| » cardAlias       | body   | string | 是   |        | 请参考API文档 |
| » customerOrderNo | body   | string | 是   |        | 请参考API文档 |

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
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型     | 约束 | 中文名       | 说明                                               |
|---------------------|----------|------|--------------|----------------------------------------------------| 
| » data              | object   | true | 请参考API文档 | 请参考API文档 |
| »» orderNo          | string   | true | 订单号       | 请参考API文档 |
| »» productInfo      | object   | true | 产品信息 | 卡片产品的详细信息 |
| »»» productCode     | string   | true | 产品编码 | 卡片产品的代码标识 |
| »»» productName     | string   | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardModel       | string   | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» cardCurrency    | string   | true | 卡结算币种 | 卡片使用的货币类型 |
| »» totalTopUpAmount | number   | true | 总充值金额   | 请参考API文档 |
| »» totalFee         | number   | true | 总费用       | 请参考API文档 |
| »» totalPayAmount   | number   | true | 总支付金额   | 请参考API文档 |
| »» totalCardCount   | integer  | true | 开卡数量     | 请参考API文档 |
| »» totalOpened      | integer  | true | 已开卡数 | 已成功开卡的数量 |
| »» orderLines       | [object] | 请参考API文档 | 订单明细     | 请参考API文档 |
| »»» orderLineNo     | integer  | 请参考API文档 | 订单明细编号 | 请参考API文档 |
| »»» topUpAmount     | number   | 请参考API文档 | 充值金额     | 请参考API文档 |
| »»» quantity        | integer  | 请参考API文档 | 开卡数       | 请参考API文档 |
| »»» feeItems        | [object] | 请参考API文档 | 费用明细     | 请参考API文档 |
| »»»» feeType        | string   | 请参考API文档 | 费用类型     | 请参考API文档 |
| »»»» amount         | number   | 请参考API文档 | 费用金额     | 请参考API文档 |
| »»»» currency       | string   | 请参考API文档 | 费用币种     | 请参考API文档 |
| »» cardInfos        | [object] | 请参考API文档 | 已开卡信息 | 多张卡片的信息列表 |
| »»» cardId          | string   | 请参考API文档 | 卡ID | 卡片的唯一标识符 |
| »»» productCode     | string   | 请参考API文档 | 产品编码 | 卡片产品的代码标识 |
| »»» productName     | string   | 请参考API文档 | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency    | string   | 请参考API文档 | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber  | string   | 请参考API文档 | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel       | string   | 请参考API文档 | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» status           | string   | 请参考API文档 | 订单状态     | 处理中 Pending，已完成 Completed，处理失败 Failure |
| »» payMessage       | string   | 请参考API文档 | 支付信息     | 请参考API文档 |
| »» orderType        | string   | 请参考API文档 | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn        | string   | 请参考API文档 | 订单创建时间 | 请参考API文档 |
| »» modifiedOn       | string   | 请参考API文档 | 订单修改时间 | 请参考API文档 |
| »» paidOn           | string   | 请参考API文档 | 支付时间     | 请参考API文档 |
| »» completedOn      | string   | 请参考API文档 | 完成时间 | 订单完成处理的时间戳 |
| »» customerOrderNo  | string   | 请参考API文档 | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId        | string   | 请参考API文档 | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError          | boolean  | 请参考API文档 | 是否有错误   | 请参考API文档 |
| » errorCode         | string   | 请参考API文档 | 错误编码     | 请参考API文档 |
| » errorMessage      | string   | 请参考API文档 | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | string |            | 请参考API文档 |
| Accept            | header | string |            | 请参考API文档 |
| body              | body | object |            | HTTP请求的主体内容 |
| » cardId          | body | string | 卡ID       | HTTP请求的主体内容 |
| » topUpAmount     | body | string | 充值金额   | HTTP请求的主体内容 |
| » customerOrderNo | body | string | 客户订单号 | HTTP请求的主体内容 |

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
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   | 名称                       | 类型     | 约束 | 中文名           | 说明                                               |
|----------------------------|----------|------|------------------|----------------------------------------------------|
| » data                     | object   | true | 请参考API文档 | 请参考API文档 |
| »» orderNo                 | string   | true | 订单号           | 请参考API文档 |
| »» productInfo             | object   | true | 产品信息 | 卡片产品的详细信息 |
| »»» productCode            | string   | true | 产品编号         | 请参考API文档 |
| »»» productName            | string   | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardModel              | string   | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» cardCurrency           | string   | true | 卡币种           | 请参考API文档 |
| »» totalTopUpAmount        | number   | true | 总充值金额       | 请参考API文档 |
| »» totalFee                | number   | true | 总费用           | 请参考API文档 |
| »» totalPayAmount          | number   | true | 总支付金额       | 请参考API文档 |
| »» totalCardCount          | integer  | true | 总充值卡数       | 请参考API文档 |
| »» totalCompletedCardCount | integer  | true | 总完成充值卡数数 | 请参考API文档 |
| [object] | true | 请参考API文档 | 订单明细行       | 请参考API文档 |
| string   | true | 请参考API文档 | 订单明细行号     | 请参考API文档 |
| object   | true | 请参考API文档 | 卡信息           | 请参考API文档 |
| string   | true | 请参考API文档 | 卡ID | 卡片的唯一标识符 |
| string   | true | 请参考API文档 | 产品编号         | 请参考API文档 |
| string   | true | 请参考API文档 | 产品名称 | 卡片产品的名称描述 |
| string   | true | 请参考API文档 | 卡结算币种 | 卡片使用的货币类型 |
| string   | true | 请参考API文档 | 脱敏卡号 | 脱敏处理后的卡号 |
| string   | true | 请参考API文档 | 卡模式 | 卡片的模式类型（标准/共享余额） |
| string   | true | 请参考API文档 | 充值金额         | 请参考API文档 |
| [object] | true | 请参考API文档 | 费用明细         | 请参考API文档 |
| string   | true | 请参考API文档 | 费用类型         | 请参考API文档 |
| number   | true | 请参考API文档 | 费用金额         | 请参考API文档 |
| string   | true | 请参考API文档 | 费用币种         | 请参考API文档 |
| string   | true | 请参考API文档 | 是否已完充值     | 请参考API文档 |
| string   | true | 请参考API文档 | 充值完成时间     | 请参考API文档 |
| string   | true | 请参考API文档 | 订单状态         | 处理中 Pending，已完成 Completed，处理失败 Failure |
| string   | true | 请参考API文档 | 支付信息         | 请参考API文档 |
| string   | true | 请参考API文档 | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| string   | true | 请参考API文档 | 订单创建时间     | 请参考API文档 |
| string   | true | 请参考API文档 | 订单修改时间     | 请参考API文档 |
| string   | true | 请参考API文档 | 订单支付时间     | 请参考API文档 |
| string   | true | 请参考API文档 | 订单完成时间     | 请参考API文档 |
| string   | true | 请参考API文档 | 客户订单号 | 客户系统生成的订单编号（可选） |
| string   | true | 请参考API文档 | 响应Id           | 请参考API文档 |
| string   | true | 请参考API文档 | 是否出错 | 标识响应是否包含错误信息 |
| string   | true | 请参考API文档 | 错误码 | 具体的错误代码标识 |
| string   | true | 请参考API文档 | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | string | 是   |        | 请参考API文档 |
| Accept            | string | 是   |        | 请参考API文档 |
| body              | object | 否   |        | 请参考API文档 |
| » cardId          | string | 是   |        | 请参考API文档 |
| » customerOrderNo | string | 否   |        | 请参考API文档 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 约束 | 中文名         |
|--------------------|--------|------|------|----------------|
| » data             | object | true | 请参考API文档 |                |
| »» orderNo         | string | true | 请参考API文档 | 订单号         |
| »» cardInfo        | object | true | 请参考API文档 | 卡信息         |
| »»» cardId         | string | true | 请参考API文档 | 卡ID           |
| »»» productCode    | string | true | 请参考API文档 | 产品编号       |
| »»» productName    | string | true | 请参考API文档 | 产品名称       |
| »»» cardCurrency   | string | true | 请参考API文档 | 卡结算币种     |
| »»» maskCardNumber | string | true | 请参考API文档 | 脱敏卡号       |
| »»» cardModel      | string | true | 请参考API文档 | 卡模式         |
| »» note            | string | true | 请参考API文档 | 备注信息       |
| »» isBlocked       | string | true | 请参考API文档 | 卡是否已被锁定 |
| »» status          | string | true | 请参考API文档 | 订单状态       |
| »» failureReason   | string | true | 请参考API文档 | 失败原因       |
| »» orderType       | string | true | 请参考API文档 | 订单类型       |
| »» createdOn       | string | true | 请参考API文档 | 订单创建时间   |
| »» modifiedOn      | string | true | 请参考API文档 | 订单修改时间   |
| »» completedOn     | string | true | 请参考API文档 | 订单完成时间   |
| »» customerOrderNo | string | true | 请参考API文档 | 客户订单号     |
| » responseId       | string | true | 请参考API文档 | 响应ID         |
| » hasError         | string | true | 请参考API文档 | 是否出错       |
| » errorCode        | string | true | 请参考API文档 | 错误码         |
| » errorMessage     | string | true | 请参考API文档 | 错误信息       |

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

| 名称              | 位置   | 类型   | 中文名 | 说明 |-------------------|--------|--------|------|--------|------| Content-Type      | header | string | 是   |        | 请参考API文档 | Accept            | header | string | 是   |        | 请参考API文档 | body              | body   | object | 否   |        | 请参考API文档 | » cardId          | body   | string | 是   |        | 请参考API文档 | » customerOrderNo | body   | string | 否   |        | 请参考API文档 | 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称               | 类型    | 中文名       | 说明 |
|--------------------|---------|------|--------------|------|
| » data             | object  | true |              | 请参考API文档 |
| »» orderNo         | string  | true | 订单号       | 请参考API文档 |
| »» cardInfo        | object  | true | 卡信息       | 请参考API文档 |
| »»» cardId         | string  | true | 卡ID | 卡片的唯一标识符 |
| »»» productCode    | string  | true | 产品编码 | 卡片产品的代码标识 |
| »»» productName    | string  | true | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency   | string  | true | 卡币种       | 请参考API文档 |
| »»» maskCardNumber | string  | true | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel      | string  | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» note            | string  | true | 订单备注     | 请参考API文档 |
| »» status          | string  | true | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» failureReason   | string  | true | 失败原因     | 请参考API文档 |
| »» orderType       | string  | true | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» createdOn       | string  | true | 订单创建时间 | 请参考API文档 |
| »» modifiedOn      | string  | true | 订单修改时间 | 请参考API文档 |
| »» completedOn     | string  | true | 订单完成时间 | 请参考API文档 |
| »» customerOrderNo | string  | true | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId       | string  | true | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError         | boolean | true | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode        | string  | true | 错误码 | 具体的错误代码标识 |
| » errorMessage     | string  | true | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | string | 是   | 请参考API文档 |
| Accept            | header | string | 是   | 请参考API文档 |
| body              | body | object | 否   | HTTP请求的主体内容 |
| » cardId          | body | string | 是   | HTTP请求的主体内容 |
| » customerOrderNo | body | string | 否   | HTTP请求的主体内容 |

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
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 类型   | 约束 | 中文名         | 说明                                                           |
|---------------------|------|------|----------------|----------------------------------------------------------------|
| » data              | true | 请参考API文档 |                | 请参考API文档 |
| »» orderNo          | true | 请参考API文档 | 订单号         | 请参考API文档 |
| »» cardInfo         | true | 请参考API文档 | 卡信息         | 请参考API文档 |
| »»» cardId          | true | 请参考API文档 | 卡ID | 卡片的唯一标识符 |
| »»» productCode     | true | 请参考API文档 | 产品编码 | 卡片产品的代码标识 |
| »»» productName     | true | 请参考API文档 | 产品名称 | 卡片产品的名称描述 |
| »»» cardCurrency    | true | 请参考API文档 | 卡结算币种 | 卡片使用的货币类型 |
| »»» maskCardNumber  | true | 请参考API文档 | 脱敏卡号 | 脱敏处理后的卡号 |
| »»» cardModel       | true | 请参考API文档 | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »» fee              | true | 请参考API文档 | 销卡手续费     | 请参考API文档 |
| »» chargeMethodType | true | 请参考API文档 | 收费方式       | 包括：固定值 FixedValue，百分比 Percentage                     |
| »» fixedValue       | true | 请参考API文档 | 固定值收费标准 | 请参考API文档 |
| »» percent          | true | 请参考API文档 | 百分比收费标准 | 请参考API文档 |
| »» settleAmount     | true | 请参考API文档 | 结算金额       | 请参考API文档 |
| »» note             | true | 请参考API文档 | 备注           | 请参考API文档 |
| »» status           | true | 请参考API文档 | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） |
| »» settleStatus     | true | 请参考API文档 | 结算状态       | 包括：Pending 处理中 ，WaitTransfer 等待划拨，Completed 已完成 |
| »» orderType        | true | 请参考API文档 | 订单类型 | 订单的业务类型（开卡/充值/冻结等） |
| »» failureReason    | true | 请参考API文档 | 失败原因       | 请参考API文档 |
| »» createdOn        | true | 请参考API文档 | 订单创建时间   | 请参考API文档 |
| »» completedOn      | true | 请参考API文档 | 订单完成时间   | 请参考API文档 |
| »» customerOrderNo  | true | 请参考API文档 | 客户订单号 | 客户系统生成的订单编号（可选） |
| » responseId        | true | 请参考API文档 | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError          | true | 请参考API文档 | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode         | true | 请参考API文档 | 错误码 | 具体的错误代码标识 |
| » errorMessage      | true | 请参考API文档 | 错误信息 | 详细的错误描述信息 |

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
| Content-Type      | header | 是   |            | 请参考API文档 |
| Accept            | header | 是   |            | 请参考API文档 |
| body              | body | 否   |            | HTTP请求的主体内容 |
| » cardId          | body | 是   | 卡ID       | HTTP请求的主体内容 |
| » withdrawAmount  | body   | 是   | 转出金额   | 转出金额必须大于0 |
| » customerOrderNo | body | 否   | 客户订单号 | HTTP请求的主体内容 |

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
|--------|-----------------------------------------------------------------|------|----------| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| 401    | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 |

### 返回数据结构

状态码 **200**

| 名称               | 类型   | 约束 | 中文名       | 说明              |--------------------|--------|-------|------|--------------|-------------------| » data             | object | true  | 请参考API文档 |              | 请参考API文档 | »» orderNo         | string | true  | 请参考API文档 | 订单号       | 请参考API文档 | »» cardId          | string | true  | 请参考API文档 | 卡ID | 卡片的唯一标识符 | »» withdrawAmount  | string | true  | 请参考API文档 | 转出金额     | 请参考API文档 | »» withdrawFee     | string | true  | 请参考API文档 | 转出费用     | 请参考API文档 | »» totalAmount     | string | true  | 请参考API文档 | 总金额       | 转出金额+转出费用 | »» status          | string | true  | 请参考API文档 | 订单状态 | 订单当前处理状态（Pending/Completed/Failed） | »» orderType       | string | true  | 请参考API文档 | 订单类型 | 订单的业务类型（开卡/充值/冻结等） | »» createdOn       | string | true  | 请参考API文档 | 订单创建时间 | 请参考API文档 | »» modifiedOn      | string | true  | 请参考API文档 | 订单修改时间 | 请参考API文档 | »» completedOn     | string | false | 请参考API文档 | 订单完成时间 | 请参考API文档 | »» customerOrderNo | string | true  | 请参考API文档 | 客户订单号 | 客户系统生成的订单编号（可选） | » responseId       | string | true  | 请参考API文档 |              | 请参考API文档 | » hasError         | string | true  | 请参考API文档 |              | 请参考API文档 | » errorCode        | string | true  | 请参考API文档 |              | 请参考API文档 | » errorMessage     | string | true  | 请参考API文档 |              | 请参考API文档 | 名称   | 位置   | 类型   | 中文名 | 说明            |
|--------|--------|------|--------|-----------------|
| path   | string | 是   |        | (Required) 卡ID |
| header | string | 是   |        | 请参考API文档 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   | 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| 403    | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                | 类型   | 约束 | 说明                                                                        |
|---------------------|--------|------|------|-----------------------------------------------------------------------------|
| » data              | object | true | 请参考API文档 | 请参考API文档 |
| »» cardId           | string | true | 请参考API文档 | 卡唯一ID                                                                    |
| »» cardModel        | string | true | 请参考API文档 | 包括：标准模式 Standard ，共享余额 ShareBalance                             |
| »» productCode      | string | true | 请参考API文档 | 请参考API文档 |
| »» cardNumber       | string | true | 请参考API文档 | 请参考API文档 |
| »» cvv              | string | true | 请参考API文档 | 请参考API文档 |
| »» expirationMMYY   | string | true | 请参考API文档 | 例如 04/2028                                                                |
| »» cardCurrency     | string | true | 请参考API文档 | 请参考API文档 |
| »» alias            | string | true | 请参考API文档 | 请参考API文档 |
| »» balanceAmount    | string | true | 请参考API文档 | 请参考API文档 |
| »» status           | string | true | 请参考API文档 | 包括：Active 活跃，Blocked 已冻结，Cancel 已注销，Expired 已过期            |
| »» maxAuthAmount    | string | true | 请参考API文档 | 仅在共享模式下可用                                                          |
| »» usedCreditAmount | string | true | 请参考API文档 | 仅在共享模式下可用                                                          |
| »» maxCreditAmount  | string | true | 请参考API文档 | 仅在共享模式下可用。值为空表示无限额度。                                    |
| »» cardOrganization | string | true | 请参考API文档 | 包括：Mastercard  万事达卡， VISA ，AmericanExpress 美国运通，UnionPay 银联 |
| »» applyTime        | string | true | 请参考API文档 | 请参考API文档 |
| » responseId        | string | true | 请参考API文档 | 请参考API文档 |
| » hasError          | string | true | 请参考API文档 | 请参考API文档 |
| » errorCode         | string | true | 请参考API文档 | 请参考API文档 |
| » errorMessage      | string | true | 请参考API文档 | 请参考API文档 |

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
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   | 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   |

### 返回数据结构

状态码 **200**

| 名称                    | 约束 | 中文名         | 说明                                                                                                                                                                                         |
|-------------------------|----------|------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data                  | object   | 请参考API文档 |                | 请参考API文档 |
| »» pageCursor           | string   | 请参考API文档 |                | 请参考API文档 |
| »» pageSize             | string   | 请参考API文档 |                | 请参考API文档 |
| »» data                 | [object] | 请参考API文档 |                | 请参考API文档 |
| »»» id                  | string   | 请参考API文档 | 交易ID         | 请参考API文档 |
| »»» authTime            | string   | 请参考API文档 | 预授权时间     | 请参考API文档 |
| »»» settleTime          | string   | 请参考API文档 | 清算时间       | 入账后，返回清算时间                                                                                                                                                                         |
| »»» transAmount         | object   | 请参考API文档 | 原始交易金额   | 请参考API文档 |
| »»»» currency           | string   | 请参考API文档 | 原始交易币种   | 请参考API文档 |
| »»»» amount             | string   | 请参考API文档 | 原始交易金额值 | 请参考API文档 |
| »»» authAmount          | object   | 请参考API文档 | 预授权金额     | 请参考API文档 |
| »»»» currency           | string   | 请参考API文档 | 预授权币种     | 请参考API文档 |
| »»»» amount             | string   | 请参考API文档 | 预授权金额值   | 请参考API文档 |
| »»» settledAmount       | object   | 请参考API文档 | 结算金额       | 入账后，返回结算金额                                                                                                                                                                         |
| »»»» currency           | string   | 请参考API文档 | 结算币种       | 请参考API文档 |
| »»»» amount             | string   | 请参考API文档 | 结算金额值     | 请参考API文档 |
| »»» cardInfo            | object   | 请参考API文档 | 卡信息         | 请参考API文档 |
| »»»» cardId             | string   | 请参考API文档 | 卡ID | 卡片的唯一标识符 |
| »»»» productCode        | string   | 请参考API文档 | 产品编码 | 卡片产品的代码标识 |
| »»»» productName        | string   | 请参考API文档 | 产品名称 | 卡片产品的名称描述 |
| »»»» cardCurrency       | string   | 请参考API文档 | 卡结算币种 | 卡片使用的货币类型 |
| »»»» maskCardNumber     | string   | 请参考API文档 | 脱敏卡号 | 脱敏处理后的卡号 |
| »»»» cardModel          | string   | 请参考API文档 | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» cardAlias           | string   | 请参考API文档 | 卡别名         | 请参考API文档 |
| »»» authCode            | string   | 请参考API文档 | 授权码         | 请参考API文档 |
| »»» merchantName        | string   | 请参考API文档 | 商户名称       | 请参考API文档 |
| »»» merchantCountryCode | string   | 请参考API文档 | 商户国家代码   | 请参考API文档 |
| »»» merchantCity        | string   | 请参考API文档 | 商户所在城市   | 请参考API文档 |
| »»» merchantState       | string   | 请参考API文档 | 商户所在州     | 请参考API文档 |
| »»» merchantZipCode     | string   | 请参考API文档 | 商户邮编       | 请参考API文档 |
| »»» merchantDesc        | string   | 请参考API文档 | 商户描述       | 请参考API文档 |
| »»» status              | string   | 请参考API文档 | 交易状态       | 包括AuthSuccess 预授权成功，AuthFailure 预授权失败，Settled 已入账                                                                                                                           |
| »»» fundsDirection      | string   | 请参考API文档 | 资金方向       | Income: 收入 Expenditure: 支出                                                                                                                                                               |
| »»» transactionType     | string   | 请参考API文档 | 交易类型       | Consume 消费, ConsumeRefund 消费退款,DisputeRelease 消费争议, DisputeRelease 争议释放,ConsumeReversal 取消消费, ConsumeRefundReversal 消费退款冲正,AuthQuery 预授权查询, TransFee 交易手续费 |
| »»» failureReason       | string   | 请参考API文档 | 失败原因       | 请参考API文档 |
| »»» failureReasonCn     | string   | 请参考API文档 | 中文失败原因   | 请参考API文档 |
| »»» note                | string   | 请参考API文档 | 备注           | 请参考API文档 |
| » responseId            | string   | 请参考API文档 | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError              | string   | 请参考API文档 | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode             | string   | 请参考API文档 | 错误码 | 具体的错误代码标识 |
| » errorMessage          | string   | 请参考API文档 | 错误信息 | 详细的错误描述信息 |

# accounts

## GET 获取客户资金账户余额信息

GET /v1/accounts

### 请求参数

| 名称   | 位置   | 中文名 | 说明 |
|--------|--------|--------|--------|------|
| Accept | header | string |        | 请参考API文档 |

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
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | 请参考API文档 | Inline   | 名称           | 类型     | 约束 | 中文名       | 说明 |
|----------|------|------|--------------|------|
| [object] | true | 请参考API文档 |              | 请参考API文档 |
| string   | true | 请参考API文档 | 账户币种     | 请参考API文档 |
| string   | true | 请参考API文档 | 账户可用金额 | 请参考API文档 |
| string   | true | 请参考API文档 | 响应ID | 用于追踪请求的唯一标识符 |
| string   | true | 请参考API文档 | 是否出错 | 标识响应是否包含错误信息 |
| string   | true | 请参考API文档 | 错误码 | 具体的错误代码标识 |
| string   | true | 请参考API文档 | 错误原因     | 请参考API文档 |

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
| Accept              | string | 是   |        | 请参考API文档 |

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
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 | Inline   |
| [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | none | Inline   |
| 403    | [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | Inline   |

### 返回数据结构

状态码 **200**

| 名称                   | 类型     | 约束 | 中文名             |
|------------------------|----------|------|------|--------------------|
| » data                 | object   | true | 请参考API文档 |                    |
| »» pageNumber          | string   | true | 请参考API文档 | 页号               |
| »» pageSize            | string   | true | 请参考API文档 | 每页数据行数       |
| »» totalRecords        | string   | true | 请参考API文档 | 总记录数           |
| »» totalPages          | string   | true | 请参考API文档 | 总页数             |
| »» data                | [object] | true | 请参考API文档 |                    |
| »»» accountLogId       | string   | true | 请参考API文档 | 账户明细ID         |
| »»» cardOrderNo        | string   | true | 请参考API文档 | 批次订单号         |
| »»» cardAccountLogType | string   | true | 请参考API文档 | 卡账户交易明细类型 |
| »»» cardInfo           | object   | true | 请参考API文档 | 卡信息             |
| »»»» cardId            | string   | true | 请参考API文档 | 卡ID               |
| »»»» productCode       | string   | true | 请参考API文档 | 产品编码           |
| »»»» productName       | string   | true | 请参考API文档 | 产品名称           |
| »»»» cardCurrency      | string   | true | 请参考API文档 | 卡结算币种         |
| »»»» maskCardNumber    | string   | true | 请参考API文档 | 脱敏卡号           |
| »»»» cardModel         | string   | true | 请参考API文档 | 卡模式             |
| »»» fundsDirection     | string   | true | 请参考API文档 | 资金方向           |
| »»» transAmount        | object   | true | 请参考API文档 | 交易金额信息       |
| »»»» currency          | string   | true | 请参考API文档 | 交易币种           |
| »»»» amount            | string   | true | 请参考API文档 | 交易金额           |
| »»» totalFee           | object   | true | 请参考API文档 | 总手续费信息       |
| »»»» currency          | string   | true | 请参考API文档 | 总手续费币种       |
| »»»» amount            | string   | true | 请参考API文档 | 总手续费金额       |
| »»» feeItems           | [object] | true | 请参考API文档 | 费用明细           |
| »»»» feeType           | string   | true | 请参考API文档 | 费用类型           |
| »»»» amount            | number   | true | 请参考API文档 | 费用金额           |
| »»»» currency          | string   | true | 请参考API文档 | 费用币种           |
| »»» totalAmount        | object   | true | 请参考API文档 | 总金额信息         |
| »»»» currency          | string   | true | 请参考API文档 | 总金额币种         |
| »»»» amount            | string   | true | 请参考API文档 | 总金额金额         |
| »»» status             | string   | true | 请参考API文档 | 状态               |
| »»» failureReason      | string   | true | 请参考API文档 | 失败原因           |
| »»» transTime          | string   | true | 请参考API文档 | 交易时间           |
| »»» completedTime      | string   | true | 请参考API文档 | 完成时间           |
| »»» note               | string   | true | 请参考API文档 | 备注               |
| » responseId           | string   | true | 请参考API文档 | 响应ID             |
| » hasError             | string   | true | 请参考API文档 | 是否出错           |
| » errorCode            | string   | true | 请参考API文档 | 错误码             |
| » errorMessage         | string   | true | 请参考API文档 | 错误信息           |

# accounts/accountLogs

## GET 分页查询 资金账户资金明细

GET /v1/accounts/accountLogs

### 请求参数

| 名称                | 位置   | 类型   | 中文名 | 说明                                |---------------------|--------|--------|------|--------|-------------------------------------| TransactionDateFrom | query  | string | 是   |        | 开始交易日期                        | TransactionDateTo   | query  | string | 是   |        | 结束交易日期                        | Limit               | query  | string | 是   |        | 返回数据条数，为空默认20条          | Offset              | query  | string | 是   |        | 偏移数据条数。为空默认为0（第一页） | Accept              | header | string | 是   |        | 请参考API文档 | 状态码 | 状态码含义                                                      | 说明 | 数据模型 |
|--------|------|----------|
| 200    | [OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)         | 请参考API文档 |
| 401    | [Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1) | 请参考API文档 | Inline   |
| [Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)  | none | Inline   |

### 返回数据结构

状态码 **200**

| 名称                 | 类型     | 中文名         | 说明                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------|----------|------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| » data               | object   | true |                | 请参考API文档 |
| »» pageNumber        | string   | true |                | 请参考API文档 |
| »» pageSize          | string   | true |                | 请参考API文档 |
| »» totalRecords      | string   | true |                | 请参考API文档 |
| »» totalPages        | string   | true |                | 请参考API文档 |
| »» data              | [object] | true |                | 请参考API文档 |
| »»» id               | string   | true | 流水号         | 请参考API文档 |
| »»» accountTransType | string   | true | 交易类型       | AccountTopUp 账户转入资金，AccountWithdraw 账户转出资金，AuthBlock  授权冻结，AuthUnBlock 授权解冻，AuthReversal 授权取消，Consume 消费，ConsumeRefund 消费退款，OpenCardFee 开卡手续费，TransFee 交易手续费，CancelCardFee 销卡手续费， Rebate 返利，ReversalRefund 冲账退回，ReversalDeduct 冲账扣除，ConsumeSettlementDiffDeduct 消费清算差额-扣除，ConsumeSettlementDiffRefund 消费清算差额-退回，AccountTopUpFee 账户转入手续费，AccountWithdrawFee 账户转出手续费，CardTopUp 卡转入资金，TopUpFee 卡转入手续费，CardWithdraw 卡转出资金，CancelCardSettleDeduct 销卡结算-扣除，CancelCardSettleRefund 销卡结算-退回，AccountAdjustIncrease 账户调增，AccountAdjustDeduct 账户调减，CardOverdrawDeduct 标准卡透支扣除，<br />CardOverdrawReversal 标准卡透支冲正 |
| »»» fundsDirection   | string   | true | 资金方向       | Income 收入，Expenditure 支出                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| »»» currency         | string   | true | 账户币种       | 请参考API文档 |
| »»» transAmount      | string   | true | 交易金额       | 分正负号                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| »»» availableBalance | string   | true | 调整后可用余额 | 请参考API文档 |
| »»» blockedBalance   | string   | true | 调整后冻结余额 | 请参考API文档 |
| »»» orderNo          | string   | true | 关联订单号     | 请参考API文档 |
| »»» note             | string   | true | 备注           | 请参考API文档 |
| »»» cardInfo         | object   | true | 卡信息         | 请参考API文档 |
| »»»» cardId          | string   | true | 卡ID | 卡片的唯一标识符 |
| »»»» productCode     | string   | true | 产品编码 | 卡片产品的代码标识 |
| »»»» productName     | string   | true | 产品名称 | 卡片产品的名称描述 |
| »»»» cardCurrency    | string   | true | 卡结算币种 | 卡片使用的货币类型 |
| »»»» maskCardNumber  | string   | true | 脱敏卡号 | 脱敏处理后的卡号 |
| »»»» cardModel       | string   | true | 卡模式 | 卡片的模式类型（标准/共享余额） |
| »»» transTime        | string   | true | 交易时间       | 请参考API文档 |
| » responseId         | string   | true | 响应ID | 用于追踪请求的唯一标识符 |
| » hasError           | string   | true | 是否出错 | 标识响应是否包含错误信息 |
| » errorCode          | string   | true | 错误码 | 具体的错误代码标识 |
| » errorMessage       | string   | true | 错误信息 | 详细的错误描述信息 |

# 数据模型

