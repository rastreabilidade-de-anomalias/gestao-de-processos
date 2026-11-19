# Torre de Controle Operacional — Alimentação (SLS | EFC)

App da torre de controle da alimentação industrial: planejamento → suprimentos → estoque → degelo → produção → logística → distribuição → consumo → anomalias.
Mostra quantas cubas e quantos quilos por cuba cada preparação precisa, a partir das pessoas que entram na catraca.

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `index.html` | O app inteiro (telas, cálculos, inventário de 200 variáveis e mapa do processo). |
| `config.js` | Onde você cola a URL e a chave do Supabase. Em branco = salva só no navegador. |
| `supabase_schema.sql` | Cria as tabelas do banco no Supabase. |
| `Torre_Controle_Simulacao_Importacao.xlsx` | Dados simulados para importar e ver todas as análises. |
| `README.md` | Este guia. |
| `.nojekyll` | Arquivo vazio que faz o GitHub publicar o site sem processar nada. |

## 1. Publicar no GitHub Pages

1. No GitHub, crie um repositório **público** (ex.: `torre-controle`). No plano gratuito, o Pages não funciona em repositório privado.
2. **Descompacte o zip no computador.** O GitHub não abre zip: se você enviar o `.zip`, o site não aparece.
3. No repositório: **Add file → Upload files** → arraste **os arquivos de dentro da pasta** (não a pasta) → **Commit changes**.
   A página inicial do repositório deve listar `index.html` direto, sem nenhuma pasta antes.
4. **Settings → Pages** → *Source*: `Deploy from a branch` → *Branch*: `main` e pasta `/ (root)` → **Save**.
5. Abra a aba **Actions**: espere o “pages build and deployment” ficar verde (1 a 3 minutos).
6. O endereço aparece no topo de **Settings → Pages**: `https://SEU-USUARIO.github.io/torre-controle/` (com o nome do repositório no final).

### Se não aparecer

| O que você vê | Causa | Como resolver |
|---|---|---|
| Erro 404 | `index.html` está dentro de uma pasta, ou você enviou o `.zip` | Envie os arquivos soltos na raiz do repositório |
| Erro 404 | Pages não ativado ou ainda publicando | Confira o passo 4 e espere a aba Actions ficar verde |
| Erro 404 | Endereço sem o nome do repositório | Use `…github.io/NOME-DO-REPOSITORIO/` |
| Aparece o texto deste README | Falta o `index.html` na raiz | Envie o `index.html` |
| Opção Pages bloqueada | Repositório privado no plano gratuito | Torne o repositório público |
| Página antiga | Cache do navegador | Recarregue com Ctrl + F5 ou abra em aba anônima |

Sem o Supabase, o app já funciona: os dados ficam salvos **só no navegador** de quem usa.

## 2. Ligar o banco (Supabase) — para todos verem os mesmos dados

1. Em [supabase.com](https://supabase.com), crie um projeto.
2. **SQL Editor → New query**, cole o conteúdo de `supabase_schema.sql` e clique em **Run**.
3. **Project Settings → API**: copie a *Project URL* e a chave *anon public*.
4. No GitHub, abra `config.js` → ✏️ editar → cole as duas → **Commit changes**.
5. Abra o app: o selo do topo deve mostrar **"Supabase conectado"**.

## 3. Carregar os dados

- **Configurações → Importar planilha completa (todas as abas)** → escolha `Torre_Controle_Simulacao_Importacao.xlsx` → *Substituir* → Importar.
- Ou toque em **Gravar base inicial** na faixa amarela.
- Deixe a hora do topo em **12:15** para ver o cenário da parada de rampa PR-001. O botão **Agora** usa o relógio real.
- Quando entrarem dados reais: **Configurações → Remover registros simulados**.

## Atenção

- O `index.html` traz o inventário de dados e o mapa do processo da coordenação. Em repositório **público**, qualquer pessoa pode ver esse conteúdo e, com o Supabase ligado, gravar no banco (as políticas do SQL são abertas para o piloto). Para uso interno, prefira repositório privado e ative login no Supabase.
- Cada tabela é guardada como um bloco JSON. A tabela de catraca cresce todo dia: arquive o histórico antigo periodicamente.
- Valores simulados não são dados reais e aparecem com a etiqueta **SIMULADO**.
