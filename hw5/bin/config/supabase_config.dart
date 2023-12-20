import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient get supabase {
    final supabase = SupabaseClient("https://vylpqsoynjpswpnlmokp.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ5bHBxc295bmpwc3dwbmxtb2twIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk3NzcyMzAsImV4cCI6MjAxNTM1MzIzMH0.xkL0jkJFTAnMZTq9OFDp9fwds_Qw5eIA6J3DPIIuk6I");
    instant = supabase;
    return supabase;
  }
  
}
