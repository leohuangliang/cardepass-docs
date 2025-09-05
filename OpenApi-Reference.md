# 卡系统API文档 v1

cardepass.com 卡系统OpenAPI接口文档

Base URLs:

* 测试环境: https://test.cardepass.com/openapi
* 生产环境: https://cardepass.com/openapi

## 目录

- [认证方式](#认证方式)
- [Token管理](#token管理)
  - [POST 获取访问令牌](#post-获取访问令牌)
  - [GET 健康检查](#get-健康检查)
- [产品管理](#产品管理)
  - [GET 查询客户可用产品列表](#get-查询客户可用产品列表)
- [卡片管理](#卡片管理)
  - [GET 查询卡信息](#get-查询卡信息)

- [标准模式订单管理](#标准模式订单管理)
  - [POST 【标准模式】开卡申请](#post-标准模式开卡申请)
  - [POST 【标准模式】卡充值](#post-标准模式卡充值)
  - [POST 【标准模式】卡冻结](#post-标准模式卡冻结)
  - [POST 【标准模式】卡解冻](#post-标准模式卡解冻)
  - [POST 【标准模式】销卡](#post-标准模式销卡)
  - [POST 【标准模式】卡余额转出](#post-标准模式卡余额转出)
  - [GET 标准模式类型的订单查询](#get-标准模式类型的订单查询)
- [共享余额模式订单管理](#共享余额模式订单管理)
  - [POST 【共享余额模式】开卡申请](#post-共享余额模式开卡申请)
  - [POST 【共享余额模式】修改限额](#post-共享余额模式修改限额)
  - [POST 【共享余额模式】冻结卡](#post-共享余额模式冻结卡)
  - [POST 【共享余额模式】解冻卡](#post-共享余额模式解冻卡)
  - [POST 【共享余额模式】销卡](#post-共享余额模式销卡)
  - [GET 【共享余额模式】订单查询](#get-共享余额模式订单查询)
- [客户账户管理](#客户账户管理)
  - [GET 获取客户资金账户余额信息](#get-获取客户资金账户余额信息)
  - [GET 分页查询卡资金明细](#get-分页查询卡资金明细)
  - [GET 分页查询客户账户资金明细](#get-分页查询客户账户资金明细)
- [交易管理](#交易管理)
  - [GET 查询交易流水（分页）](#get-查询交易流水分页)
- [错误码说明](#错误码说明)
- [最佳实践](#最佳实践)
- [版本历史](#版本历史)

---

## 认证方式

- HTTP认证，使用Bearer Token
- 需要先通过OAuth2获取访问令牌

---

## Token管理

### POST 获取访问令牌

**接口地址：** POST /connect/token

**功能描述：** 获取API访问令牌，用于后续所有API调用的身份验证

#### 请求参数

| 参数名称          | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                              |
|---------------|--------|--------|------|-------|-----------------------------------|
| Content-Type  | header | string | 是    | 内容类型  | application/x-www-form-urlencoded |
| grant_type    | body   | string | 是    | 授权类型  | 固定值：client_credentials            |
| client_id     | body   | string | 是    | 客户端ID | 客户端标识，需向cardepass申请               |
| client_secret | body   | string | 是    | 客户端密钥 | 客户端密钥，需向cardepass申请               |
| scope         | body   | string | 是    | 权限范围  | 固定值：openapi                       |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=your_client_id&client_secret=your_client_secret&scope=openapi"
```

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000"
}
```

#### 响应参数说明

| 参数名称         | 参数类型    | 中文名称 | 参数描述                 |
|--------------|---------|------|----------------------|
| access_token | string  | 访问令牌 | 后续API调用需要的访问令牌       |
| expires_in   | integer | 过期时间 | 令牌有效期（秒），默认3600秒=1小时 |
| token_type   | string  | 令牌类型 | 固定返回"Bearer"         |
| scope        | string  | 权限范围 | 令牌权限范围               |



#### 状态码说明

| 状态码 | 错误码 | 说明   | 解决方案     |
|-----|------|------|----------|
| 200 | - | 成功   | 请求处理成功   |
| 401 | - | 未授权  | 重新获取访问令牌 |
| 403 | - | 禁止访问 | 检查权限设置   |

### GET 健康检查

**接口地址：** GET /v1/ping

**功能描述：** 检查API服务状态和连接有效性

#### 请求参数

| 参数名称          | 参数位置   | 参数类型   | 是否必填 | 中文名称 | 参数描述                  |
|---------------|--------|--------|------|------|-----------------------|
| Authorization | header | string | 是    | 授权头  | Bearer {access_token} |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/ping" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "errorMessage": "Success"
}
```

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 400 | 参数错误 | 检查请求参数是否正确 |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |
| 500 | 系统错误 | 联系技术支持   |

---

## 产品管理

### GET 查询客户可用产品列表

**接口地址：** GET /v1/products

**功能描述：** 查询客户可用产品列表

#### 请求参数

| 参数名称          | 参数位置   | 参数类型   | 是否必填 | 中文名称 | 参数描述                  |
|---------------|--------|--------|------|------|-----------------------|
| Authorization | header | string | 是    | 授权头  | Bearer {access_token} |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/products" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

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
      "cardModels": ["Standard", "ShareBalance"],
      "cardCurrency": ["USD", "EUR", "GBP"],
      "description": "美元虚拟卡产品，支持标准模式和共享余额模式",
      "cardBinConfigs": [
        {
          "cardModel": "Standard",
          "currency": "USD",
          "cardBin": "504232",
          "minPreTopUpAmount": 10.0,
          "minTopUpAmount": 1.0,
          "openCardAmountPrecision": "DecimalAllowed",
          "openCardAmountPrecisionDescription": "支持小数（最多2位小数）",
          "topUpAmountPrecision": "DecimalAllowed",
          "topUpAmountPrecisionDescription": "支持小数（最多2位小数）",
          "permissions": {
            "allowOpenCard": true,
            "allowTopUpCard": true,
            "allowBlockCard": true,
            "allowUnBlockCard": true,
            "allowCancelCard": true,
            "allowWithdraw": false
          }
        },
        {
          "cardModel": "ShareBalance",
          "currency": "USD",
          "cardBin": "504233",
          "minPreTopUpAmount": null,
          "minTopUpAmount": null,
          "openCardAmountPrecision": "DecimalAllowed",
          "openCardAmountPrecisionDescription": "支持小数（最多2位小数）",
          "topUpAmountPrecision": "DecimalAllowed",
          "topUpAmountPrecisionDescription": "支持小数（最多2位小数）",
          "permissions": {
            "allowOpenCard": true,
            "allowTopUpCard": false,
            "allowBlockCard": true,
            "allowUnBlockCard": true,
            "allowCancelCard": true,
            "allowWithdraw": true
          }
        }
      ]
    }
  ]
}
```

#### 响应参数说明

| 参数名称                                    | 参数类型          | 中文名称        | 参数描述                                                    |
|-----------------------------------------|---------------|-------------|-------------------------------------------------------|
| responseId                              | string        | 响应ID        | 响应Id，需调用方保存，用于排查调用遇到的问题                               |
| hasError                                | boolean       | 是否有错误       | 是否有错误发生                                               |
| errorCode                               | string        | 错误码         | 错误代码                                                  |
| errorMessage                            | string        | 错误信息        | 错误信息                                                  |
| data                                    | array         | 数据          | 产品组信息列表                                               |
| ├─ productCode                          | string        | 产品编码        | 产品编号 (必填)                                             |
| ├─ productName                          | string        | 产品名称        | 产品名称 (必填)                                             |
| ├─ cardModels                           | array[string] | 支持的卡模式列表    | 支持的卡模式列表，可选值：Standard(标准模式), ShareBalance(共享余额模式) (必填) |
| ├─ cardCurrency                         | array[string] | 支持的结算币种列表   | 支持的结算币种列表，如：USD, EUR, GBP, CNY等 (必填)                  |
| ├─ description                          | string        | 产品介绍        | 产品介绍 (可选)                                             |
| └─ cardBinConfigs                       | array[object] | 卡BIN配置列表    | 卡片操作配置信息列表 (必填)                                       |
| ├─ cardModel                         | string        | 卡模式         | 卡模式：Standard或ShareBalance                             |
| ├─ currency                          | string        | 卡币种         | 卡片结算币种                                                |
| ├─ cardBin                           | string        | 卡BIN         | 卡片BIN号码                                               |
| ├─ minPreTopUpAmount                 | decimal       | 最小预充值金额     | 开卡时最小预充值金额（共享余额模式为null）                            |
| ├─ minTopUpAmount                    | decimal       | 最小充值金额      | 单次最小充值金额（共享余额模式为null）                              |
| ├─ openCardAmountPrecision           | string        | 开卡金额精度类型    | 开卡金额精度类型：IntegerOnly或DecimalAllowed                   |
| ├─ openCardAmountPrecisionDescription | string        | 开卡金额精度描述    | 开卡金额精度类型的中文描述                                         |
| ├─ topUpAmountPrecision              | string        | 充值金额精度类型    | 充值金额精度类型：IntegerOnly或DecimalAllowed                   |
| ├─ topUpAmountPrecisionDescription   | string        | 充值金额精度描述    | 充值金额精度类型的中文描述                                         |
| └─ permissions                       | object        | 权限配置        | 详细的卡片操作权限配置                                           |
| 　├─ allowOpenCard                  | boolean       | 是否允许开卡      | 是否允许开卡操作                                              |
| 　├─ allowTopUpCard                 | boolean       | 是否允许充值      | 是否允许充值操作                                              |
| 　├─ allowBlockCard                 | boolean       | 是否允许冻结      | 是否允许冻结操作                                              |
| 　├─ allowUnBlockCard               | boolean       | 是否允许解冻      | 是否允许解冻操作                                              |
| 　├─ allowCancelCard                | boolean       | 是否允许销卡      | 是否允许销卡操作                                              |
| 　└─ allowWithdraw                  | boolean       | 是否允许余额提取    | 是否允许余额提取操作                                            |

#### 枚举值说明

**CardModel (卡模式):**
- `Standard`: 标准模式
- `ShareBalance`: 共享余额模式

**Currency (常用币种):**
- `USD`: 美元
- `EUR`: 欧元
- `GBP`: 英镑
- `CNY`: 人民币
- `HKD`: 港币
- `JPY`: 日元
- `SGD`: 新加坡元
- `AUD`: 澳元
- `CAD`: 加拿大元

**AmountPrecisionType (金额精度类型):**
- `IntegerOnly`: 仅支持整数
- `DecimalAllowed`: 支持小数（最多2位小数）

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

## 卡片管理

### GET 查询卡信息

**接口地址：** GET /v1/cards/{cardId}

**功能描述：** 查询卡信息

#### 请求参数

| 参数名称          | 参数位置   | 参数类型   | 是否必填 | 中文名称 | 参数描述                  |
|---------------|--------|--------|------|------|-----------------------|
| Authorization | header | string | 是    | 授权头  | Bearer {access_token} |
| cardId        | path   | string | 是    | 卡ID  | 卡ID                   |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/cards/CARD123456" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

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
    "applyTime": "2025-01-10T08:00:00Z",
    "permissions": {
      "allowOpenCard": true,
      "allowTopUpCard": true,
      "allowBlockCard": true,
      "allowUnBlockCard": true,
      "allowCancelCard": true,
      "allowWithdraw": true
    }
  }
}
```

#### 卡冻结订单查询响应示例 (orderType=CardBlock)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115004",
    "cardId": "CARD123456",
    "blockReason": "用户申请冻结",
    "status": "Completed",
    "orderType": "CardBlock",
    "createdOn": "2025-01-15T17:00:00Z",
    "modifiedOn": "2025-01-15T17:01:00Z",
    "completedOn": "2025-01-15T17:01:00Z",
    "customerOrderNo": "CUST20250115004"
  }
}
```

#### 卡解冻订单查询响应示例 (orderType=CardUnblock)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115005",
    "cardId": "CARD123456",
    "unblockReason": "用户申请解冻",
    "status": "Completed",
    "orderType": "CardUnblock",
    "createdOn": "2025-01-15T18:00:00Z",
    "modifiedOn": "2025-01-15T18:01:00Z",
    "completedOn": "2025-01-15T18:01:00Z",
    "customerOrderNo": "CUST20250115005"
  }
}
```

#### 销卡订单查询响应示例 (orderType=CardCancel)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115006",
    "cardId": "CARD123456",
    "cancelReason": "用户申请销卡",
    "refundAmount": 150.00,
    "status": "Completed",
    "orderType": "CardCancel",
    "createdOn": "2025-01-15T19:00:00Z",
    "modifiedOn": "2025-01-15T19:05:00Z",
    "completedOn": "2025-01-15T19:05:00Z",
    "customerOrderNo": "CUST20250115006"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称  | 参数描述                                          |
|---------------------|----------|-------|-----------------------------------------------|
| responseId          | string   | 响应ID  | 响应Id，需调用方保存，用于排查调用遇到的问题                       |
| hasError            | boolean  | 是否有错误 | 是否有错误发生                                       |
| errorCode           | string   | 错误码   | 错误代码                                          |
| errorMessage        | string   | 错误信息  | 错误信息                                          |
| data                | object   | 数据    | 卡片详细信息                                        |
| ├─ cardId           | string   | 卡ID   | 卡片唯一标识                                        |
| ├─ cardModel        | string   | 卡模式   | Standard=标准模式, ShareBalance=共享余额模式            |
| ├─ productCode      | string   | 产品编码  | 产品编码                                          |
| ├─ cardNumber       | string   | 卡号    | 完整卡号（16位）                                     |
| ├─ cvv              | string   | CVV   | 卡片安全码                                         |
| ├─ expirationMMYY   | string   | 过期时间  | 卡片过期时间，格式：MM/YY                               |
| ├─ cardCurrency     | string   | 卡币种   | 卡片结算币种（如：USD、EUR、GBP等）                        |
| ├─ alias            | string   | 卡别名   | 卡片别名（用户自定义名称）                                 |
| └─ balanceAmount    | decimal  | 可用余额  | 当前可用余额                                        |
| └─ status           | string   | 卡状态   | Active=活跃, Blocked=冻结, Cancel=注销, Expired=已过期 |
| └─ maxAuthAmount    | decimal  | 单笔限额  | 共享余额模式：单笔最大授权金额                               |
| └─ usedCreditAmount | decimal  | 已消费额度 | 共享余额模式：已使用的信用额度                               |
| └─ maxCreditAmount  | decimal  | 总额度上限 | 共享余额模式：总信用额度上限（null表示无限制）                     |
| └─ cardOrganization | string   | 卡组织   | 卡组织（Mastercard/VISA等）                         |
| └─ applyTime        | DateTime | 申请时间  | 卡片申请时间                                        |
| └─ permissions      | object   | 操作权限  | 卡片操作权限信息                                      |
| &emsp;&emsp;├─ allowOpenCard    | boolean  | 允许开卡  | 是否允许开卡操作                                      |
| &emsp;&emsp;├─ allowTopUpCard   | boolean  | 允许充值  | 是否允许充值操作                                      |
| &emsp;&emsp;├─ allowBlockCard   | boolean  | 允许冻结  | 是否允许冻结操作                                      |
| &emsp;&emsp;├─ allowUnBlockCard | boolean  | 允许解冻  | 是否允许解冻操作                                      |
| &emsp;&emsp;├─ allowCancelCard  | boolean  | 允许销卡  | 是否允许销卡操作                                      |
| &emsp;&emsp;└─ allowWithdraw    | boolean  | 允许提取  | 是否允许余额提取操作                                    |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---



## 标准模式订单管理

### POST 【标准模式】开卡申请

**接口地址：** POST /v1/orders/standard/apply

**功能描述：** 【标准模式】开卡申请

#### 请求参数

| 参数名称            | 参数位置   | 参数类型    | 是否必填 | 中文名称      | 参数描述                  |
|-----------------|--------|---------|------|-----------|-----------------------|
| Authorization   | header | string  | 是    | 授权头       | Bearer {access_token} |
| Content-Type    | header | string  | 是    | 内容类型      | application/json      |
| productCode     | body   | string  | 是    | 产品编码      | 卡产品编码                 |
| cardCurrency    | body   | string  | 是    | 支持的结算币种列表 | 币种                    |
| topUpAmount     | body   | decimal | 是    | 充值金额      | 开卡金额                  |
| cardAlias       | body   | string  | 否    | 卡别名       | 卡别名                   |
| customerOrderNo | body   | string  | 否    | 商户订单号     | 商户请求订单号（确保唯一性） (可选)   |

#### 请求示例

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

#### 响应示例

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
            "feeType": "OpenCardFee",
            "amount": 5.0,
            "currency": "USD"
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

#### 响应参数说明

| 参数名称                | 参数类型          | 中文名称      | 参数描述                               |
|---------------------|---------------|-----------|------------------------------------|
| responseId          | string        | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题            |
| hasError            | boolean       | 是否有错误     | 是否有错误发生                            |
| errorCode           | string        | 错误码       | 错误代码                               |
| errorMessage        | string        | 错误信息      | 错误信息                               |
| data                | object        | 数据        |                                    |
| ├─ orderNo          | string        | 订单编号      | 订单编号 (必填)                          |
| ├─ productInfo      | object        | 产品信息      |                                    |
| 　├─ productCode    | string        | 产品编码      | 产品编码 (必填)                          |
| 　├─ productName    | string        | 产品名称      | 产品名称 (必填)                          |
| 　├─ cardModel      | string        | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式 |
| 　└─ cardCurrency   | string        | 支持的结算币种列表 | 卡结算币种                              |
| ├─ totalTopUpAmount | decimal       | 总开卡金额     | 总开卡金额                              |
| ├─ totalFee         | decimal       | 总手续费      | 总手续费                               |
| ├─ totalPayAmount   | decimal       | 总支付金额     | 总支付金额                              |
| ├─ totalCardCount   | integer       | 总卡数       | 总卡数                                |
| ├─ totalOpened      | integer       | 已开卡数      | 已开卡数                               |
| ├─ orderLines       | array[object] | 开卡订单明细    | 开卡订单明细 (可选)                        |
| 　├─ orderLineNo    | integer       | 明细行号      | 订单明细行号                             |
| 　├─ topUpAmount    | decimal       | 充值金额      | 单笔充值金额                             |
| 　├─ quantity       | integer       | 数量        | 开卡数量                               |
| 　└─ feeItems       | array[object] | 费用项列表     | 单张卡的费用项列表                          |
| 　　├─ feeType     | string        | 费用类型      | 费用类型：OpenCardFee(开卡费)、TopUpFee(卡充值手续费)、TransFee(交易手续费)、CancelCardFee(销卡手续费)、AccountTopUpFee(账户充值手续费)、AccountWithdrawFee(账户转出手续费)、CardWithdrawFee(卡余额转出手续费) |
| 　　├─ amount      | decimal       | 费用金额      | 费用金额                               |
| 　　└─ currency    | string        | 币种        | 费用币种                               |
| ├─ cardInfos        | array[object] | 已开卡信息     | 已开卡信息 (可选)                         |
| 　├─ cardId         | string        | 卡ID       | 卡片唯一标识                             |
| 　├─ productCode    | string        | 产品编码      | 产品编码                               |
| 　├─ productName    | string        | 产品名称      | 产品名称                               |
| 　├─ cardCurrency   | string        | 卡币种       | 卡片结算币种                             |
| 　├─ maskCardNumber | string        | 脱敏卡号      | 脱敏卡号，格式：前6位+***+后4位                 |
| 　└─ cardModel      | string        | 卡模式       | 卡模式：Standard(标准模式)、ShareBalance(共享余额模式) |
| └─ status           | string        | 状态        | 订单状态                               |
| └─ payMessage       | string        | 支付信息      | 支付信息 (可选)                          |
| └─ orderType        | string        | 订单类型      | 订单类型                               |
| └─ createdOn        | DateTime      | 创建时间      | 创建时间                               |
| └─ modifiedOn       | DateTime      | 修改时间      | 修改时间                               |
| └─ paidOn           | DateTime      | 支付时间      | 支付时间                               |
| └─ completedOn      | DateTime      | 完成时间      | 完成时间                               |
| └─ customerOrderNo  | string        | 商户订单号     | 商户请求订单号（确保唯一性） (可选)                |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【标准模式】卡充值

**接口地址：** POST /v1/orders/standard/topup

**功能描述：** 【标准模式】卡充值

#### 请求参数

| 参数名称            | 参数位置   | 参数类型    | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|---------|------|-------|-----------------------|
| Authorization   | header | string  | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string  | 是    | 内容类型  | application/json      |
| cardId          | body   | string  | 是    | 卡ID   | 卡ID (必填)              |
| topUpAmount     | body   | decimal | 是    | 充值金额  | 充值金额. （最低充值金额为1）      |
| customerOrderNo | body   | string  | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

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

#### 响应示例

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
    "orderLines": [
      {
        "orderLineNo": "LINE001",
        "cardInfo": {
          "cardId": "CARD123456",
          "productCode": "PROD001",
          "productName": "美元虚拟卡",
          "cardCurrency": "USD",
          "maskCardNumber": "****1234",
          "cardModel": "Standard"
        },
        "topUpAmount": 100.0,
        "feeItems": [
          {
            "feeType": "CardTopUpFee",
            "amount": 5.0,
            "currency": "USD"
          }
        ],
        "isCompleted": true,
        "completedOn": "2025-01-15T10:00:00Z"
      }
    ],
    "status": "Completed",
    "payMessage": "支付成功",
    "orderType": "TopUpCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "paidOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "SB20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                       | 参数类型          | 中文名称      | 参数描述                               |
|----------------------------|---------------|-----------|------------------------------------|
| responseId                 | string        | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题            |
| hasError                   | boolean       | 是否有错误     | 是否有错误发生                            |
| errorCode                  | string        | 错误码       | 错误代码                               |
| errorMessage               | string        | 错误信息      | 错误信息                               |
| data                       | object        | 数据        |                                    |
| ├─ orderNo                 | string        | 订单编号      | 订单编号 (必填)                          |
| ├─ productInfo             | object        | 产品信息      |                                    |
| 　├─ productCode           | string        | 产品编码      | 产品编码 (必填)                          |
| 　├─ productName           | string        | 产品名称      | 产品名称 (必填)                          |
| 　├─ cardModel             | string        | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式 |
| 　└─ cardCurrency          | string        | 支持的结算币种列表 | 卡结算币种                              |
| ├─ totalTopUpAmount        | decimal       | 总开卡金额     | 总充值金额                              |
| ├─ totalFee                | decimal       | 总手续费      | 总手续费                               |
| ├─ totalPayAmount          | decimal       | 总支付金额     | 总支付金额                              |
| ├─ totalCardCount          | integer       | 总卡数       | 总卡数                                |
| ├─ totalCompletedCardCount | integer       | 已充值卡数     | 已充值卡数                              |
| ├─ orderLines              | array[object] | 充值订单明细    | 充值订单明细 (可选)                        |
| 　├─ orderLineNo           | string        | 订单行号      | 订单行号                               |
| 　├─ cardInfo              | object        | 卡信息       | 卡信息                                |
| 　　├─ cardId              | string        | 卡ID        | 卡ID                                 |
| 　　├─ productCode         | string        | 产品编码      | 产品编码                               |
| 　　├─ productName         | string        | 产品名称      | 产品名称                               |
| 　　├─ cardCurrency        | string        | 卡币种       | 卡币种                                |
| 　　├─ maskCardNumber      | string        | 掩码卡号      | 掩码卡号                               |
| 　　└─ cardModel           | string        | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式 |
| 　├─ topUpAmount           | decimal       | 充值金额      | 充值金额                               |
| 　├─ feeItems              | array[object] | 费用项目      | 费用项目列表                             |
| 　　├─ feeType             | string        | 费用类型      | 费用类型枚举值                            |
| 　　├─ amount              | decimal       | 费用金额      | 费用金额                               |
| 　　└─ currency            | string        | 费用币种      | 费用币种                               |
| 　├─ isCompleted           | boolean       | 是否完成      | 是否完成                               |
| 　└─ completedOn           | DateTime      | 完成时间      | 完成时间                               |
| └─ status                  | string        | 状态        | 订单状态                               |
| └─ payMessage              | string        | 支付信息      | 支付信息 (可选)                          |
| └─ orderType               | string        | 订单类型      | 卡订单类型                              |
| └─ createdOn               | DateTime      | 创建时间      | 创建时间                               |
| └─ modifiedOn              | DateTime      | 修改时间      | 修改时间                               |
| └─ paidOn                  | DateTime      | 支付时间      | 支付时间                               |
| └─ completedOn             | DateTime      | 完成时间      | 完成时间                               |
| └─ customerOrderNo         | string        | 商户订单号     | 商户请求订单号（确保唯一性）(可选)                 |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【标准模式】卡冻结

**接口地址：** POST /v1/orders/standard/block

**功能描述：** 【标准模式】卡冻结

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 要销卡的卡片唯一标识符 (必填)        |
| customerOrderNo | body   | string | 否    | 商户订单号 | 客户系统的订单编号，用于幂等性控制 (可选) |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/block" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "BLK20250115001"
  }'
```

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115001",
    "cardInfo": {
      "cardId": "CARD123456",
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardCurrency": "USD",
      "maskCardNumber": "504232***4234",
      "cardModel": "ShareBalance"
    },
    "note": "冻结卡操作",
    "isBlocked": true,
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardBlock",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": null,
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号 (必填)                              |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ note             | string   | 备注        | 备注 (必填)                                |
| ├─ isBlocked        | boolean  | 是否渠道已冻结   | 是否渠道已冻结                                |
| ├─ status           | string   | 状态        | 订单状态                                   |
| ├─ failureReason    | string   | 失败原因      | 失败原因 (必填)                              |
| └─ orderType        | string   | 订单类型      | 订单类型                                   |
| └─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| └─ modifiedOn       | DateTime | 修改时间      | 修改时间                                   |
| └─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 商户请求订单号（确保唯一性）(可选)                     |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【标准模式】卡解冻

**接口地址：** POST /v1/orders/standard/unblock

**功能描述：** 【标准模式】卡解冻

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 卡ID (必填)              |
| customerOrderNo | body   | string | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/unblock" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "UBK20250115001"
  }'
```

#### 响应示例

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
      "cardModel": "ShareBalance"
    },
    "note": "解冻卡操作",
    "status": "Pending",
    "failureReason": null,
    "orderType": "CardUnblock",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": null,
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号 (必填)                              |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ note             | string   | 备注        | 备注 (必填)                                |
| ├─ status           | string   | 状态        | 订单状态                                   |
| ├─ failureReason    | string   | 失败原因      | 失败原因 (必填)                              |
| └─ orderType        | string   | 订单类型      | 订单类型                                   |
| └─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| └─ modifiedOn       | DateTime | 修改时间      | 修改时间                                   |
| └─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 商户请求订单号（确保唯一性）(可选)                     |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【标准模式】销卡

**接口地址：** POST /v1/orders/standard/cancel

**功能描述：** 【标准模式】销卡

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 卡ID (必填)              |
| customerOrderNo | body   | string | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/standard/cancel" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "CNL20250115001"
  }'
```

#### 响应示例

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
    "chargeMethodType": "FixedValue",
    "fixedValue": 100.0,
    "percent": 0.0,
    "settleAmount": 100.0,
    "note": "销卡操作",
    "status": "Completed",
    "settleStatus": "Completed",
    "orderType": "CardCancel",
    "failureReason": null,
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:05:00Z",
    "customerOrderNo": "CNL20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号                                   |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ fee              | decimal  | 销卡手续费     | 销卡手续费                                  |
| ├─ chargeMethodType | string   | 收费方式类型    | 收费方式类型：FixedValue-固定金额，Percentage-百分比 |
| ├─ fixedValue       | decimal  | 固定收费金额    | 固定收费金额（当chargeMethodType为FixedValue时）   |
| ├─ percent          | decimal  | 收费百分比     | 收费百分比（当chargeMethodType为Percentage时）。小数格式 |
| ├─ settleAmount     | decimal  | 结算金额      | 结算金额                                   |
| ├─ note             | string   | 备注信息      | 备注信息                                   |
| ├─ status           | string   | 订单状态      | 订单状态：Pending-处理中，Completed-已完成，Failure-处理失败 |
| ├─ settleStatus     | string   | 结算状态      | 结算状态：Pending-待结算，WaitTransfer-等待转账，Completed-已完成 |
| ├─ orderType        | string   | 订单类型      | 订单类型：CardCancel                        |
| ├─ failureReason    | string   | 失败原因      | 失败原因（当订单失败时）                           |
| ├─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| ├─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 商户请求订单号（确保唯一性）(可选)                     |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【标准模式】卡余额转出

**接口地址：** POST /v1/orders/standard/withdraw

**功能描述：** 【标准模式】卡余额转出

#### 请求参数

| 参数名称            | 参数位置   | 参数类型    | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|---------|------|-------|-----------------------|
| Authorization   | header | string  | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string  | 是    | 内容类型  | application/json      |
| cardId          | body   | string  | 是    | 卡ID   | 卡ID (必填)              |
| withdrawAmount  | body   | decimal | 否    | 转出金额  | 转出金额                  |
| customerOrderNo | body   | string  | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

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

#### 响应示例

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
    "withdrawFee": 2.5,
    "totalAmount": 102.5,
    "status": "Pending",
    "orderType": "CardWithdraw",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": null,
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称               | 参数类型     | 中文名称  | 参数描述                    |
|--------------------|----------|-------|-------------------------|
| responseId         | string   | 响应ID  | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError           | boolean  | 是否有错误 | 是否有错误发生                 |
| errorCode          | string   | 错误码   | 错误代码                    |
| errorMessage       | string   | 错误信息  | 错误信息                    |
| data               | object   | 数据    |                         |
| ├─ orderNo         | string   | 订单编号  | 订单编号 (必填)               |
| ├─ cardId          | string   | 卡ID   | 卡ID (必填)                |
| ├─ withdrawAmount  | decimal  | 转出金额  | 转出金额                    |
| ├─ withdrawFee     | decimal  | 转出手续费 | 转出手续费                   |
| ├─ totalAmount     | decimal  | 订单总金额 | 总金额（转出金额+手续费）           |
| ├─ status          | string   | 状态    | 订单状态：Pending(待处理)、Completed(已完成)、Failure(失败) |
| ├─ orderType       | string   | 订单类型  | 订单类型，固定值：CardWithdraw     |
| ├─ createdOn       | DateTime | 创建时间  | 创建时间                    |
| ├─ modifiedOn      | DateTime | 修改时间  | 修改时间                    |
| ├─ completedOn     | DateTime | 完成时间  | 完成时间，未完成时为null          |
| └─ customerOrderNo | string   | 商户订单号 | 商户请求订单号 (可选)            |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### GET 标准模式类型的订单查询

包括：开卡、充值、冻结、解冻、销卡、卡余额转出

**接口地址：** GET /v1/orders/standard

**功能描述：** 标准模式类型的订单查询。

包括：开卡、充值、冻结、解冻、销卡、卡余额转出

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                                                                                                       |
|-----------------|--------|--------|------|-------|------------------------------------------------------------------------------------------------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token}                                                                                      |
| orderType       | query  | string | 是    | 订单类型  | 订单类型: ApplyCard 开卡订单、CardTopUp 充值订单、CardCancel 销卡订单、CardBlock 卡冻结订单、CardUnblock 卡解冻订单、CardWithdraw 卡余额转出订单 |
| orderNo         | query  | string | 否    | 订单号   | 订单号 (可选)                                                                                                   |
| customerOrderNo | query  | string | 否    | 商户订单号 | 商户订单号 (可选)                                                                                                 |

#### 请求示例

```bash
# 使用订单号查询
curl -X GET "https://test.cardepass.com/openapi/v1/orders/standard?orderType=ApplyCard&orderNo=ORD202501150001" \
  -H "Authorization: Bearer your_access_token"

# 使用客户订单号查询
curl -X GET "https://test.cardepass.com/openapi/v1/orders/standard?orderType=ApplyCard&customerOrderNo=CUST202501150001" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

##### 开卡订单查询响应示例 (orderType=ApplyCard)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115001",
    "productInfo": {
      "productCode": "PROD001",
      "productName": "美元虚拟卡",
      "cardModel": "Standard"
    },
    "totalTopUpAmount": 1000.00,
    "totalFee": 5.00,
    "totalPayAmount": 1005.00,
    "totalCardCount": 1,
    "totalOpened": 1,
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:30:00Z",
    "modifiedOn": "2025-01-15T10:35:00Z",
    "completedOn": "2025-01-15T10:35:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```
##### 充值订单查询响应示例 (orderType=CardTopUp)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115003",
    "cardInfo": {
      "cardId": "CARD123456",
      "cardAlias": "我的美元卡",
      "maskedCardNumber": "****1234"
    },
    "topUpAmount": 200.00,
    "fee": 1.00,
    "totalAmount": 201.00,
    "status": "Completed",
    "orderType": "CardTopUp",
    "createdOn": "2025-01-15T16:10:00Z",
    "modifiedOn": "2025-01-15T16:15:00Z",
    "completedOn": "2025-01-15T16:15:00Z",
    "customerOrderNo": "CUST20250115003"
  }
}
```
##### 卡余额转出订单查询响应示例 (orderType=CardWithdraw)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115002",
    "cardId": "CARD123456",
    "withdrawAmount": 500.00,
    "withdrawFee": 2.50,
    "totalAmount": 502.50,
    "status": "Processing",
    "orderType": "CardWithdraw",
    "createdOn": "2025-01-15T14:20:00Z",
    "modifiedOn": "2025-01-15T14:20:00Z",
    "completedOn": null,
    "customerOrderNo": "CUST20250115002"
  }
}
```

##### 卡注销订单查询响应示例 (orderType=CardCancel)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115004",
    "cardId": "CARD123456",
    "cardAlias": "我的美元卡",
    "maskedCardNumber": "****1234",
    "status": "Completed",
    "orderType": "CardCancel",
    "createdOn": "2025-01-15T18:00:00Z",
    "modifiedOn": "2025-01-15T18:05:00Z",
    "completedOn": "2025-01-15T18:05:00Z",
    "customerOrderNo": "CUST20250115004"
  }
}
```

##### 卡冻结订单查询响应示例 (orderType=CardBlock)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115005",
    "cardId": "CARD123456",
    "cardAlias": "我的美元卡",
    "maskedCardNumber": "****1234",
    "blockReason": "用户主动冻结",
    "status": "Completed",
    "orderType": "CardBlock",
    "createdOn": "2025-01-15T20:00:00Z",
    "modifiedOn": "2025-01-15T20:01:00Z",
    "completedOn": "2025-01-15T20:01:00Z",
    "customerOrderNo": "CUST20250115005"
  }
}
```

##### 卡解冻订单查询响应示例 (orderType=CardUnblock)

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "ORD20250115006",
    "cardId": "CARD123456",
    "cardAlias": "我的美元卡",
    "maskedCardNumber": "****1234",
    "status": "Completed",
    "orderType": "CardUnblock",
    "createdOn": "2025-01-15T22:00:00Z",
    "modifiedOn": "2025-01-15T22:01:00Z",
    "completedOn": "2025-01-15T22:01:00Z",
    "customerOrderNo": "CUST20250115006"
  }
}
```



#### 响应参数说明

| 参数名称 | 参数类型 | 中文名称 | 参数描述    |
|------|------|------|---------|
| data |      | 数据   | 标准卡订单详情 |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

## 共享余额模式订单管理

### POST 【共享余额模式】开卡申请

**接口地址：** POST /v1/orders/sharebalance/apply

**功能描述：** 【共享余额模式】开卡申请

#### 请求参数

| 参数名称            | 参数位置   | 参数类型    | 是否必填 | 中文名称      | 参数描述                  |
|-----------------|--------|---------|------|-----------|-----------------------|
| Authorization   | header | string  | 是    | 授权头       | Bearer {access_token} |
| Content-Type    | header | string  | 是    | 内容类型      | application/json      |
| productCode     | body   | string  | 是    | 产品编码      | 卡产品编码                 |
| cardCurrency    | body   | Currency | 是    | 币种        | 币种枚举值，如：USD、EUR、CNY等 |
| maxAuthAmount   | body   | decimal | 是    | 单笔限额      | 单笔限额                  |
| maxCreditAmount | body   | decimal | 否    | 总额度上限     | 单卡消费总额度,可以为空，为空表示不限额度 |
| cardAlias       | body   | string  | 否    | 卡别名       | 卡别名                   |
| customerOrderNo | body   | string  | 否    | 商户订单号     | 商户请求订单号（确保唯一性） (可选)   |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/apply" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "productCode": "PROD001",
        "cardCurrency": "USD",
        "maxAuthAmount": 500.0,
        "maxCreditAmount": 10000.0,
        "cardAlias": "我的美元卡",
        "customerOrderNo": "SB20250115001"
  }'
```

#### 响应示例

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
      "cardModel": "ShareBalance",
      "cardCurrency": "USD"
    },
    "quantity": 1,
    "maxAuthAmount": 500.0,
    "maxCreditAmount": 10000.0,
    "totalAmount": 5.0,
    "transAmount": 5.0,
    "transFee": 5.0,
    "openedQty": 1,
    "cardInfos": [
      {
        "cardId": "CARD789012345",
        "cardNumber": "4***********1234",
        "expiryDate": "12/28",
        "cvv": "***",
        "status": "Active"
      }
    ],
    "note": "备注信息",
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "SB20250115001"
  }
}
```

#### 响应参数说明

| 参数名称               | 参数类型          | 中文名称        | 参数描述                               |
|--------------------|---------------|-------------|------------------------------------|
| responseId         | string        | 响应ID        | 响应Id，需调用方保存，用于排查调用遇到的问题            |
| hasError           | boolean       | 是否有错误       | 是否有错误发生                            |
| errorCode          | string        | 错误码         | 错误代码                               |
| errorMessage       | string        | 错误信息        | 错误信息                               |
| data               | object        | 数据          |                                    |
| ├─ orderNo         | string        | 订单编号        | 订单编号                               |
| ├─ productInfo     | object        | 产品信息        |                                    |
| 　├─ productCode   | string        | 产品编码        | 产品编码                              |
| 　├─ productName   | string        | 产品名称        | 产品名称                              |
| 　├─ cardModel     | string        | 卡模式         | ShareBalance=共享余额模式                |
| 　└─ cardCurrency  | Currency      | 币种          | 卡结算币种                              |
| ├─ quantity        | integer       | 申请数量        | 开卡数                                |
| ├─ maxAuthAmount   | decimal       | 单笔限额        | 单笔限额                               |
| ├─ maxCreditAmount | decimal       | 总额度上限       | 单卡消费总额度,可以为空，为空表示不限额度              |
| ├─ totalAmount     | decimal       | 订单总金额       | 总交易金额                              |
| ├─ transAmount     | decimal       | 交易金额        | 交易金额                               |
| └─ transFee        | decimal       | 手续费         | 开卡手续费(交易手续费)                       |
| └─ openedQty       | integer       | 已开卡数        | 已开卡数                               |
| ├─ cardInfos       | array[object] | 已开卡信息       | 已开卡信息列表                            |
| 　├─ cardId        | string        | 卡ID          | 卡唯一标识                              |
| 　├─ cardNumber    | string        | 卡号          | 脱敏后的卡号                             |
| 　├─ expiryDate    | string        | 有效期         | 卡有效期，格式：MM/YY                      |
| 　├─ cvv           | string        | CVV安全码      | 脱敏后的CVV                            |
| 　└─ status        | string        | 卡状态         | 卡状态                                |
| └─ note            | string        | 备注          | 备注                                 |
| └─ status          | string        | 状态          | 订单状态：Pending-处理中，Completed-已完成交易，Failure-处理失败 |
| └─ orderType       | string        | 订单类型        | 订单类型                               |
| └─ createdOn       | DateTime      | 创建时间        | 创建时间                               |
| └─ modifiedOn      | DateTime      | 修改时间        | 修改时间                               |
| └─ completedOn     | DateTime      | 完成时间        | 完成时间                               |
| └─ customerOrderNo | string        | 商户订单号       | 客户订单号                              |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【共享余额模式】修改限额

**接口地址：** POST /v1/orders/sharebalance/creditLimit

**功能描述：** 【共享余额模式】修改限额

#### 请求参数

| 参数名称            | 参数位置   | 参数类型    | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|---------|------|-------|-----------------------|
| Authorization   | header | string  | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string  | 是    | 内容类型  | application/json      |
| cardId          | body   | string  | 是    | 卡ID   | 卡ID                    |
| customerOrderNo | body   | string  | 否    | 商户订单号 | 商户请求订单号（确保唯一性）        |
| maxAuthAmount   | body   | decimal | 是    | 单笔限额  | 共享模式单笔限额              |
| maxCreditAmount | body   | decimal | 否    | 总额度上限 | 共享模式总额度，为空表示不限制       |

#### 请求示例

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

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "orderNo": "CL20250115001",
    "cardId": "CARD789012",
    "maxAuthAmount": 1000.0,
    "maxCreditAmount": 20000.0,
    "status": "Pending",
    "orderType": "ModifyCreditLimit",
    "failureReason": null,
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": null,
    "customerOrderNo": "LMT20250115001"
  }
}
```

#### 响应参数说明

| 参数名称               | 参数类型     | 中文名称  | 参数描述                    |
|--------------------|----------|-------|-------------------------|
| responseId         | string   | 响应ID  | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError           | boolean  | 是否有错误 | 是否有错误发生                 |
| errorCode          | string   | 错误码   | 错误代码                    |
| errorMessage       | string   | 错误信息  | 错误信息                    |
| data               | object   | 数据    |                         |
| ├─ orderNo         | string   | 订单编号  | 共享卡限额修改订单编号             |
| ├─ cardId          | string   | 卡ID   | 卡ID                     |
| ├─ maxAuthAmount   | decimal  | 单笔限额  | 单笔限额                    |
| ├─ maxCreditAmount | decimal  | 总额度上限 | 总限额，为空表示不限制             |
| ├─ status          | string   | 状态    | 卡限额修改状态 (Pending: 处理中, Completed: 已完成, Failure: 处理失败) |
| └─ orderType       | string   | 订单类型  | 订单类型                    |
| ├─ failureReason   | string   | 失败原因  | 失败原因 (可选)                |
| └─ createdOn       | DateTime | 创建时间  | 创建时间                    |
| └─ completedOn     | DateTime | 完成时间  | 完成时间                    |
| └─ customerOrderNo | string   | 商户订单号 | 客户订单号                   |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【共享余额模式】冻结卡

**接口地址：** POST /v1/orders/sharebalance/block

**功能描述：** 【共享余额模式】冻结卡

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 卡ID (必填)              |
| customerOrderNo | body   | string | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/block" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "CUST20250115001"
  }'
```

#### 响应示例

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
    "orderType": "CardBlock",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号                                   |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ note             | string   | 备注        | 备注                                     |
| ├─ isBlocked        | boolean  | 是否渠道已冻结   | 是否渠道已冻结                                |
| ├─ status           | string   | 状态        | 订单状态：Pending-处理中，Completed-已完成，Failure-处理失败 |
| ├─ failureReason    | string   | 失败原因      | 失败原因（可选，仅在失败时有值）                       |
| └─ orderType        | string   | 订单类型      | 订单类型                                   |
| └─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| └─ modifiedOn       | DateTime | 修改时间      | 修改时间                                   |
| └─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 客户请求订单号（确保唯一性）                         |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【共享余额模式】解冻卡

**接口地址：** POST /v1/orders/sharebalance/unblock

**功能描述：** 【共享余额模式】解冻卡

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 卡ID (必填)              |
| customerOrderNo | body   | string | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/unblock" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "CUST20250115001"
  }'
```

#### 响应示例

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
    "orderType": "CardUnblock",
    "createdOn": "2025-01-15T10:00:00Z",
    "modifiedOn": "2025-01-15T10:00:00Z",
    "completedOn": "2025-01-15T10:00:00Z",
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号                                   |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ note             | string   | 备注        | 备注                                     |
| ├─ status           | string   | 状态        | 订单状态：Pending=待处理, Completed=已完成, Failure=失败 |
| ├─ failureReason    | string   | 失败原因      | 失败原因（可选）                               |
| └─ orderType        | string   | 订单类型      | 订单类型                                   |
| └─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| └─ modifiedOn       | DateTime | 修改时间      | 修改时间                                   |
| └─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 客户请求订单号（确保唯一性）                         |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### POST 【共享余额模式】销卡

**接口地址：** POST /v1/orders/sharebalance/cancel

**功能描述：** 【共享余额模式】销卡

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                  |
|-----------------|--------|--------|------|-------|-----------------------|
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token} |
| Content-Type    | header | string | 是    | 内容类型  | application/json      |
| cardId          | body   | string | 是    | 卡ID   | 卡ID (必填)              |
| customerOrderNo | body   | string | 否    | 商户订单号 | 商户请求订单号（确保唯一性）(可选)    |

#### 请求示例

```bash
curl -X POST "https://test.cardepass.com/openapi/v1/orders/sharebalance/cancel" \
  -H "Authorization: Bearer your_access_token" \
  -H "Content-Type: application/json" \
  -d '{
        "cardId": "CARD123456",
        "customerOrderNo": "CUST20250115001"
  }'
```

#### 响应示例

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
      "cardModel": "ShareBalance"
    },
    "fee": 100.0,
    "chargeMethodType": "Fixed",
    "fixedValue": 100.0,
    "percent": 0.0,
    "note": "销卡操作",
    "status": "Pending",
    "orderType": "CardCancel",
    "settleStatus": null,
    "failureReason": null,
    "createdOn": "2025-01-15T10:00:00Z",
    "completedOn": null,
    "customerOrderNo": "CUST20250115001"
  }
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        |                                        |
| ├─ orderNo          | string   | 订单编号      | 订单编号                                   |
| ├─ cardInfo         | object   | 卡信息       |                                        |
| 　├─ cardId         | string   | 卡ID       | 卡ID                                    |
| 　├─ productCode    | string   | 产品编码      | 产品编码                                   |
| 　├─ productName    | string   | 产品名称      | 产品名称                                   |
| 　├─ cardCurrency   | string   | 支持的结算币种列表 | 结算币种                                   |
| 　├─ maskCardNumber | string   | 脱敏卡号      | 脱敏卡号： 卡号前6位 + 后4位非脱敏。例如： 504232***4234 |
| 　└─ cardModel      | string   | 卡模式       | Standard=标准模式, ShareBalance=共享余额模式     |
| ├─ fee              | decimal  | 销卡手续费     | 销卡手续费                                  |
| ├─ chargeMethodType | string   | 收费方式      | 收费方式                                   |
| ├─ fixedValue       | decimal  | 固定金额      | 固定金额                                   |
| ├─ percent          | decimal  | 百分比       | 百分比。小数格式                               |
| ├─ feeChargeDetails | array    | 费用明细      | 费用收取明细列表                               |
| ├─ feePricingStandard | object | 费用定价标准   | 费用定价标准信息                               |
| ├─ isUseNewVersionPricing | boolean | 是否使用新版定价 | 是否使用新版本定价规则                           |
| ├─ note             | string   | 备注        | 备注                                     |
| ├─ cancelCardSource | string   | 销卡来源      | 销卡操作来源                                 |
| └─ status           | string   | 状态        | 订单状态。可能值：Pending（待处理）、Completed（已完成）、Failure（失败） |
| └─ orderType        | string   | 订单类型      | 订单类型                                   |
| └─ settleStatus     | string   | 结算状态      | 结算状态                                   |
| └─ failureReason    | string   | 失败原因      | 失败原因（可选）                               |
| └─ createdOn        | DateTime | 创建时间      | 创建时间                                   |
| └─ completedOn      | DateTime | 完成时间      | 完成时间                                   |
| └─ customerOrderNo  | string   | 商户订单号     | 客户请求订单号（确保唯一性）                         |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### GET 【共享余额模式】订单查询

包括：开卡、修改限额、冻结、解冻、销卡

**接口地址：** GET /v1/orders/sharebalance

**功能描述：** 【共享余额模式】订单查询。

包括：开卡、修改限额、冻结、解冻、销卡

#### 请求参数

| 参数名称            | 参数位置   | 参数类型   | 是否必填 | 中文名称  | 参数描述                                                                                        |
|-----------------|--------|--------|------|-------|---------------------------------------------------------------------------------------------|  
| Authorization   | header | string | 是    | 授权头   | Bearer {access_token}                                                                       |
| orderType       | query  | string | 是    | 订单类型  | 订单类型：ApplyCard（开卡订单）、CreditLimit（调整限额）、CardCancel（销卡订单）、CardBlock（卡冻结订单）、CardUnblock（卡解冻订单） |
| orderNo         | query  | string | 否    | 订单号   | 系统生成的订单号，与customerOrderNo二选一必填                                                                |
| customerOrderNo | query  | string | 否    | 商户订单号 | 商户请求订单号，与orderNo二选一必填                                                                        |

#### 请求示例

```bash
# 查询开卡订单 (ApplyCard)
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=ApplyCard&orderNo=ORD202401010001" \
  -H "Authorization: Bearer your_access_token"

# 查询开卡订单 - 根据商户订单号
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=ApplyCard&customerOrderNo=MERCHANT_APPLY_001" \
  -H "Authorization: Bearer your_access_token"

# 查询额度调整订单 (CreditLimit)
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CreditLimit&orderNo=ORD202401010002" \
  -H "Authorization: Bearer your_access_token"

# 查询额度调整订单 - 根据商户订单号
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CreditLimit&customerOrderNo=MERCHANT_LIMIT_001" \
  -H "Authorization: Bearer your_access_token"

# 查询销卡订单 (CardCancel)
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardCancel&orderNo=ORD202401010003" \
  -H "Authorization: Bearer your_access_token"

# 查询销卡订单 - 根据商户订单号
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardCancel&customerOrderNo=MERCHANT_CANCEL_001" \
  -H "Authorization: Bearer your_access_token"

# 查询冻结卡订单 (CardBlock)
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardBlock&orderNo=ORD202401010004" \
  -H "Authorization: Bearer your_access_token"

# 查询冻结卡订单 - 根据商户订单号
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardBlock&customerOrderNo=MERCHANT_BLOCK_001" \
  -H "Authorization: Bearer your_access_token"

# 查询解冻卡订单 (CardUnblock)
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardUnblock&orderNo=ORD202401010005" \
  -H "Authorization: Bearer your_access_token"

# 查询解冻卡订单 - 根据商户订单号
curl -X GET "https://test.cardepass.com/openapi/v1/orders/sharebalance?orderType=CardUnblock&customerOrderNo=MERCHANT_UNBLOCK_001" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

##### 开卡订单查询响应示例 (orderType=ApplyCard)

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "status": "Completed",
    "orderType": "ApplyCard",
    "createdOn": "2024-01-01T10:00:00Z",
    "modifiedOn": "2024-01-01T10:30:00Z",
    "completedOn": "2024-01-01T10:30:00Z",
    "customerOrderNo": "MERCHANT_APPLY_001",
    "orderNo": "ORD202401010001",
    "cardInfo": {
      "cardNo": "1234567890123456",
      "maskedCardNo": "123456******3456",
      "cardStatus": "Active"
    },
    "note": "开卡申请已完成",
    "failureReason": null
  }
}
```

##### 额度调整订单查询响应示例 (orderType=CreditLimit)

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "status": "Completed",
    "orderType": "CreditLimit",
    "createdOn": "2024-01-01T11:00:00Z",
    "modifiedOn": "2024-01-01T11:05:00Z",
    "completedOn": "2024-01-01T11:05:00Z",
    "customerOrderNo": "MERCHANT_LIMIT_001",
    "orderNo": "ORD202401010002",
    "cardInfo": {
      "cardNo": "1234567890123456",
      "maskedCardNo": "123456******3456",
      "cardStatus": "Active"
    },
    "note": "额度调整已完成",
    "failureReason": null
  }
}
```

##### 销卡订单查询响应示例 (orderType=CardCancel)

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "status": "Completed",
    "orderType": "CardCancel",
    "createdOn": "2024-01-01T12:00:00Z",
    "modifiedOn": "2024-01-01T12:10:00Z",
    "completedOn": "2024-01-01T12:10:00Z",
    "customerOrderNo": "MERCHANT_CANCEL_001",
    "orderNo": "ORD202401010003",
    "cardInfo": {
      "cardNo": "1234567890123456",
      "maskedCardNo": "123456******3456",
      "cardStatus": "Cancelled"
    },
    "note": "销卡已完成",
    "failureReason": null
  }
}
```

##### 冻结卡订单查询响应示例 (orderType=CardBlock)

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "status": "Completed",
    "orderType": "CardBlock",
    "createdOn": "2024-01-01T13:00:00Z",
    "modifiedOn": "2024-01-01T13:02:00Z",
    "completedOn": "2024-01-01T13:02:00Z",
    "customerOrderNo": "MERCHANT_BLOCK_001",
    "orderNo": "ORD202401010004",
    "cardInfo": {
      "cardNo": "1234567890123456",
      "maskedCardNo": "123456******3456",
      "cardStatus": "Blocked"
    },
    "note": "卡片冻结已完成",
    "failureReason": null
  }
}
```

##### 解冻卡订单查询响应示例 (orderType=CardUnblock)

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "status": "Completed",
    "orderType": "CardUnblock",
    "createdOn": "2024-01-01T14:00:00Z",
    "modifiedOn": "2024-01-01T14:01:00Z",
    "completedOn": "2024-01-01T14:01:00Z",
    "customerOrderNo": "MERCHANT_UNBLOCK_001",
    "orderNo": "ORD202401010005",
    "cardInfo": {
      "cardNo": "1234567890123456",
      "maskedCardNo": "123456******3456",
      "cardStatus": "Active"
    },
    "note": "卡片解冻已完成",
    "failureReason": null
  }
}
```

**查询不存在的订单时返回：**
```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": null
}
```

#### 响应参数说明

| 参数名称                | 参数类型     | 中文名称      | 参数描述                                   |
|---------------------|----------|-----------|----------------------------------------|
| responseId          | string   | 响应ID      | 响应Id，需调用方保存，用于排查调用遇到的问题                |
| hasError            | boolean  | 是否有错误     | 是否有错误发生                                |
| errorCode           | string   | 错误码       | 错误代码                                   |
| errorMessage        | string   | 错误信息      | 错误信息                                   |
| data                | object   | 数据        | 订单详情数据，查询不到时为null                      |
| ├─ status           | string   | 订单状态      | 订单处理状态：Pending（待处理）、Processing（处理中）、Completed（已完成）、Failed（失败） |
| ├─ orderType        | string   | 订单类型      | 订单类型：ApplyCard、CreditLimit、CardCancel、CardBlock、CardUnblock |
| ├─ createdOn        | string   | 创建时间      | 订单创建时间，ISO 8601格式                       |
| ├─ modifiedOn       | string   | 修改时间      | 订单最后修改时间，ISO 8601格式                     |
| ├─ completedOn      | string   | 完成时间      | 订单完成时间，ISO 8601格式，未完成时为null             |
| ├─ customerOrderNo  | string   | 商户订单号     | 商户请求时提供的订单号                            |
| ├─ orderNo          | string   | 系统订单号     | 系统生成的订单号                               |
| ├─ cardInfo         | object   | 卡片信息      | 卡片相关信息，仅开卡订单包含                         |
| 　├─ cardNo         | string   | 卡号        | 完整卡号                                   |
| 　├─ maskedCardNo   | string   | 脱敏卡号      | 脱敏处理的卡号                                |
| 　└─ cardStatus     | string   | 卡片状态      | 卡片当前状态                                 |
| ├─ note             | string   | 备注        | 订单处理备注信息                               |
| └─ failureReason    | string   | 失败原因      | 订单失败时的具体原因，成功时为null                    |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

## 客户账户管理

### GET 获取客户资金账户余额信息

**接口地址：** GET /v1/accounts

**功能描述：** 获取客户资金账户余额信息

#### 请求参数

| 参数名称          | 参数位置   | 参数类型   | 是否必填 | 中文名称 | 参数描述                  |
|---------------|--------|--------|------|------|-----------------------|
| Authorization | header | string | 是    | 授权头  | Bearer {access_token} |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": [
    {
      "currency": "USD",
      "amount": 1500.50
    },
    {
      "currency": "EUR",
      "amount": 2300.75
    },
    {
      "currency": "CNY",
      "amount": 10000.00
    }
  ]
}
```

#### 响应参数说明

| 参数名称         | 参数类型    | 中文名称  | 参数描述                    |
|--------------|---------|-------|-------------------------|
| responseId   | string  | 响应ID  | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError     | boolean | 是否有错误 | 是否有错误发生                 |
| errorCode    | string  | 错误码   | 错误代码                    |
| errorMessage | string  | 错误信息  | 错误信息                    |
| data         | array   | 账户余额数据 | 客户各币种账户余额信息数组           |
| ├─ currency  | string  | 币种代码  | 币种代码，如：USD、EUR、CNY等     |
| └─ amount    | decimal | 可用余额  | 该币种的可用余额金额              |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### GET 分页查询卡资金明细

**接口地址：** GET /v1/accounts/cardAccountLogs

**功能描述：** 【标准模式】分页查询卡资金明细（不含交易），用于查询指定卡片的资金流水记录，包括开卡、充值、注销等各类资金变动明细

#### 请求参数

| 参数名称                | 参数位置   | 参数类型     | 是否必填 | 中文名称 | 参数描述                  |
|---------------------|--------|----------|------|------|-----------------------|
| Authorization       | header | string   | 是    | 授权头  | Bearer {access_token} |
| cardId              | query  | string   | 否    | 卡片ID | 卡ID (可选)              |
| transactionDateFrom | query  | DateTime | 否    | 开始日期 | 开始交易日期 (格式: YYYY-MM-DDTHH:mm:ssZ) |
| transactionDateTo   | query  | DateTime | 否    | 结束日期 | 结束交易日期 (格式: YYYY-MM-DDTHH:mm:ssZ) |
| pageIndex           | query  | integer  | 否    | 页码   | 页码，默认为1               |
| pageSize            | query  | integer  | 否    | 页大小  | 每页数量，默认为10            |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/cardAccountLogs?cardId=CARD123456&pageIndex=1&pageSize=10" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "pageIndex": 1,
    "pageSize": 10,
    "totalCount": 25,
    "totalPages": 3,
    "items": [
      {
        "accountLogId": "log_123456789",
        "cardOrderNo": "order_123456",
        "cardAccountLogType": "CardTopUp",
        "cardInfo": {
          "cardId": "CARD123456",
          "maskedCardNumber": "****1234"
        },
        "fundsDirection": "Income",
        "transAmount": {
          "amount": 100.50,
          "currency": "USD"
        },
        "totalFee": {
          "amount": 2.50,
          "currency": "USD"
        },
        "feeItems": [
          {
            "feeType": "ProcessingFee",
            "amount": {
              "amount": 2.50,
              "currency": "USD"
            }
          }
        ],
        "totalAmount": {
          "amount": 103.00,
          "currency": "USD"
        },
        "status": "Completed",
        "failureReason": null,
        "transTime": "2024-01-15T10:30:00Z",
        "completedTime": "2024-01-15T10:31:00Z",
        "note": "卡充值"
      }
    ]
  }
}
```

#### 响应参数说明

| 参数名称                        | 参数类型          | 中文名称         | 参数描述                    |
|------------------------------|---------------|--------------|-------------------------|
| responseId                   | string        | 响应ID         | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError                     | boolean       | 是否有错误        | 是否有错误发生                 |
| errorCode                    | string        | 错误码          | 错误代码                    |
| errorMessage                 | string        | 错误信息         | 错误信息                    |
| data                         | object        | 数据           | 分页数据                    |
| ├─ pageIndex                 | integer       | 页码           | 当前页码                    |
| ├─ pageSize                  | integer       | 页大小          | 每页数量                    |
| ├─ totalCount                | integer       | 总记录数         | 总记录数                    |
| ├─ totalPages                | integer       | 总页数          | 总页数                     |
| └─ items                     | array[object] | 明细列表         | 卡账户明细列表                 |
| 　　├─ accountLogId          | string        | 账户明细ID       | 账户明细唯一标识                |
| 　　├─ cardOrderNo           | string        | 卡订单号         | 批次订单号 (可选)              |
| 　　├─ cardAccountLogType    | string        | 明细类型         | 卡账户交易明细类型               |
| 　　├─ cardInfo              | object        | 卡信息          | 卡基本信息                   |
| 　　├─ fundsDirection        | string        | 资金方向         | Income-收入, Expenditure-支出 |
| 　　├─ transAmount           | object        | 交易金额         | 交易金额对象                  |
| 　　├─ totalFee              | object        | 总手续费         | 总手续费对象                  |
| 　　├─ feeItems              | array[object] | 费用明细         | 费用明细列表                  |
| 　　├─ totalAmount           | object        | 总金额          | 总金额对象                   |
| 　　├─ status                | string        | 状态           | Pending-处理中, Completed-已完成, Failure-处理失败 |
| 　　├─ failureReason         | string        | 失败原因         | 处理失败时的原因说明 (可选)         |
| 　　├─ transTime             | DateTime      | 交易时间         | 交易发生时间                  |
| 　　├─ completedTime         | DateTime      | 完成时间         | 交易完成时间 (可选)             |
| 　　└─ note                  | string        | 备注           | 备注信息 (可选)               |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

### GET 分页查询客户账户资金明细

**接口地址：** GET /v1/accounts/accountLogs

**功能描述：** 分页查询客户账户资金明细，用于查询客户账户的资金流水记录，包括充值、转出、消费、退款等各类交易明细

#### 请求参数

| 参数名称                | 参数位置   | 参数类型     | 是否必填 | 中文名称 | 参数描述                  |
|---------------------|--------|----------|------|------|-----------------------|
| Authorization       | header | string   | 是    | 授权头  | Bearer {access_token} |
| transactionDateFrom | query  | DateTime | 否    | 开始日期 | 开始交易日期 (格式: YYYY-MM-DDTHH:mm:ssZ) |
| transactionDateTo   | query  | DateTime | 否    | 结束日期 | 结束交易日期 (格式: YYYY-MM-DDTHH:mm:ssZ) |
| pageIndex           | query  | integer  | 否    | 页码   | 页码，默认为1               |
| pageSize            | query  | integer  | 否    | 页大小  | 每页数量，默认为10            |

#### 请求示例

```bash
curl -X GET "https://test.cardepass.com/openapi/v1/accounts/accountLogs?pageIndex=1&pageSize=10" \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

```json
{
  "responseId": "00000000-0000-0000-0000-000000000000",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "pageIndex": 1,
    "pageSize": 10,
    "totalCount": 50,
    "totalPages": 5,
    "items": [
      {
        "id": "log_987654321",
        "accountTransType": "AccountTopUp",
        "fundsDirection": "Income",
        "currency": "USD",
        "transAmount": 500.00,
        "availableBalance": 1500.50,
        "blockedBalance": 0.00,
        "orderNo": "order_123456",
        "note": "账户充值",
        "cardInfo": {
          "cardId": "CARD123456",
          "maskedCardNumber": "****1234"
        },
        "transTime": "2024-01-15T09:30:00Z"
      }
    ]
  }
}
```

#### 响应参数说明

| 参数名称                     | 参数类型          | 中文名称         | 参数描述                    |
|---------------------------|---------------|--------------|-------------------------|
| responseId                | string        | 响应ID         | 响应Id，需调用方保存，用于排查调用遇到的问题 |
| hasError                  | boolean       | 是否有错误        | 是否有错误发生                 |
| errorCode                 | string        | 错误码          | 错误代码                    |
| errorMessage              | string        | 错误信息         | 错误信息                    |
| data                      | object        | 数据           | 分页数据                    |
| ├─ pageIndex              | integer       | 页码           | 当前页码                    |
| ├─ pageSize               | integer       | 页大小          | 每页数量                    |
| ├─ totalCount             | integer       | 总记录数         | 总记录数                    |
| ├─ totalPages             | integer       | 总页数          | 总页数                     |
| └─ items                  | array[object] | 明细列表         | 客户账户明细列表                |
| 　　├─ id                 | string        | 流水号          | 流水唯一标识                  |
| 　　├─ accountTransType   | string        | 交易类型         | 账户交易类型                  |
| 　　├─ fundsDirection     | string        | 资金方向         | Income-收入, Expenditure-支出 |
| 　　├─ currency           | string        | 币种           | 账户币种                    |
| 　　├─ transAmount        | decimal       | 交易金额         | 交易金额（分正负）               |
| 　　├─ availableBalance   | decimal       | 可用余额         | 调整后可用余额                 |
| 　　├─ blockedBalance     | decimal       | 冻结余额         | 调整后冻结余额                 |
| 　　├─ orderNo            | string        | 关联订单号        | 关联订单号 (可选)              |
| 　　├─ note               | string        | 备注           | 备注信息 (可选)               |
| 　　├─ cardInfo           | object        | 卡信息          | 卡基本信息 (可选)              |
| 　　└─ transTime          | DateTime      | 交易时间         | 交易发生时间                  |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

## 交易管理

### GET 查询交易流水（分页）

**接口地址：** GET /v1/transactions

**功能描述：** 查询虚拟卡交易流水，支持分页查询

#### 请求参数

| 参数名称              | 参数位置   | 参数类型     | 是否必填 | 中文名称      | 参数描述                                                                                           |
|-------------------|--------|----------|------|-----------|------------------------------------------------------------------------------------------------|
| Authorization     | header | string   | 是    | 授权头       | Bearer {access_token}                                                                          |
| cardId            | query  | string   | 否    | 卡ID       | 指定查询的卡片ID，不传则查询所有卡片的交易                                                                         |
| transactionDateFrom | query  | datetime | 是    | 交易开始时间    | 交易查询开始时间，格式：2024-01-01T00:00:00Z                                                              |
| transactionDateTo | query  | datetime | 是    | 交易结束时间    | 交易查询结束时间，格式：2024-01-01T23:59:59Z                                                              |
| transactionStatus | query  | string   | 否    | 交易状态      | 交易状态筛选：AuthSuccess-预授权成功, AuthFailure-预授权失败, Settled-已入账                                      |
| pageSize          | query  | integer  | 否    | 每页数量      | 每页返回的记录数，默认20，最大100                                                                            |
| pageCursor        | query  | string   | 否    | 分页游标      | 分页游标，用于获取下一页数据。首次查询不传，后续查询传入上一页返回的pageCursor值。当返回"None"时表示已到最后一页                           |

#### 请求示例

```bash
# 查询所有卡片的交易记录
curl -X GET "https://test.cardepass.com/openapi/v1/transactions?transactionDateFrom=2024-01-01T00:00:00Z&transactionDateTo=2024-01-31T23:59:59Z&pageSize=20" \
  -H "Authorization: Bearer your_access_token"

# 查询指定卡片的交易记录
curl -X GET "https://test.cardepass.com/openapi/v1/transactions?cardId=CARD123456&transactionDateFrom=2024-01-01T00:00:00Z&transactionDateTo=2024-01-31T23:59:59Z&transactionStatus=Settled" \
  -H "Authorization: Bearer your_access_token"

# 分页查询（获取下一页）
curl -X GET "https://test.cardepass.com/openapi/v1/transactions?transactionDateFrom=2024-01-01T00:00:00Z&transactionDateTo=2024-01-31T23:59:59Z&pageSize=20&pageCursor=eyJpZCI6IjY1YzNkNGY4..." \
  -H "Authorization: Bearer your_access_token"
```

#### 响应示例

```json
{
  "responseId": "12345678-1234-1234-1234-123456789012",
  "hasError": false,
  "errorCode": null,
  "errorMessage": "操作成功",
  "data": {
    "pageCursor": "eyJpZCI6IjY1YzNkNGY4NzEyMzQ1Njc4OWFiY2RlZiJ9",
    "pageSize": 20,
    "data": [
      {
        "id": "65c3d4f871234567890abcdef",
        "authTime": "2024-01-15T10:30:00Z",
        "settleTime": "2024-01-15T10:35:00Z",
        "transAmount": {
          "amount": 99.99,
          "currency": "USD"
        },
        "authAmount": {
          "amount": 99.99,
          "currency": "USD"
        },
        "settledAmount": {
          "amount": 99.99,
          "currency": "USD"
        },
        "cardInfo": {
          "cardId": "CARD123456",
          "maskedCardNumber": "****1234",
          "cardCurrency": "USD"
        },
        "cardAlias": "我的美元卡",
        "authCode": "123456",
        "merchantName": "Amazon.com",
        "merchantCountryCode": "US",
        "merchantCity": "Seattle",
        "merchantState": "WA",
        "merchantZipCode": "98101",
        "merchantDesc": "AMAZON.COM AMZN.COM/BILL WA",
        "status": "Settled",
        "fundsDirection": "Expenditure",
        "transactionType": "Consume",
        "failureReason": null,
        "failureReasonCn": null,
        "note": "在线购物消费"
      }
    ]
  }
}
```

#### 响应参数说明

| 参数名称                        | 参数类型          | 中文名称         | 参数描述                                                                                     |
|------------------------------|---------------|--------------|----------------------------------------------------------------------------------------|
| responseId                   | string        | 响应ID         | 响应Id，需调用方保存，用于排查调用遇到的问题                                                               |
| hasError                     | boolean       | 是否有错误        | 是否有错误发生                                                                                |
| errorCode                    | string        | 错误码          | 错误代码                                                                                   |
| errorMessage                 | string        | 错误信息         | 错误信息                                                                                   |
| data                         | object        | 数据           | 分页查询结果数据                                                                               |
| ├─ pageCursor                | string        | 分页游标         | 下一页的分页游标，"None"表示已到最后一页                                                              |
| ├─ pageSize                  | integer       | 每页数量         | 当前页返回的记录数                                                                              |
| └─ data                      | array[object] | 交易列表         | 交易记录列表                                                                                 |
| 　├─ id                      | string        | 交易ID         | 唯一交易标识符                                                                                |
| 　├─ authTime                | datetime      | 预授权时间        | 交易预授权发生时间                                                                              |
| 　├─ settleTime              | datetime      | 清算时间         | 交易清算完成时间（可选）                                                                           |
| 　├─ transAmount             | object        | 原始交易金额       | 商户收取的原始交易金额                                                                            |
| 　├─ authAmount              | object        | 预授权金额        | 预授权冻结的金额（卡本币）                                                                          |
| 　├─ settledAmount           | object        | 结算金额         | 最终结算的金额（可选）                                                                            |
| 　├─ cardInfo                | object        | 卡片信息         | 关联的卡片信息                                                                                |
| 　　├─ cardId                | string        | 卡片ID         | 卡片唯一标识符                                                                                |
| 　　├─ maskedCardNumber      | string        | 脱敏卡号         | 脱敏处理的卡号                                                                                |
| 　　└─ cardCurrency          | string        | 卡片币种         | 卡片结算币种                                                                                 |
| 　├─ cardAlias               | string        | 卡片别名         | 用户设置的卡片昵称（可选）                                                                          |
| 　├─ authCode                | string        | 授权码          | 交易授权码（可选）                                                                              |
| 　├─ merchantName            | string        | 商户名称         | 交易商户名称                                                                                 |
| 　├─ merchantCountryCode     | string        | 商户国家代码       | 商户所在国家的ISO代码                                                                           |
| 　├─ merchantCity            | string        | 商户城市         | 商户所在城市                                                                                 |
| 　├─ merchantState           | string        | 商户州/省        | 商户所在州或省份                                                                               |
| 　├─ merchantZipCode         | string        | 商户邮编         | 商户邮政编码                                                                                 |
| 　├─ merchantDesc            | string        | 商户描述         | 商户详细描述信息                                                                               |
| 　├─ status                  | string        | 交易状态         | AuthSuccess-预授权成功, AuthFailure-预授权失败, Settled-已入账                                      |
| 　├─ fundsDirection          | string        | 资金方向         | Income-收入, Expenditure-支出                                                              |
| 　├─ transactionType         | string        | 交易类型         | Consume-消费, ConsumeRefund-消费退款, ConsumeDispute-消费争议, DisputeRelease-争议释放, ConsumeReversal-消费冲正, ConsumeRefundReversal-消费退款冲正, AuthQuery-预授权查询, TransFee-交易手续费 |
| 　├─ failureReason           | string        | 失败原因         | 交易失败时的英文原因描述（可选）                                                                       |
| 　├─ failureReasonCn         | string        | 中文失败原因       | 交易失败时的中文原因描述（可选）                                                                       |
| 　└─ note                    | string        | 交易备注         | 交易相关备注信息（可选）                                                                           |

#### 状态码说明

| 状态码 | 说明   | 解决方案     |
|-----|------|----------|
| 200 | 成功   | 请求处理成功   |
| 401 | 未授权  | 重新获取访问令牌 |
| 403 | 禁止访问 | 检查权限设置   |

---

## 错误码说明

#### 通用错误码

| 错误码 | HTTP状态码 | 错误说明      | 解决方案          |
|-----|---------|-----------|---------------|
| 401 | 401     | 访问令牌无效或过期 | 重新获取访问令牌      |
| 403 | 403     | 权限不足      | 检查账户权限或联系管理员  |
| 404 | 404     | 请求的资源不存在  | 检查请求的资源ID是否正确 |
| 400 | 400     | 请求参数错误    | 检查请求参数格式和内容   |
| 429 | 429     | 请求频率超限    | 降低请求频率或等待后重试  |
| 500 | 500     | 服务器内部错误   | 稍后重试或联系技术支持   |

---

## 最佳实践

#### 认证管理

1. **令牌缓存**：访问令牌有效期为1小时，建议在客户端缓存令牌，避免频繁获取
2. **令牌刷新**：在令牌过期前主动刷新，避免API调用中断
3. **安全存储**：客户端凭据应安全存储，不要硬编码在代码中

#### 错误处理

1. **重试机制**：对于5xx错误和网络超时，实现指数退避重试
2. **错误日志**：记录完整的错误响应，包括responseId用于问题追踪
3. **业务异常**：根据业务错误码实现相应的处理逻辑

#### 分页查询

1. **合理分页**：建议PageSize不超过100，避免单次请求数据量过大
2. **时间范围**：查询时间范围不建议超过3个月
3. **索引使用**：使用cardId等索引字段提高查询效率

#### 幂等性

1. **客户订单号**：使用有意义的客户订单号确保操作幂等性
2. **状态检查**：在重要操作前先查询当前状态
3. **避免重复**：对于创建类操作，确保客户订单号唯一性

---

## 版本历史

| 版本号  | 发布日期       | 更新内容 |
|------|------------|------|
| v1.0 | 2025-06-26 | 第一版  |
| v1.1 | 2025-08-18 | 主要增加了产品相关权限说明，例如是否允许开卡，是否允许充值等权限  |
| v1.2 | 2025-09-05 | 新增交易管理模块，添加GET /v1/transactions接口用于分页查询交易流水 |
| v1.3 | 2025-09-05 | 修正GET /v1/orders/standard接口文档：将orderType参数标记为必填，增加使用orderNo和customerOrderNo查询的curl示例 |
---

**文档最后更新时间**: 2025-09-05
**文档版本**: v1.3
**API版本**: v1
**生成方式**: 基于OpenAPI规范(swagger.json)自动生成

© 2025 Cardepass.com. All rights reserved.







