# Minicurso — Inteligência de Negócios: dbt (Data Build Tool)

Repositório do minicurso de **dbt (Data Build Tool)** ministrado na disciplina de **Inteligência de Negócios (FAGEN32602)**, da Faculdade de Gestão e Negócios (FAGEN) — Universidade Federal de Uberlândia (UFU).

Este repositório **é o próprio hands-on**: siga o passo a passo abaixo, na ordem, para instalar as ferramentas, conectar ao banco e rodar o pipeline dbt do zero até os modelos finais (marts).

---

## 📌 Sobre o minicurso

O dbt é hoje um dos padrões de fato da engenharia analítica moderna, responsável pela camada de **transformação (T)** em arquiteturas ELT. O framework aplica práticas de engenharia de software — versionamento, testes, modularização e documentação — diretamente sobre transformações SQL.

Este minicurso cobre:

- Contexto: o que é o dbt, onde se encaixa no ecossistema de BI e casos de uso reais.
- Hands-on guiado: execução de um pipeline de transformação real, sobre um dataset de gestão agrícola (fazendas, talhões, safras, plantio e colheita).
- Laboratório prático: réplica guiada do pipeline pela turma, seguindo este mesmo README.
- Análise crítica: comparação honesta com a ferramenta central da disciplina (Pentaho Data Integration).

---

## 🏗️ Arquitetura do projeto

```
Fonte de dados (sistema gerencial de plantio e colheita)
        │
        ▼
  PostgreSQL (Supabase) ── banco gerenciado na nuvem, usado como Data Warehouse
        │
        ▼
   dbt (staging → intermediate → marts) ── camada de transformação (foco do minicurso)
```

**Por que Postgres via Supabase, e não MySQL:**
O dbt possui adapter **nativo** para PostgreSQL, mantido diretamente pela dbt Labs — mais estável e mais documentado que alternativas de comunidade. Usar um Postgres gerenciado na nuvem (Supabase) elimina a necessidade de qualquer instalação local de banco de dados: cada aluno só precisa de uma string de conexão para acompanhar o laboratório.

**Sobre o dado final:**
O foco do minicurso é a ferramenta de **transformação**. Não há camada de visualização (Streamlit/BI) neste repositório — o pipeline termina nos modelos de `marts` (dimensões e fatos), prontos para serem consumidos por qualquer ferramenta de BI.

---

## 🧰 Stack utilizada

| Camada | Ferramenta |
| --- | --- |
| Armazenamento (DW) | PostgreSQL (Supabase) |
| Transformação | dbt (dbt-core + dbt-postgres) |
| Editor | Visual Studio Code |
| Versionamento | Git / GitHub |

---

## 📂 Estrutura do repositório

```
.
├── minicurso_dbt/
│   ├── models/
│   │   ├── _sources.yml     # declaração e testes das tabelas de origem
│   │   ├── staging/         # limpeza e padronização 1:1 com as fontes
│   │   ├── intermediate/    # joins e regras de negócio (conversões, status de cronograma)
│   │   └── marts/           # modelos finais: dimensões e fatos
│   ├── macros/               # macros customizados (conversão de unidade por cultura)
│   ├── seeds/ | snapshots/ | tests/ | analyses/
│   └── dbt_project.yml
└── README.md
```

---

## ✅ Passo a passo — do zero ao pipeline rodando

### 1. Pré-requisitos

Baixe e instale, nesta ordem:

1. **Git** — necessário para clonar este repositório e versionar seu trabalho.
   → https://git-scm.com/install/
2. **Python** (versão 3.13 ou mais recente)
   → https://www.python.org/downloads/
3. **Visual Studio Code**
   → https://code.visualstudio.com/download

### 2. Criar conta no Supabase (banco de dados na nuvem)

O dataset do minicurso já está hospedado em um projeto PostgreSQL no Supabase. Para se conectar a ele:

1. Crie uma conta gratuita em https://supabase.com/
2. Acesse o projeto do minicurso, fornecido pela dupla em aula (link de exemplo do projeto de referência: `https://supabase.com/dashboard/project/vtzvhajzfqdgdsxyvbjr/database/schemas`)
3. Em **Project Settings → Database**, anote as credenciais de conexão:
   - `host`
   - `port` (padrão `5432`)
   - `database`
   - `user`
   - `password`

> ⚠️ Essas credenciais serão fornecidas verbalmente/pelo grupo da turma no início da aula — nunca commitar credenciais reais em nenhum arquivo do repositório.

### 3. Clonar o repositório

```bash
git clone https://github.com/Gabriel-hrq/DBT-Inteligencia_de_Negocios.git
cd DBT-Inteligencia_de_Negocios
```

Abra a pasta clonada no VS Code (`File → Open Folder...`) e abra um terminal integrado (`Terminal → New Terminal`).

### 4. Criar o ambiente virtual Python

```bash
# Validar a instalação do Python
python --version

# Atualizar gerenciador de pacotes
python -m pip install --upgrade pip

# Criar o ambiente virtual
python -m venv venv

# Ativar o ambiente virtual
# Windows (PowerShell):
venv\Scripts\Activate.ps1
# Linux / macOS:
source venv/bin/activate
```

Se `python --version` der erro, revise a instalação do Python feita no passo 1 (em especial, marcar a opção "Add Python to PATH" no instalador do Windows).

### 5. Instalar o dbt

```bash
pip install dbt-postgres
```

Valide a instalação:

```bash
dbt --version
```

### 6. Conectar o dbt ao banco (Supabase)

Este repositório já contém o projeto dbt pronto em `minicurso_dbt/`. Para conectá-lo ao seu banco, crie o arquivo de perfil do dbt (`profiles.yml`) com as credenciais obtidas no passo 2:

```bash
cd minicurso_dbt
dbt init
```

O comando `dbt init` vai pedir as credenciais interativamente (host, port, database, user, password, schema). Informe os dados do Supabase.

> Alternativa manual: crie/edite `~/.dbt/profiles.yml` diretamente:
> ```yaml
> minicurso_dbt:
>   target: dev
>   outputs:
>     dev:
>       type: postgres
>       host: aws-1-sa-east-1.pooler.supabase.com
>       port: 5432
>       user: <user-do-supabase>
>       password: <senha>
>       dbname: <database>
>       schema: public
>       threads: 4
> ```

### 7. Validar a conexão

```bash
dbt debug
```

Saída esperada:

```
20:46:59  All checks passed!
```

Se der erro, confira: credenciais do passo 2, se o projeto Supabase está ativo, e se `port` está correto (`5432`).

### 8. Rodar o pipeline

```bash
# Rodar todos os modelos (staging → intermediate → marts)
dbt run

# Rodar os testes de qualidade (unique, not_null, relationships, accepted_values)
dbt test

# Gerar e navegar pela documentação/linhagem (lineage) do projeto
dbt docs generate
dbt docs serve
```

Se tudo rodou sem erros, os modelos finais estarão disponíveis no banco, no schema configurado, como tabelas (`marts`) e views (`staging`).

---

## 🔍 O que o pipeline faz

- **`_sources.yml`** — declara as 7 tabelas de origem do sistema gerencial (`cultura`, `variedade`, `fazenda`, `talhao`, `safra`, `plantio`, `colheita`), já com testes de integridade.
- **staging** — um modelo por fonte, renomeando e padronizando colunas.
- **intermediate** — onde a regra de negócio acontece:
  - `int_talhao`: separa o campo `codigo` de origem em `fazenda` e `talhao`.
  - `int_plantio`: resolve a cultura via variedade, calcula datas de colheita planejada e define `status_cronograma` (`colhido` / `em_andamento`).
  - `int_colheita`: converte a produtividade para a unidade padrão de cada cultura (sc/ha, @/ha, bu/ha, kg/ha) usando os macros `fator_conversao_kg` e `unidade_produtividade`.
- **marts** — modelagem dimensional final: 6 dimensões (`dim_cultura`, `dim_fazenda`, `dim_safra`, `dim_variedade`, `dim_talhao`, `dim_plantio`, `dim_colheita`) e 2 fatos factless (`fact_cronograma`, `fact_produtividade`).

---

## 📚 Documentação oficial (referência)

- dbt: https://docs.getdbt.com/docs/build/documentation
- Supabase: https://supabase.com/docs
- VS Code: https://code.visualstudio.com/docs

---

## 👥 Autoria

Minicurso desenvolvido por **Gabriel Henrique Alves Silva**, para a disciplina FAGEN32602 — Inteligência de Negócios (2026/01), sob orientação do **Prof. Dr. José Eduardo Ferreira Lopes** — FAGEN/UFU.
