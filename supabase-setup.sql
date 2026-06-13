-- Run this in your Supabase SQL Editor (Dashboard → SQL Editor → New query)

-- 1. Exercise lists table
create table if not exists ppl_days (
  id        text primary key,   -- day id e.g. "pushA"
  exercises jsonb not null      -- full exercise array as JSON
);

-- Allow public read and write (no login required)
alter table ppl_days enable row level security;

create policy "public read"  on ppl_days for select using (true);
create policy "public write" on ppl_days for insert with check (true);
create policy "public update" on ppl_days for update using (true);

-- 2. Storage bucket for media files
insert into storage.buckets (id, name, public)
values ('exercise-media', 'exercise-media', true)
on conflict do nothing;

-- Allow anyone to upload and read from the bucket
create policy "public upload" on storage.objects
  for insert with check (bucket_id = 'exercise-media');

create policy "public read media" on storage.objects
  for select using (bucket_id = 'exercise-media');

create policy "public delete media" on storage.objects
  for delete using (bucket_id = 'exercise-media');
