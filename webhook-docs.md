# Webhook通知对接文档

## 1. 概述

本文档描述了如何接收和处理系统发送的Webhook通知。系统会将各类业务事件通过HTTP POST请求推送到您配置的回调地址，您需要实现相应的接口来处理这些通知。

## 2. 配置要求

要接收Webhook通知，您需要：

1. 提供一个可公网访问的HTTP/HTTPS回调地址
2. 设置一个用于验证签名的密钥(Secret)
3. 选择需要订阅的事件类型

## 3. 通知格式

### 3.1 请求方式

- HTTP方法: POST
- Content-Type: application/json

### 3.2 请求体结构

```json
{
  "Id": "1234567890abcdef1234567890abcdef",
  "Type": "CardPay",
  "CreatedTime": "2023-05-20T08:30:45Z",
  "Data": {
    // 事件相关数据，根据事件类型不同而不同
  },
  "Version": "1.0",
  "Signature": "base64编码的签名"
}
```

### 3.3 参数说明

| 字段名      | 类型     | 说明                           |
|-------------|----------|--------------------------------|
| Id          | string   | 通知的唯一标识符               |
| Type        | string   | 通知类型，见下方事件类型表     |
| CreatedTime | datetime | 通知创建时间（UTC时间）        |
| Data        | object   | 通知的具体内容，与事件类型相关 |
| Version     | string   | 接口版本号                     |
| Signature   | string   | 请求签名，用于验证请求的真实性 |

### 3.4 事件类型(Type)

| 类型           | 说明                 | 实现状态            |
|----------------|----------------------|---------------------|
| CardPay        | 卡消费通知           | ✅ 已实现            |
| ApplyCard      | 开卡通知             | 🚧 开发中，暂未提供 |
| Recharge       | 充值通知             | 🚧 开发中，暂未提供 |
| AcctPay        | 共享账户资金动账通知 | 🚧 开发中，暂未提供 |
| CardAudit      | 卡片审核通知         | 🚧 开发中，暂未提供 |
| CardActivation | 卡片激活通知         | 🚧 开发中，暂未提供 |
| CardBlock      | 卡片锁定通知         | 🚧 开发中，暂未提供 |
| CardUnblock    | 卡片解锁通知         | 🚧 开发中，暂未提供 |
| CardCancel     | 卡片注销通知         | 🚧 开发中，暂未提供 |

> **📋 实现状态说明**：
> - ✅ **已实现**：完全支持，可正常使用
> - 🚧 **开发中，暂未提供**：功能规划中，敬请期待后续版本

## 4. 事件数据结构(Data字段)

### 4.1 CardPay - 卡消费通知 ✅

当卡片发生消费时，系统会发送此通知。包含预授权成功、预授权失败和交易结算三种子类型。

```json
{
  "Id": "66f8a1e4-1234-5678-9abc-123456789012",
  "AuthTime": "2023-05-20T08:30:45Z",
  "SettleTime": "2023-05-20T08:35:12Z",
  "TransAmount": {
    "Currency": "USD",
    "Amount": 29.99
  },
  "AuthAmount": {
    "Currency": "USD",
    "Amount": 29.99
  },
  "SettledAmount": {
    "Currency": "USD",
    "Amount": 29.99
  },
  "CardInfo": {
    "Id": "6805b2caa94783c5566f9397",
    "ProductCode": "0BN03HNK",
    "ProductName": "通用测试2卡",
    "CardCurrency": "USD",
    "MaskCardNumber": "436797******2419",
    "CardModel": "Standard"
  },
  "CardAlias": "测试卡01",
  "AuthCode": "123456",
  "MerchantName": "AMAZON.COM",
  "MerchantCountryCode": "US",
  "MerchantCity": "Seattle",
  "MerchantState": "WA",
  "MerchantZipCode": "98101",
  "MerchantDesc": "AMAZON.COM AMZN.COM/BILL WA",
  "Status": "AuthSuccess",
  "FundsDirection": "Expenditure",
  "TransactionType": "Consume",
  "FailureReason": null,
  "FailureReasonCn": null,
  "Note": "消费交易"
}
```

**字段说明**：

| 字段                | 类型     | 说明                         |
|---------------------|----------|------------------------------|
| Id                  | string   | 交易唯一标识符               |
| AuthTime            | datetime | 预授权时间(UTC)              |
| SettleTime          | datetime | 结算时间(UTC，可能为空)      |
| TransAmount         | Money    | 原始交易金额                 |
| ├─ Currency         | string   | 币种                         |
| └─ Amount           | decimal  | 金额                         |
| AuthAmount          | Money    | 预授权金额                   |
| ├─ Currency         | string   | 币种                         |
| └─ Amount           | decimal  | 金额                         |
| SettledAmount       | Money    | 结算金额(入账后返回)         |
| ├─ Currency         | string   | 币种                         |
| └─ Amount           | decimal  | 金额                         |
| CardInfo            | CardInfo | 卡片信息                     |
| ├─ Id               | string   | 卡片ID                       |
| ├─ ProductCode      | string   | 产品编码                     |
| ├─ ProductName      | string   | 产品名称                     |
| ├─ MaskCardNumber   | string   | 脱敏卡号                     |
| └─ CardModel        | string   | 卡模式                       |
| CardAlias           | string   | 卡别名(卡昵称)               |
| AuthCode            | string   | 授权码(授权失败时可能为空)   |
| MerchantName        | string   | 商户名称                     |
| MerchantCountryCode | string   | 商户国家代码                 |
| MerchantCity        | string   | 商户所在城市                 |
| MerchantState       | string   | 商户所在州                   |
| MerchantZipCode     | string   | 商户邮编                     |
| MerchantDesc        | string   | 商户描述                     |
| Status              | string   | 交易状态                     |
| FundsDirection      | string   | 资金方向(Income/Expenditure) |
| TransactionType     | string   | 交易类型                     |
| FailureReason       | string   | 失败原因(英文)               |
| FailureReasonCn     | string   | 失败原因(中文)               |
| Note                | string   | 备注信息                     |

**枚举值说明**：

- **Status**: `AuthSuccess`(预授权成功), `AuthFailure`(预授权失败), `Settled`(已入账)
- **FundsDirection**: `Income`(收入), `Expenditure`(支出)  
- **TransactionType**: `Consume`(消费), `ConsumeRefund`(消费退款), `ConsumeDispute`(消费争议), `DisputeRelease`(争议释放), `ConsumeReversal`(取消消费), `ConsumeRefundReversal`(消费退款冲正), `AuthQuery`(预授权查询), `TransFee`(交易手续费)

### 4.2 其他事件类型 🚧

以下事件类型正在开发中，Data字段结构将在后续版本中提供：

- **ApplyCard** - 开卡通知
- **Recharge** - 充值通知  
- **AcctPay** - 共享账户资金动账通知
- **CardAudit** - 卡片审核通知
- **CardActivation** - 卡片激活通知
- **CardBlock** - 卡片锁定通知
- **CardUnblock** - 卡片解锁通知
- **CardCancel** - 卡片注销通知

## 5. 签名验证

系统使用HMAC-SHA256算法对通知内容进行签名，您需要在收到通知后验证签名以确保通知的真实性。

### 5.1 签名生成规则

1. 将以下字段按顺序拼接：`Id + Type + CreatedTime + Data + Version`
2. 使用您配置的Secret和HMAC-SHA256算法对拼接字符串进行签名
3. 将结果进行Base64编码

## 6. 响应要求

您的服务器需要在接收到通知后，返回以下格式的JSON响应：

```json
{
  "Success": true,
  "ErrorCode": "",
  "ErrorMessage": ""
}
```

如果处理失败，请返回：

```json
{
  "Success": false,
  "ErrorCode": "ERROR_CODE",
  "ErrorMessage": "错误详细信息"
}
```

注意：系统会根据您的响应判断通知是否处理成功。如果您返回了错误状态码或错误的响应格式，系统将认为通知发送失败并可能进行重试。

## 7. 代码示例

### 7.1 Java实现（OpenAPI Webhook签名示例）

```java
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class OpenApiWebhookSignDemo {
    public static String generateSignature(String id, String type, String createdTime, String data, String version, String secret) throws Exception {
        String content = id + type + createdTime + data + version;
        Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
        SecretKeySpec secret_key = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        sha256_HMAC.init(secret_key);
        byte[] hash = sha256_HMAC.doFinal(content.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(hash);
    }
    public static void main(String[] args) throws Exception {
        String id = "123456";
        String type = "CardPay";
        String createdTime = "2023-05-20T08:30:45Z";
        String data = "{\"Id\":\"abc\",\"Amount\":100}"; // Data字段原始JSON字符串
        String version = "1.0";
        String secret = "your_webhook_secret";
        String sign = generateSignature(id, type, createdTime, data, version, secret);
        System.out.println("签名: " + sign);
    }
}
```

> 本示例适用于OpenAPI Webhook消息签名。

### 7.2 PHP实现

```php
<?php

// 接收Webhook通知
$requestBody = file_get_contents('php://input');
$payload = json_decode($requestBody, true);

// Webhook密钥
$secret = 'your_webhook_secret';

// 验证签名
if (!verifySignature($payload, $secret)) {
    http_response_code(200);
    echo json_encode([
        'Success' => false,
        'ErrorCode' => 'INVALID_SIGNATURE',
        'ErrorMessage' => '签名验证失败'
    ]);
    exit();
}

// 根据事件类型处理不同的业务逻辑
switch ($payload['Type']) {
    case 'CardPay':
        handleCardPayNotification($payload);
        break;
    case 'Recharge':
        handleRechargeNotification($payload);
        break;
    // 处理其他事件类型...
    default:
        http_response_code(200);
        echo json_encode([
            'Success' => false,
            'ErrorCode' => 'UNKNOWN_EVENT_TYPE',
            'ErrorMessage' => '未知的事件类型'
        ]);
        exit();
}

// 返回成功响应
http_response_code(200);
echo json_encode([
    'Success' => true,
    'ErrorCode' => '',
    'ErrorMessage' => ''
]);

/**
 * 验证Webhook签名
 *
 * @param array $payload
 * @param string $secret
 * @return bool
 */
function verifySignature($payload, $secret) {
    // 构建用于签名的字符串
    $content = $payload['Id'] . $payload['Type'] . $payload['CreatedTime'] . 
               json_encode($payload['Data']) . $payload['Version'];
    
    // 使用HMAC-SHA256计算签名
    $hash = hash_hmac('sha256', $content, $secret, true);
    $calculatedSignature = base64_encode($hash);
    
    // 比较计算出的签名与接收到的签名
    return hash_equals($calculatedSignature, $payload['Signature']);
}

/**
 * 处理卡消费通知
 *
 * @param array $payload
 * @return void
 */
function handleCardPayNotification($payload) {
    // 处理卡消费通知的业务逻辑
    error_log('收到卡消费通知: ' . $payload['Id']);
    
    // 解析CardPay数据
    $data = $payload['Data'];
    $transactionId = $data['Id'];
    $status = $data['Status'];
    $authCode = isset($data['AuthCode']) ? $data['AuthCode'] : null;
    
    error_log("交易ID: $transactionId");
    error_log("交易状态: $status");
    error_log("授权码: $authCode");
    
    // 根据交易状态处理业务逻辑
    switch ($status) {
        case 'AuthSuccess':
            handleAuthSuccess($transactionId, $authCode);
            break;
        case 'AuthFailure':
            handleAuthFailure($transactionId);
            break;
        case 'Settled':
            handleSettled($transactionId, $authCode);
            break;
    }
}

function handleAuthSuccess($transactionId, $authCode) {
    error_log("处理预授权成功: $transactionId, 授权码: $authCode");
    // 处理预授权成功的业务逻辑
}

function handleAuthFailure($transactionId) {
    error_log("处理预授权失败: $transactionId");
    // 处理预授权失败的业务逻辑
}

function handleSettled($transactionId, $authCode) {
    error_log("处理交易结算: $transactionId, 授权码: $authCode");
    // 处理交易结算的业务逻辑
}

function handleRechargeNotification($payload) {
    // 处理充值通知的业务逻辑
    error_log('收到充值通知: ' . $payload['Id']);
}
```

### 7.3 C#实现（OpenAPI Webhook签名示例）

```csharp
using System;
using System.Security.Cryptography;
using System.Text;

public class OpenApiWebhookSignDemo
{
    public static string GenerateSignature(string id, string type, string createdTime, string data, string version, string secret)
    {
        var content = id + type + createdTime + data + version;
        using (var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(secret)))
        {
            var hash = hmac.ComputeHash(Encoding.UTF8.GetBytes(content));
            return Convert.ToBase64String(hash);
        }
    }
    public static void Main()
    {
        var id = "123456";
        var type = "CardPay";
        var createdTime = "2023-05-20T08:30:45Z";
        var data = "{\"Id\":\"abc\",\"Amount\":100}"; // Data字段原始JSON字符串
        var version = "1.0";
        var secret = "your_webhook_secret";
        var sign = GenerateSignature(id, type, createdTime, data, version, secret);
        Console.WriteLine($"签名: {sign}");
    }
}
```

> 本示例适用于OpenAPI Webhook消息签名。

## 8. 常见问题

### 8.1 我收不到通知怎么办？

- 确认您的回调地址是否可公网访问
- 检查您是否正确配置了WebHook并启用了相关事件
- 查看您的服务器日志，确认是否收到了请求但处理失败

### 8.2 签名验证失败怎么办？

- 确认您使用的Secret是否正确
- 检查签名计算逻辑是否与文档一致
- 确认没有对签名字符串进行额外的处理（如去除空格、换行符等）

### 8.3 如何测试我的WebHook实现？

- 使用工具如Postman创建模拟的WebHook请求
- 在测试环境中触发相关事件，观察WebHook是否正常推送
- 实现详细的日志记录，以便于排查问题

## 9. 安全最佳实践

- 使用HTTPS作为回调地址
- 对密钥进行安全存储，不要硬编码在代码中
- 实现IP白名单，只允许系统的IP访问您的WebHook接口
- 实现请求超时处理，避免长时间处理导致资源耗尽
- 对接收到的数据进行验证，防止注入攻击 












