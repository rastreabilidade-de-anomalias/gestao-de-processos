-- Torre de Controle Operacional — Alimentação
-- Rode no Supabase: SQL Editor → New query → cole tudo → Run.

-- Cada tabela do app (unidades, catraca, anomalias…) fica numa linha, com os registros em JSON.
create table if not exists public.torre_tabelas (
  nome        text primary key,
  rows        jsonb not null default '{}'::jsonb,
  atualizado  timestamptz not null default now()
);

-- Parâmetros dos cálculos e campos personalizados.
create table if not exists public.torre_config (
  id          text primary key,
  dados       jsonb not null default '{}'::jsonb,
  atualizado  timestamptz not null default now()
);

alter table public.torre_tabelas enable row level security;
alter table public.torre_config  enable row level security;

-- ATENÇÃO: estas políticas deixam qualquer pessoa com o link do app ler e gravar.
-- Serve para o piloto. Para produção, troque "anon" por "authenticated" e ative login no Supabase.
drop policy if exists "torre_tabelas_leitura" on public.torre_tabelas;
drop policy if exists "torre_tabelas_escrita" on public.torre_tabelas;
drop policy if exists "torre_config_leitura"  on public.torre_config;
drop policy if exists "torre_config_escrita"  on public.torre_config;
create policy "torre_tabelas_leitura" on public.torre_tabelas for select to anon, authenticated using (true);
create policy "torre_tabelas_escrita" on public.torre_tabelas for all    to anon, authenticated using (true) with check (true);
create policy "torre_config_leitura"  on public.torre_config  for select to anon, authenticated using (true);
create policy "torre_config_escrita"  on public.torre_config  for all    to anon, authenticated using (true) with check (true);

-- Atualização em tempo real entre aparelhos.
do $$ begin
  alter publication supabase_realtime add table public.torre_tabelas;
exception when duplicate_object then null; end $$;
