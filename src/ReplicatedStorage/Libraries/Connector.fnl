;;; Return
(fn [Host Event Callback ...]
  (let [Event (or (. Host Event) Event)]
    (if Event
        (let [Arguments [...]]
          (Event:Connect (fn [...]
                           (each [_ Argument ...]
                             (table.insert Arguments Argument))
                           (Callback (table.unpack Arguments)))))
        (warn (.. "Event is not a valid member of " Host)))))