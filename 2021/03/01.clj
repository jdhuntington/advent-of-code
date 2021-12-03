(defn input []
  (map #(Integer/parseInt % 2) (line-seq (java.io.BufferedReader. *in*))))

(defn compute-least-significant-sum [ns]
  (apply + (map #(bit-and 1 %) ns)))

(defn gamma [original-ns]
  (loop [ns original-ns
         gamma-val 0
         significant-bit-mask 0
         bit-offset 0]
    (let [sum (compute-least-significant-sum ns)]
      (if (= 0 (apply + ns))
        [significant-bit-mask (- bit-offset 1) gamma-val]
        (recur
         (map #(bit-shift-right % 1) ns)
         (if (> sum (/ (count ns) 2)) (bit-set gamma-val bit-offset) gamma-val)
         (bit-set significant-bit-mask bit-offset)
         (+ 1 bit-offset))))))

(defn has-desired-bit [bit offset n]
  (if (= 1 bit) (bit-test n offset) (not (bit-test n offset))))

(defn most-common-bit [ns offset default-in-case-of-tie]
  (let [hits (count (filter #(bit-test % offset) ns))
        total (count ns)
        half (/ total 2)]
    (if (= hits half) default-in-case-of-tie
        (if (> hits half) 1 0))))

(defn least-common-bit [ns offset default-in-case-of-tie]
  (let [hits (count (filter #(bit-test % offset) ns))
        total (count ns)
        half (/ total 2)]
    (if (= hits half) default-in-case-of-tie
        (if (> hits half) 0 1))))

(defn o2 [original-ns significant-bit-offset]
  (loop [ns original-ns
         offset significant-bit-offset]
    (if (= 1 (count ns)) (first ns)
        (let [desired-bit (most-common-bit ns offset 1)]
          (recur (filter #(has-desired-bit desired-bit offset %) ns) (- offset 1))))))

(defn co2 [original-ns significant-bit-offset]
  (loop [ns original-ns
         offset significant-bit-offset]
    (if (= 1 (count ns)) (first ns)
        (let [desired-bit (least-common-bit ns offset 0)]
        (recur (filter #(has-desired-bit desired-bit offset %) ns) (- offset 1))))))


(let [all-input (input)
      [significant-bit-mask bit-offset g] (gamma all-input)
      e (bit-and significant-bit-mask (bit-not g))
      o2-val (o2 all-input bit-offset)
      co2-val (co2 all-input bit-offset)
      result-1 (* e g)
      result-2 (* o2-val co2-val)]
  (println {:g g :e e :o2 o2-val :co2 co2-val :result-1 result-1 :result-2 result-2}))
