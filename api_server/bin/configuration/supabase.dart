import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient get supabase {
    final supabase = SupabaseClient('https://buryclqqixyztbpfbgrg.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ1cnljbHFxaXh5enRicGZiZ3JnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMjk3MzQzNywiZXhwIjoyMDE4NTQ5NDM3fQ.67RmDs3LmvBhWU46bY_OOUnkW6RiYzKC-x6w-FQB5rU');
    instant = supabase;
    return supabase;
  }
}
