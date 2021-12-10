
(namespace (read-msg 'ns))

(module guard-token-policy GOVERNANCE

  (defcap GOVERNANCE ()
    (enforce-guard (keyset-ref-guard 'marmalade-admin )))

  (implements kip.token-policy-v1_DRAFT3)
  (use kip.token-policy-v1_DRAFT3 [token-info])

  (defschema guards
    mint-guard:guard
    burn-guard:guard
    sale-guard:guard
    transfer-guard:guard
  )

  (deftable policy-guards:{guards})

  (defun get-guards:object{guards} (token:object{token-info})
    (read policy-guards (at 'id token))
  )

  (defun enforce-mint:bool
    ( token:object{token-info}
      account:string
      amount:decimal
    )
    (enforce-guard (at 'mint-guard (get-guards token)))
  )

  (defun enforce-burn:bool
    ( token:object{token-info}
      account:string
      amount:decimal
    )
    (enforce-guard (at 'burn-guard (get-guards token)))
  )

  (defun enforce-init:bool
    ( token:object{token-info}
    )
    (insert policy-guards (at 'id token)
      { 'mint-guard: (read-keyset 'mint-guard)
      , 'burn-guard: (read-keyset 'burn-guard)
      , 'sale-guard: (read-keyset 'sale-guard)
      , 'transfer-guard: (read-keyset 'transfer-guard) })
    true
  )


  (defun enforce-offer:bool
    ( token:object{token-info}
      seller:string
      amount:decimal
      sale-id:string )
    (enforce-guard (at 'sale-guard (get-guards token)))
  )

  (defun enforce-buy:bool
    ( token:object{token-info}
      seller:string
      buyer:string
      amount:decimal
      sale-id:string )
    (enforce-guard (at 'sale-guard (get-guards token)))
  )


  (defun enforce-transfer:bool
    ( token:object{token-info}
      sender:string
      receiver:string
      amount:decimal )
    (enforce-guard (at 'transfer-guard (get-guards token)))
  )

  (defun enforce-crosschain:bool
    ( token:object{token-info}
      sender:string
      receiver:string
      target-chain:string
      amount:decimal )
    (enforce-guard (at 'transfer-guard (get-guards token)))
  )

  ;; dummy impl to address #928
  (implements gas-payer-v1)
  (defcap GAS_PAYER:bool
    ( user:string limit:integer price:decimal )
    (enforce false "Dummy implementation"))
  (defun create-gas-payer-guard:guard ()
    (enforce false "Dummy implementation"))

)

(create-table policy-guards)
