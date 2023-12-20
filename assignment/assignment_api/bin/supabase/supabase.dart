import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;
  get supabase {
    final SupabaseClient supabase = SupabaseClient(
        'https://vmcsvietjvesnkjopczw.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtY3N2aWV0anZlc25ram9wY3p3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTI1NDU3NCwiZXhwIjoyMDE2ODMwNTc0fQ.14Je8YYcEbNG7Jq5H03kn4FHSlRlPfmi2w0T6q-TIMs');
    instant = supabase;
  }
}
