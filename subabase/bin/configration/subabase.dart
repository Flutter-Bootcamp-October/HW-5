import 'package:supabase/supabase.dart';

class SubabaseIntigraton {
  static SupabaseClient? instant;
  get supebase {
    final supabase = SupabaseClient("https://xvmcdtmqmkylavyhvcge.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2bWNkdG1xbWt5bGF2eWh2Y2dlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMzA0MDMyMywiZXhwIjoyMDE4NjE2MzIzfQ.FaaK5SrBDSyirKmOwrY63v6cwTquVGPPfuk1WwNSXLk");
    instant = supabase;
    return supabase;
  }
}
