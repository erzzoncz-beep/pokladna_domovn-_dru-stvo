-- Jediná sdílená pokladna. Veřejnost má pouze SELECT; zápis smí vlastník řádku.
create table if not exists public.cashboxes (
  id smallint primary key default 1 check (id = 1),
  owner_id uuid not null references auth.users(id) on delete restrict,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.cashboxes enable row level security;
revoke all on public.cashboxes from anon;
revoke all on public.cashboxes from authenticated;
grant select on public.cashboxes to anon, authenticated;
grant insert, update on public.cashboxes to authenticated;

drop policy if exists "Public can read the cashbox" on public.cashboxes;
create policy "Public can read the cashbox" on public.cashboxes
  for select to anon, authenticated using (true);

drop policy if exists "Admin owns the cashbox" on public.cashboxes;
create policy "Admin owns the cashbox" on public.cashboxes
  for insert to authenticated with check ((select auth.uid()) = owner_id);

drop policy if exists "Admin can update own cashbox" on public.cashboxes;
create policy "Admin can update own cashbox" on public.cashboxes
  for update to authenticated using ((select auth.uid()) = owner_id)
  with check ((select auth.uid()) = owner_id);

