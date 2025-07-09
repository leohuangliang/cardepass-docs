# 卡系统API文档 v1

cardepass.com 卡系统OpenAPI接口文档

Base URLs:

* 测试环境: https://test.cardepass.com/openapi
* 生产环境: https://cardepass.com/openapi

## 认证方式

- HTTP认证，使用Bearer Token
- 需要先通过OAuth2获取访问令牌

---

# Token管理

## POST 获取访问令牌

**接口地址：** POST /connect/token

**功能描述：** 获取API访问令牌，用于后续所有API调用的身份验证

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                          |
|---------------|----------|----------|----------|------------|-----------------------------------|
| Content-Type  | header   | string   | 是       | 内容类型   | application/x-www-form-urlencoded |
| grant_type    | body     | string   | 是       | 授权类型   | 固定值：client_credentials        |
| client_id     | body     | string   | 是       | 客户端ID   | 客户端标识，需向cardepass申请     |
| client_secret | body     | string   | 是       | 客户端密钥 | 客户端密钥，需向cardepass申请     |
| scope         | body     | string   | 是       | 权限范围   | 固定值：openapi                   |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=your_client_id&client_secret=your_client_secret&scope=openapi"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000"
}
```

### 响应参数说明

| 参数名称     | 参数类型 | 中文名称 | 参数描述                           |
|--------------|----------|----------|------------------------------------|
| access_token | string   | 访问令牌 | 后续API调用需要的访问令牌          |
| expires_in   | integer  | 过期时间 | 令牌有效期（秒），默认3600秒=1小时 |
| token_type   | string   | 令牌类型 | 固定返回"Bearer"                   |
| scope        | string   | 权限范围 | 令牌权限范围                       |

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/ping" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "errorMessage": "Success"
}
```

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 产品管理

## GET 查询客户可用产品列表

**接口地址：** GET /v1/products

**功能描述：** 查询客户可用产品列表

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |
| request       | query    |          | 否       | request  | 获取产品信息请求      |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/products" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": [
    {
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardModels": [],
      "cardCurrency": [],
      "description": "示例文本"
    }
  ]
}
```

### 响应参数说明

| 参数名称        | 参数类型      | 中文名称           | 参数描述                                     |
|-----------------|---------------|--------------------|----------------------------------------------|
| responseId      | string        | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError        | boolean       | 是否有错误         | 是否有错误发生                               |
| errorCode       | string        | 错误码             | 错误代码                                     |
| errorMessage    | string        | 错误信息           | 错误信息                                     |
| data            | array         | 数据               |                                              |
| ├─ productCode  | string        | 产品编码           | 产品编号 (必填)                              |
| ├─ productName  | string        | 产品名称           | 产品名称 (必填)                              |
| ├─ cardModels   | array[string] | 支持的产品模式列表 | 支持的产品模式列表 (必填)                    |
| └─ cardCurrency | array[string] | 支持的结算币种列表 | 支持的结算币种列表 (必填)                    |
| └─ description  | string        | 产品介绍           | 产品介绍 (可选)                              |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 卡片管理

## GET 查询卡信息

**接口地址：** GET /v1/cards/{cardId}

**功能描述：** 查询卡信息

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |
| cardId        | path     | string   | 是       | 卡ID     | 卡ID                  |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/cards/CARD123456" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "查询成功",
  "data": {
    "cardId": "CARD123456",
    "cardModel": "Standard",
    "productCode": "PROD001",
    "cardNumber": "5042321234565678",
    "cvv": "123",
    "expirationMMYY": "12/26",
    "cardCurrency": "USD",
    "alias": "我的美元卡",
    "balanceAmount": 1250.5,
    "status": "Active",
    "maxAuthAmount": null,
    "usedCreditAmount": null,
    "maxCreditAmount": null,
    "cardOrganization": "Mastercard",
    "applyTime": "2025-01-10T08:00:00Z"
  }
}
```

### 响应参数说明

| 参数名称            | 参数类型 | 中文名称   | 参数描述                                               |
|---------------------|----------|------------|--------------------------------------------------------|
| responseId          | string   | 响应ID     | 响应Id，需调用方保存，用于排查调用遇到的问题           |
| hasError            | boolean  | 是否有错误 | 是否有错误发生                                         |
| errorCode           | string   | 错误码     | 错误代码                                               |
| errorMessage        | string   | 错误信息   | 错误信息                                               |
| data                | object   | 数据       | 卡片详细信息                                           |
| ├─ cardId           | string   | 卡ID       | 卡片唯一标识                                           |
| ├─ cardModel        | string   | 卡模式     | Standard=标准模式, ShareBalance=共享余额模式           |
| ├─ productCode      | string   | 产品编码   | 产品编码                                               |
| ├─ cardNumber       | string   | 卡号       | 完整卡号（16位）                                       |
| ├─ cvv              | string   | CVV        | 卡片安全码                                             |
| ├─ expirationMMYY   | string   | 过期时间   | 卡片过期时间，格式：MM/YY                              |
| ├─ cardCurrency     | string   | 卡币种     | 卡片结算币种（如：USD、EUR、GBP等）                    |
| ├─ alias            | string   | 卡别名     | 卡片别名（用户自定义名称）                             |
| └─ balanceAmount    | decimal  | 可用余额   | 当前可用余额                                           |
| └─ status           | string   | 卡状态     | Active=活跃, Blocked=冻结, Cancel=注销, Expired=已过期 |
| └─ maxAuthAmount    | decimal  | 单笔限额   | 共享余额模式：单笔最大授权金额                         |
| └─ usedCreditAmount | decimal  | 已消费额度 | 共享余额模式：已使用的信用额度                         |
| └─ maxCreditAmount  | decimal  | 总额度上限 | 共享余额模式：总信用额度上限（null表示无限制）         |
| └─ cardOrganization | string   | 卡组织     | 卡组织（Mastercard/VISA等）                            |
| └─ applyTime        | DateTime | 申请时间   | 卡片申请时间                                           |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 标准模式订单管理

## POST 【标准模式】开卡申请

**接口地址：** POST /v1/orders/standard/apply

**功能描述：** 【标准模式】开卡申请

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称           | 参数描述                            |
|-----------------|----------|----------|----------|--------------------|-------------------------------------|
| Authorization   | header   | string   | 是       | 授权头             | Bearer {access_token}               |
| Content-Type    | header   | string   | 是       | 内容类型           | application/json                    |
| productCode     | body     | string   | 是       | 产品编码           | 卡产品编码                          |
| cardCurrency    | body     | string   | 是       | 支持的结算币种列表 | 币种                                |
| topUpAmount     | body     | decimal  | 是       | 充值金额           | 开卡金额                            |
| cardAlias       | body     | string   | 否       | 卡别名             | 卡别名                              |
| customerOrderNo | body     | string   | 否       | 商户订单号         | 商户请求订单号（确保唯一性） (可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/apply" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "productCode": "PROD001",
        "cardCurrency": "USD",
        "topUpAmount": 100.0,
        "cardAlias": "我的美元卡",
        "customerOrderNo": "ORD20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "开卡成功",
  "data": {
    "orderNo": "ORD12345678",
    "productInfo": {
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "totalTopUpAmount": 100.0,
    "totalFee": 5.0,
    "totalPayAmount": 105.0,
    "totalCardCount": 1,
    "totalOpened": 1,
    "orderLines": [
      {
        "orderLineNo": 1,
        "topUpAmount": 100.0,
        "quantity": 1,
        "feeItems": [
          {
            "feeCode": "CARD_ISSUE",
            "feeName": "开卡费",
            "feeAmount": 5.0
          }
        ]
      }
    ],
    "cardInfos": [
      {
        "cardId": "CARD123456",
        "productCode": "PROD001",
        "productName": "美元虚拟卡",
        "cardCurrency": "USD",
        "maskCardNumber": "504232***4234",
        "cardModel": "Standard"
      }
    ],
    "status": "Completed",
    "payMessage": "支付成功",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:30Z",
    "paidOn": "2025-01-15T10:00:15Z",
    "completedOn": "2025-01-15T10:00:30Z",
    "customerOrderNo": "ORD20250115001"
  }
}
```

### 响应参数说明

| 参数名称            | 参数类型      | 中文名称           | 参数描述                                     |
|---------------------|---------------|--------------------|----------------------------------------------|
| responseId          | string        | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError            | boolean       | 是否有错误         | 是否有错误发生                               |
| errorCode           | string        | 错误码             | 错误代码                                     |
| errorMessage        | string        | 错误信息           | 错误信息                                     |
| data                | object        | 数据               |                                              |
| ├─ orderNo          | string        | 订单编号           | 订单编号 (必填)                              |
| ├─ productInfo      | object        | 产品信息           |                                              |
| │　├─ productCode   | string        | 产品编码           | 产品编码 (必填)                              |
| │　├─ productName   | string        | 产品名称           | 产品名称 (必填)                              |
| │　├─ cardModel     | string        | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式 |
| │　├─ cardCurrency  | string        | 支持的结算币种列表 | 卡结算币种                                   |
| ├─ totalTopUpAmount | decimal       | 总开卡金额         | 总开卡金额                                   |
| ├─ totalFee         | decimal       | 总手续费           | 总手续费                                     |
| ├─ totalPayAmount   | decimal       | 总支付金额         | 总支付金额                                   |
| ├─ totalCardCount   | integer       | 总卡数             | 总卡数                                       |
| ├─ totalOpened      | integer       | 已开卡数           | 已开卡数                                     |
| ├─ orderLines       | array[object] | 开卡订单明细       | 开卡订单明细 (可选)                          |
| ├─ cardInfos        | array[object] | 已开卡信息         | 已开卡信息 (可选)                            |
| └─ status           | string        | 状态               | 订单状态                                     |
| └─ payMessage       | string        | 支付信息           | 支付信息 (可选)                              |
| └─ orderType        | string        | 订单类型           | 订单类型                                     |
| └─ createdOn        | DateTime      | 创建时间           | 创建时间                                     |
| └─ modifiedOn       | DateTime      | 修改时间           | 修改时间                                     |
| └─ paidOn           | DateTime      | 支付时间           | 支付时间                                     |
| └─ completedOn      | DateTime      | 完成时间           | 完成时间                                     |
| └─ customerOrderNo  | string        | 商户订单号         | 商户请求订单号（确保唯一性） (可选)          |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【标准模式】卡充值

**接口地址：** POST /v1/orders/standard/topup

**功能描述：** 【标准模式】卡充值

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| topUpAmount     | body     | decimal  | 是       | 充值金额   | 充值金额. （最低充值金额为1）      |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/topup" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "topUpAmount": 200.0,
        "customerOrderNo": "TOP20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "productInfo": {
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "totalTopUpAmount": 100.0,
    "totalFee": 5.0,
    "totalPayAmount": 100.0,
    "totalCardCount": 1,
    "totalCompletedCardCount": 1,
    "orderLines": [],
    "status": "Completed",
    "payMessage": "支付成功",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "paidOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称                   | 参数类型      | 中文名称           | 参数描述                                     |
|----------------------------|---------------|--------------------|----------------------------------------------|
| responseId                 | string        | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError                   | boolean       | 是否有错误         | 是否有错误发生                               |
| errorCode                  | string        | 错误码             | 错误代码                                     |
| errorMessage               | string        | 错误信息           | 错误信息                                     |
| data                       | object        | 数据               |                                              |
| ├─ orderNo                 | string        | 订单编号           | 订单编号 (必填)                              |
| ├─ productInfo             | object        | 产品信息           |                                              |
| │　├─ productCode          | string        | 产品编码           | 产品编码 (必填)                              |
| │　├─ productName          | string        | 产品名称           | 产品名称 (必填)                              |
| │　├─ cardModel            | string        | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式 |
| │　├─ cardCurrency         | string        | 支持的结算币种列表 | 卡结算币种                                   |
| ├─ totalTopUpAmount        | decimal       | 总开卡金额         | 总充值金额                                   |
| ├─ totalFee                | decimal       | 总手续费           | 总手续费                                     |
| ├─ totalPayAmount          | decimal       | 总支付金额         | 总支付金额                                   |
| ├─ totalCardCount          | integer       | 总卡数             | 总卡数                                       |
| ├─ totalCompletedCardCount | integer       | 已充值卡数         | 已充值卡数                                   |
| ├─ orderLines              | array[object] | 开卡订单明细       | 开卡订单明细 (可选)                          |
| └─ status                  | string        | 状态               | 订单状态                                     |
| └─ payMessage              | string        | 支付信息           | 支付信息 (可选)                              |
| └─ orderType               | string        | 订单类型           | 卡订单类型                                   |
| └─ createdOn               | DateTime      | 创建时间           | 创建时间                                     |
| └─ modifiedOn              | DateTime      | 修改时间           | 修改时间                                     |
| └─ paidOn                  | DateTime      | 支付时间           | 支付时间                                     |
| └─ completedOn             | DateTime      | 完成时间           | 完成时间                                     |
| └─ customerOrderNo         | string        | 商户订单号         | 商户请求订单号（确保唯一性）(可选)           |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【标准模式】卡冻结

**接口地址：** POST /v1/orders/standard/block

**功能描述：** 【标准模式】卡冻结

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/block" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "BLK20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "note": "备注信息",
    "isBlocked": false,
    "status": "Completed",
    "failureReason": "",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号 (必填)                                          |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ note              | string   | 备注               | 备注 (必填)                                              |
| ├─ isBlocked         | boolean  | 是否渠道已冻结     | 是否渠道已冻结                                           |
| ├─ status            | string   | 状态               | 订单状态                                                 |
| ├─ failureReason     | string   | 失败原因           | 失败原因 (必填)                                          |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ modifiedOn        | DateTime | 修改时间           | 修改时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 商户请求订单号（确保唯一性）(可选)                       |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【标准模式】卡解冻

**接口地址：** POST /v1/orders/standard/unblock

**功能描述：** 【标准模式】卡解冻

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/unblock" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "UBK20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "note": "备注信息",
    "status": "Completed",
    "failureReason": "",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号 (必填)                                          |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ note              | string   | 备注               | 备注 (必填)                                              |
| ├─ status            | string   | 状态               | 订单状态                                                 |
| ├─ failureReason     | string   | 失败原因           | 失败原因 (必填)                                          |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ modifiedOn        | DateTime | 修改时间           | 修改时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 商户请求订单号（确保唯一性）(可选)                       |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【标准模式】销卡

**接口地址：** POST /v1/orders/standard/cancel

**功能描述：** 【标准模式】销卡

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/cancel" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "CNL20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "fee": 100.0,
    "chargeMethodType": "示例文本",
    "fixedValue": 0,
    "percent": 0.01,
    "settleAmount": 100.0,
    "note": "备注信息",
    "status": "Completed",
    "settleStatus": "示例文本",
    "orderType": "ApplyCard",
    "failureReason": "",
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号                                                 |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ fee               | decimal  | 销卡手续费         | 销卡手续费                                               |
| ├─ chargeMethodType  | string   | 收费方式           | 收费方式                                                 |
| ├─ fixedValue        | decimal  | 固定金额           | 固定金额                                                 |
| ├─ percent           | decimal  | 百分比             | 百分比。小数格式                                         |
| ├─ settleAmount      | decimal  | 结算金额           | 结算金额                                                 |
| ├─ note              | string   | 备注               | 备注 (必填)                                              |
| └─ status            | string   | 状态               | 订单状态                                                 |
| └─ settleStatus      | string   | 结算状态           | 结算状态                                                 |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ failureReason     | string   | 失败原因           | 失败原因                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 商户请求订单号（确保唯一性）(可选)                       |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【标准模式】卡余额转出

**接口地址：** POST /v1/orders/standard/withdraw

**功能描述：** 【标准模式】卡余额转出

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| withdrawAmount  | body     | decimal  | 否       | 转出金额   | 转出金额                           |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/withdraw" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "withdrawAmount": 50.0,
        "customerOrderNo": "WTD20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardId": "CARD123456",
    "withdrawAmount": 100.0,
    "withdrawFee": 0,
    "totalAmount": 100.0,
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称           | 参数类型 | 中文名称   | 参数描述                                     |
|--------------------|----------|------------|----------------------------------------------|
| responseId         | string   | 响应ID     | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError           | boolean  | 是否有错误 | 是否有错误发生                               |
| errorCode          | string   | 错误码     | 错误代码                                     |
| errorMessage       | string   | 错误信息   | 错误信息                                     |
| data               | object   | 数据       |                                              |
| ├─ orderNo         | string   | 订单编号   | 订单编号 (必填)                              |
| ├─ cardId          | string   | 卡ID       | 卡ID (必填)                                  |
| ├─ withdrawAmount  | decimal  | 转出金额   | 转出金额                                     |
| ├─ withdrawFee     | decimal  | 转出手续费 | 转出手续费                                   |
| ├─ totalAmount     | decimal  | 订单总金额 | 总金额（转出金额+手续费）                    |
| ├─ status          | string   | 状态       | 订单状态                                     |
| └─ orderType       | string   | 订单类型   | 订单类型                                     |
| └─ createdOn       | DateTime | 创建时间   | 创建时间                                     |
| └─ modifiedOn      | DateTime | 修改时间   | 修改时间                                     |
| └─ completedOn     | DateTime | 完成时间   | 完成时间                                     |
| └─ customerOrderNo | string   | 商户订单号 | 商户请求订单号 (可选)                        |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## GET 标准模式类型的订单查询。

包括：开卡、充值、冻结、解冻、销卡、卡余额转出

**接口地址：** GET /v1/orders/standard

**功能描述：** 标准模式类型的订单查询。

包括：开卡、充值、冻结、解冻、销卡、卡余额转出

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                                                                                                                                         |
|-----------------|----------|----------|----------|------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}                                                                                                                            |
| OrderType       | query    | string   | 否       | 订单类型   | 订单类型: ApplyCard 开卡订单、CardTopUp 充值订单、CardCancel 销卡订单、CardBlock 卡冻结订单、CardUnblock 卡解冻订单、CardWithdraw 卡余额转出订单 |
| OrderNo         | query    | string   | 否       | 订单号     | 订单号 (可选)                                                                                                                                    |
| CustomerOrderNo | query    | string   | 否       | 商户订单号 | 商户订单号 (可选)                                                                                                                                |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/orders/standard?OrderType=ApplyCard" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {}
}
```

### 响应参数说明

| 参数名称 | 参数类型 | 中文名称 | 参数描述       |
|----------|----------|----------|----------------|
| data     |          | 数据     | 标准卡订单详情 |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 共享余额模式订单管理

## POST 【共享余额模式】开卡申请

**接口地址：** POST /v1/orders/sharebalance/apply

**功能描述：** 【共享余额模式】开卡申请

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称           | 参数描述                                  |
|-----------------|----------|----------|----------|--------------------|-------------------------------------------|
| Authorization   | header   | string   | 是       | 授权头             | Bearer {access_token}                     |
| Content-Type    | header   | string   | 是       | 内容类型           | application/json                          |
| productCode     | body     | string   | 是       | 产品编码           | 卡产品编码                                |
| cardCurrency    | body     | string   | 是       | 支持的结算币种列表 | 币种                                      |
| maxAuthAmount   | body     | decimal  | 是       | 单笔限额           | 单笔限额                                  |
| maxCreditAmount | body     | decimal  | 否       | 总额度上限         | 单卡消费总额度,可以为空，为空表示不限额度 |
| cardAlias       | body     | string   | 否       | 卡别名             | 卡别名                                    |
| customerOrderNo | body     | string   | 否       | 商户订单号         | 商户请求订单号（确保唯一性） (可选)       |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/apply" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "productCode": "PROD001",
        "cardCurrency": "USD",
        "maxAuthAmount": 500.0,
        "maxCreditAmount": 10000.0,
        "customerOrderNo": "SB20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "productInfo": {
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardModel": "Standard",
      "cardCurrency": "USD"
    },
    "quantity": 1,
    "maxAuthAmount": 100.0,
    "maxCreditAmount": 100.0,
    "totalAmount": 100.0,
    "transAmount": 100.0,
    "transFee": 0,
    "openedQty": 1,
    "cardInfos": [],
    "note": "备注信息",
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称           | 参数类型      | 中文名称           | 参数描述                                     |
|--------------------|---------------|--------------------|----------------------------------------------|
| responseId         | string        | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError           | boolean       | 是否有错误         | 是否有错误发生                               |
| errorCode          | string        | 错误码             | 错误代码                                     |
| errorMessage       | string        | 错误信息           | 错误信息                                     |
| data               | object        | 数据               |                                              |
| ├─ orderNo         | string        | 订单编号           | 订单编号                                     |
| ├─ productInfo     | object        | 产品信息           |                                              |
| │　├─ productCode  | string        | 产品编码           | 产品编码 (必填)                              |
| │　├─ productName  | string        | 产品名称           | 产品名称 (必填)                              |
| │　├─ cardModel    | string        | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式 |
| │　├─ cardCurrency | string        | 支持的结算币种列表 | 卡结算币种                                   |
| ├─ quantity        | integer       | 申请数量           | 开卡数                                       |
| ├─ maxAuthAmount   | decimal       | 单笔限额           | 单笔限额                                     |
| ├─ maxCreditAmount | decimal       | 总额度上限         | 单卡消费总额度,可以为空，为空表示不限额度    |
| ├─ totalAmount     | decimal       | 订单总金额         | 总交易金额                                   |
| └─ transAmount     | decimal       | transAmount        | 交易金额                                     |
| └─ transFee        | decimal       | 手续费             | 开卡手续费(交易手续费)                       |
| └─ openedQty       | integer       | 已开卡数           | 已开卡数                                     |
| └─ cardInfos       | array[object] | 已开卡信息         | 已开卡信息                                   |
| └─ note            | string        | 备注               | 备注                                         |
| └─ status          | string        | 状态               | 订单状态                                     |
| Failure-处理失败   |               |                    |                                              |
| ├─ orderType       | string        | 订单类型           | 订单类型                                     |
| ├─ createdOn       | DateTime      | 创建时间           | 创建时间                                     |
| ├─ modifiedOn      | DateTime      | 修改时间           | 修改时间                                     |
| └─ completedOn     | DateTime      | 完成时间           | 完成时间                                     |
| └─ customerOrderNo | string        | 商户订单号         | 客户订单号                                   |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【共享余额模式】修改限额

**接口地址：** POST /v1/orders/sharebalance/creditLimit

**功能描述：** 【共享余额模式】修改限额

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                                |
|-----------------|----------|----------|----------|------------|-----------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}                   |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                        |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                             |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选)      |
| maxAuthAmount   | body     | decimal  | 是       | 单笔限额   | 共享模式： 单笔限额                     |
| maxCreditAmount | body     | decimal  | 否       | 总额度上限 | 共享模式: 总额度。额度为空表示 不限制。 |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/creditLimit" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD789012",
        "maxAuthAmount": 1000.0,
        "maxCreditAmount": 20000.0,
        "customerOrderNo": "LMT20250115001"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardId": "CARD123456",
    "maxAuthAmount": 100.0,
    "maxCreditAmount": 100.0,
    "status": "Completed",
    "orderType": "ApplyCard",
    "failureReason": "",
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称           | 参数类型 | 中文名称   | 参数描述                                     |
|--------------------|----------|------------|----------------------------------------------|
| responseId         | string   | 响应ID     | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError           | boolean  | 是否有错误 | 是否有错误发生                               |
| errorCode          | string   | 错误码     | 错误代码                                     |
| errorMessage       | string   | 错误信息   | 错误信息                                     |
| data               | object   | 数据       |                                              |
| ├─ orderNo         | string   | 订单编号   | 共享卡限额修改订单编号                       |
| ├─ cardId          | string   | 卡ID       | 卡ID                                         |
| ├─ maxAuthAmount   | decimal  | 单笔限额   | 单笔限额                                     |
| ├─ maxCreditAmount | decimal  | 总额度上限 | 总限额，为空表示不限制                       |
| ├─ status          | string   | 状态       | 卡限额修改状态                               |
| └─ orderType       | string   | 订单类型   | 订单类型                                     |
| └─ failureReason   | string   | 失败原因   | 失败原因                                     |
| └─ createdOn       | DateTime | 创建时间   | 创建时间                                     |
| └─ completedOn     | DateTime | 完成时间   | 完成时间                                     |
| └─ customerOrderNo | string   | 商户订单号 | 客户订单号                                   |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【共享余额模式】冻结卡

**接口地址：** POST /v1/orders/sharebalance/block

**功能描述：** 【共享余额模式】冻结卡

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/block" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "example": "data"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "note": "备注信息",
    "isBlocked": false,
    "status": "Completed",
    "failureReason": "",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号                                                 |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ note              | string   | 备注               | 备注                                                     |
| ├─ isBlocked         | boolean  | 是否渠道已冻结     | 是否渠道已冻结                                           |
| ├─ status            | string   | 状态               | 订单状态                                                 |
| ├─ failureReason     | string   | 失败原因           | 失败原因                                                 |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ modifiedOn        | DateTime | 修改时间           | 修改时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 客户请求订单号（确保唯一性）                             |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【共享余额模式】解冻卡

**接口地址：** POST /v1/orders/sharebalance/unblock

**功能描述：** 【共享余额模式】解冻卡

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/unblock" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "example": "data"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "note": "备注信息",
    "status": "Completed",
    "failureReason": "",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号                                                 |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ note              | string   | 备注               | 备注                                                     |
| ├─ status            | string   | 状态               | 订单状态                                                 |
| ├─ failureReason     | string   | 失败原因           | 失败原因                                                 |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ modifiedOn        | DateTime | 修改时间           | 修改时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 客户请求订单号（确保唯一性）                             |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## POST 【共享余额模式】销卡

**接口地址：** POST /v1/orders/sharebalance/cancel

**功能描述：** 【共享余额模式】销卡

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                           |
|-----------------|----------|----------|----------|------------|------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}              |
| Content-Type    | header   | string   | 是       | 内容类型   | application/json                   |
| cardId          | body     | string   | 是       | 卡ID       | 卡ID (必填)                        |
| customerOrderNo | body     | string   | 否       | 商户订单号 | 商户请求订单号（确保唯一性）(可选) |

### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/cancel" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "example": "data"
  }'
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD12345678",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "Standard"
    },
    "fee": 100.0,
    "chargeMethodType": "示例文本",
    "fixedValue": 0,
    "percent": 0.01,
    "note": "备注信息",
    "status": "Completed",
    "orderType": "ApplyCard",
    "settleStatus": "示例文本",
    "failureReason": "",
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

### 响应参数说明

| 参数名称             | 参数类型 | 中文名称           | 参数描述                                                 |
|----------------------|----------|--------------------|----------------------------------------------------------|
| responseId           | string   | 响应ID             | 响应Id，需调用方保存，用于排查调用遇到的问题             |
| hasError             | boolean  | 是否有错误         | 是否有错误发生                                           |
| errorCode            | string   | 错误码             | 错误代码                                                 |
| errorMessage         | string   | 错误信息           | 错误信息                                                 |
| data                 | object   | 数据               |                                                          |
| ├─ orderNo           | string   | 订单编号           | 订单编号                                                 |
| ├─ cardInfo          | object   | 卡信息             |                                                          |
| │　├─ cardId         | string   | 卡ID               | 卡ID                                                     |
| │　├─ productCode    | string   | 产品编码           | 产品编码                                                 |
| │　├─ productName    | string   | 产品名称           | 产品名称                                                 |
| │　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                                 |
| │　├─ maskCardNumber | string   | 脱敏卡号           | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| │　├─ cardModel      | string   | 卡模式             | Standard=标准模式, ShareBalance=共享余额模式             |
| ├─ fee               | decimal  | 销卡手续费         | 销卡手续费                                               |
| ├─ chargeMethodType  | string   | 收费方式           | 收费方式                                                 |
| ├─ fixedValue        | decimal  | 固定金额           | 固定金额                                                 |
| ├─ percent           | decimal  | 百分比             | 百分比。小数格式                                         |
| ├─ note              | string   | 备注               | 备注                                                     |
| └─ status            | string   | 状态               | 订单状态                                                 |
| └─ orderType         | string   | 订单类型           | 订单类型                                                 |
| └─ settleStatus      | string   | 结算状态           | 结算状态                                                 |
| └─ failureReason     | string   | 失败原因           | 失败原因                                                 |
| └─ createdOn         | DateTime | 创建时间           | 创建时间                                                 |
| └─ completedOn       | DateTime | 完成时间           | 完成时间                                                 |
| └─ customerOrderNo   | string   | 商户订单号         | 客户请求订单号（确保唯一性）                             |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## GET 【共享余额模式】订单查询。

包括：开卡、修改限额、冻结、解冻、销卡

**接口地址：** GET /v1/orders/sharebalance

**功能描述：** 【共享余额模式】订单查询。

包括：开卡、修改限额、冻结、解冻、销卡

### 请求参数

| 参数名称        | 参数位置 | 参数类型 | 是否必填 | 中文名称   | 参数描述                                                                                                                             |
|-----------------|----------|----------|----------|------------|--------------------------------------------------------------------------------------------------------------------------------------|
| Authorization   | header   | string   | 是       | 授权头     | Bearer {access_token}                                                                                                                |
| OrderType       | query    | string   | 否       | 订单类型   | 订单类型：ApplyCard（开卡订单）、CreditLimit（调整限额）、CardCancel（销卡订单）、CardBlock（卡冻结订单）、CardUnblock（卡解冻订单） |
| OrderNo         | query    | string   | 否       | 订单号     | 订单号                                                                                                                               |
| CustomerOrderNo | query    | string   | 否       | 商户订单号 | 商户订单号                                                                                                                           |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?OrderType=ApplyCard" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {}
}
```

### 响应参数说明

| 参数名称 | 参数类型 | 中文名称 | 参数描述         |
|----------|----------|----------|------------------|
| data     |          | 数据     | 共享模式订单详情 |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 客户账户管理

## GET 获取客户资金账户余额信息

**接口地址：** GET /v1/accounts

**功能描述：** 获取客户资金账户余额信息

### 请求参数

| 参数名称      | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------|----------|----------|----------|----------|-----------------------|
| Authorization | header   | string   | 是       | 授权头   | Bearer {access_token} |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": [
    {
      "currency": "示例文本",
      "amount": 0
    }
  ]
}
```

### 响应参数说明

| 参数名称     | 参数类型 | 中文名称   | 参数描述                                     |
|--------------|----------|------------|----------------------------------------------|
| responseId   | string   | 响应ID     | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError     | boolean  | 是否有错误 | 是否有错误发生                               |
| errorCode    | string   | 错误码     | 错误代码                                     |
| errorMessage | string   | 错误信息   | 错误信息                                     |
| data         | array    | 数据       |                                              |
| ├─ currency  | string   | 货币类型   | 币种 (可选)                                  |
| └─ amount    | decimal  | 金额       | 金额值                                       |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## GET 【标准模式】分页查询卡资金明细（不含交易）

**接口地址：** GET /v1/accounts/cardAccountLogs

**功能描述：** 【标准模式】分页查询卡资金明细（不含交易）

### 请求参数

| 参数名称            | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------------|----------|----------|----------|----------|-----------------------|
| Authorization       | header   | string   | 是       | 授权头   | Bearer {access_token} |
| CardId              | query    | string   | 否       | 卡片ID   | 卡ID (可选)           |
| TransactionDateFrom | query    | DateTime | 否       | 开始日期 | 开始交易日期          |
| TransactionDateTo   | query    | DateTime | 否       | 结束日期 | 结束交易日期          |
| PageNumber          | query    | integer  | 否       | 页码     | 当前页                |
| PageSize            | query    | integer  | 否       | 页大小   | 分页大小              |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/cardAccountLogs?CardId=CARD123456" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "totalPages": 0,
    "totalRecords": 0,
    "data": [],
    "pageNumber": 0,
    "pageSize": 0
  }
}
```

### 响应参数说明

| 参数名称        | 参数类型      | 中文名称     | 参数描述                                     |
|-----------------|---------------|--------------|----------------------------------------------|
| responseId      | string        | 响应ID       | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError        | boolean       | 是否有错误   | 是否有错误发生                               |
| errorCode       | string        | 错误码       | 错误代码                                     |
| errorMessage    | string        | 错误信息     | 错误信息                                     |
| data            | object        | 数据         |                                              |
| ├─ totalPages   | integer       | totalPages   | 总页数                                       |
| ├─ totalRecords | long          | totalRecords | 总记录数                                     |
| ├─ data         | array[object] | 数据         | 数据 (必填)                                  |
| └─ pageNumber   | integer       | pageNumber   | 当前页                                       |
| └─ pageSize     | integer       | pageSize     | 分页数量                                     |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

## GET 分页查询 资金账户资金明细

**接口地址：** GET /v1/accounts/accountLogs

**功能描述：** 分页查询 资金账户资金明细

### 请求参数

| 参数名称            | 参数位置 | 参数类型 | 是否必填 | 中文名称 | 参数描述              |
|---------------------|----------|----------|----------|----------|-----------------------|
| Authorization       | header   | string   | 是       | 授权头   | Bearer {access_token} |
| TransactionDateFrom | query    | DateTime | 否       | 开始日期 | 开始交易日期          |
| TransactionDateTo   | query    | DateTime | 否       | 结束日期 | 结束交易日期          |
| Limit               | query    | integer  | 否       | 限制数量 |                       |
| Offset              | query    | integer  | 否       | 偏移量   |                       |

### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/accountLogs" \
  -H "Authorization: Bearer your_access_token"
```

### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "pageNumber": 0,
    "pageSize": 0,
    "totalRecords": 0,
    "totalPages": 0,
    "data": []
  }
}
```

### 响应参数说明

| 参数名称        | 参数类型      | 中文名称     | 参数描述                                     |
|-----------------|---------------|--------------|----------------------------------------------|
| responseId      | string        | 响应ID       | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError        | boolean       | 是否有错误   | 是否有错误发生                               |
| errorCode       | string        | 错误码       | 错误代码                                     |
| errorMessage    | string        | 错误信息     | 错误信息                                     |
| data            | object        | 数据         |                                              |
| ├─ pageNumber   | integer       | pageNumber   |                                              |
| ├─ pageSize     | integer       | pageSize     |                                              |
| ├─ totalRecords | integer       | totalRecords |                                              |
| └─ totalPages   | integer       | totalPages   |                                              |
| └─ data         | array[object] | 数据         |                                              |

### 状态码说明

| 状态码 | 说明     | 解决方案         |
|--------|----------|------------------|
| 200    | 成功     | 请求处理成功     |
| 401    | 未授权   | 重新获取访问令牌 |
| 403    | 禁止访问 | 检查权限设置     |

---

# 错误码说明

## 通用错误码

| 错误码 | HTTP状态码 | 错误说明           | 解决方案                 |
|--------|------------|--------------------|--------------------------|
| 401    | 401        | 访问令牌无效或过期 | 重新获取访问令牌         |
| 403    | 403        | 权限不足           | 检查账户权限或联系管理员 |
| 404    | 404        | 请求的资源不存在   | 检查请求的资源ID是否正确 |
| 400    | 400        | 请求参数错误       | 检查请求参数格式和内容   |
| 429    | 429        | 请求频率超限       | 降低请求频率或等待后重试 |
| 500    | 500        | 服务器内部错误     | 稍后重试或联系技术支持   |

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
2. **时间范围**：查询时间范围不建议超过3个月
3. **索引使用**：使用cardId等索引字段提高查询效率

## 幂等性

1. **客户订单号**：使用有意义的客户订单号确保操作幂等性
2. **状态检查**：在重要操作前先查询当前状态
3. **避免重复**：对于创建类操作，确保客户订单号唯一性

---

# 版本历史

| 版本号 | 发布日期   | 更新内容 |
|--------|------------|----------|
| v1.0   | 2025-06-26 | 第一版   |

---

**文档最后更新时间**: 2025-06-26
**文档版本**: v1.0
**API版本**: v1
**生成方式**: 基于OpenAPI规范(swagger.json)自动生成

© 2025 Cardepass.com. All rights reserved.







