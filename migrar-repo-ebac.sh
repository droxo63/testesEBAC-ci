#!/bin/bash

REPO_ORIGINAL="https://github.com/EBAC-QE/testes-e2e-ebac-shop.git"
REPO_LOCAL="testes-e2e-ebac-shop"

echo "🔁 Clonando repositório original da EBAC..."
git clone "$REPO_ORIGINAL"

cd "$REPO_LOCAL" || exit 1

echo "🌿 Buscando todas as branches remotas..."
git fetch --all

# Lista de branches a migrar (adicione mais se necessário)
BRANCHES=("main" "ci" "azure-pipelines")

# Cria cada branch local a partir da origem remota
for BR in "${BRANCHES[@]}"; do
  echo "📦 Preparando branch: $BR"
  git checkout -b "$BR" "origin/$BR"
done

echo "🧹 Removendo remote original..."
git remote remove origin

echo "🔗 Digite a URL do seu novo repositório GitHub:"
read NOVO_REPO

git remote add origin "$NOVO_REPO"

# Push de todas as branches para o novo repositório
for BR in "${BRANCHES[@]}"; do
  git checkout "$BR"
  git push -u origin "$BR"
done

echo "🚀 Abrindo no VS Code..."
code .

