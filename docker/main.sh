#!/bin/bash

current_hour=$(date +"%Y-%m-%d_%H")
file_name="data_${current_hour}.csv"
temp_file="data_${current_hour}.json"

storageAccountName="azulstorage1"
containerName="dailydata"
blobName="${file_name}"
filePath="${file_name}"
accessKey="xyz"

echo "Executing script..."
curl 'https://api.coinbase.com/v2/exchange-rates' > "$temp_file"
jq -r '["Currency","Rate"], (.data.rates | to_entries[] | [.key, .value]) | @csv' "$temp_file" > "$file_name"

# Check if the blob already exists
existing_blob=$(az storage blob show \
    --account-name "$storageAccountName" \
    --container-name "$containerName" \
    --name "$blobName" \
    --account-key "$accessKey" 2>&1)

if [[ $existing_blob != *"BlobNotFound"* ]]; then
    # Blob exists, delete it
    az storage blob delete \
        --account-name "$storageAccountName" \
        --container-name "$containerName" \
        --name "$blobName" \
        --account-key "$accessKey"
fi

# Upload the file
az storage blob upload \
    --account-name "$storageAccountName" \
    --container-name "$containerName" \
    --name "$blobName" \
    --file "$filePath" \
    --account-key "$accessKey"

# Check the upload status
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to Azure Blob Storage."
else
    echo "Failed to upload file to Azure Blob Storage."
fi

exit 0