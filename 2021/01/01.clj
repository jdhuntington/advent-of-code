
(defn input []
  (map #(Integer/parseInt %) (line-seq (java.io.BufferedReader. *in*))))

(defn mk-pairs [l] (partition 2 1 l))

(defn ascending? [[a b]]
  (< a b))

(println (count (filter ascending? (mk-pairs (input)))))
