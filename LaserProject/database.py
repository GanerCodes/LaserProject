import os
from supabase import create_client, Client

url: str = "https://toheacpnppncdhicjaat.supabase.co/rest/v1"
key: str = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRvaGVhY3BucHBuY2RoaWNqYWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTM5NDA3MDcsImV4cCI6MjAwOTUxNjcwN30.sdsMppIebSLRLoW13LPhiDaXGQgEWBhfm3-QHXkYG3E"

#create a Supabase Client
supabase: Client = create_client(url, key)


class Database:
    pass
database = Database()