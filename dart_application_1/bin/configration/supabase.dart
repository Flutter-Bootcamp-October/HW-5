import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instance;

  SupabaseClient get createSupa {
    final supabase = SupabaseClient("https://fxocxcecxglygsoeqvgm.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4b2N4Y2VjeGdseWdzb2VxdmdtIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMjk3Mjc0MywiZXhwIjoyMDE4NTQ4NzQzfQ.LFNZNFPcYtKCBUurtII61tq0-MtT-buEesSslMKJnRE");
    instance = supabase;
    return supabase;
  }
}
