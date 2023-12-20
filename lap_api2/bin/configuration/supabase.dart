import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient get supabase {
    final supabase = SupabaseClient("https://hlaopztqctnpdzxhtjob.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhsYW9wenRxY3RucGR6eGh0am9iIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzIwNywiZXhwIjoyMDE1MzUzMjA3fQ.j44wADH5dklAsEY7lkcPTYV2edWUrPj0McHUoH2jnLE");
    instant = supabase;
    return supabase;
  }
}
