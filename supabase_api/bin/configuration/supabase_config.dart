import 'package:supabase/supabase.dart';

class SupabaseConfig {
  static SupabaseClient? instant;
  get supabaseConfig {
    final supabase = SupabaseClient("https://zkidhsvhkjshockssdec.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpraWRoc3Zoa2pzaG9ja3NzZGVjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzIxNCwiZXhwIjoyMDE1MzUzMjE0fQ.ogA1CDmr1lRh5m5z50y-PDSVmWxtzPfeFCXMvoj7ofg");
    instant = supabase;
    return supabase;
  }
}
