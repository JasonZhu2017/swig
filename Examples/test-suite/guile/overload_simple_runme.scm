;; The SWIG modules have "passive" Linkage, i.e., they don't generate
;; Guile modules (namespaces) but simply put all the bindings into the
;; current module.  That's enough for such a simple test.
(dynamic-call "scm_init_overload_simple_module" (dynamic-link "./liboverload_simple.so"))

(if (not (string=? (foo 3) "foo:int"))
    (error "foo(int)"))

(if (not (string=? (foo 3.01) "foo:double"))
    (error "foo(double)"))

(if (not (string=? (foo "hello") "foo:char *"))
    (error "foo(char *)"))

(let ((f (new-Foo))
      (b (new-Bar))
      (s (new-Spam)))
  (if (not (string=? (foo f) "foo:Foo *"))
      (error "foo(Foo *)"))
  (if (not (string=? (foo b) "foo:Bar *"))
      (error "foo(Bar *)"))
  ;; Test member functions
  (if (not (string=? (Spam-foo s 3) "foo:int"))
      (error "Spam::foo(int)"))
  (if (not (string=? (Spam-foo s 3.01) "foo:double"))
      (error "Spam::foo(double)"))
  (if (not (string=? (Spam-foo s "hello") "foo:char *"))
      (error "Spam::foo(char *)"))
  (if (not (string=? (Spam-foo s f) "foo:Foo *"))
      (error "Spam::foo(Foo *)"))
  (if (not (string=? (Spam-foo s b) "foo:Bar *"))
      (error "Spam::foo(Bar *)"))
  ;; Test static member functions
  (if (not (string=? (Spam-bar 3) "bar:int"))
      (error "Spam::bar(int)"))
  (if (not (string=? (Spam-bar 3.01) "bar:double"))
      (error "Spam::bar(double)"))
  (if (not (string=? (Spam-bar "hello") "bar:char *"))
      (error "Spam::bar(char *)"))
  (if (not (string=? (Spam-bar f) "bar:Foo *"))
      (error "Spam::bar(Foo *)"))
  (if (not (string=? (Spam-bar b) "bar:Bar *"))
      (error "Spam::bar(Bar *)"))
  ;; Test constructors
  (if (not (string=? (Spam-type-get (new-Spam)) "none"))
      (error "Spam()"))
  (if (not (string=? (Spam-type-get (new-Spam 3)) "int"))
      (error "Spam(int)"))
  (if (not (string=? (Spam-type-get (new-Spam 3.4)) "double"))
      (error "Spam(double)"))
  (if (not (string=? (Spam-type-get (new-Spam "hello")) "char *"))
      (error "Spam(char *)"))
  (if (not (string=? (Spam-type-get (new-Spam b)) "Bar *"))
      (error "Spam(Bar *)")))

(exit 0)
