(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[refactor-nrepl "2.3.1"]
                [cider/cider-nrepl "0.15.0-SNAPSHOT"]])

(swap! boot.repl/*default-middleware*
       conj 'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)
