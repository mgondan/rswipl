--- ../src/swipl-devel/tests/save/test_saved_states.pl	2025-11-23 17:54:03.256571446 +0100
+++ ../src/swipl-devel/tests/save/test_saved_states.pl.new	2025-11-23 17:52:38.075100230 +0100
@@ -202,7 +202,10 @@
 %   saved state does not terminate.
 
 read_terms(In, List) :-
-    set_stream(In, timeout(60)),
+    (   current_prolog_flag(windows, true)
+    ->  true
+    ;   set_stream(In, timeout(60))
+    ),
     read_term(In, T0, []),
     read_terms(T0, In, List).
 
