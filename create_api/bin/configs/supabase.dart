import 'package:supabase/supabase.dart';

class SupabaseNet {
  static SupabaseClient? supabases;
  SupabaseClient get supa {
    final supabase = SupabaseClient("https://zpndcybquoedpxdcgvrr.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpwbmRjeWJxdW9lZHB4ZGNndnJyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzIxNCwiZXhwIjoyMDE1MzUzMjE0fQ.4bH6ZYoE0PHiXnv28FKw3RZsc_Aq2wY8ZJ7Q6wiY38A");
    supabases = supabase;
    return supabase;
  }
}
