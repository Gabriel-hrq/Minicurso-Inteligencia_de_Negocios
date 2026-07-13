# Minicurso — Inteligência de Negócios: dbt (Data Build Tool)

Repositório do minicurso de **dbt (Data Build Tool)** ministrado na disciplina de **Inteligência de Negócios (FAGEN32602)**, da Faculdade de Gestão e Negócios (FAGEN) — Universidade Federal de Uberlândia (UFU).

Contém exemplos práticos de construção de pipelines analíticos modernos, utilizando SQL, boas práticas de engenharia de dados, testes automatizados, versionamento e documentação de modelos.

---

## 📌 Sobre o minicurso

O DBT é hoje um dos padrões de fato da engenharia analítica moderna, responsável pela camada de **transformação (T)** em arquiteturas ELT, o framework aplica práticas de engenharia de software — versionamento, testes, modularização e documentação — diretamente sobre transformações SQL.

Este minicurso cobre:

- Contexto: o que é o dbt, onde se encaixa no ecossistema de BI e casos de uso reais.
- Hands-on guiado: construção de um pipeline de transformação do zero, sobre um dataset real.
- Laboratório prático: réplica guiada do pipeline pela turma.
- Análise crítica: comparação honesta com a ferramenta central da disciplina (Pentaho Data Integration).

---

## 🏗️ Arquitetura do projeto

```
Fonte de dados (raw)
        │
        ▼
  PostgreSQL (Supabase) ── banco gerenciado na nuvem, usado como Data Warehouse
        │
        ▼
   dbt (staging → intermediate → marts) ── camada de transformação (foco do minicurso)
        │
        ▼
  Streamlit ── camada de consumo / visualização simples
```

**Por que Postgres via Supabase, e não MySQL:**
O dbt possui adapter **nativo** para PostgreSQL, mantido diretamente pela dbt Labs — mais estável e mais documentado que alternativas de comunidade. Usar um Postgres gerenciado na nuvem (Supabase) elimina a necessidade de qualquer instalação local de banco de dados por parte da turma: cada aluno só precisa de uma string de conexão para acompanhar o laboratório.

**Por que Streamlit é só a camada final:**
O foco do minicurso é a ferramenta de **transformação**. O Streamlit aparece apenas como consumo rápido dos modelos já prontos, sem lógica de negócio — toda a regra de transformação vive nos modelos dbt.

---

## 🧰 Stack utilizada

| Camada | Ferramenta |
| --- | --- |
| Armazenamento (DW) | PostgreSQL (Supabase) |
| Transformação | dbt (dbt-core + dbt-postgres) |
| Visualização | Streamlit |
| Versionamento | Git / GitHub |

---

## 📂 Estrutura do repositório

```
.
├── dbt_project/
│   ├── models/
│   │   ├── staging/        # modelos de limpeza e padronização das fontes
│   │   ├── intermediate/   # modelos de transformação intermediária
│   │   └── marts/          # modelos finais, prontos para consumo
│   ├── tests/               # testes customizados
│   ├── dbt_project.yml
│   └── profiles.yml.example # exemplo de configuração de conexão (sem credenciais)
├── streamlit_app/
│   └── app.py                # visualização simples sobre os marts finais
├── lab/
│   └── roteiro.pdf            # roteiro do laboratório entregue à turma
├── docs/
│   └── slides.pdf              # slides da apresentação
└── README.md
```

> A estrutura acima é o ponto de partida planejado; será ajustada conforme o desenvolvimento do projeto avançar.

---

## ⚙️ Configuração do ambiente

### Pré-requisitos

- Python 3.10+
- `pip`
- Conta no [Supabase](https://supabase.com) (gratuita) — para o laboratório, a string de conexão será fornecida pela dupla no início da aula.

### Instalação

```bash
# Clonar o repositório
git clone https://github.com/<usuario>/Minicurso---Inteligencia-de-Negocios.git
cd Minicurso---Inteligencia-de-Negocios

# Criar ambiente virtual
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Instalar dependências
pip install dbt-core dbt-postgres streamlit
```

### Configuração da conexão (dbt)

Copie o arquivo de exemplo e preencha com as credenciais do Supabase fornecidas em aula:

```bash
cp dbt_project/profiles.yml.example ~/.dbt/profiles.yml
```

```yaml
minicurso_dbt:
  target: dev
  outputs:
    dev:
      type: postgres
      host: db.vtzvhajzfqdgdsxyvbjr.supabase.co
      user: postgres
      password: <senha>
      port: 5432
      dbname: <nome-do-banco>
      schema: public
      threads: 4
```

> ⚠️ Nunca commitar credenciais reais. `profiles.yml` fica fora do repositório (veja `.gitignore`).

---

## 🚀 Como executar

```bash
# Testar a conexão com o banco
dbt debug

# Rodar todos os modelos
dbt run

# Rodar os testes
dbt test

# Gerar e visualizar a documentação
dbt docs generate
dbt docs serve
```

```bash
# Rodar a visualização
streamlit run streamlit_app/app.py
```

---

## 📚 Referências

_A ser preenchido com no mínimo 5 referências bibliográficas (pelo menos 3 de 2024 em diante), conforme exigido pelos critérios de avaliação do minicurso._

---

## 👥 Autoria

Minicurso desenvolvido por **Gabriel Henrique Alves Silva**, para a disciplina FAGEN32602 — Inteligência de Negócios (2026/01), sob orientação do **Prof. Dr. José Eduardo Ferreira Lopes** — FAGEN/UFU.