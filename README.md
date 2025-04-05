# 📦 infra_gym-trainer

Infraestrutura como código (IaC) para um backend seguro e escalável que entrega imagens com links temporários usando **AWS + MongoDB Atlas**. Criado com **Terraform**, este repositório implementa uma API REST com Lambda e API Gateway que gera links assinados para imagens armazenadas no S3, sem expor o caminho real ao cliente.

---

## 🏗️ Componentes da Infraestrutura

| Serviço         | Função                                                                 |
|----------------|------------------------------------------------------------------------|
| **AWS Lambda**  | Função que busca imagem no MongoDB Atlas e gera URL temporária (signed URL) do S3 |
| **API Gateway** | Cria endpoint HTTP `/imagens/{id}` que chama a Lambda                 |
| **S3 Bucket**   | Armazena imagens de forma privada (não públicas)                     |
| **IAM Roles**   | Permissões para Lambda acessar o S3 e logar no CloudWatch            |
| **MongoDB Atlas** | Banco externo com metadados das imagens ou referências a arquivos  |

---

## 🔁 Fluxo de Funcionamento

```text
Cliente → API Gateway → Lambda → MongoDB Atlas + S3 → Link Temporário → Cliente

```


### Instruções de Deploy
```text
    - cd terraform
    - terraform init
    - terraform apply -var="mongodb_uri=<SUA_STRING_MONGO_ATLAS>"

```

## Aqui temos uma receita fake para demonstrar o que foi criado em aula.

```text
Para criar e reproduzir altere os dados utilizando os dados do seu projeto bem como sua conta AWS, lembre-se de deixar o repositório privado para proteger suas informações de conta!
```