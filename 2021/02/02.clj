(require '[clojure.string :as str])

(def navigate
  {"down" (fn [steps [x y aim]] [x y (+ aim steps)])
   "up" (fn [steps [x y aim]] [x y (- aim steps)])
   "forward" (fn [steps [x y aim]] [(+ x steps) (+ y (* steps aim)) aim])})

(defn parse-line [unparsed]
  (let [tuple (str/split unparsed #" ")]
    [(tuple 0) (Integer/parseInt (tuple 1))]))

(defn input [] (map parse-line (line-seq (java.io.BufferedReader. *in*))))

(defn apply-step [starting-position step]
  (print ((navigate (step 0)) (step 1) starting-position))
  ((navigate (step 0)) (step 1) starting-position))

(defn compute-location [steps]
  (reduce apply-step [0 0 0] steps))

(let [result (compute-location (input))]
  (println result)
  (println (apply * (take 2 result))))

