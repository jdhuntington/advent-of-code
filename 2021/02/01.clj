(require '[clojure.string :as str])

(def navigate
  {"down" (fn [steps [x y]] [x (+ steps y)])
   "up" (fn [steps [x y]] [x (- y steps)])
   "forward" (fn [steps [x y]] [(+ x steps) y])})

(defn parse-line [unparsed]
  (let [tuple (str/split unparsed #" ")]
    [(tuple 0) (Integer/parseInt (tuple 1))]))

(defn input [] (map parse-line (line-seq (java.io.BufferedReader. *in*))))

(defn apply-step [starting-position step]
  (print ((navigate (step 0)) (step 1) starting-position))
  ((navigate (step 0)) (step 1) starting-position))

(defn compute-location [steps]
  (reduce apply-step [0 0] steps))

(let [result (compute-location (input))]
  (println result)
  (println (apply * result)))

