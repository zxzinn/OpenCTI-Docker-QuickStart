# OpenCTI Docker 部署指南

<div align="right">

[English](README_EN.md) | **繁體中文**

</div>

## 簡介
這個專案包含了部署OpenCTI所需的Docker Compose配置文件和環境設置腳本。OpenCTI（Open Cyber Threat Intelligence）是一個開源的威脅情報平台。

## 前置需求
- Docker
- Docker Compose
- Python 3.x
- OpenSSL

## 快速開始

1. 克隆此儲存庫：
```bash
git clone [your-repository-url]
cd [repository-name]
```

2. 生成環境配置文件：
   - Windows用戶：雙擊執行 `generate_env.bat`
   - Linux/Mac用戶：執行 `./generate_env.sh`

3. 啟動服務：
```bash
docker-compose up -d
```

4. 訪問平台：
   打開瀏覽器訪問 `http://localhost:8080`

## 文件說明

- `docker-compose.yml`: Docker服務配置文件
- `.env.example`: 環境變數範本文件
- `generate_env.bat`: Windows環境配置生成腳本
- `generate_env.sh`: Linux/Mac環境配置生成腳本

## 環境配置說明

環境配置包含以下主要部分：
- OpenCTI平台配置
- MinIO配置（對象存儲）
- RabbitMQ配置（消息佇列）
- ElasticSearch配置
- 各種連接器配置（MITRE、AlienVault等）

## 安全性注意事項

1. 請勿將包含敏感信息的 `.env` 文件上傳到版本控制系統
2. 定期更換密碼和API密鑰
3. 確保生產環境中使用強密碼

## 故障排除

如果遇到問題：

1. 確認所有必要的服務都已啟動：
```bash
docker-compose ps
```

2. 檢查服務日誌：
```bash
docker-compose logs [service-name]
```

3. 確認環境變數是否正確設置：
```bash
docker-compose config
```

## 貢獻指南

歡迎提交Pull Request和Issue來改進這個項目。在提交之前，請：

1. 確保代碼符合項目規範
2. 更新相關文檔
3. 添加必要的測試

## 授權

本項目採用 MIT 授權條款 - 詳見 [LICENSE](LICENSE) 文件
