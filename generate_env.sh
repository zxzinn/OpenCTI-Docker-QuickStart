#!/bin/bash

# 生成一個隨機密碼
generate_password() {
    openssl rand -base64 12
}

# 生成一個UUID
generate_uuid() {
    python -c "import uuid; print(str(uuid.uuid4()))"
}

# 生成一個API金鑰
generate_api_key() {
    openssl rand -hex 32
}

# 檢查.env.example是否存在
if [ ! -f .env.example ]; then
    echo "錯誤：找不到 .env.example 文件"
    exit 1
fi

# 如果.env已存在，創建備份
if [ -f .env ]; then
    cp .env ".env.backup.$(date +%Y%m%d_%H%M%S)"
fi

# 讀取.env.example並創建新的.env
while IFS= read -r line || [ -n "$line" ]; do
    # 跳過空行和註釋
    if [ -z "$line" ] || [[ $line == \#* ]]; then
        echo "$line" >> .env.tmp
        continue
    fi

    # 獲取變數名稱
    var_name=$(echo "$line" | cut -d'=' -f1)
    
    # 根據不同的變數類型生成不同的值
    case "$var_name" in
        *"_TOKEN" | *"_ID")
            # UUID類型
            echo "$var_name=$(generate_uuid)" >> .env.tmp
            ;;
        *"API_KEY")
            # API金鑰類型
            echo "$var_name=$(generate_api_key)" >> .env.tmp
            ;;
        "IPINFO_TOKEN")
            # 較短的API金鑰
            echo "$var_name=$(openssl rand -hex 8)" >> .env.tmp
            ;;
        *"PASSWORD" | *"_PASS")
            # 密碼類型
            echo "$var_name=$(generate_password)" >> .env.tmp
            ;;
        *)
            # 保持原值的變數
            if [[ $line == *"ChangeMe"* ]]; then
                echo "$var_name=$(generate_password)" >> .env.tmp
            else
                echo "$line" >> .env.tmp
            fi
            ;;
    esac
done < .env.example

# 移動臨時文件到最終位置
mv .env.tmp .env

echo "新的 .env 文件已生成完成！"
