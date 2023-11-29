;;; Root
(local Root {})

;;; Local Functions
(fn GetConfiguration [Instance Async?]
  ((. Instance (or (and Async? "FindFirstChild")
                   "WaitForChild")) Instance "Configuration"))

(fn GetAttribute [Configuration Attribute]
  (Configuration:GetAttribute Attribute))

(fn GetAttributes [Configuration]
  (Configuration:GetAttributes))

(fn GetSignal [Configuration Attribute]
  (Configuration:GetAttributeChangedSignal Attribute))

(fn GetAnySignal [Configuration]
  Configuration.AttributeChanged)

(fn SetAttribute [Configuration Attribute Value]
  (Configuration:SetAttribute Attribute Value)
  (GetAttribute Configuration Attribute))

(fn SetCallback [Signal Callback Configuration Attribute]
  (let [PreviousValue {}]
    (Signal:Connect (fn [...]
                      (let [Attribute (or Attribute ...)
                            CurrentValue (GetAttribute Configuration Attribute)]
                        (Callback CurrentValue (. PreviousValue Attribute) ...)
                        (tset PreviousValue Attribute CurrentValue))))))

(fn SetName [Configuration]
  (set Configuration.Name "Configuration")
  Configuration)

(fn SetParent [Configuration Parent]
  (set Configuration.Parent Parent)
  Configuration)

;;; Exported Functions
(fn Root.New [Instance Template]
  (-?> (or (and Template (Template:Clone))
           (Instance.new "Configuration"))
       (SetName)
       (SetParent Instance)))

(fn Root.Set [Instance Attribute Value]
  (-?> (GetConfiguration Instance)
       (SetAttribute Attribute Value)))

(fn Root.Get [Instance Attribute Async?]
  (-?> (GetConfiguration Instance Async?)
       (GetAttribute Attribute)))

(fn Root.GetAll [Instance]
  (-?> (GetConfiguration Instance)
       (GetAttributes)))

(fn Root.Connect [Instance Attribute Callback]
  (let [Configuration (GetConfiguration Instance)]
    (and Configuration (-?> (GetSignal Configuration Attribute)
                            (SetCallback Callback Configuration Attribute)))))

(fn Root.ConnectAny [Instance Callback]
  (let [Configuration (GetConfiguration Instance)]
    (and Configuration (-> (GetAnySignal Configuration)
                           (SetCallback Callback Configuration)))))

;;; Return
Root