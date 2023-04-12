(namespace (read-msg 'ns))

(module fixed-quote-policy GOVERNANCE

  @doc "Policy for fixed issuance "

  (defcap GOVERNANCE ()
    (enforce-guard (keyset-ref-guard 'marmalade-admin )))

  ; TODO: we might need a new concrecte-policy interface
  ; kip.concrete-policy-v1
  (implements kip.token-policy-v1)
  (use kip.token-policy-v1 [token-info])

  (defschema supply-schema
    mint-guard:guard
    max-supply:decimal
    min-amount:decimal
  )

  (deftable supplies:{supply-schema})

  (defun get-supply:object{policy-schema} (token:object{token-info})
    (read supplies (at 'id token))
  )

  (defun enforce-ledger:bool ()
     (enforce-guard (marmalade.ledger.ledger-guard))
   )

  (defun enforce-mint:bool
    ( token:object{token-info}
      account:string
      guard:guard
      amount:decimal
    )
    (enforce-ledger)
    (bind (get-supply token)
      { 'mint-guard:=mint-guard:guard
      , 'min-amount:=min-amount:decimal
      , 'max-supply:=max-supply:decimal
      }
      (enforce-guard mint-guard)
      (enforce (>= amount min-amount) "mint amount < min-amount")
      (enforce (<= (+ amount (at 'supply token)) max-supply) "Exceeds max supply")
  ))

  (defun enforce-burn:bool
    ( token:object{token-info}
      account:string
      amount:decimal
    )
    (enforce-ledger)
    (enforce false "Burn prohibited")
  )

  (defun enforce-init:bool
    ( token:object{token-info}
    )
    (enforce-ledger)
    (let* ( (mint-guard:guard (read-keyset 'mint-guard ))
            (max-supply:decimal (read-decimal 'max-supply ))
            (min-amount:decimal (read-decimal 'min-amount ))
            )
    (enforce (>= min-amount 0.0) "Invalid min-amount")
    (enforce (>= max-supply 0.0) "Invalid max-supply")
    (insert supplies (at 'id token)
      { 'mint-guard: mint-guard
      , 'max-supply: max-supply
      , 'min-amount: min-amount })
    true)
  )

  (defun enforce-offer:bool
    ( token:object{token-info}
      seller:string
      amount:decimal
      sale-id:string
    )
    @doc "Capture quote spec for SALE of TOKEN from message"
    (enforce-ledger)
  )

  (defun enforce-buy:bool
    ( token:object{token-info}
      seller:string
      buyer:string
      buyer-guard:guard
      amount:decimal
      sale-id:string )
    (enforce-ledger)
  )

  (defun enforce-transfer:bool
    ( token:object{token-info}
      sender:string
      guard:guard
      receiver:string
      amount:decimal )
    (enforce-ledger)
  )

  (defun enforce-crosschain:bool
    ( token:object{token-info}
      sender:string
      guard:guard
      receiver:string
      target-chain:string
      amount:decimal )
    (enforce-ledger)
    (enforce false "Transfer prohibited")
  )
)


(if (read-msg 'upgrade)
  ["upgrade complete"]
  [ (create-table quotes)
    (create-table policies) ])
