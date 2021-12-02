
(defn input []
  (map #(Integer/parseInt %) (line-seq (java.io.BufferedReader. *in*))))

(defn mk-tuples [l] (partition 3 1 l))

(defn mk-pairs [l] (partition 2 1 l))

(defn ascending? [[a b]]
  (< a b))
(defn sum [l] (apply + l))
(println (count (filter ascending? (mk-pairs (map sum (mk-tuples (input)))))))
