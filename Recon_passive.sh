#!/bin/bash

# Verificar se a URL foi fornecida
if [ "$#" -ne 1 ]; then
  echo "Uso: $0 <URL>"
  exit 1
fi

URL=$1
RESULT_DIR="resultados"

# Criar a pasta de resultados
mkdir -p "$RESULT_DIR"

# Executar whois
echo "Executando whois em $URL..."
whois "$URL" > "$RESULT_DIR/whois.txt"

# Executar dig
echo "Executando dig em $URL..."
dig "$URL" > "$RESULT_DIR/dig.txt"

# Executar nslookup
echo "Executando nslookup em $URL..."
nslookup "$URL" > "$RESULT_DIR/nslookup.txt"

# Executar ping e obter o IP
echo "Executando ping em $URL..."
PING_IP=$(ping -c 1 "$URL" | grep -oP '(?<=\()\d+\.\d+\.\d+\.\d+(?=\))')

if [ -z "$PING_IP" ]; then
  echo "Falha ao obter o IP do ping. Finalizando..."
  exit 1
fi

echo "IP obtido do ping: $PING_IP"

# Executar as ferramentas novamente com o IP do ping
# Executar whois
echo "Executando whois no IP $PING_IP..."
whois "$PING_IP" > "$RESULT_DIR/pingwhois.txt"

# Executar dig
echo "Executando dig no IP $PING_IP..."
dig -x "$PING_IP" > "$RESULT_DIR/pingdig.txt"

# Executar nslookup
echo "Executando nslookup no IP $PING_IP..."
nslookup "$PING_IP" > "$RESULT_DIR/pingnslookup.txt"


echo "Reconhecimento passivo concluído. Resultados salvos na pasta '$RESULT_DIR'."
