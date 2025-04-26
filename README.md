# Cardepass API 文档

## 概述

Cardepass API 提供了完整的虚拟卡管理功能，包括开卡、充值、冻结/解冻、销卡等操作。本文档将指导您快速接入和使用 Cardepass API。

## 环境地址

- 测试环境: `https://test.cardepass.com/openapi`
- 生产环境: `https://cardepass.com/openapi`

## 认证方式

API 使用 Bearer Token 认证方式，需要先获取 access_token。

### 1. 获取 Access Token

```http
POST /connect/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
client_id=YOUR_CLIENT_ID
client_secret=YOUR_CLIENT_SECRET
```

成功后返回:
```json
{
  "access_token": "eyJhbGc...",
  "expires_in": 3600,
  "token_type": "Bearer",
  "scope": "card"
}
```

### 2. 使用 Token

在后续 API 调用中，将 token 添加到请求头:

```http
Authorization: Bearer YOUR_ACCESS_TOKEN
```

## 基本流程

### 1. 查询可用产品

```http
GET /v1/products
```

返回可用的卡产品列表，包含产品代码、支持的卡模式和币种等信息。

### 2. 开卡

#### 标准模式开卡
```http
POST /v1/orders/standard/apply
Content-Type: application/json

{
  "productCode": "PRODUCT_CODE",
  "cardCurrency": "USD",
  "topUpAmount": "10",
  "cardAlias": "My Card",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 共享余额模式开卡
```http
POST /v1/orders/sharebalance/apply
Content-Type: application/json

{
  "productCode": "PRODUCT_CODE", 
  "cardCurrency": "USD",
  "maxAuthAmount": "10",
  "cardAlias": "My Card",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

### 3. 查询卡信息

```http
GET /v1/cards/{cardId}
```

返回卡的详细信息，包括卡号、CVV、有效期等。

## 卡操作

### 标准模式(Standard)卡操作

#### 1. 充值
```http
POST /v1/orders/standard/topup
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "topUpAmount": "2",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 2. 冻结
```http
POST /v1/orders/standard/block
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 3. 解冻
```http
POST /v1/orders/standard/unblock
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 4. 销卡
```http
POST /v1/orders/standard/cancel
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 5. 余额转出
```http
POST /v1/orders/standard/withdraw
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "withdrawAmount": "1",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

### 共享余额模式(ShareBalance)卡操作

#### 1. 调整限额
```http
POST /v1/orders/sharebalance/creditLimit
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "maxAuthAmount": "20",
  "maxCreditAmount": "", // 为空表示无限额度
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 2. 冻结
```http
POST /v1/orders/sharebalance/block
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 3. 解冻
```http
POST /v1/orders/sharebalance/unblock
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

#### 4. 销卡
```http
POST /v1/orders/sharebalance/cancel
Content-Type: application/json

{
  "cardId": "CARD_ID",
  "customerOrderNo": "YOUR_ORDER_NO"
}
```

### 两种模式的主要区别

1. 标准模式(Standard):
   - 每张卡都有独立的余额
   - 需要先充值才能使用
   - 支持余额转出操作
   - 消费受卡内余额限制

2. 共享余额模式(ShareBalance):
   - 多张卡共享资金池余额
   - 无需单独充值
   - 通过限额控制消费
   - 支持设置单笔限额(maxAuthAmount)和总额度(maxCreditAmount)

### 查询交易

```http
GET /v1/transactions?CardId={cardId}&TransactionDateFrom=2024-01-01&TransactionDateTo=2024-12-31
```

## 重要提示

1. 请妥善保管 client_id 和 client_secret
2. access_token 有效期为1小时，建议在过期前刷新
3. 所有金额相关字段使用字符串类型
4. 请求前先确认使用的环境(测试/生产)
5. 建议先在测试环境完成功能验证
6. customerOrderNo 需要保证唯一性
7. 操作前请确认卡状态是否正常
8. 共享余额模式的maxCreditAmount为空表示无限额度
9. 标准模式的充值和转出操作会产生手续费
10. 所有操作都是异步的,需要通过订单查询接口确认最终状态

## 常见问题

1. Token 获取失败
   - 检查 client_id 和 client_secret 是否正确
   - 确认请求环境是否正确

2. 开卡失败
   - 检查产品代码是否正确
   - 确认账户余额是否充足
   - 验证币种是否支持

3. 交易查询无数据
   - 确认查询时间范围是否正确
   - 验证卡ID是否正确
   - 检查卡状态是否正常

## 技术支持

如需技术支持，请联系 Cardepass 技术团队获取帮助。