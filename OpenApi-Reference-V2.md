# 卡系统API文档 v2.0

cardepass.com 卡系统API文档

Base URLs:

* [测试环境: https://test.cardepass.com/openapi](https://test.cardepass.com/openapi)
* [生产环境: https://cardepass.com/openapi](https://cardepass.com/openapi)

## 认证方式

- HTTP认证，使用Bearer Token
- 需要先通过OAuth2获取访问令牌

---

# Token管理

## POST 获取访问令牌

**接口地址：** POST /connect/token

**功能描述：** 获取API访问令牌，用于后续所有API调用的身份验证

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                        |
|----------------|----------|----------|----------|------------|-------------------------------|
| Content-Type   | header   | string   | 是       | 内容类型   | application/x-www-form-urlencoded |
| grant_type     | body     | string   | 是       | 授权类型   | 固定值：client_credentials      |
| client_id      | body     | string   | 是       | 客户端ID   | 客户端标识，需向cardepass申请    |
| client_secret  | body     | string   | 是       | 客户端密钥 | 客户端密钥，需向cardepass申请    |
| redirect_uri   | body     | string   | 否       | 重定向地址 | OAuth2重定向地址（可选）        |

### 请求示例

`ash
curl -X POST "https://test.cardepass.com/openapi/connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=your_client_id&client_secret=your_client_secret"
`

### 响应示例

`json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6...",
  "expires_in": 3600,
  "token_type": "Bearer",
  "scope": "card"
}
`

### 响应参数说明

| 参数名称     | 参数类型 | 中文名称     | 参数描述                                  |
|--------------|----------|--------------|-------------------------------------------|
| access_token | string   | 访问令牌     | 后续API调用需要的访问令牌                |
| expires_in   | integer  | 过期时间     | 令牌有效期（秒），默认3600秒=1小时       |
| token_type   | string   | 令牌类型     | 固定返回"Bearer"                         |
| scope        | string   | 权限范围     | 令牌权限范围，默认"card"                 |

### 状态码说明

| 状态码 | 说明         | 解决方案                |
|--------|--------------|-------------------------|
| 200    | 获取成功     | 令牌获取成功            |
| 400    | 参数错误     | 检查请求参数格式        |
| 401    | 认证失败     | 检查客户端凭据是否正确  |

---

# 系统验证

## GET Ping接口

**接口地址：** GET /v1/ping

**功能描述：** 验证API连接和令牌有效性

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述                    |
|---------------|----------|----------|----------|----------|-----------------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token}       |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/ping" \
  -H "Authorization: Bearer your_access_token"
`

### 响应示例

`json
"Ping Success"
`

### 状态码说明

| 状态码 | 说明       | 解决方案         |
|--------|------------|------------------|
| 200    | 连接正常   | API服务正常      |
| 401    | 令牌无效   | 重新获取访问令牌 |
| 403    | 权限不足   | 检查权限设置     |

---

# 产品管理

## GET 获取产品列表

**接口地址：** GET /v1/products

**功能描述：** 获取所有可用的卡片产品列表

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/products" \
  -H "Authorization: Bearer your_access_token"
`

### 响应示例

`json
{
  "data": [
    {
      "productCode": "DGG0C4JD",
      "productName": "通用卡",
      "cardModels": ["ShareBalance", "Standard"],
      "cardCurrency": ["USD"],
      "description": "通用卡-测试使用"
    }
  ],
  "responseId": "uuid-response-id",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
`

### 响应参数说明

| 参数名称      | 参数类型 | 中文名称   | 参数描述                             |
|---------------|----------|------------|--------------------------------------|
| data          | array    | 产品列表   | 产品信息数组                         |
| productCode   | string   | 产品编码   | 产品唯一标识                         |
| productName   | string   | 产品名称   | 产品显示名称                         |
| cardModels    | array    | 卡片模式   | 支持的模式：ShareBalance/Standard    |
| cardCurrency  | array    | 支持币种   | 支持的货币类型                       |
| description   | string   | 产品描述   | 产品详细说明                         |
| responseId    | string   | 响应ID     | 请求追踪标识                         |
| hasError      | boolean  | 是否错误   | 错误标识                             |
| errorCode     | string   | 错误码     | 具体错误代码                         |
| errorMessage  | string   | 错误信息   | 错误详细说明                         |

---

# 卡片管理

## GET 获取卡片信息

**接口地址：** GET /v1/cards/{cardId}

**功能描述：** 根据卡片ID获取卡片详细信息

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| cardId        | path     | string   | 是       | 卡片ID   | 卡片唯一标识符        |
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/cards/68085ad8b85b8cf3d3f3087e" \
  -H "Authorization: Bearer your_access_token"
`

### 响应示例

`json
{
  "data": {
    "cardId": "68085ad8b85b8cf3d3f3087e",
    "cardAlias": "测试卡片",
    "cardModel": "ShareBalance",
    "cardCurrency": "USD",
    "cardStatus": "Active",
    "balance": 100.50,
    "maxAuthAmount": 500,
    "maxCreditAmount": 1000,
    "createdOn": "2025-01-15T10:30:00Z"
  },
  "responseId": "uuid-response-id",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
`

### 响应参数说明

| 参数名称       | 参数类型 | 中文名称     | 参数描述                                |
|----------------|----------|--------------|----------------------------------------|
| cardId         | string   | 卡片ID       | 卡片唯一标识符                         |
| cardAlias      | string   | 卡片别名     | 用户自定义别名                         |
| cardModel      | string   | 卡片模式     | ShareBalance(共享余额)/Standard(标准) |
| cardCurrency   | string   | 卡片币种     | 卡片货币类型                           |
| cardStatus     | string   | 卡片状态     | Active(激活)/Blocked(冻结)/Cancelled(已销卡) |
| balance        | number   | 卡片余额     | 当前余额                               |
| maxAuthAmount  | number   | 单笔限额     | 单次交易最大金额                       |
| maxCreditAmount| number   | 总消费额度   | 卡片总消费限额                         |
| createdOn      | string   | 创建时间     | 卡片创建时间戳                         |

### 状态码说明

| 状态码 | 说明       | 解决方案         |
|--------|------------|------------------|
| 200    | 查询成功   | 返回卡片信息     |
| 401    | 令牌无效   | 重新获取访问令牌 |
| 403    | 权限不足   | 检查权限设置     |
| 404    | 卡片不存在 | 检查卡片ID是否正确 |

---

# 共享余额模式订单管理

## POST 共享余额开卡申请

**接口地址：** POST /v1/orders/sharebalance/apply

**功能描述：** 申请开通共享余额模式卡片

### 请求参数

| 参数名称          | 参数位置 | 参数类型 | 是否必填 | 中文名称       | 参数描述                    |
|-------------------|----------|----------|----------|----------------|-----------------------------|
| Authorization     | header   | string   | 是       | 授权头         | Bearer {access_token}       |
| Content-Type      | header   | string   | 是       | 内容类型       | application/json            |
| productCode       | body     | string   | 是       | 产品代码       | 卡片产品唯一标识            |
| cardCurrency      | body     | string   | 是       | 卡片币种       | 卡片使用的货币类型          |
| maxAuthAmount     | body     | string   | 是       | 单笔限额       | 单次交易最大金额限制        |
| maxCreditAmount   | body     | string   | 否       | 总消费额度     | 卡片总消费限额，空表示无限额 |
| cardAlias         | body     | string   | 否       | 卡片别名       | 用户自定义卡片别名          |
| customerOrderNo   | body     | string   | 否       | 客户订单号     | 客户系统订单编号            |

### 请求示例

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/apply" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
    "productCode": "A5GGCYNQ",
    "cardCurrency": "USD",
    "maxAuthAmount": "10",
    "cardAlias": "共享卡测试01",
    "customerOrderNo": "T20250423001"
  }'
`

### 响应示例

`json
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
    "transFee": 0.1,
    "openedQty": 0,
    "status": "Pending",
    "orderType": "ApplyCard",
    "createdOn": "2025-04-23T03:13:17.668Z",
    "customerOrderNo": "T20250423001"
  },
  "responseId": "01fa02d3-20dd-4ce7-84ea-ca6c9884a485",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
`

### 响应参数说明

| 参数名称        | 参数类型 | 中文名称     | 参数描述                           |
|-----------------|----------|--------------|-----------------------------------|
| orderNo         | string   | 订单编号     | 系统生成的唯一订单号              |
| productInfo     | object   | 产品信息     | 产品详细信息                      |
| quantity        | integer  | 申请数量     | 申请开卡数量                      |
| maxAuthAmount   | number   | 单笔限额     | 单次交易最大金额                  |
| maxCreditAmount | number   | 总消费额度   | 卡片总消费限额                    |
| totalAmount     | number   | 订单总金额   | 订单总费用                        |
| transFee        | number   | 手续费       | 交易手续费                        |
| openedQty       | integer  | 已开卡数     | 已成功开卡数量                    |
| status          | string   | 订单状态     | Pending/Completed/Failed          |
| orderType       | string   | 订单类型     | ApplyCard/CreditLimit等           |
| createdOn       | string   | 创建时间     | 订单创建时间戳                    |
| customerOrderNo | string   | 客户订单号   | 客户系统订单编号                  |

## POST 共享余额调整限额

**接口地址：** POST /v1/orders/sharebalance/creditLimit

**功能描述：** 调整共享余额模式卡片的交易限额

### 请求参数

| 参数名称          | 参数位置 | 参数类型 | 是否必填 | 中文名称       | 参数描述                    |
|-------------------|----------|----------|----------|----------------|-----------------------------|
| Authorization     | header   | string   | 是       | 授权头         | Bearer {access_token}       |
| Content-Type      | header   | string   | 是       | 内容类型       | application/json            |
| cardId            | body     | string   | 是       | 卡片ID         | 卡片唯一标识符              |
| maxAuthAmount     | body     | string   | 是       | 单笔限额       | 新的单次交易最大金额        |
| maxCreditAmount   | body     | string   | 否       | 总消费额度     | 新的总消费额度              |
| customerOrderNo   | body     | string   | 否       | 客户订单号     | 客户系统订单编号            |

### 请求示例

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/creditLimit" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
    "cardId": "68085ad8b85b8cf3d3f3087e",
    "maxAuthAmount": "20",
    "customerOrderNo": "T20250423002"
  }'
`

## GET 共享余额订单查询

**接口地址：** GET /v1/orders/sharebalance

**功能描述：** 查询共享余额模式订单信息

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| OrderType       | query    | string   | 否       | 订单类型   | ApplyCard/CreditLimit/CardBlock等  |
| OrderNo         | query    | string   | 否       | 订单编号   | 系统订单号（与客户订单号二选一）   |
| CustomerOrderNo | query    | string   | 否       | 客户订单号 | 客户订单号（与系统订单号二选一）   |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?OrderNo=C1000-20250423-2RJI" \
  -H "Authorization: Bearer your_access_token"
`

---

# 标准模式订单管理

## POST 标准模式开卡申请

**接口地址：** POST /v1/orders/standard/apply

**功能描述：** 申请开通标准模式卡片

### 请求参数

| 参数名称          | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述              |
|-------------------|----------|----------|----------|------------|-----------------------|
| Authorization     | header   | string   | 是       | 授权头     | Bearer {access_token} |
| Content-Type      | header   | string   | 是       | 内容类型   | application/json      |

### 请求示例

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/apply" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
    "productCode": "STD001",
    "cardCurrency": "USD",
    "maxAuthAmount": "100"
  }'
`

## POST 标准模式卡充值

**接口地址：** POST /v1/orders/standard/topup

**功能描述：** 为标准模式卡片充值

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |
| Content-Type  | header   | string   | 是       | 内容类型 | application/json      |
| cardId        | body     | string   | 是       | 卡片ID   | 目标卡片标识符        |
| amount        | body     | number   | 是       | 充值金额 | 充值数额              |

### 请求示例

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/topup" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
    "cardId": "68085ad8b85b8cf3d3f3087e",
    "amount": 50.00
  }'
`

## GET 标准模式订单查询

**接口地址：** GET /v1/orders/standard

**功能描述：** 查询标准模式订单信息

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                                    |
|-----------------|----------|----------|----------|------------|--------------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}                      |
| OrderType       | query    | string   | 否       | 订单类型   | ApplyCard/CardTopUp/CardBlock/CardWithdraw |
| OrderNo         | query    | string   | 否       | 订单编号   | 系统订单号（与客户订单号二选一）           |
| CustomerOrderNo | query    | string   | 否       | 客户订单号 | 客户订单号（与系统订单号二选一）           |

---

# 账户管理

## GET 获取客户资金账户余额

**接口地址：** GET /v1/accounts

**功能描述：** 获取当前客户的资金账户余额信息

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts" \
  -H "Authorization: Bearer your_access_token"
`

### 响应示例

`json
{
  "data": {
    "accountBalance": 1000.50,
    "availableBalance": 950.00,
    "frozenBalance": 50.50,
    "currency": "USD"
  },
  "responseId": "uuid-response-id",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
`

### 响应参数说明

| 参数名称         | 参数类型 | 中文名称   | 参数描述     |
|------------------|----------|------------|--------------|
| accountBalance   | number   | 账户总余额 | 账户总金额   |
| availableBalance | number   | 可用余额   | 可用于消费的金额 |
| frozenBalance    | number   | 冻结余额   | 被冻结的金额 |
| currency         | string   | 账户币种   | 账户货币类型 |

## GET 查询卡资金明细

**接口地址：** GET /v1/accounts/cardAccountLogs

**功能描述：** 分页查询标准模式卡片的资金明细

### 请求参数

| 参数名称            | 参数位置 | 参数类型 | 是否必填 | 中文名称     | 参数描述                    |
|---------------------|----------|----------|----------|--------------|----------------------------|
| Authorization       | header   | string   | 是       | 授权头       | Bearer {access_token}      |
| CardId              | query    | string   | 否       | 卡片ID       | 指定卡片的资金明细         |
| TransactionDateFrom | query    | string   | 否       | 开始日期     | 查询起始日期（YYYY-MM-DD） |
| TransactionDateTo   | query    | string   | 否       | 结束日期     | 查询结束日期（YYYY-MM-DD） |
| PageNumber          | query    | integer  | 否       | 页码         | 分页页码，从1开始          |
| PageSize            | query    | integer  | 否       | 页大小       | 每页记录数                 |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/cardAccountLogs?CardId=68085ad8b85b8cf3d3f3087e&PageNumber=1&PageSize=10" \
  -H "Authorization: Bearer your_access_token"
`

## GET 查询资金账户明细

**接口地址：** GET /v1/accounts/accountLogs

**功能描述：** 分页查询客户资金账户的资金明细

### 请求参数

| 参数名称            | 参数位置 | 参数类型 | 是否必填 | 中文名称     | 参数描述                    |
|---------------------|----------|----------|----------|--------------|----------------------------|
| Authorization       | header   | string   | 是       | 授权头       | Bearer {access_token}      |
| TransactionDateFrom | query    | string   | 否       | 开始日期     | 查询起始日期（YYYY-MM-DD） |
| TransactionDateTo   | query    | string   | 否       | 结束日期     | 查询结束日期（YYYY-MM-DD） |
| Limit               | query    | integer  | 否       | 限制数量     | 返回结果的最大数量         |
| Offset              | query    | integer  | 否       | 偏移量       | 查询的起始位置             |

---

# 交易管理

## GET 查询交易流水

**接口地址：** GET /v1/transactions

**功能描述：** 查询卡片的交易流水记录

### 请求参数

| 参数名称            | 参数位置 | 参数类型 | 是否必填 | 中文名称     | 参数描述                              |
|---------------------|----------|----------|----------|--------------|---------------------------------------|
| Authorization       | header   | string   | 是       | 授权头       | Bearer {access_token}                 |
| CardId              | query    | string   | 否       | 卡片ID       | 指定卡片的交易流水                    |
| TransactionDateFrom | query    | string   | 否       | 开始日期     | 查询起始日期（YYYY-MM-DD）            |
| TransactionDateTo   | query    | string   | 否       | 结束日期     | 查询结束日期（YYYY-MM-DD）            |
| TransactionStatus   | query    | string   | 否       | 交易状态     | Pending(处理中)/Success(成功)/Failed(失败) |
| PageSize            | query    | integer  | 否       | 页大小       | 每页返回的记录数                      |
| PageCursor          | query    | string   | 否       | 游标         | 游标分页的位置标识                    |

### 请求示例

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/transactions?CardId=68085ad8b85b8cf3d3f3087e&TransactionStatus=Success&PageSize=20" \
  -H "Authorization: Bearer your_access_token"
`

### 响应示例

`json
{
  "data": [
    {
      "transactionId": "tx_123456789",
      "cardId": "68085ad8b85b8cf3d3f3087e",
      "amount": -25.50,
      "currency": "USD",
      "transactionType": "Purchase",
      "status": "Success",
      "merchantName": "Amazon.com",
      "description": "在线购物",
      "transactionTime": "2025-01-20T14:30:00Z",
      "authCode": "AUTH123"
    }
  ],
  "pagination": {
    "pageSize": 20,
    "nextCursor": "cursor_next_page",
    "hasMore": true
  },
  "responseId": "uuid-response-id",
  "hasError": false,
  "errorCode": null,
  "errorMessage": null
}
`

### 响应参数说明

| 参数名称        | 参数类型 | 中文名称     | 参数描述                    |
|-----------------|----------|--------------|----------------------------|
| transactionId   | string   | 交易ID       | 交易唯一标识符             |
| cardId          | string   | 卡片ID       | 关联的卡片标识符           |
| amount          | number   | 交易金额     | 交易金额（负数表示支出）   |
| currency        | string   | 交易币种     | 交易使用的货币类型         |
| transactionType | string   | 交易类型     | Purchase/Refund/TopUp等    |
| status          | string   | 交易状态     | Success/Failed/Pending     |
| merchantName    | string   | 商户名称     | 交易商户名称               |
| description     | string   | 交易描述     | 交易详细描述               |
| transactionTime | string   | 交易时间     | 交易发生时间戳             |
| authCode        | string   | 授权码       | 交易授权码                 |


---

# 错误码说明

## 通用错误码

| 错误码 | HTTP状态码 | 错误说明             | 解决方案                      |
|--------|------------|----------------------|-------------------------------|
| 401    | 401        | 访问令牌无效或过期   | 重新获取访问令牌              |
| 403    | 403        | 权限不足             | 检查账户权限或联系管理员      |
| 404    | 404        | 请求的资源不存在     | 检查请求的资源ID是否正确      |
| 400    | 400        | 请求参数错误         | 检查请求参数格式和内容        |
| 429    | 429        | 请求频率超限         | 降低请求频率或等待后重试      |
| 500    | 500        | 服务器内部错误       | 稍后重试或联系技术支持        |

## 业务错误码

### 认证相关错误

| 错误码           | 错误说明                 | 解决方案                    |
|------------------|-------------------------|-----------------------------|
| invalid_client   | 客户端认证失败           | 检查client_id和client_secret |
| invalid_grant    | 授权类型不支持           | 使用client_credentials      |
| invalid_scope    | 权限范围无效             | 使用正确的scope参数         |

### 卡片业务错误

| 错误码                    | 错误说明           | 解决方案                |
|---------------------------|--------------------|-------------------------|
| CARD_NOT_FOUND           | 卡片不存在         | 检查卡片ID是否正确      |
| CARD_STATUS_INVALID      | 卡片状态不支持操作 | 检查卡片当前状态        |
| INSUFFICIENT_BALANCE     | 余额不足           | 确保账户余额充足        |
| LIMIT_EXCEEDED           | 超出限额           | 调整交易金额或提升限额  |
| PRODUCT_NOT_AVAILABLE    | 产品不可用         | 选择其他可用产品        |

### 订单相关错误

| 错误码                    | 错误说明           | 解决方案                |
|---------------------------|--------------------|-------------------------|
| ORDER_NOT_FOUND          | 订单不存在         | 检查订单号是否正确      |
| ORDER_STATUS_INVALID     | 订单状态不支持操作 | 检查订单当前状态        |
| DUPLICATE_ORDER          | 重复订单           | 使用不同的客户订单号    |

---

# 完整调用示例

## 场景1：共享余额模式开卡完整流程

### 第一步：获取访问令牌

`ash
curl -X POST "https://test.cardepass.com/openapi/connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=your_client_id&client_secret=your_client_secret"
`

**响应：**
`json
{
  "access_token": "eyJhbGciOiJSUzI1NiIs...",
  "expires_in": 3600,
  "token_type": "Bearer",
  "scope": "card"
}
`

### 第二步：验证连接状态

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/ping" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

**响应：**
`json
"Ping Success"
`

### 第三步：获取可用产品

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/products" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

**响应：**
`json
{
  "data": [
    {
      "productCode": "A5GGCYNQ",
      "productName": "通用卡-共享测试产品",
      "cardModels": ["ShareBalance", "Standard"],
      "cardCurrency": ["USD"],
      "description": "通用卡-测试使用"
    }
  ]
}
`

### 第四步：申请开卡

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/apply" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "productCode": "A5GGCYNQ",
    "cardCurrency": "USD",
    "maxAuthAmount": "100",
    "cardAlias": "我的共享卡",
    "customerOrderNo": "MYORDER_001"
  }'
`

**响应：**
`json
{
  "data": {
    "orderNo": "C1000-20250421-ABC1",
    "status": "Pending",
    "customerOrderNo": "MYORDER_001"
  },
  "hasError": false
}
`

### 第五步：查询订单状态

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?CustomerOrderNo=MYORDER_001" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

**响应（成功开卡后）：**
`json
{
  "data": {
    "orderNo": "C1000-20250421-ABC1",
    "status": "Completed",
    "cardInfos": [
      {
        "cardId": "680861234567890abcdef",
        "cardAlias": "我的共享卡",
        "balance": 0
      }
    ]
  }
}
`

### 第六步：查看卡片详情

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/cards/680861234567890abcdef" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

## 场景2：标准模式开卡并充值

### 申请标准模式卡片

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/apply" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "productCode": "STD001",
    "cardCurrency": "USD",
    "maxAuthAmount": "200",
    "cardAlias": "我的标准卡"
  }'
`

### 为标准卡充值

`ash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/topup" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "cardId": "680861234567890abcdef",
    "amount": 100.00,
    "customerOrderNo": "TOPUP_001"
  }'
`

## 场景3：账户余额和交易查询

### 查询账户余额

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

### 查询交易流水

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/transactions?CardId=680861234567890abcdef&TransactionStatus=Success&PageSize=10" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

### 查询资金明细

`ash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/cardAccountLogs?CardId=680861234567890abcdef&PageNumber=1&PageSize=20" \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIs..."
`

---

# 最佳实践

## 认证管理

1. **令牌缓存**：访问令牌有效期为1小时，建议在客户端缓存令牌，避免频繁获取
2. **令牌刷新**：在令牌过期前主动刷新，避免API调用中断
3. **安全存储**：客户端凭据应安全存储，不要硬编码在代码中

## 错误处理

1. **重试机制**：对于5xx错误和网络超时，实现指数退避重试
2. **错误日志**：记录完整的错误响应，包括responseId用于问题追踪
3. **业务异常**：根据业务错误码实现相应的处理逻辑

## 分页查询

1. **合理分页**：建议PageSize不超过100，避免单次请求数据量过大
2. **游标分页**：对于交易流水等大量数据，使用游标分页提高性能
3. **时间范围**：查询时间范围不建议超过3个月

## 幂等性

1. **客户订单号**：使用有意义的客户订单号确保操作幂等性
2. **状态检查**：在重要操作前先查询当前状态
3. **避免重复**：对于创建类操作，确保客户订单号唯一性

---

# 开发环境配置

## 测试环境信息

- **Base URL**: https://test.cardepass.com/openapi
- **OAuth2 Endpoint**: https://test.cardepass.com/openapi/connect/token
- **申请测试账号**: 请联系cardepass技术支持

## 生产环境信息

- **Base URL**: https://cardepass.com/openapi
- **OAuth2 Endpoint**: https://cardepass.com/openapi/connect/token
- **上线前确认**: 生产环境使用前需完成安全审核

## SDK支持

目前提供以下语言的SDK支持：
- JavaScript/Node.js
- Python
- Java
- C#/.NET
- PHP

SDK下载地址：https://docs.cardepass.com/sdk

---

# 联系我们

## 技术支持

- **邮箱**: support@cardepass.com
- **工单系统**: https://support.cardepass.com
- **响应时间**: 工作日24小时内响应

## 商务合作

- **邮箱**: business@cardepass.com
- **电话**: +86-400-xxx-xxxx

## 文档反馈

- **邮箱**: docs@cardepass.com
- **GitHub**: https://github.com/cardepass/docs

---

# 版本历史

| 版本号 | 发布日期   | 更新内容                           |
|--------|------------|------------------------------------|
| v2.0   | 2025-01-21 | 重新设计文档结构，优化字段说明     |
| v1.5   | 2024-12-15 | 新增交易流水查询接口               |
| v1.4   | 2024-11-10 | 优化错误码说明和示例               |
| v1.3   | 2024-10-05 | 新增标准模式卡充值接口             |
| v1.2   | 2024-09-01 | 新增共享余额模式限额调整接口       |
| v1.1   | 2024-08-15 | 优化认证流程和产品查询接口         |
| v1.0   | 2024-07-01 | 初始版本发布                       |

---

**文档最后更新时间**: 2025-01-21  
**文档版本**: v2.0  
**API版本**: v1  
**生成方式**: 基于OpenAPI 3.0规范手工优化

© 2025 Cardepass.com. All rights reserved.

