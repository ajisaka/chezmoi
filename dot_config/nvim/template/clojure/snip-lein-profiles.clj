  :profiles {:dev
             {:dependencies [[org.clojure/tools.namespace "0.3.1"]]
              :source-paths ["src" "dev"]
              :aot []
              :bootclasspath true
              :repl-options {:init-ns user}}
             :uberjar
             {:aot :all
              :main coming-postal.core}}

