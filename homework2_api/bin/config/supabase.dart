import 'package:supabase/supabase.dart';

class SupabaseClass {
  static SupabaseClient? intense;
  SupabaseClient get supabase {
    final supabase = SupabaseClient("https://hvyslowrljbhagxswlch.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2eXNsb3dybGpiaGFneHN3bGNoIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzI2NCwiZXhwIjoyMDE1MzUzMjY0fQ.cx3IfvV4hdnebFY-jmMk534JfMbg_Rkmjchwz1kzjRQ");
    intense = supabase;
    return supabase;
  }
}
