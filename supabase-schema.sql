-- RSS Reader 用 Supabase スキーマ
-- Supabase SQL Editor で実行してください。

create table if not exists public.rss_feeds (
  profile_id text not null,
  url text not null,
  title text not null default '',
  color text not null default '#5b9bd5',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (profile_id, url)
);

create table if not exists public.rss_pins (
  profile_id text not null,
  link text not null,
  created_at timestamptz not null default now(),
  primary key (profile_id, link)
);

create table if not exists public.rss_saved_articles (
  profile_id text not null,
  link text not null,
  title text not null default '',
  feed_url text,
  pub_date timestamptz,
  image text,
  content text not null default '',
  saved_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  primary key (profile_id, link)
);

alter table public.rss_feeds enable row level security;
alter table public.rss_pins enable row level security;
alter table public.rss_saved_articles enable row level security;

grant select, insert, update, delete on public.rss_feeds to anon;
grant select, insert, update, delete on public.rss_pins to anon;
grant select, insert, update, delete on public.rss_saved_articles to anon;

drop policy if exists "rss_feeds_anon_select" on public.rss_feeds;
drop policy if exists "rss_feeds_anon_insert" on public.rss_feeds;
drop policy if exists "rss_feeds_anon_update" on public.rss_feeds;
drop policy if exists "rss_feeds_anon_delete" on public.rss_feeds;
drop policy if exists "rss_pins_anon_select" on public.rss_pins;
drop policy if exists "rss_pins_anon_insert" on public.rss_pins;
drop policy if exists "rss_pins_anon_update" on public.rss_pins;
drop policy if exists "rss_pins_anon_delete" on public.rss_pins;
drop policy if exists "rss_saved_articles_anon_select" on public.rss_saved_articles;
drop policy if exists "rss_saved_articles_anon_insert" on public.rss_saved_articles;
drop policy if exists "rss_saved_articles_anon_update" on public.rss_saved_articles;
drop policy if exists "rss_saved_articles_anon_delete" on public.rss_saved_articles;

create policy "rss_feeds_anon_select" on public.rss_feeds for select to anon using (true);
create policy "rss_feeds_anon_insert" on public.rss_feeds for insert to anon with check (profile_id <> '');
create policy "rss_feeds_anon_update" on public.rss_feeds for update to anon using (profile_id <> '') with check (profile_id <> '');
create policy "rss_feeds_anon_delete" on public.rss_feeds for delete to anon using (profile_id <> '');

create policy "rss_pins_anon_select" on public.rss_pins for select to anon using (true);
create policy "rss_pins_anon_insert" on public.rss_pins for insert to anon with check (profile_id <> '');
create policy "rss_pins_anon_update" on public.rss_pins for update to anon using (profile_id <> '') with check (profile_id <> '');
create policy "rss_pins_anon_delete" on public.rss_pins for delete to anon using (profile_id <> '');

create policy "rss_saved_articles_anon_select" on public.rss_saved_articles for select to anon using (true);
create policy "rss_saved_articles_anon_insert" on public.rss_saved_articles for insert to anon with check (profile_id <> '');
create policy "rss_saved_articles_anon_update" on public.rss_saved_articles for update to anon using (profile_id <> '') with check (profile_id <> '');
create policy "rss_saved_articles_anon_delete" on public.rss_saved_articles for delete to anon using (profile_id <> '');

create index if not exists rss_feeds_profile_updated_idx on public.rss_feeds (profile_id, updated_at desc);
create index if not exists rss_pins_profile_created_idx on public.rss_pins (profile_id, created_at desc);
create index if not exists rss_saved_profile_saved_idx on public.rss_saved_articles (profile_id, saved_at desc);
